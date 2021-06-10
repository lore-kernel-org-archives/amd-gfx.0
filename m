Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355F9C48BCD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 08:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047F26140F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 08:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047F26140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31216E866;
	Thu, 10 Jun 2021 08:20:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A937D6E866;
 Thu, 10 Jun 2021 08:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty1bzPNhmfQe57733ifGKe7HCKVpc0chEAobE4e1BOke14Eh4adEGH4A8gQlRCZyA1AeczyWM5L6NVTUU02yhepTscSOeIWr2h94Yfhq1piRnjPBRPKghvVKLG87s0qVpwqnRU/ZkZTrDpQwUF5YDNyCPP1f/l033oRM5fj6Nkp+dDpIYZ4nC7PRzp4CO3t9/t02cgfDi7s0B2l1lB1hzN8vL35WpLR/xlBaXRbx7JULrwPOKEQjM/M94b6ClXWcOiYnI8lA+7MDnWrSIf9Ci6VVYfnqCtd9DrFZXNq1CGZtAFBgCZEeopMnZWvEWf4pYNam5hN7H8tfBYROTber/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0A4d5ctWY1bZbzaTTd6QmrAMXn9FBSbGqiOP5U+Kbw=;
 b=ibS1YR0nh0Pk48Hq0kRTfUMOdASqYoofZTzQNvH5cTJkXedDvVBtznjxnxDIvUOUV3ASiWhjTjvRLC7+8Z6knoxtZYnBxExXIeFVh3PRkZIXJC+rKtJ5KqdXgCDIrCZfi3EYGXhPnhbB/yrtsvlV2h4snwodUrAqj3B79prEkO7brpyyOMtU9gfMyPxK89GbnEFJCeDU9AfPC0enief2t8TZuE4L8uI8rluIR3KLi3I7re+lQiiwYZY7ddhy33ILHMAg/lps68lm2RRIQTyArfPfwHniQ6RpzN44vYK26kgZKoEVsrOSsTxXDn97BtQT+Gv4DSbQzy0QPAdLqAVZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0A4d5ctWY1bZbzaTTd6QmrAMXn9FBSbGqiOP5U+Kbw=;
 b=prfck7yr+lCd6stvR1Vd1uV3v8Fa2PHB/cH8WDmleTtl1orFELgpTpOzxTrLUb2rsdaACk12RghI6hWhgLFQ2YX7fQ/nAIVS2VrRQi6I2g0K133XpZI6uV8owpBqfxZ0v1jb9mNkxrBxBJe7C67Qyhcw4QKt5TPlUobrxGcqHNM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 08:20:52 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 08:20:52 +0000
Subject: Re: [PATCH -next] drm/amdgpu: Use DIV_ROUND_UP_ULL instead of
 DIV_ROUND_UP
To: He Ying <heying24@huawei.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch, airlied@redhat.com,
 bskeggs@redhat.com, matthew.auld@intel.com, Ramesh.Errabolu@amd.com,
 mchehab+huawei@kernel.org, Dennis.Li@amd.com, funfunctor@folklore1984.net
References: <20210610082005.86876-1-heying24@huawei.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5ffe00de-a7b6-3ac4-f61a-5f28b653e7b1@amd.com>
Date: Thu, 10 Jun 2021 10:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210610082005.86876-1-heying24@huawei.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:c285:5f9a:99f5:633e]
X-ClientProxiedBy: PR0P264CA0229.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:c285:5f9a:99f5:633e]
 (2a02:908:1252:fb60:c285:5f9a:99f5:633e) by
 PR0P264CA0229.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 08:20:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c31637e3-1331-49ab-f06a-08d92be8a900
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB491322D83EE52363D3026AAE83359@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:214;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvEPTcE6KlWk1bTaIXi7StsgjFY0Fbc7rpg/zyvtDZd6weOeO8olEiAK+LXxH2+dbvvfkcB8BLAmNyTTI3+78pDI2A7C8dyEznt9UlPLtA80QxuwRYrIAO3ErGyZwDbI4balP5Khjo2EtGXL6jfwmb/GP/Nj53aeA6LQrrd+eUYxdO2/CNC8ivkXYMElIJvfZytjKeHGQ38uIdRTbztmSrocv24zdhe0ntS9aBBsprhdsQeH2snlP0wv6t749sod7pkssZMvzodLUM02FpiliVeZCGjdWj5E9dW8SlMQYFknxHGAmUHXLZrxhb+Kp8toqWqsJw+hXJRuMdqgaQFe3P9ulM889QFJWEOoM+pgy+zVy/gEeDsSEZkMKEVTv+YNt1o1pUTi7eb7ID9WfCNmwH9/a4L8dkc8zMpwd9OtReC8eVmK94Bq3UEtF0xN2yzsdNvIKy5NmdjrAGjH07eCbNm8MnuGfwODZxlYejz5Otvt6YXbyvR0irBmgr/nGDEQk4AQD39+e6hnAj2BdOv/24UvQMqCQDA0nNTT2PXWoRS0OSOlFml7e5LxT1OkUlzNCq/LE1r5L3TUrsKgHosuWQKnvtp2sKgqs+cJJvVtLWgvIGtIin6ZPpEizF6JVWhdIy78VeDFEaYjAGn4gMpYYffyKqP9sEVi+hyrAG4MbdmV4Z5EK/J2HdJONbHeDuV7ftvAriUj9CAxrQ2wLGkLTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(8936002)(66476007)(66946007)(66556008)(8676002)(86362001)(921005)(186003)(2906002)(31696002)(38100700002)(16526019)(6486002)(316002)(6666004)(31686004)(2616005)(83380400001)(4326008)(36756003)(7416002)(5660300002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUhnNzYzNnNsdHZtZ3hUbFJabnBmN3NjdEdDMHJIUGxsLzNkS3NZdXFRQ3Yv?=
 =?utf-8?B?MEpVNSs5WHdJZEtuU2JkbGlUVHp5TnNERTRJU05wN2NGWWw5alIrbkNrTjlx?=
 =?utf-8?B?MjQ3TGJudHM1N0h0VnhFOGd3cy9tVDFQc2pJUDNVZ3F2bjJEWVpONjRhMmJ3?=
 =?utf-8?B?QkJtQStVK010U282eHp2SlZvcU1WRHgxZXE1eGdOUDBJOVdGN21mVnNKZHBq?=
 =?utf-8?B?MU9zNHl6aXBoVlhHWm9pOVVENXhzb1c1cElZa0xWWUhDaDIwY2puZ0lmM2NE?=
 =?utf-8?B?RU5xTE1sWHZMTUNvTUV0cmdUeHBpN2JodStQU1JIZ0FtRlJNeXRnclBEcTda?=
 =?utf-8?B?bzNTYnhwSjdiTkJaNmlFVmE4b2Yvc2VBRjBod3VnQnRTbHNsVDFGYXN0YWsx?=
 =?utf-8?B?YjkwQ0sxTmYvMTBCOHdidmJPMSsrdVk3VFFEOHVxTFNuUGJ6NVR1NGQwYmlL?=
 =?utf-8?B?N2hNbFJQWnZZdTRta1FPUjZWTVF3RzFxaTFnM1Q1ZHpNMzhhbXc1NnB1RFdo?=
 =?utf-8?B?ZnhPME5td0dlZ0dkQzBzWCtBMlRGM2tLOGJSdzRvcVJIRXFVTmQxb1gxSnVG?=
 =?utf-8?B?d1FwSGZQUDdpWmQrTG5WSksxbzk2eDdWL244dFVVOVp3cE50a0M4emo4TEJx?=
 =?utf-8?B?ODZ1ejFQeDhDYkhUTHhyM2QwM3FzbndjQTJ6cS9BTnNCWktPYnUzbFN5V01W?=
 =?utf-8?B?Snl3dHREVnRkRGtPeTVES3NlSTVldEpjVkJvdkNqYllXM1J5VEhpM2tzeVZw?=
 =?utf-8?B?RnoxVXB4UDdXWWdOR0txcUsvU0x6blRRR3NWUExCNlYrZGk4WFZUWWZla0Fz?=
 =?utf-8?B?cmNiSlphQjFObVd1T1ZJVzdzNVlTeGFnQWNuZEJyaUlUbFR3aFc4MkJKS3lB?=
 =?utf-8?B?REVaOXJVelROWFB2NG1xSTMyc0NERzVtQzd6YmRBODhVREc0aFIvYmRpSzYx?=
 =?utf-8?B?MHAyZXZjMXBrcXoyNU5yQWJMTmsvZlRYK0xRejArU2hpVlN4b3VQSEFhMjNC?=
 =?utf-8?B?N2Q2MFUvSWh1TW8rRGF3bjVsQk5tT2NncGViTHFQYnZpcFk3RlQwQXord1My?=
 =?utf-8?B?b0NSU1JDbTNrejBZSTJaQU1lYStzYWdMWFBGSTJTaUEvdjRJOU1reTh3aDln?=
 =?utf-8?B?RlM4dzN0RHY0NkhpMUVRWm00bFFjUUZ6ZERjY09kUFladFozQm5PL3ZRTSto?=
 =?utf-8?B?YXI4TGZxL2wrbnZyUjNaVkdJVVpwNkJyemNwWUdTb2dDRHZFZmdPNVZ3R1hp?=
 =?utf-8?B?R3B3b2owNExRc08yK3J1Zzh1Y2p4MU5NTUlza2s4bTJJWFBMckI3SEpFMHVN?=
 =?utf-8?B?NUpNODBVcWtGMWphVGxOTXRWbzRVa2dibFgzV3NXRExxMDRuamNjRU5KTUI4?=
 =?utf-8?B?Qmt5VTRpQ3FmTW51dUg0eXI2YlBYcDRiUExHT3JUazIyQ3pKclVMSENVVVVx?=
 =?utf-8?B?dm11QmxqWnNtdjlmZXo2bTRObkpnQmo1WmVoeHIvNktad3JlK0x1QUwxRGxp?=
 =?utf-8?B?VmtyWDlsdmxxZEhNbWFaLytWTDFXZ2xnamdackJHaW1RZzZvRU0zS3UxV1Fm?=
 =?utf-8?B?K1kxRHRsaGg2NG56TzdYYkNWbnEzVEo5TzA3bi9Ddlh2alB0RWwrcUJxTFMy?=
 =?utf-8?B?c3E1MWJVdmpRR054bVBVcTFYaTdaUTU1T3N3UThGSmR4Sm1ZZE5jYmc1TW1Z?=
 =?utf-8?B?NkhQR1ZyNWFFUlBBN1NxK1lYLy9SL1EyM1U4Y3hvZzRZREk5WFZjZWJ4LzE0?=
 =?utf-8?B?alRKV0RzVHI0b2ZJc0VrclNhdC9KeVdWakVCS3lpSW1HMi9uc1RqY0pBQmhl?=
 =?utf-8?B?Z1lxUXE5K2JIdzNnSUxuY1VsN05IRk80aDQ5TDZBZ1prUm50bzJxMitZV29O?=
 =?utf-8?Q?It5MpIzbzfgTD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31637e3-1331-49ab-f06a-08d92be8a900
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 08:20:51.9652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHVJcJXiT+L+mT0xVxSsrYpHElnMgyI56N/jTXZ1WswPRE8zEsQT8W5I1OzgXknu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxMC4wNi4yMSB1bSAxMDoyMCBzY2hyaWViIEhlIFlpbmc6Cj4gV2hlbiBjb21waWxpbmcg
dGhlIGtlcm5lbCBmb3IgTUlQUyB3aXRoIENPTkZJR19EUk1fQU1ER1BVID0geSwgZXJyb3JzIGFy
ZQo+IGVuY291bnRlcmVkIGFzIGZvbGxvd3M6Cj4KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdnJhbV9tZ3IubzogSW4gZnVuY3Rpb24gYGFtZGdwdV92cmFtX21ncl9uZXcnOgo+
IGFtZGdwdV92cmFtX21nci5jOigudGV4dCsweDc0MCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YF9fdWRpdmRpMycKPgo+IE1ha2luZyBhIDY0IGJpdCBkaXZpc2lvbiBieSBhL2IgKGEgaXMgdWlu
dDY0X3QpIGlzIG5vdCBzdXBwb3J0ZWQgYnkgZGVmYXVsdAo+IGluIGxpbnV4IGtlcm5lbCBzcGFj
ZS4gSW5zdGVhZCwgdXNpbmcgZG9fZGl2IGlzIE9LIGZvciB0aGlzIHNpdHVhdGlvbi4gRm9yCj4g
dGhpcyBwcm9ibGVtLCB1c2luZyBESVZfUk9VTkRfVVBfVUxMIGluc3RlYWQgb2YgRElWX1JPVU5E
X1VQIGlzIGJldHRlci4KCkFscmVhZHkgZml4ZWQgYnkgdGhpcyBwYXRjaCBpbiBkcm0tbmV4dDoK
CmNvbW1pdCA2OTFjZjhjZDdhNTMxZGJmY2MyOWQwOWEyM2M1MDlhODZmZDliMjRmCkF1dGhvcjog
RGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT4KRGF0ZTrCoMKgIFRodSBKdW4gMTAgMTI6
NTk6MDAgMjAyMSArMTAwMAoKIMKgwqDCoCBkcm0vYW1kZ3B1OiB1c2UgY29ycmVjdCByb3VuZGlu
ZyBtYWNybyBmb3IgNjQtYml0CgogwqDCoMKgIFRoaXMgZml4ZXMgMzItYml0IGFybSBidWlsZCBk
dWUgdG8gbGFjayBvZiA2NC1iaXQgZGl2aWRlcy4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBG
aXhlczogNmE3Zjc2ZTcwZmFjICgiZHJtL2FtZGdwdTogYWRkIFZSQU0gbWFuYWdlciB2MiIpCj4g
UmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IEhlIFlpbmcgPGhleWluZzI0QGh1YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPiBpbmRleCA5YTZkZjAyNDc3Y2UuLjQzNmVjMjQ2
YTdkYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJh
bV9tZ3IuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21n
ci5jCj4gQEAgLTQwNyw3ICs0MDcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXco
c3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCj4gICAjZW5kaWYKPiAgIAkJcGFnZXNf
cGVyX25vZGUgPSBtYXhfdCh1aW50MzJfdCwgcGFnZXNfcGVyX25vZGUsCj4gICAJCQkJICAgICAg
IHRiby0+cGFnZV9hbGlnbm1lbnQpOwo+IC0JCW51bV9ub2RlcyA9IERJVl9ST1VORF9VUChQRk5f
VVAobWVtX2J5dGVzKSwgcGFnZXNfcGVyX25vZGUpOwo+ICsJCW51bV9ub2RlcyA9IERJVl9ST1VO
RF9VUF9VTEwoUEZOX1VQKG1lbV9ieXRlcyksIHBhZ2VzX3Blcl9ub2RlKTsKPiAgIAl9Cj4gICAK
PiAgIAlub2RlID0ga3ZtYWxsb2Moc3RydWN0X3NpemUobm9kZSwgbW1fbm9kZXMsIG51bV9ub2Rl
cyksCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
