Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B1BC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 07:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6AA6113D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 07:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E6AA6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC38730B6;
	Tue, 27 Jul 2021 07:00:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1236A73074;
 Tue, 27 Jul 2021 07:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEZarTgZn3oFjWma3RxV9jX0XE+Y7kQcunX9BPi/iqE8ZuW7Upeet6KuU779dddxML+tILAw2i1AMGV1fEuXRFfo+m3gGwEMZPalYjFHNUVNY6ITSVsu/k6lCUMD16HGyjE7gsoHrNShU2RUlu5Y12AUWecZWwb1p0whwCm5Qa4Q+hlaT0kXZdtHtUxl3s3g5MCfAE5DsVMN1cQ/UEkUn13+NnZ2QNJ7vyPNkeezlSdZZvtTdOzsXAyReNtIatjEKBMgmo5eM6h7RvBHrE5+jk8OjG5+8rngvoNEbbDN8NDsIF9eJZc/lt3xY+/DexO8ZLqev3XKVAkfNWKf0ZiMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgz+m6Hh6SJsVBGYUtAAYX3augXIXd3tPMiQ5Mc7VHA=;
 b=mwxZpvH0C+OKpWKHPg9Qt0EFKPTE5ahrJI9tjlDPU2WpUE1LKe9V8K/XM7rXxmDXs1XvM28Yyo8hDq3I+/5YoKnCBSv7uWuvQYyNbhWQUzwUGd7/cI/ALUrWDFGvw5TPlyLtacIjsf7/X6ddZ0AsqW/yPLfnpvNXJ4we1RIue0F0M5kQXqCOejYaPxUKYoJjRmCYa3We+EcAZ3FNEEzsqlmm0kfcJgtW6+fRtAxJjO08DJFWMq6j+4whwpKE3jLMfv4JjlKskixVhDpw+IGbQoeGuE5n8j+BWnFXnTgeAqMmJhaQ2fKUimGpTLqxF6/ItJ+aJZHcmLFRe0qNGIAi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgz+m6Hh6SJsVBGYUtAAYX3augXIXd3tPMiQ5Mc7VHA=;
 b=q+snA7zjd7Qs1ssusRQoRyjiGrOfsvQSsC1zOVEGmMyZ1sw536uyHfnYWhp0rCzcOIrl98pG5R/RdyJcIpqBCmKKrwTk5EoiLShiL6rCvSWJnz3xxxsOieQvXTCLTkDkojia0ihs8Lfngu4LlbhN45rQmsJ29k0Q16unPuKdPWo=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 07:00:18 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 07:00:18 +0000
Subject: Re: [PATCH v4 3/4] drm/amd/display: Add control mechanism for FPU
 utilization
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 sunpeng.li@amd.com, roman.li@amd.com
References: <20210727005248.1827411-1-Rodrigo.Siqueira@amd.com>
 <20210727005248.1827411-4-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9af7d914-4934-d8d1-403d-a2c5f113ddf5@amd.com>
Date: Tue, 27 Jul 2021 09:00:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210727005248.1827411-4-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PR2P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ae22:6310:9a31:9877]
 (2a02:908:1252:fb60:ae22:6310:9a31:9877) by
 PR2P264CA0033.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Tue, 27 Jul 2021 07:00:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4d6db74-fff9-48a7-ccb7-08d950cc3114
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42213596F5274BC3F3BC669D83E99@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVjqddZbGPLsNs774OePxpa33fZqFgvqa5iS7hZQfKJEMbDT1mR3EFxAbWy23hEwKNh69iwDZWHnXgkt3ayaTOi1Vd1TZoqi8TG2ux3vYro+mhTxlI9XsNAttX94XOn7gTKv3nC+ivulv4tt2dnpEEM+CUHkwyeRWj3UEot6tFnQi4WvoVlyaAZutP5i3x3SZS6B9Yo5lSzas/W7OCouLds/b2wTr+vH8P/gGKZ1eXCu4/5BpiPgHPWQRT9eZ31VGsRkqZ1XM2/IyBqI8JBi4Y/NGZr6zsFAL44RmjW7XvdxPpxrJIEuGNb8ifH7xvhMRDJHHL7OKQQDdw+J53e/jg5a1LPu6SXAvno3gWIFgdVBdJpkwkGVuAFMItkeNCvtlVQadkwlZa+ZPBhHEW4CYT26zYQt4E+l/90EHvAlelPjg8486O6qi8WT5KwRrTfJtw3O5JuyEr5EtanztFMtaj/x8rvTMrccYudehrIZ/i14I4HbdvjbSjMFyjLxr0VQvVz7WrMgvGKT6FoyzC7iNxIQ9dmToFTiSbEK4VhCSEr3EfhYrfTAk8fKwgvOgdpQaYLajBxtlPdbOB90+8Og/2w+45fTmMxu3cZJnqp0VV6yK065otj/5ymI8JI48GkR51AzvfBLzPRTpk/YWA8jF11M+LoeEh1FJ+lh2eUdcDvUf/1rWSI5RBJyJPSPTzlur0Q654sIms3ZFaQCKvCxFxWkX2fqe5wIakw8B6wg29o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(316002)(6666004)(83380400001)(86362001)(54906003)(66556008)(8676002)(5660300002)(478600001)(66476007)(6486002)(66574015)(66946007)(36756003)(4326008)(6636002)(38100700002)(31686004)(2616005)(2906002)(31696002)(8936002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K08vUW44VzZJVXk1eCt6TzJkUTI4bi9NVHhSSG04alRqeC9IMksybXZURjlJ?=
 =?utf-8?B?NDdNNEtYNEx1L3VEdGh1b3QrOElPMGFiOGYxNkFxbTBrZG9VMmJVdjJoT04v?=
 =?utf-8?B?SGdrdkZMMUQvWjVjNmpGbkJ1VnFGTjlaRXNzMm5aUnByaGEzams3QXYyZGYy?=
 =?utf-8?B?U1dIWHplWWJCQXBVbjAyL1dMV1lxK3MzZXpzbzFWVXRSMzYwM21zME5ucG9v?=
 =?utf-8?B?SFRxdEQ5eFh3Q1VhejZsNlAyMmJHY1FNS0Z6SGZocm4wTUFtU0Iwb2luWWgr?=
 =?utf-8?B?OUNRY2ZVL1VKa1hOM2pCaExTMDlhem44dFF0MnFmTWsyMzV4TEtra05TTHQv?=
 =?utf-8?B?U3IrQTlqUlduQ0k2MGNLLzAySUZIM3h1N1UxcVJOcmxwcDV0NjBWQmVWZE5q?=
 =?utf-8?B?MzVqTEY5TmpkRGpJYVA1SzNIemFoLzdaR3o4dGRTcGx1djVOOGs1SGtMbm91?=
 =?utf-8?B?Qzdid28rcW9jdTJHOFRRNkM1akgxTmoveERiYnlJMFVmSGpUR3RhTFBlcHgw?=
 =?utf-8?B?eVpwOTRFSG1kREFXbENYZTV5c1Vhc3pZQSt4TkpGcVdsbmJrZ2NOU0tBWU9C?=
 =?utf-8?B?bndtT0hFUXBLclNkRlA3N0x5bDZkakt1YXNKTFJYRkFyb3FqYmErejQvbmZa?=
 =?utf-8?B?aWdYWFoyZ214NmVDNE9IVi9sNHlHNWdyemwxbnFwbXc1cUJpc3dOTUhrMEE0?=
 =?utf-8?B?Sy9TeEswTll6SXdKN2d0M0lqcFRQVVB6MnNKY2tYbFVHdzNsVDZ4d2hUYzMz?=
 =?utf-8?B?NEg1Nm1oZzREWjByS05JbFRlcUpxaEpSaDFqNVBMTjRUYkFlUVN1RVgrSHh3?=
 =?utf-8?B?eWdycWRQdDRXZ2JPbmJBcE83ZlhWY1dRaDVzV2Zncm1ncGhMTlNOa3RHZ0pQ?=
 =?utf-8?B?WFZmbUxiL2ZDQU9GQi9TZTh2V0hzTGkrTk5RM1lRNVo2Wm5OTDRmWG0weWRW?=
 =?utf-8?B?d00zNUNlOXo5S3ppa0trc1ExanhGZ25PTjNaUC80LzZTaStMV0tMcGY1Smt3?=
 =?utf-8?B?M0J5eVNJNnAvZzBiZmdqaENkRUJxdVRKc1QxRkp1RU1SQzFXbHVNRjJ4SW9T?=
 =?utf-8?B?S0ZnLzFrNHpuc1dRb1V0ZE0wSS9MQXMzbEF1bFArYXNhb1FBRmpWSlZzZEhN?=
 =?utf-8?B?N1JCRDJwUytwbk53OUJ4Z2haenV2TjRpclh4V2dnMUQrak00cGtZL2JWa0lJ?=
 =?utf-8?B?TVc1ZE9qVEk5UEwzZjJhOGlRYTV4QWtBamR4amFsa1ZuL2htNHVjWjkwbGVW?=
 =?utf-8?B?VFh0OGwzaVVoU1pQWXAvRWlHYXhNYnpxbTNrN3RCdWg0VmYvcUFtVk5pTHVF?=
 =?utf-8?B?T294eWdTLzFoQ0JiOFlPSXFBckZiRUNEUldjVFo1VXp1czJBcENZN29ZNSt2?=
 =?utf-8?B?ZXlZSHhqRktwODFNZ0lNSC9kN1AwamZlcG4vU0UrWCtzLzFOTU16dW1lY0Q5?=
 =?utf-8?B?V3V3dldTdC84amFEZlcvUkVhcXRsUlkxRjRlbjB3RWFJVDFZOVhVVTc0eDNl?=
 =?utf-8?B?VXVyd3dDQWM0RVUwNnBrNWFzV3pGaWV1bDRxNktwV2NYcTNPZm90Z29qZTRB?=
 =?utf-8?B?VTlNNmI2Z2ZDZDZTMi82b0J6VG5yRWszVlptZm9JQUJmdlIxZmdka3lyczFz?=
 =?utf-8?B?UWlXOHM2VnBaa3M3Q3Bvem5lY1dkdGtVeW9nMTlUd0R5KzFVSFN4K2VhdHVy?=
 =?utf-8?B?ZFM1VW8wT0JWUm4rQzc5WjYvZTNxOUEvcCtGeEltNktaMGxSSUtpam42a1l0?=
 =?utf-8?B?eEN3dkVXeUpORXRtZGozTm1qZEUvZVRXVktRWVI0cnFXeUQwTm9Mc012dVJS?=
 =?utf-8?B?UDQ1OXhvaEJ0NkFRaFljMGVVYkZIeXpDRkg2c1Fqc0RDbUFtcnZ0WUNOdWQr?=
 =?utf-8?Q?lB5J4j34/iLWr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d6db74-fff9-48a7-ccb7-08d950cc3114
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 07:00:17.8172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYjtsaTh+GID20Mr2f4XN8o7VXwk8nBRL+NMTaX3l9SqukICZb7XYcKsemSvJh5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: Aric Cyr <aric.cyr@amd.com>, kernel test robot <lkp@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Anson Jacob <Anson.Jacob@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDcuMjEgdW0gMDI6NTIgc2NocmllYiBSb2RyaWdvIFNpcXVlaXJhOgo+IERDIGludm9r
ZXMgRENfRlBVX1NUQVJUL0VORCBpbiBtdWx0aXBsZSBwYXJ0cyBvZiB0aGUgY29kZTsgdGhpcyBj
YW4KPiBjcmVhdGUgYSBzaXR1YXRpb24gd2hlcmUgd2UgaW52b2tlIHRoaXMgRlBVIG9wZXJhdGlv
biBpbiBhIG5lc3RlZCB3YXkgb3IKPiBleGl0IHRvbyBlYXJseS4gRm9yIGF2b2lkaW5nIHRoaXMg
c2l0dWF0aW9uLCB0aGlzIGNvbW1pdCBhZGRzIGEKPiBtZWNoYW5pc20gd2hlcmUgZGNfZnB1X2Jl
Z2luL2VuZCBtYW5hZ2VzIHRoZSBhY2Nlc3MgdG8KPiBrZXJuZWxfZnB1X2JlZ2luL2VuZC4KPgo+
IENoYW5nZSBzaW5jZSBWMzoKPiAtIFJlYmFzZQo+Cj4gQ2hhbmdlIHNpbmNlIFYyOgo+IC0gQ2hy
aXN0aWFuOiBEbyBub3QgdXNlIHRoaXNfY3B1XyogYmV0d2VlbiBnZXQvcHV0X2NwdV9wdHIoKS4K
Pgo+IENoYW5nZSBzaW5jZSBWMToKPiAtIFVzZSBhIGJldHRlciB2YXJpYWJsZSBuYW1lcwo+IC0g
VXNlIGdldF9jcHVfcHRyIGFuZCBwdXRfY3B1X3B0ciB0byBiZXR0ZXIgYmFsYW5jZSBwcmVlbXB0
aW9uIGVuYWJsZQo+IGFuZCBkaXNhYmxlCj4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5Lndl
bnRsYW5kQGFtZC5jb20+Cj4gQ2M6IEFuc29uIEphY29iIDxBbnNvbi5KYWNvYkBhbWQuY29tPgo+
IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IEhl
cnNlbiBXdSA8aGVyc2VueHMud3VAYW1kLmNvbT4KPiBDYzogQXJpYyBDeXIgPGFyaWMuY3lyQGFt
ZC5jb20+Cj4gQ2M6IEp1biBMZWkgPGp1bi5sZWlAYW1kLmNvbT4KPiBDYzogRG15dHJvIExha3R5
dXNoa2luIDxkbXl0cm8ubGFrdHl1c2hraW5AYW1kLmNvbT4KPiBDYzogUWluZ3FpbmcgWmh1byA8
cWluZ3Fpbmcuemh1b0BhbWQuY29tPgo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdv
LlNpcXVlaXJhQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIC4uLi9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtX3RyYWNlLmggICB8IDEzICsrLS0KPiAgIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9kY19mcHUuYyAgICB8IDc3ICsrKysrKysrKysrKystLS0tLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY190cmFjZS5oICAgICB8ICA0ICstCj4gICAzIGZp
bGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3Ry
YWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV90
cmFjZS5oCj4gaW5kZXggMjMwYmIxMmM0MDVlLi5mZGNhZWEyMmI0NTYgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHJhY2UuaAo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3Ry
YWNlLmgKPiBAQCAtNjM4LDIzICs2MzgsMjYgQEAgVFJBQ0VfRVZFTlQoYW1kZ3B1X3JlZnJlc2hf
cmF0ZV90cmFjaywKPiAgICk7Cj4gICAKPiAgIFRSQUNFX0VWRU5UKGRjbl9mcHUsCj4gLQkgICAg
VFBfUFJPVE8oYm9vbCBiZWdpbiwgY29uc3QgY2hhciAqZnVuY3Rpb24sIGNvbnN0IGludCBsaW5l
KSwKPiAtCSAgICBUUF9BUkdTKGJlZ2luLCBmdW5jdGlvbiwgbGluZSksCj4gKwkgICAgVFBfUFJP
VE8oYm9vbCBiZWdpbiwgY29uc3QgY2hhciAqZnVuY3Rpb24sIGNvbnN0IGludCBsaW5lLCBjb25z
dCBpbnQgcmVjdXJzaW9uX2RlcHRoKSwKPiArCSAgICBUUF9BUkdTKGJlZ2luLCBmdW5jdGlvbiwg
bGluZSwgcmVjdXJzaW9uX2RlcHRoKSwKPiAgIAo+ICAgCSAgICBUUF9TVFJVQ1RfX2VudHJ5KAo+
ICAgCQkJICAgICBfX2ZpZWxkKGJvb2wsIGJlZ2luKQo+ICAgCQkJICAgICBfX2ZpZWxkKGNvbnN0
IGNoYXIgKiwgZnVuY3Rpb24pCj4gICAJCQkgICAgIF9fZmllbGQoaW50LCBsaW5lKQo+ICsJCQkg
ICAgIF9fZmllbGQoaW50LCByZWN1cnNpb25fZGVwdGgpCj4gICAJICAgICksCj4gICAJICAgIFRQ
X2Zhc3RfYXNzaWduKAo+ICAgCQkJICAgX19lbnRyeS0+YmVnaW4gPSBiZWdpbjsKPiAgIAkJCSAg
IF9fZW50cnktPmZ1bmN0aW9uID0gZnVuY3Rpb247Cj4gICAJCQkgICBfX2VudHJ5LT5saW5lID0g
bGluZTsKPiArCQkJICAgX19lbnRyeS0+cmVjdXJzaW9uX2RlcHRoID0gcmVjdXJzaW9uX2RlcHRo
Owo+ICAgCSAgICApLAo+IC0JICAgIFRQX3ByaW50aygiJXMoKSslZDogJXMiLAo+ICsJICAgIFRQ
X3ByaW50aygiJXM6IHJlY3Vyc2lvbl9kZXB0aDogJWQ6ICVzKCkrJWQ6IiwKPiArCQkgICAgICBf
X2VudHJ5LT5iZWdpbiA/ICJiZWdpbiIgOiAiZW5kIiwKPiArCQkgICAgICBfX2VudHJ5LT5yZWN1
cnNpb25fZGVwdGgsCj4gICAJCSAgICAgIF9fZW50cnktPmZ1bmN0aW9uLAo+IC0JCSAgICAgIF9f
ZW50cnktPmxpbmUsCj4gLQkJICAgICAgX19lbnRyeS0+YmVnaW4gPyAiYmVnaW4iIDogImVuZCIK
PiArCQkgICAgICBfX2VudHJ5LT5saW5lCj4gICAJICAgICkKPiAgICk7Cj4gICAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmMKPiBpbmRleCBkNGFi
MjdiZjhkMDQuLjMzODA3ZDc0NmU3NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYwo+IEBAIC0zMyw2ICszMywxOSBAQAo+ICAgI2luY2x1
ZGUgPGFzbS9jcHV0YWJsZS5oPgo+ICAgI2VuZGlmCj4gICAKPiArLyoqCj4gKyAqIERPQzogREMg
RlBVIG1hbmlwdWxhdGlvbiBvdmVydmlldwo+ICsgKgo+ICsgKiBEQyBjb3JlIHVzZXMgRlBVIG9w
ZXJhdGlvbnMgaW4gbXVsdGlwbGUgcGFydHMgb2YgdGhlIGNvZGUsIHdoaWNoIHJlcXVpcmVzIGEK
PiArICogbW9yZSBzcGVjaWFsaXplZCB3YXkgdG8gbWFuYWdlIHRoZXNlIGFyZWFzJyBlbnRyYW5j
ZS4gVG8gZnVsZmlsbCB0aGlzCj4gKyAqIHJlcXVpcmVtZW50LCB3ZSBjcmVhdGVkIHNvbWUgd3Jh
cHBlciBmdW5jdGlvbnMgdGhhdCBlbmNhcHN1bGF0ZQo+ICsgKiBrZXJuZWxfZnB1X2JlZ2luL2Vu
ZCB0byBiZXR0ZXIgZml0IG91ciBuZWVkIGluIHRoZSBkaXNwbGF5IGNvbXBvbmVudC4gSW4KPiAr
ICogc3VtbWFyeSwgaW4gdGhpcyBmaWxlLCB5b3UgY2FuIGZpbmQgZnVuY3Rpb25zIHJlbGF0ZWQg
dG8gRlBVIG9wZXJhdGlvbgo+ICsgKiBtYW5hZ2VtZW50Lgo+ICsgKi8KPiArCj4gK3N0YXRpYyBE
RUZJTkVfUEVSX0NQVShpbnQsIGZwdV9yZWN1cnNpb25fZGVwdGgpOwo+ICsKPiAgIC8qKgo+ICAg
ICogZGNfZnB1X2JlZ2luIC0gRW5hYmxlcyBGUFUgcHJvdGVjdGlvbgo+ICAgICogQGZ1bmN0aW9u
X25hbWU6IEEgc3RyaW5nIGNvbnRhaW5pbmcgdGhlIGZ1bmN0aW9uIG5hbWUgZm9yIGRlYnVnIHB1
cnBvc2VzCj4gQEAgLTQ4LDIyICs2MSwzMCBAQAo+ICAgICovCj4gICB2b2lkIGRjX2ZwdV9iZWdp
bihjb25zdCBjaGFyICpmdW5jdGlvbl9uYW1lLCBjb25zdCBpbnQgbGluZSkKPiAgIHsKPiAtCVRS
QUNFX0RDTl9GUFUodHJ1ZSwgZnVuY3Rpb25fbmFtZSwgbGluZSk7Cj4gKwlpbnQgKnBjcHU7Cj4g
Kwo+ICsJcGNwdSA9IGdldF9jcHVfcHRyKCZmcHVfcmVjdXJzaW9uX2RlcHRoKTsKPiArCSpwY3B1
ICs9IDE7Cj4gICAKPiArCWlmICgqcGNwdSA9PSAxKSB7Cj4gICAjaWYgZGVmaW5lZChDT05GSUdf
WDg2KQo+IC0Ja2VybmVsX2ZwdV9iZWdpbigpOwo+ICsJCWtlcm5lbF9mcHVfYmVnaW4oKTsKPiAg
ICNlbGlmIGRlZmluZWQoQ09ORklHX1BQQzY0KQo+IC0JaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVf
RlRSX1ZTWF9DT01QKSkgewo+IC0JCXByZWVtcHRfZGlzYWJsZSgpOwo+IC0JCWVuYWJsZV9rZXJu
ZWxfdnN4KCk7Cj4gLQl9IGVsc2UgaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX0FMVElWRUNf
Q09NUCkpIHsKPiAtCQlwcmVlbXB0X2Rpc2FibGUoKTsKPiAtCQllbmFibGVfa2VybmVsX2FsdGl2
ZWMoKTsKPiAtCX0gZWxzZSBpZiAoIWNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX0ZQVV9VTkFWQUlM
QUJMRSkpIHsKPiAtCQlwcmVlbXB0X2Rpc2FibGUoKTsKPiAtCQllbmFibGVfa2VybmVsX2ZwKCk7
Cj4gLQl9Cj4gKwkJaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX1ZTWF9DT01QKSkgewo+ICsJ
CQlwcmVlbXB0X2Rpc2FibGUoKTsKPiArCQkJZW5hYmxlX2tlcm5lbF92c3goKTsKPiArCQl9IGVs
c2UgaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX0FMVElWRUNfQ09NUCkpIHsKPiArCQkJcHJl
ZW1wdF9kaXNhYmxlKCk7Cj4gKwkJCWVuYWJsZV9rZXJuZWxfYWx0aXZlYygpOwo+ICsJCX0gZWxz
ZSBpZiAoIWNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX0ZQVV9VTkFWQUlMQUJMRSkpIHsKPiArCQkJ
cHJlZW1wdF9kaXNhYmxlKCk7Cj4gKwkJCWVuYWJsZV9rZXJuZWxfZnAoKTsKPiArCQl9Cj4gICAj
ZW5kaWYKPiArCX0KPiArCj4gKwlUUkFDRV9EQ05fRlBVKHRydWUsIGZ1bmN0aW9uX25hbWUsIGxp
bmUsICpwY3B1KTsKPiArCXB1dF9jcHVfcHRyKCZmcHVfcmVjdXJzaW9uX2RlcHRoKTsKPiAgIH0K
PiAgIAo+ICAgLyoqCj4gQEAgLTc4LDE5ICs5OSwyNyBAQCB2b2lkIGRjX2ZwdV9iZWdpbihjb25z
dCBjaGFyICpmdW5jdGlvbl9uYW1lLCBjb25zdCBpbnQgbGluZSkKPiAgICAqLwo+ICAgdm9pZCBk
Y19mcHVfZW5kKGNvbnN0IGNoYXIgKmZ1bmN0aW9uX25hbWUsIGNvbnN0IGludCBsaW5lKQo+ICAg
ewo+IC0JVFJBQ0VfRENOX0ZQVShmYWxzZSwgZnVuY3Rpb25fbmFtZSwgbGluZSk7Cj4gKwlpbnQg
KnBjcHU7Cj4gKwo+ICsJcGNwdSA9IGdldF9jcHVfcHRyKCZmcHVfcmVjdXJzaW9uX2RlcHRoKTsK
PiArCSpwY3B1IC09IDE7Cj4gKwlpZiAoKnBjcHUgPD0gMCkgewo+ICAgI2lmIGRlZmluZWQoQ09O
RklHX1g4NikKPiAtCWtlcm5lbF9mcHVfZW5kKCk7Cj4gKwkJa2VybmVsX2ZwdV9lbmQoKTsKPiAg
ICNlbGlmIGRlZmluZWQoQ09ORklHX1BQQzY0KQo+IC0JaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVf
RlRSX1ZTWF9DT01QKSkgewo+IC0JCWRpc2FibGVfa2VybmVsX3ZzeCgpOwo+IC0JCXByZWVtcHRf
ZW5hYmxlKCk7Cj4gLQl9IGVsc2UgaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX0FMVElWRUNf
Q09NUCkpIHsKPiAtCQlkaXNhYmxlX2tlcm5lbF9hbHRpdmVjKCk7Cj4gLQkJcHJlZW1wdF9lbmFi
bGUoKTsKPiAtCX0gZWxzZSBpZiAoIWNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX0ZQVV9VTkFWQUlM
QUJMRSkpIHsKPiAtCQlkaXNhYmxlX2tlcm5lbF9mcCgpOwo+IC0JCXByZWVtcHRfZW5hYmxlKCk7
Cj4gLQl9Cj4gKwkJaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX1ZTWF9DT01QKSkgewo+ICsJ
CQlkaXNhYmxlX2tlcm5lbF92c3goKTsKPiArCQkJcHJlZW1wdF9lbmFibGUoKTsKPiArCQl9IGVs
c2UgaWYgKGNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX0FMVElWRUNfQ09NUCkpIHsKPiArCQkJZGlz
YWJsZV9rZXJuZWxfYWx0aXZlYygpOwo+ICsJCQlwcmVlbXB0X2VuYWJsZSgpOwo+ICsJCX0gZWxz
ZSBpZiAoIWNwdV9oYXNfZmVhdHVyZShDUFVfRlRSX0ZQVV9VTkFWQUlMQUJMRSkpIHsKPiArCQkJ
ZGlzYWJsZV9rZXJuZWxfZnAoKTsKPiArCQkJcHJlZW1wdF9lbmFibGUoKTsKPiArCQl9Cj4gICAj
ZW5kaWYKPiArCX0KPiArCj4gKwlUUkFDRV9EQ05fRlBVKGZhbHNlLCBmdW5jdGlvbl9uYW1lLCBs
aW5lLCAqcGNwdSk7Cj4gKwlwdXRfY3B1X3B0cigmZnB1X3JlY3Vyc2lvbl9kZXB0aCk7Cj4gICB9
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY190cmFjZS5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3RyYWNlLmgKPiBpbmRleCBkNTk4
YmE2OTdlNDUuLmM3MTE3OTdlNWM5ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNfdHJhY2UuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY190cmFjZS5oCj4gQEAgLTM4LDUgKzM4LDUgQEAKPiAgICNkZWZpbmUgVFJBQ0VfRENO
X0NMT0NLX1NUQVRFKGRjbl9jbG9ja3MpIFwKPiAgIAl0cmFjZV9hbWRncHVfZG1fZGNfY2xvY2tz
X3N0YXRlKGRjbl9jbG9ja3MpCj4gICAKPiAtI2RlZmluZSBUUkFDRV9EQ05fRlBVKGJlZ2luLCBm
dW5jdGlvbiwgbGluZSkgXAo+IC0JdHJhY2VfZGNuX2ZwdShiZWdpbiwgZnVuY3Rpb24sIGxpbmUp
Cj4gKyNkZWZpbmUgVFJBQ0VfRENOX0ZQVShiZWdpbiwgZnVuY3Rpb24sIGxpbmUsIHJlZl9jb3Vu
dCkgXAo+ICsJdHJhY2VfZGNuX2ZwdShiZWdpbiwgZnVuY3Rpb24sIGxpbmUsIHJlZl9jb3VudCkK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
