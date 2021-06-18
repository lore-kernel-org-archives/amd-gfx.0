Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC52C49361
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 15:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0855B6120A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 15:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0855B6120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989EC6EA39;
	Fri, 18 Jun 2021 15:40:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48A06EA39;
 Fri, 18 Jun 2021 15:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWM8ZIM7/UEG1oPmRj/5xdGaGC4bHb0WUK1KW6AZb9n6tKH6AKoEleoBNZN7id8jSaAdu7eZ4TxtJPf6+2zqweOju/Wl86+jVwiYyUTBukdBbIcTCwckdJasWPSz0FRubxJ1GfC/NLv4Ud4nRs4HXzVEeVYEXr/BZpNbpGbLauoJAvy4MmEG0TLtEAJBTiCZoMisRtNwFzW9xK27QFNlGjbikRRgc74r00hYy6WJknb47nHGYSiD5EPTiM23y+/dlwH7tSiHOxcuQYTChKr7E85JpPhYjICzJygMdoCAhF6kL/IOrVyMA4semh20YaJrdcOSD4rK+70dSbgZPKYuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TAWZOjpT5bucATXH92Xv9rGIe8N6+rs9b9l8UXk9mg=;
 b=jTTDy6OoWdvC/HmWnkcYERsGoOxpkYErD2UBmBFT+hbl8CVDsLuLb6Sx6lxbqyvwDxm6tqfLkUPjYaxmeGGl7vN/L13MwrmwpaKRhdA5A11bs5bc1ZMX7LQPzQClxGGY5jxl9a0f7oOsxkT8Pxh55PsyDylGgxjzonR2kG08N1M9MxM3hK+8Ya61eu6kq8cNCsjYho1b2tJKRrdjSo/2SvxJw8CsTEo1bYq68SmXTQGElAAJlziOzyrMx1CVMQGSw6XgrUUG2h0dbB4xDUlTXgH7XgB26Jd2hScxyKlmI5/D04ochT+tS2A1NQBMN2esuLPSuRAs+WSIlGoJ7qLY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TAWZOjpT5bucATXH92Xv9rGIe8N6+rs9b9l8UXk9mg=;
 b=PTe/Zlww+W56EbHnnciyfpQbA3tIcvfZohcpPkFMsyyYOYFp2rZfD7BeTB/czuwG9tUNVjo5qOosiStSP6iQbgJ9r4/5rMr1uEF+UJfLRyTp7JzaRIEkqQkuNjxtFtMpSjEazs8Z2kMY6SwEFgllVikzGZtVlu0YJBqPJXpXdp0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 15:40:55 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 15:40:55 +0000
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_preempt_mgr_new()
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>
References: <YMxbQXg/Wqm0ACxt@mwanda>
 <fadcee22-d830-c1be-09f0-9788b98c45ec@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <adee15a2-f531-688c-1121-7504163ae441@amd.com>
Date: Fri, 18 Jun 2021 11:40:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <fadcee22-d830-c1be-09f0-9788b98c45ec@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::11) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Fri, 18 Jun 2021 15:40:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aff9dcaf-04de-4c9d-bc5d-08d9326f7632
X-MS-TrafficTypeDiagnostic: BN9PR12MB5338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53386073AEC9A26E5D773D0C920D9@BN9PR12MB5338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMeWHzjrHRUAtrU1u1zuKugP6eUZuVI9dqKSBR4Y9jugpo7xM7D0yXEcI9kQPVVuS8esaWMi0MtHs3abZpBUC1B7GPP2MyVr9FPuYWVCzG4vRgXLqHuE2UmBMvMLODgsChHgOX/C4SCz+0DiQBCHWW6UUgVUR8+cY2Da5bxrE1IyA9sZ3oVLVeMZSOaKNsEw2zJwTt8dzYb/Q8pkPAYTdxI8nGM90XkPrJHLXPmRJ6p3lzb5z9yxvKWKF8Q0qDKG6s4dUGVNcLzfHmDgIahb0b9Q+MgVfBrtB8QVXofGcjYZMKZjKUXnxRBXHhCe+8KyCin+Z4hniXXHmxtWoTBCxeaXL4mONZqsw+ynMftEXoG1UU8hR1rm5NbqRLphp2UkSA+EXK79i40T6/2+UYjjBw2v2imEcYSShcMTaFX7dEgH5wCh+vwkxypTYWbnInzDrlnbvb060COSdHIHnPuEy2er3+n81fxza+N0hEbmZZFiPff931lPfvIal9wvHlFYG+YihCnhcyzdLOJ6KvtM8lXA/owz7lpjrztR3FNc4mm2nfY29pyc9Zp/Bj3NJo5bmHThY/ZKEoxn1zWxt/FhucNS3UqtMvVy4o26MezCE36+fp0OaCRoEwaS1IaCATSbxzy/mTsc9sa40QzAYHnFGhUmLOZWOowz4aOJgviHU1juzeM671diddvdEmnzdInP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(110136005)(316002)(38100700002)(54906003)(2906002)(83380400001)(44832011)(478600001)(2616005)(186003)(66946007)(16576012)(66574015)(5660300002)(26005)(86362001)(956004)(6486002)(8676002)(16526019)(4326008)(31696002)(8936002)(31686004)(36756003)(66476007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkZuNzEwaEpia0wzNmFlbVFFNDZweHJnRlpUVlEvQUUvTHlvMDl6ZXFlVDd0?=
 =?utf-8?B?VnhVL1lyRkFTS1VGcDYwTHMxOEUwS2w2Umpwamk1TEhwcmtCYTFLUjNwZU44?=
 =?utf-8?B?bDB0NU9ZZElVUWU1dGc4T2V3bUZIeXZjNXRUSlpRcnN1OHpCOVhHaE4wZGU5?=
 =?utf-8?B?TEROQzV5U2NoakdvbXBvU281Mm8yMkpIR2d3ZWdoeUMrQnFGcEkzdFVRM3lX?=
 =?utf-8?B?bmtsdkEyQy84SkVUc3JqVEJhdklMMml4V1pzZTFvRmN2MWNlNUJvSzNrR1dG?=
 =?utf-8?B?ZHNGcHVlNVdHRTM4K09pM0syYUJ2YVZ2ZUw0WVhUSkVxMXVxSWpNcm8rT3Fl?=
 =?utf-8?B?eUtKelJxMEZMNHMwMklyT1FHRm9hSkRnMW9JWkdmaS95bVdlU1FTc1hEOG1L?=
 =?utf-8?B?WjU2REdDYmhjRm9VaVRvWW1FL1ZRSk8xOURmNkxpbjBxWW5rMFVFWDZaK3Qy?=
 =?utf-8?B?cHdVbnhOZjE5dDJsQkFyZnNkMjBmWDlsRXFtb21vZk1IaXplZGJVeVRqY3JG?=
 =?utf-8?B?eEdHUmpYcXNNY2ZBbTlZeEFSYXhwN0szN3hQenk4cEZFWEdwaC9lZzQ2Vy9L?=
 =?utf-8?B?TDNRbVdoOVFEUFF4K3VYQng2aGV2QnRXcUt2RWRldVB3dVJGWE9uOXFoQzh2?=
 =?utf-8?B?NHBwRjdoTW1tQytRZUhFL0VoaFlpSFNYWWJ0UVAwc3hOY3p0azVlaDNPRkN4?=
 =?utf-8?B?Q2FodUpFSTRGd2V0RHVYZVZ4MnVFdE1zZHo5OWpMTzVQb3NtOHMrOUxZOGZQ?=
 =?utf-8?B?N0lmMCswc2Z2cWJFU3VLYTV0SXMrNWg4MWRFeVp2eWdncUpIZ0htdUZNTDI5?=
 =?utf-8?B?NXYrbXdvcS9VdkdVcko1YzNNdnE3OVYxT0F6L2ZKNytVRXlkNGFiK2JaYU9L?=
 =?utf-8?B?SWI0SnpWMDZYYXFaMjNSUWZ2ZmVQQmdWQXpBam1lbEs3WUdMZ1FPOTduU05E?=
 =?utf-8?B?cXFQRzNsNXFEa0FkU1FzMlZtSWFGTm13RFBpQ0prU3U1TFRGc3p1SXFSSGRW?=
 =?utf-8?B?MWNzZjdHS3kyalhpSU1waHNiZXI3MmZ5YUZkT0RFdCswY2MzTCtGTVNqQlND?=
 =?utf-8?B?S0V1NnROekZ2dXJqcHcxWnlINk9GNThKenhRcnJ3VDd5SnJCWUZXZDNldGRs?=
 =?utf-8?B?MDJja2JwcTFuUnNvcUlCUEtrOVBGVndQUUNlUmFqN2ZIT0lJTjJBOTJyNHNn?=
 =?utf-8?B?T2swUEI5d1R1TnhISzFHZkZVVHdWSlVad0lCdlJLWTFrQkF2bVJrbjZTQmdQ?=
 =?utf-8?B?QjBrdHNmbTlZN09idk8wcWEyNUdraU1qZWRST1RPOUVQVGhsZzVLYVVOT0Ra?=
 =?utf-8?B?Tk1tdlRkczNVbitoRSthbVJzenZ2citQTHdnalQwZGpMVmpPTDdYMjA4WFFr?=
 =?utf-8?B?SGI4d0dIaExCR3Bxa2VWRHhwak1ZMTNsQXg2MER1UTI3T0lyY00xOTNSc0c0?=
 =?utf-8?B?djdicHllMk9lY2dIdHdmdmtmSkpaNTR4Mlk0VSt0V0NOcSt4a0hscFptMTFq?=
 =?utf-8?B?YXhkV0lBek51czU2ZEpKNjBCZUloeHpQTFZJNmRpU1lONm45VEdyd3QwMzVL?=
 =?utf-8?B?UDlqNFhpM3dhYi9jVkZZR1BEL3lvQUthN1FIZk4yN0xxUi9lcFBXOVd1RnBa?=
 =?utf-8?B?SElPWEtMV2ZGVGdoMVh1bE1jWGJ2bEY2cGppVEdENHR5UE5URG1CRWVJL2px?=
 =?utf-8?B?bVhYWUpJZjE3MzV6VjFUengvLytJRFpCbHlQdnRiaFE1cmdpL2ZqMFR4NkNv?=
 =?utf-8?Q?+WAnkpWWuOOO8Yi1wfa8otoK0Wjra3/7hUTKP0A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff9dcaf-04de-4c9d-bc5d-08d9326f7632
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 15:40:55.7163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJBEImjLaKlItBZ4fHMPG0bOw9ZGoUomMdbbEcipRQkUe8jUxsQ1mPur/A8wykKmQ4HIrkcBhAmbgzG0lBwc5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0xOCB1bSA0OjM5IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFt
IDE4LjA2LjIxIHVtIDEwOjM3IHNjaHJpZWIgRGFuIENhcnBlbnRlcjoKPj4gVGhlcmUgaXMgYSBy
ZXZlcnNlZCBpZiBzdGF0ZW1lbnQgaW4gYW1kZ3B1X3ByZWVtcHRfbWdyX25ldygpIHNvIGl0Cj4+
IGFsd2F5cyByZXR1cm5zIC1FTk9NRU0uCj4+Cj4+IEZpeGVzOiAwOWIwMjBiYjA1YTUgKCJNZXJn
ZSB0YWcgJ2RybS1taXNjLW5leHQtMjAyMS0wNi0wOScgb2YKPj4gZ2l0Oi8vYW5vbmdpdC5mcmVl
ZGVza3RvcC5vcmcvZHJtL2RybS1taXNjIGludG8gZHJtLW5leHQiKQo+PiBTaWduZWQtb2ZmLWJ5
OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Cj4KPiBNb3N0IGJlIHNv
bWUgZmFsbG91dCBmcm9tIG1lcmdpbmcgaXQgd2l0aCB0aGUgVFRNIGNoYW5nZXMuCj4KPiBBbnl3
YXksIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CgpUaGlzIGlzIG9idmlvdXNseSBub3QgZm9yIGFtZC1zdGFnaW5nLWRybS1u
ZXh0LiBDaHJpc3RpYW4sIGFyZSB5b3UgZ29pbmcKdG8gYXBwbHkgaXQgdG8gdGhlIHJlbGV2YW50
IGJyYW5jaGVzPwoKVGhhbmtzLArCoCBGZWxpeAoKCj4KPiBUaGFua3MsCj4gQ2hyaXN0aWFuLgo+
Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHJlZW1wdF9t
Z3IuYyB8IDIgKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHJlZW1wdF9tZ3IuYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
cmVlbXB0X21nci5jCj4+IGluZGV4IGY2YWZmN2NlNTE2MC4uZDAyYzg2MzdmOTA5IDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHJlZW1wdF9tZ3IuYwo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHJlZW1wdF9tZ3IuYwo+
PiBAQCAtNzEsNyArNzEsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9wcmVlbXB0X21ncl9uZXcoc3Ry
dWN0Cj4+IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCj4+IMKgwqDCoMKgwqAgc3RydWN0IGFt
ZGdwdV9wcmVlbXB0X21nciAqbWdyID0gdG9fcHJlZW1wdF9tZ3IobWFuKTsKPj4gwqAgwqDCoMKg
wqDCoCAqcmVzID0ga3phbGxvYyhzaXplb2YoKipyZXMpLCBHRlBfS0VSTkVMKTsKPj4gLcKgwqDC
oCBpZiAoKnJlcykKPj4gK8KgwqDCoCBpZiAoISpyZXMpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVOT01FTTsKPj4gwqAgwqDCoMKgwqDCoCB0dG1fcmVzb3VyY2VfaW5pdCh0Ym8sIHBs
YWNlLCAqcmVzKTsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
