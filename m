Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7C9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6CB64F09
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6CB64F09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4DC6E886;
	Mon,  8 Mar 2021 20:38:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB3A6E883
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 20:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF4tN5pHohg0nVkkoppNVNB1Y6PwPeMZQfq23sLH8gyPOzJ06NQUvrMHnhft3ulkDzv2oiovPRPC2iJCMI4YFApOeWyE6fKoumoKAM8RfPnAl6ZMEqz+YnrfE9nrGRrdk/zT1tpUAG1vB/6a80Ddj6FOgDqtMwyq835NEKJr919CWMNvDEwLa/rtiIFswD50UA2WuAcwk+5M8K8FDxYc6RD54r8UnC1RQfSzWsozE+GuZAPbEQyBulk7G1ezXq/f+ZA4EeqHZ5rGl6wvuRzohnUrOqWnxyZ3ct4ovyduWxqftQcsxB9yLa50jjK4StRR4ZPrl3juIkpRHq4oem2iIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuxXImSTN/v0LyWOuGuerpr6s/zYPsG2s1GCuag4ybY=;
 b=Zu2M0VxNiu7wNvuBldQZlD8zkblDVxQ/7DZbmLJ5ZO/1nccjF/T+oxHpzSFVzGs27I8oy8ynKjac50rmcrTqEL76ETnpcNgsqvw+GzxRoRaG8c0+Cn5bq05kDgyef23ve9pIO/lyKnNZNkgnU/WeAvgpRitFIsUvB2SQR7YQAYQ/41rj15kanNRTDAMdNwzL6WlA1vBA9rJxDpnnDBNbLAXU3ImmGeyaMZmpXmLd3ZwTtiUuajTRJY3wvc/F+Lzxr/lDqnKbzQb6fnhDdd0rflprNpb1pGLNjQqE6Y/Sr3cNNmUcZ2XbRv1zUtOCVKH6WFeiK6BK0MwD1trzXvn79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuxXImSTN/v0LyWOuGuerpr6s/zYPsG2s1GCuag4ybY=;
 b=pxWs8HodY5lrU1ZS9I74OqRx12Ozv175PRe3YF2bqwpIOwrOSRBj1UXqI4QAKqL5JH4S8lZ3NUNJ/cGh1IHz1JaN9m+hKv08u4SdXhs5rG5JNOhdpZA3Rpd4dneZMFCvf/lSifwkFvRLXEw2soL3I1201O796+mAYm1vgZKFv1Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 20:38:53 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::4d9b:6989:13f2:e4f8]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::4d9b:6989:13f2:e4f8%3]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 20:38:52 +0000
Subject: Re: [PATCH 3/6] amd/display: fail on cursor plane without an
 underlying plane
To: Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?Q?Michel_D=c3=a4nzer?=
 <michel@daenzer.net>
References: <I5B1EIA88M4W0bSuy9DLTgt70QGefRznp9IdJ14Cco@cp7-web-042.plabs.ch>
 <326ccbf2-8752-2fa2-b757-6811b90ecb8b@daenzer.net>
 <CAKMK7uE1+Y_agt=YCMf7OS6X-QjhAXsPO+3asWsahda11ev-eQ@mail.gmail.com>
 <e7661e4b-a99c-5be7-9912-421ac3e61ff0@daenzer.net>
 <94a2e9cd-8a14-984d-71a7-3671d7c352ab@amd.com>
 <5d62d002-faa4-ea6b-c55e-2b297e8e1b5c@daenzer.net>
 <19062958-ff28-0f1e-d891-9c030a88ecb0@amd.com>
 <0fef827c-7aff-28bb-efda-70460cb658eb@daenzer.net>
 <CAKMK7uGq7YZLXbbCjasQOiUaCXGO5ZSoUcKa5JrtyGTW=Mu7qw@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <c3855456-e209-3e08-f351-c4231ddf48c7@amd.com>
Date: Mon, 8 Mar 2021 15:38:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAKMK7uGq7YZLXbbCjasQOiUaCXGO5ZSoUcKa5JrtyGTW=Mu7qw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::44) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend
 Transport; Mon, 8 Mar 2021 20:38:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bd19eee-5f0b-49a8-1fcf-08d8e2722f61
X-MS-TrafficTypeDiagnostic: BY5PR12MB4291:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB429159A0F84D52AE2E3A2C2BEC939@BY5PR12MB4291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSWqGVMxZAelHqcwOABVR98w3xe94+YtKA+mE1Huseph9/gJ9kZ+MtIaKoHneBXGCWinxTSWjjR8AZ7GFxXHKuqHn0bhK5f6aiO+7LgwOFu30NpeM7Op9ijv2+ZNGlDvfGY4ho0a+B3bJUOGYV1mGUYO9k0FxL8cD5NcndWpuFF4CkqEG4Wk4un7vA42oMkaQ/Kb2byjjl9UBN1clYU1maf2N9EMJfbabyhWUwLUaTefqUs1t37seNSZdEStjogKlmXhF2Zf3M8Qu/+RV46xJUSspz76odCOyf1AZTjUbDyErPhgG6nLP2rBNMnMC38xaWrL7SKLrJsvFTE3j01Z51z/IGzRCUPwmzYWdJEQsr0h6HI2onFm3G2I87v+dzr/2Tx73ro59H2Nhr2lOqtit29owXet1UHiUuokkD3kS0PQw2YfE0/R7fB30UH+SU8zqG29JBxWrE8ftyHNChswK/RYlBRgewwsWKAt1JwSwl13JngqnvUB4SbPeYBe8AgoIlbPsceDVRY7cZjnuBoRMC7MUqOy82uZYzEBMhx96lesF4XVzyy7CLc51UwKNzZttnFUcAIpUVqFB+uw0gYhOSv5aveOzaAgvokrYrWB1QI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(8676002)(54906003)(16576012)(52116002)(956004)(478600001)(186003)(316002)(16526019)(2616005)(110136005)(6666004)(66476007)(66946007)(26005)(4326008)(86362001)(5660300002)(31686004)(53546011)(36756003)(66556008)(83380400001)(66574015)(31696002)(8936002)(2906002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MHFVOGxmQk12VzJHb0dUaEp2YmxwZElHTWJkbFNBZVAyNW9PdDIwL3MzTkY1?=
 =?utf-8?B?VEZ4MDZqaG9NckZIb0RpdXpOczdoUzJSUlRIbHZMTmRLdEJwVW9ENHdwM1Bt?=
 =?utf-8?B?NzdJcFFUWHowNk9KVzhmclRPZEZVa1BxMWM4eGhpYkRuUjFJRVluZDNJdWxY?=
 =?utf-8?B?NlJzZGlyUVBuQU4vWWhkNTVib0hSWFIza3R4dUh4d1VybTVkTzM3SzBvd1JN?=
 =?utf-8?B?dW9oOWZha1RLcVk3dmx2UWV6VEF4MjlMcm4wRHVDamJSb3pvblExaHcrdTJF?=
 =?utf-8?B?bHNIVWVmNmx3RHZlS3g0MXdkdUJ3NW80eTNHcjhvazN0SXJDVkhQMDE5aVdQ?=
 =?utf-8?B?dzBVbWdBZTBsV1FqYzFVclBuVzVDRUpaSFY4M0s1dUNHZmw1VHpDN05MMlRM?=
 =?utf-8?B?RnNrUmhuTEw3aXUwZ0FudG1HbFpiQWd0dkIvNUVjMnlqNkhCM1ZzeFcxKzBF?=
 =?utf-8?B?QlJqSUdoWlM1c2o3NjNEWjAybGtObUNQclhyMUQ4VHZSMW5CcFNiVXJUY0Zn?=
 =?utf-8?B?cldBcEhveFlYMTlqMFdlSXlxYU94SCtSRzMrNDFaSXhaKzZWSUQvUXdoYk1L?=
 =?utf-8?B?b0g3c09hYXdSK2orNFdJWXVmaHBuZ2JON3NQb0xvYWlnalRHTU8wQWxVNVh4?=
 =?utf-8?B?dmZ0dU5tTGRHK1dEZmJ1dW8xZUV1Wjd3NkZlQmJhUFVQRnhJNW92aGRYNW9V?=
 =?utf-8?B?ZURXeTk0UXlrcFRwOEExSi9TNnUyNXFYQWlQczRBcFdtZ1M3UVNxc3Rwd25s?=
 =?utf-8?B?MHNHL3RpS0NzbjZqSVJSTC9ZTlloeXpJUkdVOG1VZEhodU1UMUdlOGxwTHZG?=
 =?utf-8?B?Nk1seHZUZ1hBUitxeU1ZQWV1dTdySFRocmV1bFR5OGxseTlSYWJ2YzFYYUNB?=
 =?utf-8?B?TG1iUnNmUldDU3I2MWpwQkNlSVdReEpvOUs1Zm56bUZlakxTSW9JOWtIVkpO?=
 =?utf-8?B?U3lPUnVmanI2SzZaUC9ZYUQ5YmtUczl5eHphaXo1aUlZc1FaQUpjem5JR2pT?=
 =?utf-8?B?WGhWc3ZBWThsOFprQVdPdkdXa3JJT1RmY2VPL1dUTW5PVE9LeG1aVkVrUzh6?=
 =?utf-8?B?cHpzaWI4c0JjNDZLczBnSForaEIzZ1dOU3Q5YzAwTGtURFhrOWhVK0tvNVR5?=
 =?utf-8?B?VVZjaEJqYXdVUW9jWjA2T1d6REVZQlk2TlY4dUViUUkrU1JOaVJKZG5NaWRv?=
 =?utf-8?B?T2ozclZXRmdrUlY4a3QwdUhjK1RkWGk2MjZZa3Y3dnJqb3NyWDA3azNVQlI0?=
 =?utf-8?B?dTBOVHF6YllYbjFQb2ZjSUN1aERvV2RsN3Q1RmthRW1iaTlxbUVZL0xQT3ZK?=
 =?utf-8?B?QS9ac0xCbVFJVW9hK1dQTzNhNDBMeHhySnBVYWZWYURlTnNNR3c1MFJzSTln?=
 =?utf-8?B?Wm9USnFuNHc4WkxJTHJxbTNjYkQrdVFhanFISmRrdUw1KzN6ZDlMNG1wRUkw?=
 =?utf-8?B?Smxjc0pUL29HRkM5MnZlTS9MYk1TRHZoWENQNjFpTmNtb1V3OFNLSnBYQ25N?=
 =?utf-8?B?QXUrWEFHSm9aY203THFzdzMyR0MyY3cvbVMvcFp5UmEvRDVOQVpBUjFLczEx?=
 =?utf-8?B?Y0tWL3ZSZHVZQlVEVTdibkxaU002TjMybkVlKzNXRkppWlR3RmdHNC9yd1Vw?=
 =?utf-8?B?Vlg1WE04R016alBTZkIxeW1PbVJQbjVFSXJIejNiYm1UN0ZEL3kySVBnMlFY?=
 =?utf-8?B?NDNtZlpsMmRGL2hVRktIbzQzNS9keGt4WDRONU1SUVI5Z09jVlBOYnFsSXlF?=
 =?utf-8?Q?wKF1llqogqYgVkJW/fMpsiFR3VpxgpiCHTzdp6b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd19eee-5f0b-49a8-1fcf-08d8e2722f61
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 20:38:52.7175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyeS1kBpmdJ7Ib+npmjdiju49l9+uha0vYiHM0XtOn/l22KZIzAvHEqGEbmbpoCHoAaK31TBBeECQ7PjmjGTBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <hwentlan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0wOCAzOjE4IHAubS4sIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4gT24gRnJpLCBN
YXIgNSwgMjAyMSBhdCAxMDoyNCBBTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0
PiB3cm90ZToKPj4KPj4gT24gMjAyMS0wMy0wNCA3OjI2IHAubS4sIEthemxhdXNrYXMsIE5pY2hv
bGFzIHdyb3RlOgo+Pj4gT24gMjAyMS0wMy0wNCAxMDozNSBhLm0uLCBNaWNoZWwgRMOkbnplciB3
cm90ZToKPj4+PiBPbiAyMDIxLTAzLTA0IDQ6MDkgcC5tLiwgS2F6bGF1c2thcywgTmljaG9sYXMg
d3JvdGU6Cj4+Pj4+IE9uIDIwMjEtMDMtMDQgNDowNSBhLm0uLCBNaWNoZWwgRMOkbnplciB3cm90
ZToKPj4+Pj4+IE9uIDIwMjEtMDMtMDMgODoxNyBwLm0uLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+
Pj4+Pj4+IE9uIFdlZCwgTWFyIDMsIDIwMjEgYXQgNTo1MyBQTSBNaWNoZWwgRMOkbnplciA8bWlj
aGVsQGRhZW56ZXIubmV0Pgo+Pj4+Pj4+IHdyb3RlOgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBNb3Jlb3Zl
ciwgaW4gdGhlIHNhbWUgc2NlbmFyaW8gcGx1cyBhbiBvdmVybGF5IHBsYW5lIGVuYWJsZWQgd2l0
aCBhCj4+Pj4+Pj4+IEhXIGN1cnNvciBjb21wYXRpYmxlIGZvcm1hdCwgaWYgdGhlIEZCIGJvdW5k
IHRvIHRoZSBvdmVybGF5IHBsYW5lIGlzCj4+Pj4+Pj4+IGRlc3Ryb3llZCwgdGhlIGNvbW1vbiBE
Uk0gY29kZSB3aWxsIGF0dGVtcHQgdG8gZGlzYWJsZSB0aGUgb3ZlcmxheQo+Pj4+Pj4+PiBwbGFu
ZSwgYnV0IGRtX2NoZWNrX2NydGNfY3Vyc29yIHdpbGwgcmVqZWN0IHRoYXQgbm93LiBJIGNhbid0
Cj4+Pj4+Pj4+IHJlbWVtYmVyCj4+Pj4+Pj4+IGV4YWN0bHkgd2hhdCB0aGUgcmVzdWx0IGlzLCBi
dXQgQUZBSVIgaXQncyBub3QgcHJldHR5Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gQ1JUQyBnZXRzIGRpc2Fi
bGVkIGluc3RlYWQuIFRoYXQncyB3aHkgd2Ugd2VudCB3aXRoIHRoZSAiYWx3YXlzCj4+Pj4+Pj4g
cmVxdWlyZSBwcmltYXJ5IHBsYW5lIiBoYWNrLiBJIHRoaW5rIHRoZSBvbmx5IHNvbHV0aW9uIGhl
cmUgd291bGQgYmUKPj4+Pj4+PiB0byBlbmFibGUgdGhlIHByaW1hcnkgcGxhbmUgKGJ1dCBub3Qg
aW4gdXNlcnNwYWNlLXZpc2libGUgc3RhdGUsIHNvCj4+Pj4+Pj4gdGhpcyBuZWVkcyB0byBiZSBk
b25lIGluIHRoZSBkYyBkZXJpdmVkIHN0YXRlIG9iamVjdHMgb25seSkgdGhhdCBzY2Fucwo+Pj4+
Pj4+IG91dCBibGFjayBhbnkgdGltZSB3ZSdyZSBpbiBzdWNoIGEgc2l0dWF0aW9uIHdpdGggY3Vy
c29yIHdpdGggbm8KPj4+Pj4+PiBwbGFuZXMuCj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBpcyBhYm91dCBh
IHNjZW5hcmlvIGRlc2NyaWJlZCBieSBOaWNob2xhcyBlYXJsaWVyOgo+Pj4+Pj4KPj4+Pj4+IEN1
cnNvciBQbGFuZSAtIEFSR0I4ODg4Cj4+Pj4+Pgo+Pj4+Pj4gT3ZlcmxheSBQbGFuZSAtIEFSR0I4
ODg4IERlc2t0b3AvVUkgd2l0aCBjdXRvdXQgZm9yIHZpZGVvCj4+Pj4+Pgo+Pj4+Pj4gUHJpbWFy
eSBQbGFuZSAtIE5WMTIgdmlkZW8KPj4+Pj4+Cj4+Pj4+PiBBbmQgZGVzdHJveWluZyB0aGUgRkIg
Ym91bmQgdG8gdGhlIG92ZXJsYXkgcGxhbmUuIFRoZSBmYWxsYmFjayB0bwo+Pj4+Pj4gZGlzYWJs
ZQo+Pj4+Pj4gdGhlIENSVEMgaW4gYXRvbWljX3JlbW92ZV9mYiBvbmx5IGtpY2tzIGluIGZvciB0
aGUgcHJpbWFyeSBwbGFuZSwgc28gaXQKPj4+Pj4+IHdvdWxkbid0IGluIHRoaXMgY2FzZSBhbmQg
d291bGQgZmFpbC4gV2hpY2ggd291bGQgaW4gdHVybiB0cmlnZ2VyIHRoZQo+Pj4+Pj4gV0FSTiBp
biBkcm1fZnJhbWVidWZmZXJfcmVtb3ZlIChhbmQgbGVhdmUgdGhlIG92ZXJsYXkgcGxhbmUgc2Nh
bm5pbmcKPj4+Pj4+IG91dAo+Pj4+Pj4gZnJvbSBmcmVlZCBtZW1vcnk/KS4KPj4+Pj4+Cj4+Pj4+
Pgo+Pj4+Pj4gVGhlIGNsZWFuZXN0IHNvbHV0aW9uIG1pZ2h0IGJlIG5vdCB0byBhbGxvdyBhbnkg
Zm9ybWF0cyBpbmNvbXBhdGlibGUKPj4+Pj4+IHdpdGgKPj4+Pj4+IHRoZSBIVyBjdXJzb3IgZm9y
IHRoZSBwcmltYXJ5IHBsYW5lLgo+Pj4+Pgo+Pj4+PiBMZWdhY3kgWCB1c2Vyc3BhY2UgZG9lc24n
dCB1c2Ugb3ZlcmxheXMgYnV0IENocm9tZSBPUyBkb2VzLgo+Pj4+Pgo+Pj4+PiBUaGlzIHdvdWxk
IHJlZ3Jlc3MgQ2hyb21lT1MgTVBPIHN1cHBvcnQgYmVjYXVzZSBpdCByZWxpZXMgb24gdGhlIE5W
MTIKPj4+Pj4gdmlkZW8gcGxhbmUgYmVpbmcgb24gdGhlIGJvdHRvbS4KPj4+Pgo+Pj4+IENvdWxk
IGl0IHVzZSB0aGUgTlYxMiBvdmVybGF5IHBsYW5lIGJlbG93IHRoZSBBUkdCIHByaW1hcnkgcGxh
bmU/Cj4+Pgo+Pj4gUGxhbmUgb3JkZXJpbmcgd2FzIHByZXZpb3VzbHkgdW5kZWZpbmVkIGluIERS
TSBzbyB3ZSBoYXZlIHVzZXJzcGFjZSB0aGF0Cj4+PiBhc3N1bWVzIG92ZXJsYXlzIGFyZSBvbiB0
b3AuCj4+Cj4+IFRoZXkgY2FuIHN0aWxsIGJlIGJ5IGRlZmF1bHQ/Cj4+Cj4+PiBUb2RheSB3ZSBo
YXZlIHRoZSB6LW9yZGVyIHByb3BlcnR5IGluIERSTSB0aGF0IGRlZmluZXMgd2hlcmUgaXQgaXMg
aW4KPj4+IHRoZSBzdGFjaywgc28gdGVjaG5pY2FsbHkgaXQgY291bGQgYnV0IHdlJ2QgYWxzbyBi
ZSByZWdyZXNzaW5nIGV4aXN0aW5nCj4+PiBiZWhhdmlvciBvbiBDaHJvbWUgT1MgdG9kYXkuCj4+
Cj4+IFRoYXQncyB1bmZvcnR1bmF0ZSwgYnV0IG1pZ2h0IGJlIHRoZSBsZWFzdCBiYWQgY2hvaWNl
IG92ZXJhbGwuCj4+Cj4+IEJUVywgZG9lc24ndCBDaHJvbWUgT1MgdHJ5IHRvIGRpc2FibGUgdGhl
IEFSR0Igb3ZlcmxheSBwbGFuZSB3aGlsZSB0aGVyZSBhcmUgbm8gVUkgZWxlbWVudHMgdG8gZGlz
cGxheT8gSWYgaXQgZG9lcywgdGhpcyBzZXJpZXMgbWlnaHQgYnJlYWsgaXQgYW55d2F5IChpZiB0
aGUgY3Vyc29yIHBsYW5lIGNhbiBiZSBlbmFibGVkIHdoaWxlIHRoZSBBUkdCIG92ZXJsYXkgcGxh
bmUgaXMgb2ZmKS4KPj4KPj4KPj4+Pj4gV2hlbiBDaHJvbWVPUyBkaXNhYmxlcyBNUE8gaXQgZG9l
c24ndCBkbyBpdCBwbGFuZSBieSBwbGFuZSwgaXQgZG9lcyBpdAo+Pj4+PiBpbiBvbmUgZ28gZnJv
bSBOVjEyK0FSR0I4ODg4IC0+IEFSR0I4ODg4OC4KPj4+Pgo+Pj4+IEV2ZW4gc28sIHdlIGNhbm5v
dCBleHBlY3QgYWxsIHVzZXIgc3BhY2UgdG8gZG8gdGhlIHNhbWUsIGFuZCB3ZSBjYW5ub3QKPj4+
PiBhbGxvdyBhbnkgdXNlciBzcGFjZSB0byB0cmlnZ2VyIGEgV0FSTiBhbmQgc2Nhbm91dCBmcm9t
IGZyZWVkIG1lbW9yeS4KPj4+Cj4+PiBUaGUgV0FSTiBkb2Vzbid0IHRyaWdnZXIgYmVjYXVzZSB0
aGVyZSdzIHN0aWxsIGEgcmVmZXJlbmNlIG9uIHRoZSBGQiAtCj4+Cj4+IFRoZSBXQVJOIHRyaWdn
ZXJzIGlmIGF0b21pY19yZW1vdmVfZmIgcmV0dXJucyBhbiBlcnJvciwgd2hpY2ggaXMgdGhlIGNh
c2UgaWYgaXQgY2FuJ3QgZGlzYWJsZSBhbiBvdmVybGF5IHBsYW5lLiBJIGFjdHVhbGx5IGhpdCB0
aGlzIHdpdGggSUdUIHRlc3RzIHdoaWxlIHdvcmtpbmcgb24gYjgzNmEyNzRiNzk3ICJkcm0vYW1k
Z3B1L2RjOiBSZXF1aXJlIHByaW1hcnkgcGxhbmUgdG8gYmUgZW5hYmxlZCB3aGVuZXZlciB0aGUg
Q1JUQyBpcyIgKEkgaW5pdGlhbGx5IHRyaWVkIGFsbG93aW5nIHRoZSBjdXJzb3IgcGxhbmUgdG8g
YmUgZW5hYmxlZCB0b2dldGhlciB3aXRoIGFuIG92ZXJsYXkgcGxhbmUgd2hpbGUgdGhlIHByaW1h
cnkgcGxhbmUgaXMgb2ZmKS4KPj4KPj4+IHRoZSByZWZlcmVuY2UgaGVsZCBieSBEUk0gc2luY2Ug
aXQncyBzdGlsbCBzY2FubmluZyBvdXQgdGhlIG92ZXJsYXkuCj4+PiBVc2Vyc3BhY2UgY2FuJ3Qg
cmVjbGFpbSB0aGlzIG1lbW9yeSB3aXRoIGFub3RoZXIgYnVmZmVyIGFsbG9jYXRpb24KPj4+IGJl
Y2F1c2UgaXQncyBzdGlsbCBpbiB1c2UuCj4+Cj4+IEdvb2QgcG9pbnQsIHNvIGF0IGxlYXN0IHRo
ZXJlJ3Mgbm8gc2Nhbm91dCBvZiBmcmVlZCBtZW1vcnkuIEV2ZW4gc28sIHRoZSBvdmVybGF5IHBs
YW5lIGNvbnRpbnVlcyBkaXNwbGF5aW5nIGNvbnRlbnRzIHdoaWNoIHVzZXIgc3BhY2UgYXBwYXJl
bnRseSBkb2Vzbid0IHdhbnQgdG8gYmUgZGlzcGxheWVkIGFueW1vcmUuCj4gCj4gSG0gSSBkbyB3
b25kZXIgaG93IG11Y2ggd2UgbmVlZCB0byBjYXJlIGZvciB0aGlzLiBJZiB5b3UgdXNlIHBsYW5l
cywKPiB5b3UgYmV0dGVyIHVzZSBURVNUX09OTFkgaW4gYXRvbWljIHRvIGl0J3MgZnVsbCBleHRl
bmQgKGluY2x1ZGluZwo+IGN1cnNvciwgaWYgdGhhdCdzIGEgcmVhbCBwbGFuZSwgd2hpY2ggaXQg
aXMgZm9yIGV2ZXJ5IGRyaXZlciBleGNlcHQKPiBtc20vbWRwNCkuIElmIHVzZXJzcGFjZSBzY3Jl
d3MgdGhpcyB1cCBhbmQgd29yc2UsIHNodXRzIG9mIHBsYW5lcyB3aXRoCj4gYW4gUk1GQiwgSSB0
aGluayBpdCdzIG5vdCBlbnRpcmVseSB1bnJlYXNvbmFibGUgdG8gY2xhaW0gdGhhdCBpdAo+IHNo
b3VsZCBrZWVwIHRoZSBwaWVjZXMuCj4gCj4gU28gbWF5YmUgd2Ugc2hvdWxkIHJlZmluZSB0aGUg
V0FSTl9PTiB0byBub3QgdHJpZ2dlciBpZiBvdGhlciBwbGFuZXMKPiB0aGFuIGNydGMtPnByaW1h
cnkgYW5kIGNydGMtPmN1cnNvciBhcmUgZW5hYmxlZCByaWdodCBub3c/Cj4gCj4+PiBJdCdzIGEg
bGl0dGxlIG9kZCB0aGF0IGEgZGlzYWJsZSBjb21taXQgY2FuIGZhaWwsIGJ1dCBJIGRvbid0IHRo
aW5rCj4+PiB0aGVyZSdzIGFueXRoaW5nIGluIERSTSBjb3JlIHRoYXQgc3BlY2lmaWVzIHRoYXQg
dGhpcyBjYW4ndCBoYXBwZW4gZm9yCj4+PiBwbGFuZXMuCj4+Cj4+IEknZCBzYXkgaXQncyBtb3Jl
IHRoYW4ganVzdCBhIGxpdHRsZSBvZGQuIDopIEJlaW5nIHVuYWJsZSB0byBkaXNhYmxlIGFuIG92
ZXJsYXkgcGxhbmUgc2VlbXMgdmVyeSBzdXJwcmlzaW5nLCBhbmQgY291bGQgbWFrZSBpdCB0cmlj
a3kgZm9yIHVzZXIgc3BhY2UgKG5vdCB0byBtZW50aW9uIGNvcmUgRFJNIGNvZGUgbGlrZSBhdG9t
aWNfcmVtb3ZlX2ZiKSB0byBmaW5kIGEgc29sdXRpb24uCj4+Cj4+IEknZCBzdWdnZXN0IHRoZSBh
bWRncHUgRE0gY29kZSBzaG91bGQgcmF0aGVyIHZpcnR1YWxpemUgdGhlIEtNUyBBUEkgcGxhbmVz
IHNvbWVob3cgc3VjaCB0aGF0IGFuIG92ZXJsYXkgcGxhbmUgY2FuIGFsd2F5cyBiZSBkaXNhYmxl
ZC4gV2hpbGUgdGhpcyBtaWdodCBpbmN1ciBzb21lIHNob3J0LXRlcm0gcGFpbiwgaXQgd2lsbCBs
aWtlbHkgc2F2ZSBtb3JlIHBhaW4gb3ZlcmFsbCBpbiB0aGUgbG9uZyB0ZXJtLgo+IAo+IFllYWgg
SSB0aGluayB0aGlzIGFtZCBkYyBjdXJzb3IgcHJvYmxlbSBpcyB0aGUgZmlyc3QgY2FzZSB3aGVy
ZQo+IHJlbW92aW5nIGEgcGxhbmUgY2FuIG1ha2UgdGhpbmdzIHdvcnNlLgo+IAo+IFNpbmNlIHRo
ZSBodyBpcyB3aGF0IGl0IGlzLCBjYW4ndCB3ZSBwdXQgYSB0cmFuc3BhcmVudCBwbGFuZSB3aXRo
Cj4gY3Vyc29yIGNvbXBhdGlibGUgZm9ybWF0IGluIGZvciB0aGUgY2FzZSB3aGVyZSBzdHVmZiB3
b3VsZCBmYWlsPyBTbwo+IG5vdCBmdWxseSB2aXJ0dWFsaXplIHRoZSBwbGFuZXMgKHNpbmNlIEkg
ZG9uJ3Qgc2VlIGhvdyB0aGF0IGhlbHBzKSwKPiBidXQganVzdCBrZWVwaW5nIHRoZSBwbGFuZSBn
b2luZyB1bmRlcm5lYXRoIGl0IGFsbC4KPiAKPiBJIHRoaW5rIHRoYXQncyBhbHNvIHdoYXQgVmls
bGUgZGlkIGZvciBpOTE1L2dlbjIsIHdoaWNoIGhhcyB0aGUKPiByZXF1aXJlbWVudCB0aGF0IHRo
ZSBwcmltYXJ5IHBsYW5lIG11c3QgYWx3YXlzIGJlIG9uIGlpcmMuCj4gCj4gT2ZjIHNpbmNlIGFt
ZCBkaXNwbGF5IGRvZXNuJ3QgZ28gdGhyb3VnaCBwYWdldGFibGVzIHRoaXMgbmVlZHMgc29tZQo+
IHZyYW0sIGJ1dCBtYXliZSB5b3UgY2FuIHVzZSB0aGUgc2NhbGVycyB0byBtYWtlIHRoZSByZXF1
aXJlbWVudCBhIGJpdAo+IGxlc3MgZHJhc3RpYy4KPiAtRGFuaWVsID4KClRoZSBjdXJzb3IgZnJh
bWVidWZmZXIgd291bGQgaGF2ZSB0byBiZSB1c2VkIGFzIHRoZSBwaXBlJ3MgcHJpbWFyeSAKZnJh
bWVidWZmZXIgaW4gdGhpcyBjYXNlIGJlY2F1c2UgdGhlIGhhcmR3YXJlIGhhcyBub3RoaW5nIHVu
ZGVybmVhdGggdG8gCnNjYW4gb3V0IGFsb25nIHdpdGggaXQuCgpJJ20gbm90IHN1cmUgdGhlIGF0
b21pYyBhc3luYyB1cGRhdGUgaW50ZXJmYWNlIHdvdWxkIHdvcmsgd2VsbCBpbiB0aGUgCnZpcnR1
YWxpemF0aW9uIGNhc2UgaWYgd2UgaGFkIHRvIGZhbGxiYWNrIGZyb20gdXNpbmcgdGhlIHJlZ3Vs
YXIgY3Vyc29yIApwcm9ncmFtbWluZyB0byB1c2luZyBmdWxsIHBpcGUgcHJvZ3JhbW1pbmcuCgpU
aGlzIHdvdWxkIGJ1cm4gZXh0cmEgcG93ZXIgZnJvbSB0aGUgc2Vjb25kYXJ5IHBpcGUgYnV0IGl0
IHdvdWxkIGFsc28gCmFkZCBjdXJzb3Igc3R1dHRlcmluZyBpbnRvIHRoZSBtaXggYmVjYXVzZSBh
c3luYyB1cGRhdGVzIHdvdWxkIGJlIGJsb2NrZWQuCgpNeSBwcmVmZXJlbmNlIHdvdWxkIGJlIHRv
IGNvbnRpbnVlIHRvIHJlamVjdCB0aGUgY29tbWl0cyBhbmQgbm90IAppbXBsZW1lbnQgdGhlIGZh
bGxiYWNrIHBhdGggYmVjYXVzZSBvZiBob3cgc3Vib3B0aW1hbCB0aGUgd2hvbGUgdGhpbmcgCmlz
LCBidXQgdGhpcyB3aG9sZSB0aGluZyBpcyBqdXN0IGtpbmQgb2YgYSBtZXNzLgoKUmVnYXJkcywK
TmljaG9sYXMgS2F6bGF1c2thcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
