Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A09C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7091F61159
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7091F61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DAA6E419;
	Mon,  7 Jun 2021 14:29:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42E26E419;
 Mon,  7 Jun 2021 14:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAeLAG/zMYdoqmZCkTBuZ+Y4UPjF1Gg6++OaiZDl4/MYqubAbcn7NnCkanHyI1wRTtA2r9SV1lkCOqKZzUvUn2oz98eVPyZ5BqPNIrdx9cCCgsObt6tNQOT55jRTFUtnsxbdhLpwAVfWyiIeR3bjEPP1RW8v3RzLMzQas4zoJ8P74Pq1gz7XAEd58WZAPRk+mA0s4/OgohO8Lz7DUEWU4yyUobLRDVvNhyy6GF9YQSONKncS9U1c7oR04jNpoK39DBkC20aIP85Pk7iYeX5VeV4s4Dq0kM5qpbDKCPnH2QDPlA4XP+cUlVRydxWyayfiJW2+rtIEsfTfwPI8zJFdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJo5a792LkAuZYBGOExxtadqrRpqiETYS3/p5JyW3I0=;
 b=ht8QLrKHXjXAHcZQQyvI8IQsjl1iOVcW4wxWmowi+nudxqLHjtYszUgAKcFG93GDozR7LGBAj2rUo2pYzvsT484X5cQeVRYV9Iz/ZKNfI1bESpU2bxhYxlgmEcryhiPw2Koub/N9sqLDTSbRP8o7vwJh/AQEfhWEGpIau3qKRgbc6LtCohs3cEzjwqGrDJxPuz4ece+jPlCmdOMiHiLg5+DjxYRIIjgt2YQfy9C2vgYU/dKhFYxUFYIq9DoD1PNXCp02g3TajdtwcEdfdwAyDXwHv2tmbPuInSk4/ha2EKC0t2ToJclDWuckcx1Hz7/wGjamawk5YTgB3M3M3qEsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJo5a792LkAuZYBGOExxtadqrRpqiETYS3/p5JyW3I0=;
 b=GqyCVMtsKTzYKkBQVywpZI49BRIDy4bxxnCRJ+B5EpjjUIvTj+PXxNTvOROznUpGft3rFzrDB2hswU/IzN4RA8nigz/wRogjFAlvRtUUqx/aMryf6obE7g8l5FPi7EChE+1yCT3UtZvyFyKXqdShyDjvI17vCqdahcFdlEVXWHU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2813.namprd12.prod.outlook.com (2603:10b6:805:69::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Mon, 7 Jun
 2021 14:29:19 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4195.024; Mon, 7 Jun 2021
 14:29:19 +0000
Subject: Re: [PATCH 0/7] libdrm tests for hot-unplug fe goature
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210601201702.23316-1-andrey.grodzovsky@amd.com>
 <CADnq5_Nfs_j9XE1Siou2wGYuwd5cvTD1T7m9gFpS9z74D=AuAQ@mail.gmail.com>
 <SN6PR12MB46230F8575C786B53056FE79EA3C9@SN6PR12MB4623.namprd12.prod.outlook.com>
 <CADnq5_OHQ3Dtq3ZikvDPR=pSubSBq0pN_uRkXW8FaVcbr2pWAQ@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <48f25209-8832-33e0-cb2d-e47db0ecfe78@amd.com>
Date: Mon, 7 Jun 2021 10:29:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CADnq5_OHQ3Dtq3ZikvDPR=pSubSBq0pN_uRkXW8FaVcbr2pWAQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:de1b:fb9d:c48e:87bf]
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:de1b:fb9d:c48e:87bf]
 (2607:fea8:3edf:49b0:de1b:fb9d:c48e:87bf) by
 YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.25 via Frontend Transport; Mon, 7 Jun 2021 14:29:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f1b4574-f168-456a-0301-08d929c0a297
X-MS-TrafficTypeDiagnostic: SN6PR12MB2813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB281381B67C4C231B2694D5F7EA389@SN6PR12MB2813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJhRQxbULiwRG+08nun4cPbpXfeTvooWx/NrQXQgMUyfndjr8gx506VHDoVnZsrcgWGAeTdm7aAWpokG3A/CzgFGBogpE5SYIKNrApIZF40kjnzEBppBFkiuBE+s9aleUSmKiCYvNmLIWNDA7afNAvueqdSgbtiYoWNYOmOl5CKRm8qhckvTQSI5A/1D/wiztpUU55XWQRy3+NDCx/eJyfCH3GFjjGl3cuKONaDyQlTpYxALbkQqpR0PBp9QNBXq3kN+erylJ/Me4AgWNaVga8eHI+ZVbZwhUP8T40BYvZ5iku6OryD0gXhUpONm+zHZ8xqmYk5ENflnRCpx8FUb+IHdnIGCq5Qr9Ltkk5vo4bFUYE1otkGIdEZICIKKLh0cXjwYrm/SnxbMd+zRCANfa54m4Bt02GkndQGMID0Cu/R3KU9LlpyBrC4AjtMHOsg+qJBUodtAfDlpxemQBlNF8RxjjQrUYV8gspEyuMuLb47LVfkxWspIZcJPCqMKkE2u6HZyNHqCvqiAEoLelI7Tpa3VaI9b87UQflg1PiIXiCJ5L8hpdNw3xHchpZgAOyB3wQGw0hZ/wOfcj+DSCJsB/O1qih9b1E0aNJBDuNFkVzzNlLJmkUvgZKYj51RazoX58Sf0U8oh2i9Q2/NttuLmJ3dykLIjs+fiMuCATxl6iDCRlhJj5EQNOCQhLhK8p7UPGPpiiDjSCD0EefNjY4zGgnJKaWq7AFmjTUcTjUONpfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39850400004)(366004)(136003)(83380400001)(45080400002)(66574015)(8936002)(316002)(8676002)(54906003)(4326008)(2906002)(36756003)(186003)(38100700002)(6916009)(53546011)(2616005)(5660300002)(6486002)(31696002)(31686004)(66946007)(16526019)(66476007)(66556008)(52116002)(44832011)(86362001)(478600001)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cXRuOTg3aXRXOXVjZ1M2SjBLTTJmc2lJZUZPTlVIU0RPQkVnOVNIb2R1RVp0?=
 =?utf-8?B?ekx1N1VaT2xyckp6YXc2NDVWTm9xeXIySWh3ZG9rT09kclJ6UTRFRzd5bHFU?=
 =?utf-8?B?SnFCeTFUNlZ0U213OWlDeXFuVE1mZ3Nkayt0UlMxWDlxY21FMFV3VUF5WWpz?=
 =?utf-8?B?Rkk5ZXJxTEtCNUYxck4vOUJvV2ZaR0dxZFV4UWcvWEFwa1BSMHRzYm1YVGVt?=
 =?utf-8?B?RUJhdzROR3hDQlNDZm5zN1cxRUk4blUyRnhhOVZwWWhvczZpSVdrQy9FWVdD?=
 =?utf-8?B?WjB2WDZFcm8zb2NDNHE3MktSVmpVN29UMUdrSGJMSGg5RUtnYmRyc3ZCRytR?=
 =?utf-8?B?T1BqVDc1MXpxZHludThPTjZVWHNXNnMxUS9aSUo0STlLakFGTFhyY0VyUnlq?=
 =?utf-8?B?cGQyQk1MbDd0eDdNck9VZXJlNTNUeU83K2Y1UjlHdmlzV0xueGZITzhSQnZM?=
 =?utf-8?B?d1JPWmhNclRjaHo4UFdOdkhJZ1JIZGE0b1YvaXQ2ekwyZll1b25xVnBIeTRD?=
 =?utf-8?B?a0gveUVLQlJ3Ty9HMURsQkVYaGtuMEtZd0xtYjd1NVpOMFBoZ3RYUXJXM3hv?=
 =?utf-8?B?NzFhak03emtkdkdldWRkaFBPcDN4UktoM2dYZDJXVm1razFSVHU5UWFLMUV2?=
 =?utf-8?B?UUNKVmVjUnMwTTE2a1AwZE1uVk94MGF1K1d5V3hXenVhMzNsVEhlZnltMEtK?=
 =?utf-8?B?a3RtU2FKT2N1ampsNnJCNFdoanNrTXc4RUpkdEFISlRmLzFmRUczZzluWWNI?=
 =?utf-8?B?QVNwWVlJMDgrQzlSZTB2ZXJPTVBuTGs5UjFQekxXOVl3bmhxQU9VTnBzUEdT?=
 =?utf-8?B?Q01SVFpuM0hmUFMyMzBQUFdFQkJZeE1HNCtLM2hOZXFLejlTVFBLUHlBS1p2?=
 =?utf-8?B?b3FnZjdEVDlpb0lUQW1YM3Y2cE9KN3N5MjBvSWFrRjRMZDlGdXJKNXFVOXdo?=
 =?utf-8?B?Y3M2NU1HUlBiL2FCQVo1RVE0Y3N5aUFvcERCbnBTcFhNYnBQR01MRzVTME01?=
 =?utf-8?B?VElqakNqWnNhcmZmOXlqNmFKbGVZbkF6MmdjcXJ3NVNFWE1DNHdsOW5Kc1Qx?=
 =?utf-8?B?Z3JTa3p0dVBscCtOSUlWQytSZkxabVlaZVcwanJBQ3ZUZzR0dmF0eXR3Uzdr?=
 =?utf-8?B?bTNTZ0lFTVd3MjROWXd2V3pTMnpma29MeHNOTFNHWWJ1SlZuMlBjRndOKzVa?=
 =?utf-8?B?Zys0MFRoVXhXOEd5cTAzNXpyMGw1YUozb2pZVEtINEFWdWdMN24yTlY4MjE4?=
 =?utf-8?B?QlVUdk5OYWtHMGs3eHpSZjN1Wk1saUVUcmZWSllsWG5CV3VJRU90c092dmxC?=
 =?utf-8?B?YW0vRWJiVVNRSU9oVmp4VTRXdnRrZ1gvcFZGUkFkRys3ZVArZW93dlB3ZjhZ?=
 =?utf-8?B?MUhtN0NBUXdqc3VoRDlHWGl4YkttRFBrbnJ0cHJydGF6TWxhME9ZZW16WjRz?=
 =?utf-8?B?VGduZGZyYWpGcnlKcUJvaG9CL05mRG41cGwyNFBNNTIzZVlCbEtXY0VPQmFZ?=
 =?utf-8?B?MndzT05ucnBkdHJ5WDlnSzQ1MXNubXBGbjlzYW8wRUt5YnZCZjMvT2JGODUw?=
 =?utf-8?B?R0xEcStxc2FZdjVhRHV2U0h0eCt2V25wVkxBMlBOekZCYS94YVZWZGFYUjJq?=
 =?utf-8?B?Z29DTGpuTW1WSWtlTG9ianRnQnV0ekJINVhLaWkyei9GSWN5clB6ejF0Rk05?=
 =?utf-8?B?WGp3VXArVzlocGtIYXpBaFNNeVBpZkVtcVFkK1YwQzNYcU12cnRHNkRqd29R?=
 =?utf-8?B?RXQyWm1Bb2Z5S2dSSTAyeWtySTdSZktMb3BpblB6NXhnVFE4b3EvZmxsNDdo?=
 =?utf-8?B?Mmc3QlFBN1FrYmhmQkFrME5NVENuSXl1L25TT1A3VUw4VVZSSFV2UlRKbUhs?=
 =?utf-8?Q?15DCGNEXKEB8u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1b4574-f168-456a-0301-08d929c0a297
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 14:29:19.0319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVVzfJTDwGdKvh6/yg9npGVdh+z0Kih7lwp8l1pAIL1v6+oakeoTdXvj3kJjo6aovkeocm1W6ucZgF+A41flpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2813
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGV5LCBNUiBjcmVhdGVkIGF0IApodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9k
cm0vLS9tZXJnZV9yZXF1ZXN0cy8xNzIsIHBsZWFzZSAKaGVscCByZXZpZXcuCgpBbmRyZXkKCk9u
IDIwMjEtMDYtMDMgMTA6MjYgcC5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IENvZGUgcmV2aWV3
IGhhcHBlbnMgb24gZ2l0bGFiIG5vdyBmb3IgbGliZHJtLgo+Cj4gQWxleAo+Cj4gT24gVGh1LCBK
dW4gMywgMjAyMSBhdCA2OjAyIFBNIEdyb2R6b3Zza3ksIEFuZHJleQo+IDxBbmRyZXkuR3JvZHpv
dnNreUBhbWQuY29tPiB3cm90ZToKPj4gSXMgbGliZHJtIG9uIGdpdGxhYiA/IEkgd2Fzbid0IGF3
YXJlIG9mIHRoaXMuIEkgYXNzdW1lZCBjb2RlIHJldmlld3Mgc3RpbGwgZ28gdGhyb3VnaCBkcmkt
ZGV2ZWwuCj4+Cj4+IEFuZHJleQo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+PiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4KPj4gU2VudDog
MDMgSnVuZSAyMDIxIDE3OjIwCj4+IFRvOiBHcm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9k
em92c2t5QGFtZC5jb20+Cj4+IENjOiBNYWxpbmcgbGlzdCAtIERSSSBkZXZlbG9wZXJzIDxkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwu
Y29tPgo+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvN10gbGliZHJtIHRlc3RzIGZvciBob3QtdW5w
bHVnIGZlYXR1cmUKPj4KPj4gUGxlYXNlIG9wZW4gYSBnaXRsYWIgTVIgZm9yIHRoZXNlLgo+Pgo+
PiBBbGV4Cj4+Cj4+IE9uIFR1ZSwgSnVuIDEsIDIwMjEgYXQgNDoxNyBQTSBBbmRyZXkgR3JvZHpv
dnNreQo+PiA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4gd3JvdGU6Cj4+PiBBZGRpbmcgc29t
ZSB0ZXN0cyB0byBhY29tcGFueSB0aGUgcmVjZW50bHkgYWRkZWQgaG90LXVucGx1Zwo+Pj4gZmVh
dHVyZS4gRm9yIG5vdyB0aGUgdGVzdCBzdWl0ZSBpcyBkaXNhYmxlZCB1bnRpbCB0aGUgZmVhdHVy
ZQo+Pj4gcHJvcGFnYXRlcyBmcm9tIGRybS1taXNjLW5leHQgdG8gZHJtLW5leHQuCj4+Pgo+Pj4g
QW5kcmV5IEdyb2R6b3Zza3kgKDcpOgo+Pj4gICAgdGVzdHMvYW1kZ3B1OiBGaXggdmFsZ3JpbmQg
d2FybmluZwo+Pj4gICAgeGY4NmRybTogQWRkIGZ1bmN0aW9uIHRvIHJldHJpZXZlIGNoYXIgZGV2
aWNlIHBhdGgKPj4+ICAgIHRlc3QvYW1kZ3B1OiBBZGQgaGVscGVyIGZ1bmN0aW9ucyBmb3IgaG90
IHVucGx1Zwo+Pj4gICAgdGVzdC9hbWRncHUvaG90dW5wbHVnOiBBZGQgdGVzdCBzdWl0ZSBmb3Ig
R1BVIHVucGx1Zwo+Pj4gICAgdGVzdC9hbWRncHUvaG90dW5wbHVnOiBBZGQgYmFzaWMgdGVzdAo+
Pj4gICAgdGVzdHMvYW1kZ3B1L2hvdHVucGx1ZzogQWRkIHVucGx1ZyB3aXRoIGNzIHRlc3QuCj4+
PiAgICB0ZXN0cy9hbWRncHUvaG90dW5wbHVnOiBBZGQgaG90dW5wbHVnIHdpdGggZXhwb3J0ZWQg
Ym8gdGVzdAo+Pj4KPj4+ICAgdGVzdHMvYW1kZ3B1L2FtZGdwdV90ZXN0LmMgICAgIHwgIDQyICsr
Ky0KPj4+ICAgdGVzdHMvYW1kZ3B1L2FtZGdwdV90ZXN0LmggICAgIHwgIDI2ICsrKwo+Pj4gICB0
ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYyAgICAgfCAgIDUgKy0KPj4+ICAgdGVzdHMvYW1kZ3B1
L2hvdHVucGx1Z190ZXN0cy5jIHwgMzU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+Pj4gICB0ZXN0cy9hbWRncHUvbWVzb24uYnVpbGQgICAgICAgfCAgIDEgKwo+Pj4gICB4Zjg2
ZHJtLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMjMgKysrCj4+PiAgIHhmODZkcm0uaCAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMSArCj4+PiAgIDcgZmlsZXMgY2hhbmdlZCwgNDUwIGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9h
bWRncHUvaG90dW5wbHVnX3Rlc3RzLmMKPj4+Cj4+PiAtLQo+Pj4gMi4yNS4xCj4+Pgo+Pj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4gaHR0cHM6
Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZh
bXA7ZGF0YT0wNCU3QzAxJTdDQW5kcmV5Lkdyb2R6b3Zza3klNDBhbWQuY29tJTdDMTU1YjhjYjhk
NjgzNGU4NjI3NWEwOGQ5MjcwMDQxMTclN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3NTgzNzA0MzI2OTY1NTkwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5
SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPUFjbEFZa0lTNHhsRTZjcG1tYU15SW84NmdKNzBQayUy
RmtxSm5jR05BTTNjdyUzRCZhbXA7cmVzZXJ2ZWQ9MApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
