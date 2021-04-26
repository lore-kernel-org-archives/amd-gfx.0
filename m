Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DB8C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 16:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1736D61075
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 16:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1736D61075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5DA89CD4;
	Mon, 26 Apr 2021 16:02:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B17689CD4
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 16:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhFW5DLWgb4R4mx+a0VytvPr27nmCgzFdIFEVzZA9wn4mhNaj/jUztocNqBF4jcL1ghmWBlw4Y5n+oY8lpRTOMrnej6kGXK5s0XcxC9o7kikOSeYzHJYGQiT0gQBvR77Ujjdy8FWsaTUlBDo0lXQCyrNwK5ffmI7WUUuBQbnA0U+TCPxg0h90+wz5sjrrjDSMTkVEIjYTCSjU617097ahd00+gOBhIaLq9qQSYoykqcyB9mFq3BIlIH463dJSEGmzAiyXd23uQWX0a1dJ3n4IAy4Q6xSfD1HZ+yeBOUMlsKYdsE0XP39Cmt43S3gadAvb183Lnw4mwdwub/Kn30ROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq3jfKcoFWvaQFua/QJvRZve5Z9BxwUVmElV2udw2dQ=;
 b=bncnGNsU7JvvkKiq3Xjt1orrf96FhApZACiLZnPnp4k1QnGH1X1t0m5eZij5a1Myrl17wf6rwU/nfNehv2AurfmYpt9MrGlL0UpdTBp/MIo8hwRBffFPNLMs10wR9dWNj3+I4FxloABHx/MXvZqf7BlILaXcUmdP/PEl9BTFK11gXF0vNINzEm/r4kGrN6ussH6XaQLBRMBIpFN5JNBm2EFRHbsBWiAYEeWGA/Pl+prtdHbl/CXf5RAkrvSua8vr4A98JGyxvpsOX14RHUlZBBztV07Mg5cBzAJF2axiWnZG0F18h/ELHlsRg6hmSX247+eFR4Xjl0DVDqqjvbPfug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq3jfKcoFWvaQFua/QJvRZve5Z9BxwUVmElV2udw2dQ=;
 b=wEehGQ6njx3rGINzCMKR/XAOhpOhn7y6eC3B4tW+lQ2nFDVYUtaACgubEa/bAdYLD26dWfeR7sohFFDGy13VqlswyATP4cFfdxTkvcRKm6k2VQXOwhhIRH/zQ+BPphGWMX8R6k9b28G+fvW1pBfgF1R12sPXbVg5FexoYqAcIl8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 16:02:46 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Mon, 26 Apr 2021
 16:02:45 +0000
Subject: Re: [PATCH] drm/amdgpu: restructure amdgpu_vram_mgr_new
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210426085434.2974-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3bcff580-1c9c-c9ab-b5f1-263ea2388cb1@amd.com>
Date: Mon, 26 Apr 2021 12:02:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210426085434.2974-1-christian.koenig@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24 via Frontend Transport; Mon, 26 Apr 2021 16:02:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 343706fa-94ac-4413-3240-08d908ccbb36
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4223E5572D96D1102CA3CBBB92429@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whBdqzvcger5sjsvozWM2H0n6ePmmkUhJXaO7VvC2/J1aR2LtvzauwBuY90+uE/2t96l0TK5BP5/8bRhg5TE5dPykoZj5XiN0ObpZ6ZLl+d5/DE77RhLg6gho9HOt4RRjtv+0ENxSqIqUvZRpYEWTZ582czN6UiAVsNpiNte0DBFFKrRr6xMQI3x1Lebvhg7iOkU98+iugLDYARjULTx5D3sKh8nAbOGtXVzsMPwdMvM7NsBt6oiz0VT8QoO5nJK5+ZJWMkB3jCMI1/A/mluuso/uWpfjT+FbgJCNKYvVMIsn2VHOFGoGSW8w7DwyH7j9gTvn83heLTVW8rMIReZWTKrcJAqnKkuSat0IyCYeNRlAIbblLOETPOh7+GqUqSwrcFfEsZXUKm+JGcJZgBAdgflIndnWRnfELIfkkx8rilxKHOgxt2A/1jEsm0efLh0rxEXCUWEM7HNnYfRKRn8C30K68t5ePCd2DBtNkDaC82iaFl9T/TeN2GOSpxeJXra52Jyz8tHVPWVn5F3o8g/ZWKMshv7IkXlmIoM++u6mvrgrbdClVvZDnTLzVyOSfkrizV2jpp/rslzQbC1aWYm2baIUAHj7l0E+z2SzrhfjhNkn7HMSm+sklOLsIzygFRD0C8zgJOHyXQkUWn9EsRuUjBYWh4v+rr80oyKAu4nGVySj2/ipjcbs/hN4NTavxUQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(31696002)(2906002)(44832011)(86362001)(6486002)(478600001)(38100700002)(8936002)(26005)(36756003)(186003)(31686004)(316002)(66556008)(66476007)(5660300002)(16576012)(66946007)(66574015)(83380400001)(956004)(2616005)(16526019)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VnhEcDZPZWdxLzZaMHB4c013TG0rdVNDdDhSY09TdmNWUkd1ckZXY09oTWts?=
 =?utf-8?B?OXk2enppcWFOaUlkWGh5RkM2MmNrd0JGZ280QU95aEdpdVN4ellpaWxScHMz?=
 =?utf-8?B?R0hZblhPQkQ0L2szQjQ1MVFoWk4weGFLV1V2dHV0Uy82dXhTQTR1TkhPOUZy?=
 =?utf-8?B?dFFXNWdwZEVJL0wyZTErc0xxa0Y0VTFlSGNmNng0ZXJPR0s5eUl3T1lodWN2?=
 =?utf-8?B?U3p4SXpJTk5YTnF1Sm9Wd1ZFYStRV2E4eThtSDQxSWZyUzd6T3pvTkdaN1FD?=
 =?utf-8?B?bW1pSTFPajdCRWZoT3lGMWZUT2pwVDRPMjFiSWJjSzBPVUFLbVlsa1hSd0sv?=
 =?utf-8?B?eSsvM2RIU2RIUDk5YUFUZkMrb1FQM3pTc3Q0dFYvQmRkT2t1WUM1K0puWHF5?=
 =?utf-8?B?akNGc0xUSDJ3WEQycmJYaDlUUGNYVEQyM28xU2dPMWo4a2ZEVW5veWkxZDRX?=
 =?utf-8?B?OWsxdTNjWVNSUXlIaFJGMm8vTStlUWQvTlZPTHRWejhJcEMvZUh5dXRzZ2dO?=
 =?utf-8?B?a3JsaUIwdDNHaXJuZDRDYkw2Z1NLYXc4ZW03YTAwcGMxeDFCc0ZiMnRKQ1ov?=
 =?utf-8?B?WVF0YW5ud0gxeFQ0SDFDTDZQUGM2a2lCVnNaanlWcEFtZEVuOUE0TEVnUlBm?=
 =?utf-8?B?VlJkK0xVdXUxdklGRU05N2hXemdwWTV3NDhYZVpvUk9WK3VFRjh0M0tFWlVh?=
 =?utf-8?B?eU4wZ0NJWWNwQW5KbWtnY0d4cGswVzFSZHFZRGkyQVZQWEdHcHR1WmYzNTJM?=
 =?utf-8?B?VjdnVGcwb3BWdDRvQlFmMzI0elRsUUtaMUpZcFRXUWZtVldHUEZNMDVYMWFq?=
 =?utf-8?B?aG9NMFU0VFdZdmRmSVFqdEI5bm5kWXJnSjZ3MXFxUlBGWUFPY3dnZ015T3Q1?=
 =?utf-8?B?d2RUaVF2ZEpmTFA3c0VhU1RJVHozTng5d2RRTWxGYk9xS1U1VUc0N0FMaUVz?=
 =?utf-8?B?dHJ0L3JOc0RuUGU4MlhaeTkvZkV0Y2V4dlo4MGcwS0thTU9vTldGcHRFckli?=
 =?utf-8?B?dlJMWjdpTGpHZE9lSnM4ZGJPSkxiL04wanJsZk5rNTlJOUExN1pVZnczY05a?=
 =?utf-8?B?aTBqZDExQnNmNVlZeFlDQW9ZOTUvYUNrZXZNNG1zdjlZeUVCRFNqbUJBYjFn?=
 =?utf-8?B?YnQrRFUzTk5mZVlOZWt0czBWeUNDRjV5cW1WbUFVc2JjYXBTenlBUzJuNWoz?=
 =?utf-8?B?RmVsNTFpWFVpaXdLTEtPZ25jSkR3QlZXc3pvMmxvVUI2MzlYL0ZvK09yVzRN?=
 =?utf-8?B?Mi9HNGdKM3pMWG90VzliL3FQU2E5cTI0ckxISlNEQ0NadlB6aHRJYlBCaUJw?=
 =?utf-8?B?ZUFFQ0NLUWtRQ3FDdXVuT2VhNEdwcEVudUN1cXl0cGZScjd3QVE2RC9udFI4?=
 =?utf-8?B?MDE4SnJVMjlyNnBzbm03RTlESnhGalVFOFRyVWR6eXd3c0k0b0VXYU1ranhp?=
 =?utf-8?B?K1hSYXY1RFZXL2ZmMjNpVWdJQzJDbGk1QTJvejdVRWpiU0JYVDcyd01xcGp3?=
 =?utf-8?B?TnVmQS9ReFNhTk5KOGlwaWZQQ08zbEl5djRRZ1JSUER4TkRkam1FTjNuU081?=
 =?utf-8?B?L0cwdXhvazA0Z2VHMmszaTRkVngxdFZNdFB1dVlhdEFQN3p6L2RjQmhrL2Jk?=
 =?utf-8?B?ZEVyamU4bGRKUWpxN0VVbmI2dTRReWNNY01POFoyMktmRnhaZFpyZVN5NWdh?=
 =?utf-8?B?RTZTa3ZsZS93YysyNzhXdzVMNGdUUzFpK3lDTWViUThzQVRQdm9ydHIxQmlE?=
 =?utf-8?Q?0OJofBctXCh7E1FqKAbJQJFltbzM1T7nhKNady1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343706fa-94ac-4413-3240-08d908ccbb36
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 16:02:45.8301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP2hf2x3jKyK+zffxfw0iUUKWn8kHgr99DeZFjA+pBDmBF8mVDTL94wEnTSjLqp46E39r2MisdlpCJda/EwlTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

CkFtIDIwMjEtMDQtMjYgdW0gNDo1NCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBN
ZXJnZSB0aGUgdHdvIGxvb3BzLCBsb29zZW4gdGhlIHJlc3RyaWN0aW9uIGZvciBiaWcgYWxsb2Nh
dGlvbnMuCj4gVGhpcyByZWR1Y2VzIHRoZSBDUFUgb3ZlcmhlYWQgaW4gdGhlIGdvb2QgY2FzZSwg
YnV0IGluY3JlYXNlcwo+IGl0IGEgYml0IHVuZGVyIG1lbW9yeSBwcmVzc3VyZS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAt
LS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgfCA1OCAr
KysrKysrKystLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwg
MzEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZyYW1fbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dnJhbV9tZ3IuYwo+IGluZGV4IDUyOWM1YzMyYTIwNS4uZTJjYmUxOTQwNGMwIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPiBAQCAtMzU4LDEz
ICszNTgsMTMgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdCB0dG1fcmVz
b3VyY2VfbWFuYWdlciAqbWFuLAo+ICAJCQkgICAgICAgY29uc3Qgc3RydWN0IHR0bV9wbGFjZSAq
cGxhY2UsCj4gIAkJCSAgICAgICBzdHJ1Y3QgdHRtX3Jlc291cmNlICptZW0pCj4gIHsKPiArCXVu
c2lnbmVkIGxvbmcgbHBmbiwgbnVtX25vZGVzLCBwYWdlc19wZXJfbm9kZSwgcGFnZXNfbGVmdCwg
cGFnZXM7Cj4gIAlzdHJ1Y3QgYW1kZ3B1X3ZyYW1fbWdyICptZ3IgPSB0b192cmFtX21ncihtYW4p
Owo+ICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSB0b19hbWRncHVfZGV2aWNlKG1ncik7
Cj4gKwl1aW50NjRfdCB2aXNfdXNhZ2UgPSAwLCBtZW1fYnl0ZXMsIG1heF9ieXRlczsKPiAgCXN0
cnVjdCBkcm1fbW0gKm1tID0gJm1nci0+bW07Cj4gLQlzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGVz
Owo+ICAJZW51bSBkcm1fbW1faW5zZXJ0X21vZGUgbW9kZTsKPiAtCXVuc2lnbmVkIGxvbmcgbHBm
biwgbnVtX25vZGVzLCBwYWdlc19wZXJfbm9kZSwgcGFnZXNfbGVmdDsKPiAtCXVpbnQ2NF90IHZp
c191c2FnZSA9IDAsIG1lbV9ieXRlcywgbWF4X2J5dGVzOwo+ICsJc3RydWN0IGRybV9tbV9ub2Rl
ICpub2RlczsKPiAgCXVuc2lnbmVkIGk7Cj4gIAlpbnQgcjsKPiAgCj4gQEAgLTM5MSw5ICszOTEs
MTAgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdCB0dG1fcmVzb3VyY2Vf
bWFuYWdlciAqbWFuLAo+ICAJCXBhZ2VzX3Blcl9ub2RlID0gSFBBR0VfUE1EX05SOwo+ICAjZWxz
ZQo+ICAJCS8qIGRlZmF1bHQgdG8gMk1CICovCj4gLQkJcGFnZXNfcGVyX25vZGUgPSAoMlVMIDw8
ICgyMFVMIC0gUEFHRV9TSElGVCkpOwo+ICsJCXBhZ2VzX3Blcl9ub2RlID0gMlVMIDw8ICgyMFVM
IC0gUEFHRV9TSElGVCk7Cj4gICNlbmRpZgo+IC0JCXBhZ2VzX3Blcl9ub2RlID0gbWF4KCh1aW50
MzJfdClwYWdlc19wZXJfbm9kZSwgbWVtLT5wYWdlX2FsaWdubWVudCk7Cj4gKwkJcGFnZXNfcGVy
X25vZGUgPSBtYXhfdCh1aW50MzJfdCwgcGFnZXNfcGVyX25vZGUsCj4gKwkJCQkgICAgICAgbWVt
LT5wYWdlX2FsaWdubWVudCk7Cj4gIAkJbnVtX25vZGVzID0gRElWX1JPVU5EX1VQKG1lbS0+bnVt
X3BhZ2VzLCBwYWdlc19wZXJfbm9kZSk7Cj4gIAl9Cj4gIAo+IEBAIC00MTEsNDIgKzQxMiwzNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5h
Z2VyICptYW4sCj4gIAltZW0tPnN0YXJ0ID0gMDsKPiAgCXBhZ2VzX2xlZnQgPSBtZW0tPm51bV9w
YWdlczsKPiAgCj4gLQlzcGluX2xvY2soJm1nci0+bG9jayk7Cj4gLQlmb3IgKGkgPSAwOyBwYWdl
c19sZWZ0ID49IHBhZ2VzX3Blcl9ub2RlOyArK2kpIHsKPiAtCQl1bnNpZ25lZCBsb25nIHBhZ2Vz
ID0gcm91bmRkb3duX3Bvd19vZl90d28ocGFnZXNfbGVmdCk7Cj4gLQo+IC0JCS8qIExpbWl0IG1h
eGltdW0gc2l6ZSB0byAyR0IgZHVlIHRvIFNHIHRhYmxlIGxpbWl0YXRpb25zICovCj4gLQkJcGFn
ZXMgPSBtaW4ocGFnZXMsICgyVUwgPDwgKDMwIC0gUEFHRV9TSElGVCkpKTsKPiArCS8qIExpbWl0
IG1heGltdW0gc2l6ZSB0byAyR0IgZHVlIHRvIFNHIHRhYmxlIGxpbWl0YXRpb25zICovCj4gKwlw
YWdlcyA9IG1pbihwYWdlc19sZWZ0LCAyVUwgPDwgKDMwIC0gUEFHRV9TSElGVCkpOwo+ICAKPiAt
CQlyID0gZHJtX21tX2luc2VydF9ub2RlX2luX3JhbmdlKG1tLCAmbm9kZXNbaV0sIHBhZ2VzLAo+
IC0JCQkJCQlwYWdlc19wZXJfbm9kZSwgMCwKPiAtCQkJCQkJcGxhY2UtPmZwZm4sIGxwZm4sCj4g
LQkJCQkJCW1vZGUpOwo+IC0JCWlmICh1bmxpa2VseShyKSkKPiAtCQkJYnJlYWs7Cj4gLQo+IC0J
CXZpc191c2FnZSArPSBhbWRncHVfdnJhbV9tZ3JfdmlzX3NpemUoYWRldiwgJm5vZGVzW2ldKTsK
PiAtCQlhbWRncHVfdnJhbV9tZ3JfdmlydF9zdGFydChtZW0sICZub2Rlc1tpXSk7Cj4gLQkJcGFn
ZXNfbGVmdCAtPSBwYWdlczsKPiAtCX0KPiAtCj4gLQlmb3IgKDsgcGFnZXNfbGVmdDsgKytpKSB7
Cj4gLQkJdW5zaWduZWQgbG9uZyBwYWdlcyA9IG1pbihwYWdlc19sZWZ0LCBwYWdlc19wZXJfbm9k
ZSk7Cj4gKwlpID0gMDsKPiArCXNwaW5fbG9jaygmbWdyLT5sb2NrKTsKPiArCXdoaWxlIChwYWdl
c19sZWZ0KSB7Cj4gIAkJdWludDMyX3QgYWxpZ25tZW50ID0gbWVtLT5wYWdlX2FsaWdubWVudDsK
PiAgCj4gLQkJaWYgKHBhZ2VzID09IHBhZ2VzX3Blcl9ub2RlKQo+ICsJCWlmIChwYWdlcyA+PSBw
YWdlc19wZXJfbm9kZSkKPiAgCQkJYWxpZ25tZW50ID0gcGFnZXNfcGVyX25vZGU7Cj4gIAo+IC0J
CXIgPSBkcm1fbW1faW5zZXJ0X25vZGVfaW5fcmFuZ2UobW0sICZub2Rlc1tpXSwKPiAtCQkJCQkJ
cGFnZXMsIGFsaWdubWVudCwgMCwKPiAtCQkJCQkJcGxhY2UtPmZwZm4sIGxwZm4sCj4gLQkJCQkJ
CW1vZGUpOwo+IC0JCWlmICh1bmxpa2VseShyKSkKPiArCQlyID0gZHJtX21tX2luc2VydF9ub2Rl
X2luX3JhbmdlKG1tLCAmbm9kZXNbaV0sIHBhZ2VzLCBhbGlnbm1lbnQsCj4gKwkJCQkJCTAsIHBs
YWNlLT5mcGZuLCBscGZuLCBtb2RlKTsKPiArCQlpZiAodW5saWtlbHkocikpIHsKPiArCQkJaWYg
KHBhZ2VzID4gcGFnZXNfcGVyX25vZGUpIHsKClRoaXMgbWVhbnMgd2UgY2FuIG5ldmVyIGFsbG9j
YXRlIGNodW5rcyBzbWFsbGVyIHRoYW4gMk1CLCBleGNlcHQgZm9yIHRoZQp0YWlsLiBBbmQgdGhl
IHRhaWwgc3RpbGwgbmVlZHMgdG8gYmUgYWxsb2NhdGVkIGluIG9uZSBwaWVjZSBpZiBpdCdzIDwg
Mk1CLgoKT24gdGhlIG90aGVyIGhhbmQsIHdlIHNob3VsZCBub3QgYWxsb3cgYWxsb2NhdGlvbnMg
c21hbGxlciB0aGFuCm1lbS0+cGFnZV9hbGlnbm1lbnQsIGV4Y2VwdCBmb3IgdGhlIHRhaWwuIFNv
IHNob3VsZCB0aGlzIGNvbmRpdGlvbiBiZQoiaWYgKHBhZ2VzID4gbWVtLT5wYWdlX2FsaWdubWVu
dCkiIHRvIGFsbG93IG1heGltdW0gZmxleGliaWxpdHkgZm9yCmFsbG9jYXRpb25zIHdpdGhvdXQg
cGh5c2ljYWwgYWxpZ25tZW50IGNvbnN0cmFpbnRzIHdoZW4gbWVtb3J5IGlzIHZlcnkKZnJhZ21l
bnRlZD8KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPiArCQkJCWlmIChpc19wb3dlcl9vZl8yKHBhZ2Vz
KSkKPiArCQkJCQlwYWdlcyA9IHBhZ2VzIC8gMjsKPiArCQkJCWVsc2UKPiArCQkJCQlwYWdlcyA9
IHJvdW5kZG93bl9wb3dfb2ZfdHdvKHBhZ2VzKTsKPiArCQkJCWNvbnRpbnVlOwo+ICsJCQl9Cj4g
IAkJCWdvdG8gZXJyb3I7Cj4gKwkJfQo+ICAKPiAgCQl2aXNfdXNhZ2UgKz0gYW1kZ3B1X3ZyYW1f
bWdyX3Zpc19zaXplKGFkZXYsICZub2Rlc1tpXSk7Cj4gIAkJYW1kZ3B1X3ZyYW1fbWdyX3ZpcnRf
c3RhcnQobWVtLCAmbm9kZXNbaV0pOwo+ICAJCXBhZ2VzX2xlZnQgLT0gcGFnZXM7Cj4gKwkJKytp
Owo+ICsKPiArCQlpZiAocGFnZXMgPiBwYWdlc19sZWZ0KQo+ICsJCQlwYWdlcyA9IHBhZ2VzX2xl
ZnQ7Cj4gIAl9Cj4gIAlzcGluX3VubG9jaygmbWdyLT5sb2NrKTsKPiAgCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
