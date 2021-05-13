Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02681C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 19:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8302B61452
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 19:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8302B61452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2323F89C2C;
	Thu, 13 May 2021 19:37:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A704289C2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 19:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lS2UKqs3r2QwYi7m07gid3JHff6kDhk4GeEt9tUWLkGFkEHEbJWOJZ+2yhGVsPbL/lSjRlrrqvhriamF7P2W/SW/anzIAiyagdyUQDby0WbJZoE4WoqSaI4nmTyzGXGbg1GtCi4mUyGdSknxaMofO9RAsRLjQmLak8QpLS/NCSumNmvP4fUhnCbFbxCbrhTh5+xMC9iHy0q8fTJ50JnB3e+v+BPa62gC+IcVQ77jQz1bQc/cW51FwN5mXPU+EML7YFQSWkzkZ5fH51vCvXT/zlCuMZDTCfop7Z971E3rfB5kO/YtDQnBccFxNYB5z8zAwmrW0RRPOpKNRL8zyhrU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ6gBzv9JHgOf+wLyQBSFJ+rDmGRwbeDWvUs95+xMkA=;
 b=nIGnWuogD+e54K4x+Y4kiKwqOygyPfuUIqkUUeSrm3Jmebau7tZ4A+cqxoFN526BkqoHR5ot3JiPhY1m9P+jCUmHmg7Blrn6zObye2nFItnh9lH5Iv6ed4bYl7JqQpSNYkjBb+T8s/if7U9K+R+aoaTjeIRxQx41eAMZl3SR0FhkXNXwWJXGWLhx6ixl7L7owUasz2qYI3811rtp6Lvi0qkZBnXw0DTqCFzkwUQLnSo8KAvJLi9TIL/l96Tq6SNQMauOsfBB0J84xCl62K7n5WJTZ5Lkm/dWbNtOawlADycutggGlWSNcbme3mEgVPbJCXeM7DiaKry2Ek9nmokeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ6gBzv9JHgOf+wLyQBSFJ+rDmGRwbeDWvUs95+xMkA=;
 b=Y7hf0037/YFmT7G5k054QdNLBBbsBJa+YK76Onn0SsqWbVOdLT0p0KFOOFNVFdCLmNJuvwGi7Mvn43UKY1geXr9VspWqNQYPV9l5+x+Be1815U4WS++alddmjcGV9EPkzrRX2+btU/p7Ln8tFdoDUTqWUQTJa1ily0wBqMC13qA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 19:37:41 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 19:37:41 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Don't query CE and UE errors
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210512170302.64951-1-luben.tuikov@amd.com>
 <9d7f82e8-6528-154f-9a23-bf78ff249505@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <1d54c92e-1448-7aaf-9738-3a22e6799356@amd.com>
Date: Thu, 13 May 2021 15:37:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <9d7f82e8-6528-154f-9a23-bf78ff249505@gmail.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 13 May 2021 19:37:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b64c9578-5688-440f-eaed-08d9164692a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4387CC12F6C9100B5913169099519@DM6PR12MB4387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZLYoAq95uoqXaAQcIQADT5PrbL8ailUDkXxdkO44Atn0HJyi96W/MLkt6vpawNQASa3yPWc9SAnlvCkcRuO1MF9C6QqCKUrEb2wguAhFWD9HKtP1A1e+fExtP8I6XcmB2dejYv/p7jXTNa0Z03IEfqK+jLapsvdMXPhON2+yTtRAV5s4BEQ9+SuCy8bjlxjwzhCD2lND0bSstIs3x/P3zC/RFmGlAjb1+azLVEUqU5N5+DDUKkmoMvXJHfxE/ITLQdGbBp6r7LECAH+4X5b/8Jj4cQ9+/5BUjYYkwcHf6ldKL68CWX54/CQclhaKq8bHY1fNvDIwu98W7O8xo9lf0dRIAVk0MfdyMvbhZrhnt61dyZ9TO/NLAT5hHeiodpAx62o+IiN4Ah1PkBfxAZRFyTjl0pVEiULbfV2RIOD/rGdxnGpXmnIwf75GbYOuqUTTDI+1vO79T/oKxvgeNyLioFiNBhQBMyfdpSf0YUOalS85xySysSrXJoSS2ZyajBKQAF9VNn18QqLsq+p5ZOnFb/vg4Wk1NZoHW3bNCk1Eg3pvJrZoLoMpzMW0fpw7SvL5mm1AX9ODoRY8adgnK0GheaNIS2BHjodInssePPOxomSUm2p3uXhmHdYJPTiJ1dRWs+2N/fSyfcAhvI8cTLflYKNnAfMOF8mBUmxl6M36RSNAizkGRxfLdlb5ow6tI41
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39850400004)(6512007)(478600001)(16526019)(44832011)(66556008)(316002)(2906002)(36756003)(38100700002)(2616005)(956004)(26005)(66946007)(53546011)(8936002)(4326008)(8676002)(31686004)(66476007)(6506007)(6486002)(66574015)(31696002)(86362001)(55236004)(5660300002)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVRYM2VtdDlwRGtKYWVSUFdOVHVDbEQveXFUdEhoYUNITjR3Yk9XRVd3Q0Zu?=
 =?utf-8?B?aXZkN0Nvdi8rRUdkWHd5UDNielFmVGVqT0J3TEpqSndjM21tdS9RMC9wZHRS?=
 =?utf-8?B?VG8yMWs2aEpLZEQyYVZFRTZLeVN1a3RMY0ltMUhqdnUrTUozRGl5Tlgyd1FT?=
 =?utf-8?B?dzFxdGFaMjFFeTRGZWpWOWRaTzdqL0puODRNQ1lZSTllU25CYVg1bHZsREt4?=
 =?utf-8?B?YUZtNHRLc1RXMHE1OG9YbVZEd3NmZ0VRV1hyaG1EUERKN0ZHM2NmZWlrYlM4?=
 =?utf-8?B?S3ZTMEUvWitwZTJFall3bWFnM1JkUDdqSE1PdXMzOFF2UjgwZlVqQTdFWG80?=
 =?utf-8?B?S2w1YjhqZmZ4OTd0SlRSR0F3dnNxV01RUjJxem5TcG9Xdm1EemgvTk1ablNp?=
 =?utf-8?B?MmJKejJ6ck1MUU5MMFJManJ5U3BNZFR5YklnVjExejdXN3RUTXFzS1g3QmMr?=
 =?utf-8?B?T0xYMFViT2ZKZktaM2JXRDArRWVzOWxucnB2ZkpWQWN1TXdOOE1TNWp5YWpM?=
 =?utf-8?B?elNJYTdsRXFlVlc2dWIzWnNVZU5ldUZyQ2dXamdXQ3V6SXZjNWxLTDF0YXAx?=
 =?utf-8?B?QmlSVmMrbHBEaXZBblBTVTlKeHhyVkY2Y3BGOWxjNUNidU5KMUY1eThEQVJ4?=
 =?utf-8?B?Zlo3ZWNGSjZ6ZHZ4T2Yvc3JEaUZLbkVYVEhaU0xoSWUzV1JJUStOZGJGN0pm?=
 =?utf-8?B?U2pyOVZXcmpOYUNiRW9tT05DUHFzSHNWenUvb1B6SS9UcThDVDdmV3VXMVFv?=
 =?utf-8?B?SFVuSTJMSE5QZkZ3U1JoUDc2cEovZ1VaUnFtQThIaWU0Zm5nYVF0Ti9wQTNs?=
 =?utf-8?B?RnJhTzZoUDQ4N1VHR0RqeVBiM1RXSmNaUlhNbGJSeGNvU0RNQm5BZzdrelZs?=
 =?utf-8?B?dm1tMmJ3NnZGN0JLeUtVWTBzY3cyQmtLQ0xScXZicHZpQ1JjbjBHZXJMR2U4?=
 =?utf-8?B?a3k1Y1NqZ2hqanFOYVYwVGhaQWVPNUxaaldlczA3K2RGM0h4SkdDZkY5UGh3?=
 =?utf-8?B?VEo3UnZ0ZjF4M3YrbFdQRWdDUWZvSVZ4MjhWNXFuSnNjUHhLNWYxWEQ0bm56?=
 =?utf-8?B?WGhQT2YvYmRkTHhUMlhJZm40T2RKcEkxSDg0QmpGQVVkNmJHeEpmTHVYbC93?=
 =?utf-8?B?djdZM1VqOVlsQWRqL093c2orbVhqcUxCTk9HNitmUUJ6ekxyMUcxWEhKV1Va?=
 =?utf-8?B?R2tlQUZGNGpoWGgwRnNaN3ZTbnUrS0k2Q1gvclNPVStyZTRHUC9rMjI5UThQ?=
 =?utf-8?B?NTQ1cWpyM2owNUZvTXRVeGwvOU5rSTVOM2dVcm5wV3dOVm5HY0tjWEg4Rktl?=
 =?utf-8?B?VXZBN1lxYkxtQlZKUUEzMTBFM2FOZ05zZDJ5QjBmdU1UbThMVHZiM2cvQkRn?=
 =?utf-8?B?SDJ0NUJISEtNTTJOclE0elhaL083S25DeG9QcUFZRzhEWGUyeStmRW8rV3Bn?=
 =?utf-8?B?TXFmenpCNE5uSkdOK3dkS3RSWDhnaExPbWRCY0I5OVUvQlI5Z1RwSjI2SC96?=
 =?utf-8?B?MWpHc1JxRHpqSGNvMmdTVDhYTDRpMWFsMTJKdFJ4aHRlUnRyM3dJRFRrMm1D?=
 =?utf-8?B?cW9jZlNwdHJWTEs0bmJ5bzVaNytoUE4wNUl3b1lYdVRzbWJBUHhTUGlSbjAv?=
 =?utf-8?B?OWtybEp4Q2QvRm80MGJ0RFlrTWFWY2FkWWZHZUhvT3BOd2crUitmeENLcE9r?=
 =?utf-8?B?OEdrVmJONTd3UVlsQm1xK0FKRzRidXNpNUVVQy9lWXd5MXlYNWFXbEFxbmpH?=
 =?utf-8?Q?rolmsun50U+DgajykqqQ+PnYYZbGdJLWrdeZ9Cy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64c9578-5688-440f-eaed-08d9164692a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 19:37:41.5302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uL+7NObQcJy9gc0BxOueF3Wr8QZbJM3I+jYEGcQTG7FXMOCdMUlUgeDwupO8d0ID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNS0xMyAzOjU2IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4KPiBBbSAx
Mi4wNS4yMSB1bSAxOTowMyBzY2hyaWViIEx1YmVuIFR1aWtvdjoKPj4gT24gUVVFUlkyIElPQ1RM
IGRvbid0IHF1ZXJ5IGNvdW50cyBvZiBjb3JyZWN0YWJsZQo+PiBhbmQgdW5jb3JyZWN0YWJsZSBl
cnJvcnMsIHNpbmNlIHdoZW4gUkFTIGlzCj4+IGVuYWJsZWQgYW5kIHN1cHBvcnRlZCBvbiBWZWdh
MjAgc2VydmVyIGJvYXJkcywKPj4gdGhpcyB0YWtlcyBpbnN1cm1vdW50YWJseSBsb25nIHRpbWUs
IGluIE8obl4zKSwKPj4gd2hpY2ggc2xvd3MgdGhlIHN5c3RlbSBkb3duIHRvIHRoZSBwb2ludCBv
ZiBpdAo+PiBiZWluZyB1bnVzYWJsZSB3aGVuIHdlIGhhdmUgR1VJIHVwLgo+Pgo+PiBGaXhlczog
YWUzNjNhMjEyYjE0ICgiZHJtL2FtZGdwdTogQWRkIGEgbmV3IGZsYWcgdG8gQU1ER1BVX0NUWF9P
UF9RVUVSWV9TVEFURTIiKQo+PiBDYzogQWxleGFuZGVyIERldWNoZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+Cj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+IFNpZ25lZC1vZmYt
Ynk6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDI2ICsrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPj4gaW5k
ZXggMDFmZTYwZmVkY2JlLi5kNDgxYTMzZjRlYWYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3R4LmMKPj4gQEAgLTM2MywxOSArMzYzLDE5IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X2N0eF9xdWVyeTIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+ICAgCQlvdXQt
PnN0YXRlLmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX0dVSUxUWTsKPj4gICAKPj4g
ICAJLypxdWVyeSB1ZSBjb3VudCovCj4+IC0JcmFzX2NvdW50ZXIgPSBhbWRncHVfcmFzX3F1ZXJ5
X2Vycm9yX2NvdW50KGFkZXYsIGZhbHNlKTsKPj4gLQkvKnJhcyBjb3VudGVyIGlzIG1vbm90b25p
YyBpbmNyZWFzaW5nKi8KPj4gLQlpZiAocmFzX2NvdW50ZXIgIT0gY3R4LT5yYXNfY291bnRlcl91
ZSkgewo+PiAtCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JB
U19VRTsKPj4gLQkJY3R4LT5yYXNfY291bnRlcl91ZSA9IHJhc19jb3VudGVyOwo+PiAtCX0KPj4g
LQo+PiAtCS8qcXVlcnkgY2UgY291bnQqLwo+PiAtCXJhc19jb3VudGVyID0gYW1kZ3B1X3Jhc19x
dWVyeV9lcnJvcl9jb3VudChhZGV2LCB0cnVlKTsKPj4gLQlpZiAocmFzX2NvdW50ZXIgIT0gY3R4
LT5yYXNfY291bnRlcl9jZSkgewo+PiAtCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQVV9DVFhf
UVVFUlkyX0ZMQUdTX1JBU19DRTsKPj4gLQkJY3R4LT5yYXNfY291bnRlcl9jZSA9IHJhc19jb3Vu
dGVyOwo+PiAtCX0KPj4gKwkvKiByYXNfY291bnRlciA9IGFtZGdwdV9yYXNfcXVlcnlfZXJyb3Jf
Y291bnQoYWRldiwgZmFsc2UpOyAqLwo+PiArCS8qIC9cKnJhcyBjb3VudGVyIGlzIG1vbm90b25p
YyBpbmNyZWFzaW5nKlwvICovCj4+ICsJLyogaWYgKHJhc19jb3VudGVyICE9IGN0eC0+cmFzX2Nv
dW50ZXJfdWUpIHsgKi8KPj4gKwkvKiAJb3V0LT5zdGF0ZS5mbGFncyB8PSBBTURHUFVfQ1RYX1FV
RVJZMl9GTEFHU19SQVNfVUU7ICovCj4+ICsJLyogCWN0eC0+cmFzX2NvdW50ZXJfdWUgPSByYXNf
Y291bnRlcjsgKi8KPj4gKwkvKiB9ICovCj4+ICsKPj4gKwkvKiAvXCpxdWVyeSBjZSBjb3VudCpc
LyAqLwo+PiArCS8qIHJhc19jb3VudGVyID0gYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChh
ZGV2LCB0cnVlKTsgKi8KPj4gKwkvKiBpZiAocmFzX2NvdW50ZXIgIT0gY3R4LT5yYXNfY291bnRl
cl9jZSkgeyAqLwo+PiArCS8qIAlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlky
X0ZMQUdTX1JBU19DRTsgKi8KPj4gKwkvKiAJY3R4LT5yYXNfY291bnRlcl9jZSA9IHJhc19jb3Vu
dGVyOyAqLwo+PiArCS8qIH0gKi8KPiBQbGVhc2UgY29tcGxldGVseSBkcm9wIHRoZSBjb2RlLiBX
ZSB1c3VhbGx5IGRvbid0IGtlZXAgY29tbWVudGVkIG91dCAKPiBjb2RlIGluIHRoZSBkcml2ZXIu
CgoxLiBBbGV4IHN1Z2dlc3RlZCB0aGlzIHdoZW4gd2UgY2hhdHRlZC0tdGhpcyBpcyB3aHkgaXQg
aXMgY29tbWVudGVkLgoyLiBIZSBzdWdnZXN0ZWQgdGhlIHNhbWUgdGhpbmcgbGFzdCBuaWdodCBh
bmQgMi41IGhvdXJzIGJlZm9yZSB5b3VyIGVtYWlsLArCoMKgwqAgSSBwb3N0ZWQgYSBwYXRjaCBp
biB3aGljaCB0aGUgY29kZSBpcyBjb21tZW50ZWQgb3V0LS1kaWQgeW91IG5vdCBzZWUgaXQ/CsKg
wqDCoCBJdCdzIHRocmVhZGVkLCBpdCBhcHBlYXJzIGFib3ZlLCAyLjUgaG91cnMgYmVmb3JlIHlv
dXIgZW1haWwuCgpSZWdhcmRzLApMdWJlbgoKPgo+IFdpdGggdGhhdCBkb25lIHRoZSBwYXRjaCBp
cyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+ICAgCj4+ICAgCW11dGV4X3VubG9jaygmbWdyLT5sb2Nr
KTsKPj4gICAJcmV0dXJuIDA7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
