Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECCBC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767CF61401
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767CF61401
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B76186E998;
	Mon, 17 May 2021 14:38:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EF789CBC
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je5nisnVXTdgzfnWTZxGMWJbaxI2s1eP/MAObpI4MqvEjQbpepez17ddx4BzxmJ4K+uGTr4wilKo0a6PXauHAma/R62s2SzbCnM2ZO5m41jQFyk4IL4Y+syJJyLfD+UE+nxRLbk/qsYPiVfPIR6/MotP8+Bg2QMRTLC6liPzFnMnWwkLUHreYcYtOuJH8kQIoy5cyuMYwhdYAbLNBwYlrA9J/4DynfhfLkydgUqxHj5JuqqxUEUBp1oAcX8GZioi43U4HGeWCF5/LoOfj/o8yKRxtXRjvgb1pEo3+1PZAjQj9HI2wJvQThDMZjc1uQzwv4NKY99r1x/UEGGn7RFO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsUzE/ZE7qnsll1nWkVoHogtv2owBKNlcCrsgaTBWb0=;
 b=OrTtwvamEJ7l5PeIcTyIa8N5U+8s8KQ75SDZ4gKqr19Ua2K5Vzmmtlrg5QprikmdZQWiGrNDCyDeCAj4j5rBl2Z7mhJraIgAbg49EkJKdolXfGuZ7GyXIDLvoVJ61PiAxQx6wCmLgh83DZx1j5TuB9wwyCnKvXPCmlD8lJg+VdmqFAVe7Hx/L+w4LWtqVi+NKvQfojeBfaWCp0uU8WfftQ5SLKR3QaU13T/WLrr1Q1JPCRnaP3yzrloXEllS3O+HE6ZnVZLCq38DqqGRJebPc7JaFdivs9BjEZ9lIZ8f1WNWv8+Ioe4Uzqa9pBl1DW0NRhnLiUZdttUeecrvO59q8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsUzE/ZE7qnsll1nWkVoHogtv2owBKNlcCrsgaTBWb0=;
 b=KgoSdthd0ki2RLqArboQmRUAONBr5xY0QH3XSomAT8nyGcmoIUPjqp3FJS8RQznDDYf2KJdLeBo7hvt9BnjpRYI1WFD4nQ8tZmZPpEntfyKOVARoCKYK045ixKHPS7lagkFDNoVitFMIWvRjfFA4yWqSOP8uz4DKCrHF/suZ2Xc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.29; Mon, 17 May
 2021 14:38:20 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:38:20 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: add invalid pages debug at vram migration
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210512173429.957-1-alex.sierra@amd.com>
 <20210512173429.957-3-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8d8b5ab4-df54-a190-0845-1fdacfc2046e@amd.com>
Date: Mon, 17 May 2021 10:38:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210512173429.957-3-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YT1PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::27)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YT1PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Mon, 17 May 2021 14:38:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a61fc49-b5e1-43d7-62d5-08d919416a9b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5289EE9988E0C7AC1CE9A4F5922D9@BN9PR12MB5289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwFK/1Zio9uje5tlRNo+qEpIeZ5HeNKcqz4SrSSki4TM5+0jOq6FPGu8lTo5Dfyl/ioqKm+IaQdcLt2D4oDicgH2qrHHPvILhPyIcuPvH9qvsIu7tsPJJrKH9bIOJJxz9oQgfeP2UtOmCR1ywIrFBUbdPCSjIY9+a619PnrIoUModEwgnisYjPDuLmyrQOl1sPpWQ8nR52irtHZHoOfnRW3fpWOaugz4E7nIQnhuFUcivVuHUd8cFEquOS/ICdRgsNpEPMjNGYWUu92jeHr/aBYzYZU8vvm6Y6QghRWu5vBGNo+Nz3t+R4w4kuCp8AsBEuU9lLwIKKLwHQdydLnkFShydoDcfi/5kn1tV8oBP0nYHfISXJ2OOnOBtoJ1gc/73AxPfjl2Qr6DTuMS234lwf4xENDXMaTXQ+VTlkPh58Mc/xtclSva6ysRrYxaYp1HHvvSn+qR3w87/Rkt3ZVw78rqOE2++m7oZ0N/ceXVkcYplQziZ3Z37qyy1tNDKcpq5KPq36UPYFgx9ANxxa/A06gvGa0PxmqTA/Sidcf1DW3XFM1A+eS1lLUcFcMSKGj/YoQ0+++PZoDl2tjzksEnc8Az21em1XST5lcCUr98QOMkLA3nPc90ZhzPJlVXBw/DtpgL5+IuWNVzOjw22NBbcp6hV6/RRlsjtOS3gTdSpeFQ+VUvmxeiSaJaPLvnUlaG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39850400004)(346002)(366004)(16576012)(316002)(31696002)(66946007)(2616005)(26005)(956004)(66476007)(66556008)(186003)(31686004)(86362001)(478600001)(8676002)(2906002)(38100700002)(8936002)(36756003)(6486002)(5660300002)(16526019)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YUpnVEtSemtSZVdYaHV4dUUxTjhaY3BGNWdlNjZZaHF3ZDByZGk4elg0SjlT?=
 =?utf-8?B?cTB4YWRwQW5FeGFpazIyYzl3ZUdsV1M3K2dqamZFeVJPUE1ITjZkY1JNWGZH?=
 =?utf-8?B?SmNwY2hRUUNPZHlQRWtENlR2cVBqU1hDOCtuWU5HTTg5MVg0NFFVdVNDVmF2?=
 =?utf-8?B?Z0svYjJQZmZaMHJvVStLMWc0YVQ4b2lQUVI4aGpWUjdTN1N2MXlDTXdSS2g4?=
 =?utf-8?B?dVFpWm1xSS9zdVJKYmw2cnk2b3U4cE9EY0FqK2xBajhNSktFZkNnbjdFZE1V?=
 =?utf-8?B?VksxRmREenQyY3FVTFozNE9LZXkzdkN1SGIvMEQ1MFo4TDRNQ3VGSURodlB5?=
 =?utf-8?B?VUVFbnRiVGIvdmgwcUZ2UkdnWVNMNGJ6Ymo0MDVJUHNORUkzTzV2Tm8zWCtw?=
 =?utf-8?B?NU1TSFBJbStjZUhTcUdvbWgxemRFOVFBcG5JM3lhaytBSmdSc3pEWHQ2UEhz?=
 =?utf-8?B?U21nKzEydkYyd3dBMHJTT013cnlYNVdOQWlVWGt3NkZwTzY3Qi83cjhwY01n?=
 =?utf-8?B?clUrb3E4VElMbURkOTRjRVZzSWdVWm9Ma2czeXBpQlFpVVNVLy9pcytHL0RP?=
 =?utf-8?B?Y2RIbi82cEp2TncyOWNuNUZFVnRrbVU2WkFXRE1iUnpZTlJyNUdjWk1KUUpl?=
 =?utf-8?B?TllXeFl2ZXorZWhNR0N3eXY2S245ZGZJNW9KVUtBYVA4RmY4Y0kwWjBBcWdM?=
 =?utf-8?B?Nnd1UzVJUjB4Skhua0J6OVFlVUgveUZmVE0zeGwyenQ2SlljWlpHQ1JDUEpo?=
 =?utf-8?B?TUMwTmpaa2lTeEh1K1RGQlFxQ2xCZ1JZOWovSVNlL0lOUlBTUHgxMnpUSU5q?=
 =?utf-8?B?OXZJQXNXbHR5bFp0Nnc3T3UrT3NsTTExT3hvNjNpOFhXN1pnUnB0MlI1ZURh?=
 =?utf-8?B?bU9Jcjc1NzV3NjdNVmIreE9uRHB5MHZ2eVFVWDJpVlI4Zm92b3Y1TVh5dHBz?=
 =?utf-8?B?VVZ0dnJ6VUI5dUdsSkhyNXBsMDFobEJpcjM4SXRtajByZG54YVBBRU1qM2FX?=
 =?utf-8?B?MjFOOHFVR1pLWGI0YWU4aldFUjhVaWQ5RnYzVC8yS0F2ZUJNVUtaSm1JSVJX?=
 =?utf-8?B?NjlSd3FNYnhDYkswZGpGeTRLWjVBbElWN1RXbE1iSm9NS2J3NW5UaU5wUVBx?=
 =?utf-8?B?YXRvRE1jbE1TQno4YzZ1ZnhXcktEQzhlWnROZGVRcFNiR3pxakNPbTFvalZh?=
 =?utf-8?B?ME13ZlVYdzZRaERzejJpanZVeHkyRlltQ3ZGVkNIRlZWR0w4ZjlCODBYdGoz?=
 =?utf-8?B?SjFUdFFlcENwTGw4Sk1nVGxMck0xRXZiRjRiQzRZV2FQNVk2aDJORkZjazlz?=
 =?utf-8?B?aDkyOHYzSHVPRWFLaFJkN01CazNCSnd0U0J2dkVVQ0hLV2lrcTM3OXN2dFRr?=
 =?utf-8?B?TWhwQlBaUXhkeGhBV2Z1N3gzQitTRkpJNTc0YkxKazhBWmtWekxyci9PaEJF?=
 =?utf-8?B?ZEhtT3d2cXlZZFV6Y3R3OXBCQlhKRzFlUHJqZ2ZSSHdKcUJDOHlNQnZ5b2Rz?=
 =?utf-8?B?Rk5BRGUvYmY2M3o4SU0rSmhnTms5U3dQT1Q4U1AxZjJRSDg1R3d4VXFvTGhJ?=
 =?utf-8?B?TStGNlFvaXZjMXpkYjVBUWR5NWNJTXpWa095NnVFeE02Z1B1TjBxOXBiL0Rm?=
 =?utf-8?B?TUZXVzEwR20ybEhlcmxTYzU3RVo1TEQrZUFCbUxLb3IrdUkyQ3VLdkF4Rmtq?=
 =?utf-8?B?QURmY3YvOEluZ29FOWpqc3I4aGh2SVBRdFhqNXFFdVJQdjAxMWQySXUvSXVE?=
 =?utf-8?Q?kyvm6IC8N1f+MdV3/unR3+44KVRUj5OB+Y5yisl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a61fc49-b5e1-43d7-62d5-08d919416a9b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:38:20.3335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxCJVgDszuJ+OJ+utA4ARSuvFCFche9ZAye+oaLYK7lH83/NbrbnB6O4aY81FBhQ1WE80KsAOLLzkJpS4f4CtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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

CkFtIDIwMjEtMDUtMTIgdW0gMTozNCBwLm0uIHNjaHJpZWIgQWxleCBTaWVycmE6Cgo+IFRoaXMg
aXMgZm9yIGRlYnVnIHB1cnBvc2VzIG9ubHkuCj4gSXQgY29uZGl0aW9uYWxseSBnZW5lcmF0ZXMg
cGFydGlhbCBtaWdyYXRpb25zIHRvIHRlc3QgbWl4ZWQKPiBDUFUvR1BVIG1lbW9yeSBkb21haW4g
cGFnZXMgaW4gYSBwcmFuZ2UgZWFzaWx5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEg
PGFsZXguc2llcnJhQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9taWdyYXRlLmMgfCAxNCArKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9taWdyYXRlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5j
Cj4gaW5kZXggZTFjYzg0NGIyZjRlLi40YzZlMzQwMzkzZmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMKPiBAQCAtNDAzLDYgKzQwMywyMCBAQCBzdm1fbWln
cmF0ZV9jb3B5X3RvX3ZyYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBzdm1f
cmFuZ2UgKnByYW5nZSwKPiAgCQl9Cj4gIAl9Cj4gIAo+ICsjaWZkZWYgREVCVUdfRk9SQ0VfTUlY
RURfRE9NQUlOUwo+ICsJZm9yIChpID0gMCwgaiA9IDA7IGkgPCBucGFnZXM7IGkgKz0gNCwgaisr
KSB7Cj4gKwkJaWYgKGogJiAxKQo+ICsJCQljb250aW51ZTsKPiArCQlzdm1fbWlncmF0ZV9wdXRf
dnJhbV9wYWdlKGFkZXYsIGRzdFtpXSk7Cj4gKwkJbWlncmF0ZS0+ZHN0W2ldID0gMDsKPiArCQlz
dm1fbWlncmF0ZV9wdXRfdnJhbV9wYWdlKGFkZXYsIGRzdFtpICsgMV0pOwo+ICsJCW1pZ3JhdGUt
PmRzdFtpICsgMV0gPSAwOwo+ICsJCXN2bV9taWdyYXRlX3B1dF92cmFtX3BhZ2UoYWRldiwgZHN0
W2kgKyAyXSk7Cj4gKwkJbWlncmF0ZS0+ZHN0W2kgKyAyXSA9IDA7Cj4gKwkJc3ZtX21pZ3JhdGVf
cHV0X3ZyYW1fcGFnZShhZGV2LCBkc3RbaSArIDNdKTsKPiArCQltaWdyYXRlLT5kc3RbaSArIDNd
ID0gMDsKPiArCX0KPiArI2VuZGlmCgpZb3UncmUgZG9pbmcgdGhpcyBhdCB0aGUgZW5kIG9mIHN2
bV9taWdyYXRlX2NvcHlfdG9fdnJhbS4gSWYgeW91IGRpZCBpdAppbiB0aGUgYmVnaW5uaW5nLCB5
b3UgY291bGQgYWxzbyBjaGVjayB0aGF0IHN2bV9taWdyYXRlX2NvcHlfdG9fdnJhbQppdHNlbGYg
aXMgYmVoYXZpbmcgY29ycmVjdGx5IGZvciBwYXJ0aWFsIG1pZ3JhdGlvbnMuCgpSZWdhcmRzLArC
oCBGZWxpeAoKCj4gIG91dDoKPiAgCXJldHVybiByOwo+ICB9Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
