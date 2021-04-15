Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890EBC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 14:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F2A61153
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 14:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F2A61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9463B6EA51;
	Thu, 15 Apr 2021 14:12:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 866376EA51
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 14:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwYeJUDdbTPJDPQ5LLYJZF0ptM0whkUzhWyVOsBM1axa6gG3q1M+UYY5JeLC2myjGTcE/dVLOJ7BNRWG8Nqlni/vDpAq7or5U9wvUpH6xKKf3G5DNtkGWKhgzmRK3R2LhraS3Xk86WHlSwePJh+ziQxxTbCTnUsRer4T7T/obRoRmY/hzaBQEHAa6+1Qlk7ZlKEetOT80ckP1eNifEebph2SiprPnVPCUOzg+XmM/wnjbghF7b0LiVt3FDZDlaQ9YdNFlJqI5nGceVOHi7bwlTLr99DYRSalmplpUGxV0IMExGTp+CL/SALmwxQc+ySA8ADMxLeV7ahsuRFR40JUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7E8avOuoFxPPdXVpV99/ZAhDru6hrjcXqeSSiHIFSI=;
 b=gZOd5pZSJCpBKvEeOIKBw6PXcHLj3X1lLD8lwVcYchAHv76yW9msFqsXIybbOzDLWQjdj71KmXNqMqPPvAeE0E9F5oYHqNO3y6I+f8WUL0KyB7PncwaJ2mOyV5maliItmJtKhFaLb4pX5mbABfTqWWQf30dwPLIemDWiReUNulJEJQClG+TEvx5ZK8/iVqx8KoaiPHtLB/1g0c7HZCbKwGN6jcXUbp7k31gVllV4KBZ5/eKdcXI2GymNQxhf8mXVpgePhk+eYWB5YoJ34cR2AkcN1iB3q2++JPoRNVl8oSxPINGclbrYt0rAuI8g3vdhZ9Z7QThDQ52HLSaatsoGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7E8avOuoFxPPdXVpV99/ZAhDru6hrjcXqeSSiHIFSI=;
 b=MqyuqsI2cXgTySBabpZQQ16cZ9G/+/zfwXV5VA1aC2i7erVGeVY3rrVstmXP2f/f0Gfa1UHT2q09eTWjyUBEvzzbjFVe3Zi3J7+HyvEQzm0lCo+CgxBtSCOCcntgbyjS5/c7QaxLR+X/xaIgtctsHyh0eQBuK+8Lia+3ucR/VuM=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Thu, 15 Apr
 2021 14:11:58 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 14:11:58 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
 <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
 <0fe87232-08ec-d804-ff55-2716b8e09c12@amd.com>
 <e37d6954-46e7-e7eb-22c3-a5b19829fe6c@amd.com>
 <65cd86df-b660-6c8a-348e-d511b61d91d4@amd.com>
 <689099ea-c1e9-31ea-6a5a-070562cb7440@amd.com>
 <b30c75cf-9b00-b52d-1ac1-ccd33e02bfe3@amd.com>
 <3dab0504-b834-add7-1f2f-0237b0f0c20d@amd.com>
 <bb13794d-1067-6b91-c2dc-138118c3ef0d@amd.com>
 <cd66c76d-5678-f495-75a8-b8c4f6458353@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <1b35efc3-87c8-7ec3-1ad3-bb7c9ab515ba@amd.com>
Date: Thu, 15 Apr 2021 10:11:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <cd66c76d-5678-f495-75a8-b8c4f6458353@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:b19e:41d7:d05d:3307]
X-ClientProxiedBy: YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::47) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:b19e:41d7:d05d:3307]
 (2607:fea8:3edf:49b0:b19e:41d7:d05d:3307) by
 YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22 via Frontend Transport; Thu, 15 Apr 2021 14:11:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28e7a0fe-3f91-46cf-7f68-08d900186e92
X-MS-TrafficTypeDiagnostic: SA0PR12MB4448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4448733A33350B8B521C9101EA4D9@SA0PR12MB4448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6FaIFp4yepGCynnHl20mo+22+dy2FqS9TKu0JGYs4w/1XK5O8V9U9ZPOBr3iGeCb4FEqUsqOuO7JE86K0NmpzsqgavzyHS3t5k5vFu84IWAskXePBIXi9VeRAcxXMKzO9UUskzWxJ5ABelYY70fkCmTmzxWD00DYHpmTxX/ZAcTFgNIM4szwISGTx/5Y/UMR59ya5/VziTS1fvNHlxDgpP4Xt4Rv0HzfVCDUtVZiNruJxyU3b/xNlJgZ16RLFWgzXqXS7dwbsehsIWs/d73iKapZfj6lsdUCAAkiXKQ3Z6lw/0J9FSSi1oEBgv91omdlHboO2Cs388r6fD5kSogmY7dvaqAXpWYaydnYHnrAovhEDE8pSo5f8QpdI/CO3p7cFivJOIWV5wzzNtjZzab4B0xnv0KttpN7yWJbiI/wvmDZyj/xNhXsOnrN6lROxXMjhS97GEM64JMRRMz/vVYSNwLpWfsdIn/ZtfnZsxunuLSWenNyNoyaYxfItEcRumgerkyLAGCL+KTS6/4kFg5YqNuY4v/CLSaxJlrep33w9AAMZLaRtRY9tAXphYkFKeZeimnNo5S1qpmQgkPZg3ZwYcdExjY3B9blUFK0Q7+UBW93BXNbEZu0WnRZ4XJBs4U26roh/xRITIjEYkycBkPSMiHEuHTWQQCIJC3sFysnLqYzuMCFWaak6N43+0IzX5rOBdkUl55AmsvKh2EdtS4RTeVjEBWt1CgsYG7/qB2cjkc5ZBKnwbK7TkOnKbMsRV+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66556008)(478600001)(66476007)(921005)(316002)(31686004)(66574015)(83380400001)(966005)(86362001)(36756003)(45080400002)(53546011)(110136005)(6486002)(66946007)(8676002)(16526019)(2616005)(52116002)(44832011)(186003)(8936002)(5660300002)(38100700002)(2906002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q2dCbk1zdVFiYXVXR0pZNVpFUnRkTnl2b2xINDhMd0FTZzV2TTJ6dDJaNVVl?=
 =?utf-8?B?ektGMVBGMWhNckJIRFVQYk5mMWNabC9CdlV5VHc5aDFLTkVGYUVkSW5vU0Zu?=
 =?utf-8?B?SUluWGZBZm9rejZ3MlgyVDI5N3pxWTROUU00NWFpMVhBb09sTWp3SHNIdWxz?=
 =?utf-8?B?TmtHS2FaTTZ0MVVTaTE3akQrbXFPSjhYYUF0UHhUZzFCdDRRMUFqbndseERu?=
 =?utf-8?B?QkNISDRVUGtyTDE2NklPdDhMUGhxZkIwejBQU2J2TndON0Via1JnZ09sYWRk?=
 =?utf-8?B?ajV6aXdSWVdUS1dyUlU3WG8wZEswa1dXMmVPRThuTHNlTTVyVXFqR3FkSHI3?=
 =?utf-8?B?Q2ZGU3NQc0tCQWIxNDBDRUdGOFdSckZCWlZHNWk3anRDemdBbWdwQk9DNGRB?=
 =?utf-8?B?MFc1UEN3dzRDR0J2N01FY1pldEQ4RW9PNlVmS3lRRGowZmNnaGhQaUszZDh6?=
 =?utf-8?B?OTAwNlU5T3lFRTljMTZVaDlKTmsrMEp0N1lQeWlELzF1QXlaenpPWFFJSUkv?=
 =?utf-8?B?dGlzdXRDSG0zdVVGbkV3M1F0RFErYUpscHF4MWpGOU1DYy9TSTdkS3FkNzhr?=
 =?utf-8?B?V2JuNjZoUUVVR1JzU0RQS2dFby9jRVl5MmtCZmhpYjJDUE5vQ0ZjSEgzd1FK?=
 =?utf-8?B?WEt0eVlFa09sU0xPbWUxeDUwNFR4aThKNGdFdW9RdTFCVVVGejFManRmKzhR?=
 =?utf-8?B?MFRNOUJhdUdraC9NMEhQWEtsU1p2Y25tSXJVT3NaRGNvTDBxcWh1dUhDRndK?=
 =?utf-8?B?Lys3cTJRZjNMSEZvUWQxTnF1dXlHVnZpSGkwb1ZMUnM4bjU1TlgyVTFQa096?=
 =?utf-8?B?ZzU2U3ZTNkJGaVR5TFdpd2JraUpJYUQrdTROREd2SkV2akNWbWhLSWhrZVYw?=
 =?utf-8?B?NmswMHcyUjNWSFJaaDY2a1hsc3dlV3NWckJ2Vk1weTJXRTV6QWQxSmZsQ0Y3?=
 =?utf-8?B?RERuMU1NUitPb1hLcEtLTGJKSERLNjU5dmZob3JVOHVPN0VhOVNwWkhRSG1m?=
 =?utf-8?B?VjhPdmREWmFWc0VGNGZZUTVNSGFSMXFXZUZtVndFc0oxT3NwL3RDTU95R0pt?=
 =?utf-8?B?ZUNIS0gxSGtpV1JycDJSSlhHOWNjQWRDR1JxQ1hNaTk5aFc1SVV3TTR5NUJC?=
 =?utf-8?B?WkNpaTUwdUhVRlJvdXRVYXFzbEI3ei96S1daTDVIdU4rcklsckhMN2ZQUzBM?=
 =?utf-8?B?c1R4OXpYenBCVUxvRlA4dzBmcGtabnRTNktqNE5MYy81eDkrS0h5OTVSYUZV?=
 =?utf-8?B?T3NkUXRiNzJ6U2JNNXBlTjM5b2oyaXh1a01hNjNSWitqbXNyaXI1aFdKMG93?=
 =?utf-8?B?d25QS01nRjYrcnJZaFBHNERxbzc5ZUQ4TGczNXVDRCtMOWtTQ3pyRVpGWERK?=
 =?utf-8?B?Z1VIbVJsOWlVNGowSlJ4cksrKzAveENRcDUzdm9kWDFMWUpBYTVyM0RBcGU1?=
 =?utf-8?B?NFdIeE1IbU9jVE10YzZTR1F6dlZMc0V6S0tEZWZtc0VFVGJmMmJDaUV4RUo1?=
 =?utf-8?B?a0p6WXBoSHVPbXBDbDdxUEdPdjJoZTVISmRjeXJROVJzRG9HUmg3cWp4eGpK?=
 =?utf-8?B?V3lIdkhDQ2lUQjgreTVGRWtEWEpSZk11ZUNkT0ZCQUVQSEkza1hRaVBhMDFo?=
 =?utf-8?B?ZkJJL2IzNHdqR2xxRFNidUxoR0tMbjNUVkNKVzhmTGl2S1lzZGlqbUlOYklC?=
 =?utf-8?B?b0l4eE9lYzJWR09hUTEwL3JORGR2SmpTd0FJT1VUQkplOUNCZUJ3T2F0bnRa?=
 =?utf-8?B?UFJwSUl6ZEk5YnJJcDlyaVJsL3Z1Y1g2SjlsWFBnWVY4bEZZV0s2V0hsUzR0?=
 =?utf-8?B?VWxrNE9XOHV5UXpVWHg2cXNjWlRkR0xKUlFwdEFVbHpQZzVHSTY0cXhWRXR4?=
 =?utf-8?Q?SCVMGWVbuRVgC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e7a0fe-3f91-46cf-7f68-08d900186e92
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 14:11:58.6594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcV5gi3mYotTVPZIf9M9Qn3oze2ozu29pRpKe6f6xiHheoQyAGcjzxryIk3q8AL0P0iA2vkMjkYsFtGKhHtBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDQtMTUgMzowMiBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDE1
LjA0LjIxIHVtIDA4OjI3IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Cj4+IE9uIDIwMjEt
MDQtMTQgMTA6NTggYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDE0LjA0LjIx
IHVtIDE2OjM2IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4gwqBbU05JUF0KPj4+Pj4+
Pgo+Pj4+Pj4+IFdlIGFyZSByYWNpbmcgaGVyZSBvbmNlIG1vcmUgYW5kIG5lZWQgdG8gaGFuZGxl
IHRoYXQuCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IEJ1dCB3aHksIEkgd3JvdGUgYWJvdmUgdGhhdCB3
ZSBmaXJzdCBzdG9wIHRoZSBhbGwgc2NoZWR1bGVycywgCj4+Pj4+PiB0aGVuIG9ubHkgY2FsbCBk
cm1fc2NoZWRfZW50aXR5X2tpbGxfam9icy4KPj4+Pj4KPj4+Pj4gVGhlIHNjaGVkdWxlcnMgY29u
c3VtaW5nIGpvYnMgaXMgbm90IHRoZSBwcm9ibGVtLCB3ZSBhbHJlYWR5IAo+Pj4+PiBoYW5kbGUg
dGhhdCBjb3JyZWN0Lgo+Pj4+Pgo+Pj4+PiBUaGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBlbnRpdGll
cyBtaWdodCBjb250aW51ZSBmZWVkaW5nIHN0dWZmIGludG8gCj4+Pj4+IHRoZSBzY2hlZHVsZXIu
Cj4+Pj4KPj4+Pgo+Pj4+IE1pc3NlZCB0aGF0LsKgIE9rLCBjYW4gSSBqdXN0IHVzZSBub24gc2xl
ZXBpbmcgUkNVIHdpdGggYSBmbGFnIAo+Pj4+IGFyb3VuZCBkcm1fc2NoZWRfZW50aXR5X3B1c2hf
am9iIGF0IHRoZSBhbWRncHUgbGV2ZWwgKG9ubHkgMiAKPj4+PiBmdW5jdGlvbnMgY2FsbCBpdCAt
IGFtZGdwdV9jc19zdWJtaXQgYW5kIGFtZGdwdV9qb2Jfc3VibWl0KSBhcyBhIAo+Pj4+IHByZWxp
bWluYXJ5IHN0ZXAgdG8gZmx1c2ggYW5kIGJsb2NrIGluIGZsaWdodCBhbmQgZnV0dXJlIAo+Pj4+
IHN1Ym1pc3Npb25zIHRvIGVudGl0eSBxdWV1ZSA/Cj4+Pgo+Pj4gRG91YmxlIGNoZWNraW5nIHRo
ZSBjb2RlIEkgdGhpbmsgd2UgY2FuIHVzZSB0aGUgbm90aWZpZXJfbG9jayBmb3IgdGhpcy4KPj4+
Cj4+PiBFLmcuIGluIGFtZGdwdV9jcy5jIHNlZSB3aGVyZSB3ZSBoYXZlIHRoZSBnb3RvIGVycm9y
X2Fib3J0Lgo+Pj4KPj4+IFRoYXQgaXMgdGhlIHBsYWNlIHdoZXJlIHN1Y2ggYSBjaGVjayBjb3Vs
ZCBiZSBhZGRlZCB3aXRob3V0IGFueSAKPj4+IGFkZGl0aW9uYWwgb3ZlcmhlYWQuCj4+Cj4+Cj4+
IFN1cmUsIEkgd2lsbCBqdXN0IGhhdmUgdG8gYWRkIHRoaXMgbG9jayB0byBhbWRncHVfam9iX3N1
Ym1pdCB0b28uCj4KPiBOb3QgaWRlYWwsIGJ1dCBJIHRoaW5rIHRoYXQncyBmaW5lIHdpdGggbWUu
IFlvdSBtaWdodCB3YW50IHRvIHJlbmFtZSAKPiB0aGUgbG9jayBmb3IgdGhpcyB0aG91Z2h0Lgo+
Cj4+Cj4+PiBbU05JUF0KPj4+Pj4+Cj4+Pj4+PiBNYXliZSBqdXN0IGVtcGlyaWNhbGx5IC0gbGV0
J3MgdHJ5IGl0IGFuZCBzZWUgdW5kZXIgZGlmZmVyZW50IAo+Pj4+Pj4gdGVzdCBzY2VuYXJpb3Mg
d2hhdCBhY3R1YWxseSBoYXBwZW5zwqAgPwo+Pj4+Pgo+Pj4+PiBOb3QgYSBnb29kIGlkZWEgaW4g
Z2VuZXJhbCwgd2UgaGF2ZSB0aGF0IGFwcHJvYWNoIHdheSB0byBvZnRlbiBhdCAKPj4+Pj4gQU1E
IGFuZCBhcmUgdGhlbiBzdXJwcmlzZWQgdGhhdCBldmVyeXRoaW5nIHdvcmtzIGluIFFBIGJ1dCBm
YWlscyAKPj4+Pj4gaW4gcHJvZHVjdGlvbi4KPj4+Pj4KPj4+Pj4gQnV0IERhbmllbCBhbHJlYWR5
IG5vdGVkIGluIGhpcyByZXBseSB0aGF0IHdhaXRpbmcgZm9yIGEgZmVuY2UgCj4+Pj4+IHdoaWxl
IGhvbGRpbmcgdGhlIFNSQ1UgaXMgZXhwZWN0ZWQgdG8gd29yay4KPj4+Pj4KPj4+Pj4gU28gbGV0
J3Mgc3RpY2sgd2l0aCB0aGUgYXBwcm9hY2ggb2YgaGlnaCBsZXZlbCBsb2NraW5nIGZvciBob3Rw
bHVnLgo+Pj4+Cj4+Pj4KPj4+PiBUbyBteSB1bmRlcnN0YW5kaW5nIHRoaXMgaXMgdHJ1ZSBmb3Ig
b3RoZXIgZGV2aXNlcywgbm90IHRoZSBvbmUgCj4+Pj4gYmVpbmcgZXh0cmFjdGVkLCBmb3IgaGlt
IHlvdSBzdGlsbCBuZWVkIHRvIGRvIGFsbCB0aGUgSFcgZmVuY2UgCj4+Pj4gc2lnbmFsbGluZyBk
YW5jZSBiZWNhdXNlIHRoZSBIVyBpcyBnb25lIGFuZCB3ZSBibG9jayBhbnkgVERScyAKPj4+PiAo
d2hpY2ggd29uJ3QgaGVscCBhbnl3YXkpLgo+Pj4+Cj4+Pj4gQW5kcmV5Cj4+Cj4+Cj4+IERvIHlv
dSBhZ3JlZSB0byB0aGUgYWJvdmUgPwo+Cj4gWWVhaCwgSSB0aGluayB0aGF0IGlzIGNvcnJlY3Qu
Cj4KPiBCdXQgb24gdGhlIG90aGVyIGhhbmQgd2hhdCBEYW5pZWwgcmVtaW5kZWQgbWUgb2YgaXMg
dGhhdCB0aGUgaGFuZGxpbmcgCj4gbmVlZHMgdG8gYmUgY29uc2lzdGVudCBvdmVyIGRpZmZlcmVu
dCBkZXZpY2VzLiBBbmQgc2luY2Ugc29tZSBkZXZpY2UgCj4gYWxyZWFkeSBnbyB3aXRoIHRoZSBh
cHByb2FjaCBvZiBjYW5jZWxpbmcgZXZlcnl0aGluZyB3ZSBzaW1wbHkgaGF2ZSB0byAKPiBnbyBk
b3duIHRoYXQgcm91dGUgYXMgd2VsbC4KPgo+IENocmlzdGlhbi4KCgpXaGF0IGRvZXMgaXQgbWVh
biBpbiBvdXIgY29udGV4dCA/IFdoYXQgbmVlZHMgdG8gYmUgZG9uZSB3aGljaCB3ZSBhcmUgCm5v
dCBkb2luZyBub3cgPwoKQW5kcmV5CgoKPgo+Pgo+PiBBbmRyZXkKPj4KPj4KPj4+Pgo+Pj4+Cj4+
Pj4+Cj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Cj4+
Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+
IEFuZHJleQo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+Pj4+PiBD
aHJpc3RpYW4uCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4gQlRXOiBDb3VsZCBpdCBiZSB0aGF0IHRoZSBkZXZp
Y2UgU1JDVSBwcm90ZWN0cyBtb3JlIHRoYW4gCj4+Pj4+Pj4+Pj4+Pj4+PiBvbmUgZGV2aWNlIGFu
ZCB3ZSBkZWFkbG9jayBiZWNhdXNlIG9mIHRoaXM/Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IEkgaGF2ZW4ndCBhY3R1YWxseSBleHBlcmllbmNlZCBhbnkgZGVh
ZGxvY2sgdW50aWwgbm93IAo+Pj4+Pj4+Pj4+Pj4+PiBidXQsIHllcywgZHJtX3VucGx1Z19zcmN1
IGlzIGRlZmluZWQgYXMgc3RhdGljIGluIAo+Pj4+Pj4+Pj4+Pj4+PiBkcm1fZHJ2LmMgYW5kIHNv
IGluIHRoZSBwcmVzZW5jZSBvZiBtdWx0aXBsZSBkZXZpY2VzIGZyb20gCj4+Pj4+Pj4+Pj4+Pj4+
IHNhbWUgb3IgZGlmZmVyZW50IGRyaXZlcnMgd2UgaW4gZmFjdCBhcmUgZGVwZW5kZW50IG9uIGFs
bCAKPj4+Pj4+Pj4+Pj4+Pj4gdGhlaXIgY3JpdGljYWwgc2VjdGlvbnMgaSBndWVzcy4KPj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IFNoaXQsIHllYWggdGhlIGRldmls
IGlzIGEgc3F1aXJyZWwuIFNvIGZvciBBK0kgbGFwdG9wcyB3ZSAKPj4+Pj4+Pj4+Pj4+PiBhY3R1
YWxseSBuZWVkIHRvIHN5bmMgdGhhdCB1cCB3aXRoIERhbmllbCBhbmQgdGhlIHJlc3Qgb2YgCj4+
Pj4+Pj4+Pj4+Pj4gdGhlIGk5MTUgZ3V5cy4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IElJ
UkMgd2UgY291bGQgYWN0dWFsbHkgaGF2ZSBhbiBhbWRncHUgZGV2aWNlIGluIGEgZG9ja2luZyAK
Pj4+Pj4+Pj4+Pj4+PiBzdGF0aW9uIHdoaWNoIG5lZWRzIGhvdHBsdWcgYW5kIHRoZSBkcml2ZXIg
bWlnaHQgZGVwZW5kIG9uIAo+Pj4+Pj4+Pj4+Pj4+IHdhaXRpbmcgZm9yIHRoZSBpOTE1IGRyaXZl
ciBhcyB3ZWxsLgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBDYW4ndCB3
ZSBwcm9wb3NlIGEgcGF0Y2ggdG8gbWFrZSBkcm1fdW5wbHVnX3NyY3UgcGVyIAo+Pj4+Pj4+Pj4+
Pj4gZHJtX2RldmljZSA/IEkgZG9uJ3Qgc2VlIHdoeSBpdCBoYXMgdG8gYmUgZ2xvYmFsIGFuZCBu
b3QgCj4+Pj4+Pj4+Pj4+PiBwZXIgZGV2aWNlIHRoaW5nLgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
PiBJJ20gcmVhbGx5IHdvbmRlcmluZyB0aGUgc2FtZSB0aGluZyBmb3IgcXVpdGUgYSB3aGlsZSBu
b3cuCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IEFkZGluZyBEYW5pZWwgYXMgd2VsbCwgbWF5YmUg
aGUga25vd3Mgd2h5IHRoZSAKPj4+Pj4+Pj4+Pj4gZHJtX3VucGx1Z19zcmN1IGlzIGdsb2JhbC4K
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gUmVnYXJkcywKPj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+IMKgwqDCoCAvKiBQYXN0IHRoaXMgcG9pbnQgbm8gbW9yZSBmZW5jZSBhcmUgc3Vi
bWl0dGVkIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0byBIVyByaW5nIGFuZCBoZW5jZSB3ZSBjYW4g
c2FmZWx5IGNhbGwgZm9yY2UgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHNpZ25hbCBvbiBhbGwgdGhh
dCBhcmUgY3VycmVudGx5IHRoZXJlLgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqIEFu
eSBzdWJzZXF1ZW50bHkgY3JlYXRlZCBIVyBmZW5jZXMgd2lsbCBiZSAKPj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4gcmV0dXJuZWQgc2lnbmFsZWQgd2l0aCBhbiBlcnJvciBjb2RlIHJpZ2h0IGF3YXkKPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgKi8KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGZvcl9lYWNoX3JpbmcoYWRldikKPj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4gYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MocmluZykKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGRybV9kZXZfdW5wbHVnKGRldik7Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+IMKgwqDCoCBTdG9wIHNjaGVkdWxlcnMKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDC
oMKgIGNhbmNlbF9zeW5jKGFsbCB0aW1lcnMgYW5kIHF1ZXVlZCB3b3Jrcyk7Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+IMKgwqDCoCBod19maW5pCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCB1bm1h
cF9tbWlvCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IH0KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4g
QW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQWx0
ZXJuYXRpdmVseSBncmFiYmluZyB0aGUgcmVzZXQgd3JpdGUgc2lkZSAKPj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+PiBhbmQgc3RvcHBpbmcgYW5kIHRoZW4gcmVzdGFydGluZyB0aGUgc2NoZWR1bGVy
IAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGNvdWxkIHdvcmsgYXMgd2VsbC4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4gSSBkaWRuJ3QgZ2V0IHRoZSBhYm92ZSBhbmQgSSBkb24ndCBzZWUgd2h5
IEkgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBuZWVkIHRvIHJldXNlIHRoZSBHUFUgcmVzZXQg
cndfbG9jay4gSSByZWx5IG9uIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gdGhlIFNSQ1UgdW5w
bHVnIGZsYWcgZm9yIHVucGx1Zy4gQWxzbywgbm90IAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4g
Y2xlYXIgdG8gbWUgd2h5IGFyZSB3ZSBmb2N1c2luZyBvbiB0aGUgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+PiBzY2hlZHVsZXIgdGhyZWFkcywgYW55IGNvZGUgcGF0Y2ggdG8gZ2VuZXJhdGUgCj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBIVyBmZW5jZXMgc2hvdWxkIGJlIGNvdmVyZWQsIHNvIGFu
eSBjb2RlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gbGVhZGluZyB0byBhbWRncHVfZmVuY2Vf
ZW1pdCBuZWVkcyB0byBiZSB0YWtlbiAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGludG8gYWNj
b3VudCBzdWNoIGFzLCBkaXJlY3QgSUIgc3VibWlzc2lvbnMsIFZNIAo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4gZmx1c2hlcyBlLnQuYwo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBZb3UgbmVlZCB0byB3b3JrIHRvZ2V0aGVyIHdpdGggdGhlIHJlc2V0IGxv
Y2sgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGFueXdheSwgY2F1c2UgYSBob3RwbHVnIGNvdWxk
IHJ1biBhdCB0aGUgc2FtZSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gdGltZSBhcyBhIHJlc2V0
Lgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBGb3IgZ29pbmcgbXkgd2F5IGluZGVlZCBub3cgSSBzZWUgbm93IHRoYXQg
SSBoYXZlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHRvIHRha2UgcmVzZXQgd3JpdGUgc2lkZSBs
b2NrIGR1cmluZyBIVyBmZW5jZXMgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gc2lnbmFsbGluZyBp
biBvcmRlciB0byBwcm90ZWN0IGFnYWluc3QgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gc2NoZWR1
bGVyL0hXIGZlbmNlcyBkZXRhY2htZW50IGFuZCByZWF0dGFjaG1lbnQgCj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4gZHVyaW5nIHNjaGVkdWxlcnMgc3RvcC9yZXN0YXJ0LiBCdXQgaWYgd2UgZ28gd2l0
aCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB5b3VyIGFwcHJvYWNoIHRoZW4gY2FsbGluZyBkcm1f
ZGV2X3VucGx1ZyBhbmQgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gc2NvcGluZyBhbWRncHVfam9i
X3RpbWVvdXQgd2l0aCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBkcm1fZGV2X2VudGVyL2V4aXQg
c2hvdWxkIGJlIGVub3VnaCB0byBwcmV2ZW50IAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGFueSBj
b25jdXJyZW50IEdQVSByZXNldHMgZHVyaW5nIHVucGx1Zy4gSW4gZmFjdCAKPj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+PiBJIGFscmVhZHkgZG8gaXQgYW55d2F5IC0gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzOiUyRiUyRmNnaXQuZnJlZWRlc2t0b3Aub3JnJTJGfmFncm9kem92JTJGbGludXglMkZjb21t
aXQlMkYlM0ZoJTNEZHJtLW1pc2MtbmV4dCUyNmlkJTNEZWYwZWE0ZGQyOWVmNDRkMjY0OWM1ZWRh
MTZjOGY0ODY5YWNjMzZiMSZhbXA7ZGF0YT0wNCU3QzAxJTdDYW5kcmV5Lmdyb2R6b3Zza3klNDBh
bWQuY29tJTdDYTY0YjFmNWUwZGYwNDAzYTY1NjQwOGQ4ZmZkYzdiZGIlN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTQwNjY5NzMyNjkyNDg0JTdDVW5rbm93
biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJU
aUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPXBMY3BsbmxESUVTVjk5
OHRMTzdpeWR4RW81bGg3MUJqUUNiQU94S2lmMlElM0QmYW1wO3Jlc2VydmVkPTAgCj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
PiBZZXMsIGdvb2QgcG9pbnQgYXMgd2VsbC4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4u
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Cj4+Pgo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
