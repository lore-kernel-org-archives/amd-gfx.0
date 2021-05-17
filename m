Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE873C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701D261004
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701D261004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5B36EA6D;
	Mon, 17 May 2021 19:46:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC9F6EA6C;
 Mon, 17 May 2021 19:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6GRn82YqNwIT2klW50p74HtKujweCwwDExVnkwsQy7KxbuYnlT+QI2T9tdN76VPP4gHSt+4bXt2TY9rBD64rwbCYlIohsKESInKDlrgNrltFrU8s1cllsiHurSKJoOnKTFbak5QONX2Ocnl7lnubGfjg7Fz6eiIOjH0+IPsfQUfsmffrycMn8RhSSha4KzVm7hx3jdP6I0yU62SkIu0sRIwdVA0oTPIS2VYe6ZMttglXx/dNUA948SBgVeefuEVyVu3NYmOmzlrgX6eCOkOPVNlw2tVW1GvGDIw0mJ3qfvA2IppuLtFtnQr2NZHDTCSdhBpO3Npwt36bA53ZV45hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U39TwFYbpNGYJoPfyPAkCxXOayqwb06iIFf+ZL/dzc=;
 b=fdui7V6Am/E/dezIgvKd47Z+whL+TDwmhEbwiESB8b6aSwzCcG+DZqgBNAAJ715aD3KYeCfavySUzEsq7P3FTAXeAgugSZv8666zamFKI3naVkdl3BqeAAH8+c8Q+G8uz+OYa2S1HTLoP+r/gH4P8w7IxA0a70UUY0R6mF5/Cw9dDeNboxgwbjPQD/35WW4lSmYhzs4JXwbZ6fnuO4WqvOpDaERsSDftzUNN7GKmQeTtxL86WyaHQG9Uev4QePJjh7TOntMJh54Sn+I4am5uam5y6GhTZgBKK4wN7+EiWnRB0/D6wW/4gFglUtN2ehAQO834fYwppZ9njI1MtN1PCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U39TwFYbpNGYJoPfyPAkCxXOayqwb06iIFf+ZL/dzc=;
 b=ST87GIPR2aOtQOufQABspEXZZs+BVptigTYIZa9CUQA9iiATfYchvGGAW7u9Fw7O48iuc/tJOXk8tQo1Ig8XCfGQMb+VqOny+LhuzveH49cXDfVXOiLc9XH64p05cT8Ng5elytoDwYXOlfbdHYpXbWCNDY2dsJOggZf6Lm5B3h0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2495.namprd12.prod.outlook.com (2603:10b6:802:32::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 19:46:07 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 19:46:07 +0000
Subject: Re: [PATCH v7 12/16] drm/amdgpu: Fix hang on device removal.
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-13-andrey.grodzovsky@amd.com>
 <0e13e0fb-5cf8-30fa-6ed8-a0648f8fe50b@amd.com>
 <a589044b-8dac-e573-e864-4093e24574a3@amd.com>
 <356d03bf-e221-86b1-f133-83def9d956bd@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <8997d1b0-8f7a-e8dd-fabe-212fd181e24a@amd.com>
Date: Mon, 17 May 2021 15:46:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <356d03bf-e221-86b1-f133-83def9d956bd@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:19e2:b915:59c1:4860]
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:19e2:b915:59c1:4860]
 (2607:fea8:3edf:49b0:19e2:b915:59c1:4860) by
 YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 17 May 2021 19:46:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e81759c8-17dc-47d6-ba36-08d9196c69a4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24951EF8240C826DC449427DEA2D9@SN1PR12MB2495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2iEtMoBSRUkATrxAIY6iAp7rEEdMWX4xTp2wLVQTrWbT2fuRkF40Ix4D5YEzVKgDUZGiskz2Q9KurMelLuVDJIGdVMD/990EQ0Vfsk1njPYQtFdgnTs06aJF2MTY0YEeeA2PUBQdM63ze5satnyR1E+hdp6WVtAxmxQOrfR/APf6NgQN3NuMn9XqklqadaypoIVrIRLAJWhSN0JcQfHnNs9tTxzyVPxF+yKyhwPNfJR6qr46Dhh/yUcUspYlQkNYPqBaNFmJsendI2CPx+QptZJheIvnauviqxFVhn9/5fFhMCYu0hm5bgG3AecSg+yELi87zPqvMFsLnoqWrgVhSL/WgQja+P/PvwGt7y/7UlI/VxytnB1y2hg52rl9bj282cXr+zTTJdE9L7jlycgEck0gNTJ3qGAqcTOc7Gs18eYn1qa1fDED3qtlNCvrxW8gPmR3Ch/szYVsS/lIq5rdjdLZkoYH1HZ5tAVAd2L1stze5slCbMASqRGmUEPmjsOx6kJ/UCKwFkvP2u6swRqUapzeDerjq2A+V5jq0nkqojXagRHwojOSZ6mTl9tQjjOycUrv4Au9NYieHFNZKS38gaHJVtOJp/yg6x9McFM+BggW1qlb5OkZQ1zS5tVwDhetParjsnzZCmnq2N4bccXCEUw5fDfkHCykyP4pOSrcmXattrda+eoQofPObZP1qy6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(44832011)(478600001)(31686004)(66476007)(66556008)(4326008)(66946007)(8676002)(36756003)(6486002)(8936002)(5660300002)(2616005)(38100700002)(186003)(6636002)(16526019)(86362001)(83380400001)(31696002)(53546011)(2906002)(316002)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SXVnOWdiT2hlc2Z4VE01aFMrM1lQVjBvU2t5MzhpNzJ1VzZVOWNLUGd3WCtz?=
 =?utf-8?B?ZzZEa1AyZFBGeWRmSnEwQkVJM0M1V25MNUZyem9jYkxHTnZzL0s1bmY3ZFBM?=
 =?utf-8?B?M25BeEFna3Z2M1h2RG5FSmVMelVXc1E1S0ZMcGJXM1BRZDVUREhNR1dJdGYr?=
 =?utf-8?B?MmNmampZR0ZiUjNpQzI2dWJ0eHl6cVZWOFY5MlA1VkhGVE9ZRWR3ek9uMXdT?=
 =?utf-8?B?MUlsdTZsN1YxdFdrbDM1RDA2MUZOdG43Tk1YL2ZhNE54VnVMZlRjd21oY1Jh?=
 =?utf-8?B?enp3RzZ4SXVhUHordk9IM1B5cnZab0REajBlZXdkSFFYUmdHbzc5anpOMTVO?=
 =?utf-8?B?M0FVOVZvOTR5RjM4ZFVzQ0FDcXROeUxNVFVIZFZaejNRVStIeHJ2MHZyeXlZ?=
 =?utf-8?B?WlhlOFJQUTgzYnpURkpxbDdjMTNoUGZiMGMvOXFSTU9pRVBsSi9JVHVnK3lN?=
 =?utf-8?B?YlJ0UGxyVDZMRFIzM3k2OWhzUm1lWjJmQ0F2UFpFSUxsYmJUaE13UVFqZDg4?=
 =?utf-8?B?ckdaUFpHYzN5VEo5TjZYUldhYlVZV3p0Ymd0SXFmaFRZeUd1clcyNTBtc1A2?=
 =?utf-8?B?NHN4VWVJODJDTHBNSXgzbnA0OTNXbjlCVXUzdkg4Z3Y5UzZsRlgzQnFuUC9h?=
 =?utf-8?B?eHJoQW53cG9ReGM4WEw2WndwZXlieDVCZ3pXMUJQSU1iOGFadW1mSUdZc20w?=
 =?utf-8?B?NEpHYkM2SlpDMytVVkdJNTVSS1dtL0FzZVp5WDJOREZEdFBPekdxbHVrZktq?=
 =?utf-8?B?MHR0ZG8vZHFmNHJETkowVHplNTg4UkFoSGU2QUVXM0hhMHhoUjFWeVhBRlJB?=
 =?utf-8?B?QkJtTVZEeG5tVnpKaHZRWFo1VHFKOW5ET0JiVG02UWRqMGQwN2J3YnFoQU03?=
 =?utf-8?B?bTlobXl0ZzlYaUExY0RVOEVjZjNLYStiMjJIN0hTelZjSUxxNnVudk9vNy81?=
 =?utf-8?B?RHBMTFVmZHJKTnVoaHhZbU1VL2xjZU9uUFl2RmpaVHg0Q1FWVzNmNU9DYVhi?=
 =?utf-8?B?OTNTWVk4bWduSU9DWm1WOXV1YzBULzlGNDZEalppRGV5K2RmNnRuamtZMndX?=
 =?utf-8?B?UW5YNWZYZ3BvWEh1MWFVM0owUyt3UWozS2VWV0dqdmhhMkY0NlcraERCRlBt?=
 =?utf-8?B?aEdpT1BUSFVvM0wrd3QzOThzUFlLLzg0K2RuZDIydjlXdWM2RjZmZEx4ZDJG?=
 =?utf-8?B?U2Z1dUdzVWZxalQvcjhKV1BNb3liSEQvOUdjR2I4M2VZZ3ZiYlZSaUVwRE9G?=
 =?utf-8?B?SElUZ2NoczkrOGxpMGNreGN3Q2hiWHVpM0pTeXlIdUhmTzBkM1BLdzczMGUr?=
 =?utf-8?B?b2tJOU1IQnN4SXdyd2xGZVdad3BtT1B1REMzWk55UElHc3RpWjV0MzNNczVj?=
 =?utf-8?B?Vmw3WTNDY2ZhZ3VXRmdQeVJlSXNiT0FqYjkwMVNqZTdxaHhGbXVyOTRYdDhy?=
 =?utf-8?B?Z2s4MFpJa2ZnNlNTQ1V2SWRRdEQxNktDOFZqK3JmaUo5SklnZkRXQW8yUjJT?=
 =?utf-8?B?dVRCQ0RCSjM2RHhNN1dYUzYrZmZZM0wwVmNLSFc3endMS2xuTGFLdm11MkRP?=
 =?utf-8?B?Z2F3SUVtbW9hRGE2MEZHcHVzZWg2S3hsZ3plRVNqRk56RWxNWXRRUVFldU1k?=
 =?utf-8?B?NGd6TERncVlwZ0dIa09SN0hRSW95R3dKb0RVYXFYK0FwZmJwU0FDNzBDanV1?=
 =?utf-8?B?T1BoYXhoN0ZBa2RPSHBVYXl3RzRCZ0U0TldXQ2ZiNjRpalVFMytoLzRKS3RJ?=
 =?utf-8?B?UmU3dFVYSmFhV1BlTUZHanBuWmZ0Sy9FclFCbDN2aDlmTDJpMDBnVEphM0hn?=
 =?utf-8?B?WjgreFlnNGVML1ZBQVlFdVJkYWpqZXZNWXloNHBLVGN2YjU2ckxHOWZBMnY4?=
 =?utf-8?Q?Ni+QFn6LjK8Xi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81759c8-17dc-47d6-ba36-08d9196c69a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 19:46:07.1360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiRuSn7gDwgYLimVB1e2NP0sDjC/LhuUhISnfuLKLgt8JTVPJl9lL//Qk6eBGI5/7QMhJTPpctiz6zECaJVRPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2495
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVwLCB5b3UgY2FuIHRha2UgYSBsb29rLgoKQW5kcmV5CgpPbiAyMDIxLTA1LTE3IDM6MzkgcC5t
LiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBZb3UgbmVlZCB0byBub3RlIHdobyB5b3UgYXJl
IHBpbmdpbmcgaGVyZS4KPiAKPiBJJ20gc3RpbGwgYXNzdW1pbmcgeW91IHdhaXQgZm9yIGZlZWRi
YWNrIGZyb20gRGFuaWVsLiBPciBzaG91bGQgSSB0YWtlIGEgCj4gbG9vaz8KPiAKPiBDaHJpc3Rp
YW4uCj4gCj4gQW0gMTcuMDUuMjEgdW0gMTY6NDAgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToK
Pj4gUGluZwo+Pgo+PiBBbmRyZXkKPj4KPj4gT24gMjAyMS0wNS0xNCAxMDo0MiBhLm0uLCBBbmRy
ZXkgR3JvZHpvdnNreSB3cm90ZToKPj4+IFBpbmcKPj4+Cj4+PiBBbmRyZXkKPj4+Cj4+PiBPbiAy
MDIxLTA1LTEyIDEwOjI2IGEubS4sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+Pj4+IElmIHJl
bW92aW5nIHdoaWxlIGNvbW1hbmRzIGluIGZsaWdodCB5b3UgY2Fubm90IHdhaXQgdG8gZmx1c2gg
dGhlCj4+Pj4gSFcgZmVuY2VzIG9uIGEgcmluZyBzaW5jZSB0aGUgZGV2aWNlIGlzIGdvbmUuCj4+
Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zz
a3lAYW1kLmNvbT4KPj4+PiAtLS0KPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZmVuY2UuYyB8IDE2ICsrKysrKysrKystLS0tLS0KPj4+PiDCoCAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyAKPj4+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4+Pj4gaW5kZXggMWZmYjM2YmQw
YjE5Li5mYTAzNzAyZWNiZmIgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmVuY2UuYwo+Pj4+IEBAIC0zNiw2ICszNiw3IEBACj4+Pj4gwqAgI2luY2x1ZGUg
PGxpbnV4L2Zpcm13YXJlLmg+Cj4+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4K
Pj4+PiArI2luY2x1ZGUgPGRybS9kcm1fZHJ2Lmg+Cj4+Pj4gwqAgI2luY2x1ZGUgImFtZGdwdS5o
Igo+Pj4+IMKgICNpbmNsdWRlICJhbWRncHVfdHJhY2UuaCIKPj4+PiBAQCAtNTI1LDggKzUyNiw3
IEBAIGludCBhbWRncHVfZmVuY2VfZHJpdmVyX2luaXQoc3RydWN0IAo+Pj4+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4+Pj4gwqDCoCAqLwo+Pj4+IMKgIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9m
aW5pX2h3KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4+IMKgIHsKPj4+PiAtwqDCoMKg
IHVuc2lnbmVkIGksIGo7Cj4+Pj4gLcKgwqDCoCBpbnQgcjsKPj4+PiArwqDCoMKgIGludCBpLCBy
Owo+Pj4+IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7IGkrKykg
ewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2
LT5yaW5nc1tpXTsKPj4+PiBAQCAtNTM1LDExICs1MzUsMTUgQEAgdm9pZCBhbWRncHVfZmVuY2Vf
ZHJpdmVyX2ZpbmlfaHcoc3RydWN0IAo+Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGlmICghcmluZy0+bm9fc2NoZWR1bGVyKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRybV9zY2hlZF9maW5pKCZyaW5nLT5zY2hlZCk7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHIgPSBh
bWRncHVfZmVuY2Vfd2FpdF9lbXB0eShyaW5nKTsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHIp
IHsKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBubyBuZWVkIHRvIHRyaWdnZXIgR1BV
IHJlc2V0IGFzIHdlIGFyZSB1bmxvYWRpbmcgKi8KPj4+PiArwqDCoMKgwqDCoMKgwqAgLyogWW91
IGNhbid0IHdhaXQgZm9yIEhXIHRvIHNpZ25hbCBpZiBpdCdzIGdvbmUgKi8KPj4+PiArwqDCoMKg
wqDCoMKgwqAgaWYgKCFkcm1fZGV2X2lzX3VucGx1Z2dlZCgmYWRldi0+ZGRldikpCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHJpbmcpOwo+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBlbHNlCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9
IC1FTk9ERVY7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIG5vIG5lZWQgdG8gdHJpZ2dlciBHUFUg
cmVzZXQgYXMgd2UgYXJlIHVubG9hZGluZyAqLwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocikK
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNl
X2NvbXBsZXRpb24ocmluZyk7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIH0KPj4+PiArCj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChyaW5nLT5mZW5jZV9kcnYuaXJxX3NyYykKPj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfaXJxX3B1dChhZGV2LCByaW5nLT5mZW5jZV9kcnYu
aXJxX3NyYywKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmluZy0+ZmVuY2VfZHJ2LmlycV90eXBlKTsKPj4+Pgo+IApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
