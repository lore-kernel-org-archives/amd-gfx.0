Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E4C433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 15:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53ADE613C2
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 15:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53ADE613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E83168938F;
	Tue,  6 Apr 2021 15:58:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2206E8938F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 15:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJAHFCPob4Aq5ou7RPh67eTKzh4+UG7DE0zKf6fgThCnnL3Wk9WJMOVr9QmCzADQNVNTLKixF37BUArtPBnyGVd3mXm3oCGP1eGzzS6POFowkAIXXDpzQ7yN3KnkpHWcUecv6dwpKn2t83m90vtlVfCmPqbM9weMIE8QSOCj1rcqCCR3VYR5trBXghJ18rNz7RJuyOvfkXv2lYQzbkuQKhrx0QUbN/jxCR/EHLvY2sdEeNR0nH08HboY4fUSEKtfxqNIn92lpyuGgQcpOTPv6XSdtvaZfMm7624VSsOpEJUkHUcCq97cEhLt12A+G1c/BdzDpt09vjA/zLdh9uAfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXDY9+7/3utkIKFGrrwaFTdSZXaB0MtCmA/WKnUCGic=;
 b=cY/AeeuV/GFRqQ3zHPk7MZ/GUicJzkNKocZYEMmhxBJRT7eZCiEyHdvoSTWhm/Ve3spnrKcU8S+VdFn4B9VWY9x/4b0fMv8UTPKqFsP3Z2CDcJUQ36QIu07Qr5osAFHkT8jdZMq5rWOl9yucaAztOZDEKvxuc3l1N6EeloSro9jVByU3EVEzYrA1wUgaZqLttO1ObV+2aA0jHLhiL5nYpIGkIWFqbDh6cIn/qnRQxqO6YnyFlLk1vtd5scsGSPdJibErbpAP8srEOgb8VxsXeqsXmrQHheVek0/9Nor6rvaV+GpBq+POS684x5nL6AbaXCRRpFGUeGwYGVKu6k/3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXDY9+7/3utkIKFGrrwaFTdSZXaB0MtCmA/WKnUCGic=;
 b=rvgbBOP9kTZj7yybW1kBJVePA/FLGwJ+RnrcqvwG/4TdH0AjzuSgvVyOzczIINd7WtyhYRty/v49suQajkb91SgvmgsH3tb/pRqmSgVv+v/ngNoScaHSDv2OVDknCEMA1QnBh+DKec733iSpMo+1D8IxjsJoOE3YCwU5Whge9QA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 15:58:30 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.039; Tue, 6 Apr 2021
 15:58:30 +0000
Subject: Re: [PATCH] drm/amdgpu: Add show_fdinfo() interface
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy <nirmodas@amd.com>, Roy Sun <Roy.Sun@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210406094915.22984-1-Roy.Sun@amd.com>
 <cfab1417-2a93-dc89-f9d3-1dabdc0a0a79@amd.com>
 <62667fb1-fc41-693b-bb1e-e2343ced33d0@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b8fc1c1c-a3cb-a27b-c517-582446afa655@amd.com>
Date: Tue, 6 Apr 2021 11:58:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <62667fb1-fc41-693b-bb1e-e2343ced33d0@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.116.84.209]
X-ClientProxiedBy: YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.84.209) by
 YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Tue, 6 Apr 2021 15:58:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ea57a4f-2bac-47b6-8c86-08d8f914d2a1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4899:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4899F18861F8429E84364C9092769@BL0PR12MB4899.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ni7+zQGNc1t7eUguE12JJb06ZSiG1XYPZwrpeqxeArZxO4d2YoaQlGf4Ua0PJVB/ZGHJU6w38xrz1YeBmDCIELbRVQd9Lc7JayxlsUuovK2bpjY0gNR4QwJMzddXYYSwILf2+1lrN0BgH5eP3+a/DssbliWcaPNe+23jAAaweKyB7lttUP8a3yzr/pChM7+5jpDSK6jg4ZDXnWGUUHNPUJ3QthQyb4yZ9PZL+pwoQNqTfJQNRq4eIDd8zqBpCf5KIil6jhdadx1hbHzK4naXrqtyt9iCsGTRjCiLygPYELzXXF7IE/05qcb1BMG1NxkNN5z82w0mNznCs01y5AnjXICVUlg2LaTYNedbGpfH5qZU0s6r2jP+cf3d9wiGR1K7iG9sVjlaFO0cnv6aASoia0x5zGk1/T2BBAwXqO/isvxiktBryZq8SpQY2SodlGO+sk8s+0saqoOQ7VNkzQLQ1jfGo6rjfKbh5QTMIyYh+XgHwN651ep3VPJeb0DADc7kobEjEnlOIT5WGIqW9BveN1ZFEeaAoYVVd0htexNK8qNN0lPNeR8abG2yw5saIP0NXf35/ARrJAlB3igZh0BUJiIrjoJiU83rye5LciUZrR1bftX51TdOmWAbAX1Ezzw7qxAA4RT9+f+haw5qUs4ZhkudEdzOys24+QbUpXzYRmy2qkL1ukDxjogLmnaMLK8uOS5PFE1lDH5ROyYDrIDaVVEcx4R4/OxOrjmmBbU5KZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(5660300002)(38100700001)(478600001)(8676002)(16526019)(16576012)(66946007)(36756003)(4326008)(186003)(86362001)(31696002)(6486002)(26005)(66556008)(44832011)(316002)(66574015)(2906002)(2616005)(956004)(31686004)(66476007)(8936002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TU4vTEUxWXFsVXltOWNxVncwU2hHZWFUdjBVb09tSGlhVDdlbS81UmhlZGdG?=
 =?utf-8?B?a1k5S1ZPV3pIZEQ2NGVTd3ZYN1Y2S1NpL1hucFR6bjF0S2hOWmdDMTIvV2dN?=
 =?utf-8?B?ZTlYTXBHamlyRGRKZFBiSmdLdkJIbllVVHoveXFvUmhnbCtnM21vVHdoRm5H?=
 =?utf-8?B?YW1ZYzB3alRPQzlkSHR0MGNhZmRqV0I4SGJHZEIrczUyZDlNMVQwUVR0aTU1?=
 =?utf-8?B?YStvY1dWRlM0ZGI0U0VJL1k3NFNVb2ZqNjdXWHBvT0VsaFpaYkRNUjV3K2xK?=
 =?utf-8?B?aWM0RzZ1WmpHaFUwWVdrM1BFa0hzekpQdFJDazg0VmN3UDRUeUtBeXdKMGZl?=
 =?utf-8?B?Y3Mzb0d2NHZCRk5XcG8vZEY2YVgyZlB3V1V5RGF3bVd0MEluSE93dGovTHhq?=
 =?utf-8?B?MzQ1U3FpMi90ZXVnTTlOM2FaemYzclVOeG9BM2REMGY5N2tubVVvaFhvOTVR?=
 =?utf-8?B?WDdFWGM0KzZMUXdEK0JUYnl1ekVlaWUvZkNaNGVTamlnYmVUd2QzTTRyT3Nu?=
 =?utf-8?B?RVBzbmR0WWQwQzJmaWZYMEV2OUpPMlJYQXBEUytpTFJrUE5yTHJPSzBNdWNi?=
 =?utf-8?B?UWl6Z2t3eTJHRFJMeHJobnJIK1FBZmUvSnNQb1VDWWNOdDF4Q25oa0R1MVhX?=
 =?utf-8?B?RWozZHk0dTZMM2VadUJXRnpyZ1lYb3did0YwbDdnaXY1TlVYd2hPWHFBcnVC?=
 =?utf-8?B?QXBleGRiT2RBRkY1S1lUU1JTSkFpY2UvMVlkU2JBOTFwZnFic2VydlFVMVJ0?=
 =?utf-8?B?Q1V4dVB5YkV5enZuZVdwTjRpaG1GTnJwSUkxaFo1SzFuSGZvQ29MeG5XZGV2?=
 =?utf-8?B?eHRpQkFaeGV6bFRSMk1OVDJDemtYS2FJMXdWZ3h6aE9jYkZwdTNQNjZKbWRV?=
 =?utf-8?B?N1YxcVIzT091WnNNWkQ4akVkZy9nK21xMHM3UzNzdURHdG9UdlZMaU1VTzA4?=
 =?utf-8?B?QnNaVWFreVlhWVpSVFJXdk1HMi9qT3UwZVNIbWZmNkl1Njc4VzZHZS9nWVVV?=
 =?utf-8?B?cDVoYVZLSXE3SUxFUjlwV1I5MjU2cCsyRGtYZFRFQ1NwV0FQdXJ5eXBPRzE5?=
 =?utf-8?B?QVJzV0pZMlovT0ZYN1FCeEM5cVNCV0dqcVZMbWV2d2FlbTYvSkJsZGtkbSsv?=
 =?utf-8?B?V2p2bkJXWGMwbXJTRm1DeUJaL3p0ZEJCNVBwNEh1by95M29IcjRZS2laWTU0?=
 =?utf-8?B?NGd6cTBqYVYxU1ZkY3BGaE05NWJaVlBjcUUrQnBFbC9tVHNUa3F1dVdYbG5N?=
 =?utf-8?B?ZnJxQjdKRTNPWEc2L09paWxQN0pqZHBtMWlkZU81Z2NoRmFVMDB6ZkdnWDBv?=
 =?utf-8?B?N0kyLytEUGNzUndtbllQZmVJN2hMSVgzbEFVMmRSL285OGxDVWpUTFhYMlpu?=
 =?utf-8?B?cFRWSXVFcnp1dGExV093OXdNQys5K0IrOVV1ZTh4bEIrbmhFUEpjRFM2VlBY?=
 =?utf-8?B?d215RG80OFhFTDFXSDhYKzlqaHdnMUxSMlhrV3NTMlpNTVZVbzZLSks2ZGZh?=
 =?utf-8?B?YjNmUnMxeDRsUG9OYWs1RE1XeXErQkFybk0wMy9ZUjVFQmp6T2lZRml6R1FQ?=
 =?utf-8?B?bUFFRm5TdVVwT1VTVlJ1WUdNS0NDWHd6aWhnZnpNeWRwZDFRcGFBb2dHOUt3?=
 =?utf-8?B?N091MWxFc1R1SUY0QytBVm9ScFA2Z0JQQUVpTEE1aWZPYnhROG9NWDhRNVhR?=
 =?utf-8?B?YWE0QjJvUjJVUE9ES0E4NXlCK1lZejJoWmNpMDc1bzcvK2FVdW0yQWVQOHVQ?=
 =?utf-8?Q?E7/ZDbMXY0OHMRMVwT7NcckzSFQItBOx6KpSyEC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea57a4f-2bac-47b6-8c86-08d8f914d2a1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:58:30.3052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWyM1hJopbTxFZf1v0AIYhHVdCdZmTNCR6ZZmc9Be5b3tkGd4DOnCkBV4cLTJoOJn1n35De+8vnnikcdJ7WQ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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
Cc: Alexander.Deucher@amd.com, David M Nieto <David.Nieto@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDQtMDYgdW0gNzoxMyBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
Cj4+PiBAQCAtMTA0MiwxMyArMTA0MiwxNSBAQCBpbnQKPj4+IGFtZGdwdV9hbWRrZmRfZ3B1dm1f
Y3JlYXRlX3Byb2Nlc3Nfdm0oc3RydWN0IGtnZF9kZXYgKmtnZCwgdTMyIHBhc2lkLAo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZG1hX2Zl
bmNlICoqZWYpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gZ2V0X2FtZGdwdV9kZXZpY2Uoa2dkKTsKPj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9m
cHJpdiAqZnByaXY7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfdm0gKm5ld192bTsKPj4+
IMKgwqDCoMKgwqAgaW50IHJldDsKPj4+IMKgIC3CoMKgwqAgbmV3X3ZtID0ga3phbGxvYyhzaXpl
b2YoKm5ld192bSksIEdGUF9LRVJORUwpOwo+Pj4gLcKgwqDCoCBpZiAoIW5ld192bSkKPj4+ICvC
oMKgwqAgZnByaXYgPSBremFsbG9jKHNpemVvZigqZnByaXYpLCBHRlBfS0VSTkVMKTsKPj4+ICvC
oMKgwqAgaWYgKCFmcHJpdikKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsK
Pj4+IMKgICvCoMKgwqAgbmV3X3ZtID0gJmZwcml2LT52bTsKPj4+IMKgwqDCoMKgwqAgLyogSW5p
dGlhbGl6ZSBBTURHUFUgcGFydCBvZiB0aGUgVk0gKi8KPj4+IMKgwqDCoMKgwqAgcmV0ID0gYW1k
Z3B1X3ZtX2luaXQoYWRldiwgbmV3X3ZtLCBBTURHUFVfVk1fQ09OVEVYVF9DT01QVVRFLAo+Pj4g
cGFzaWQpOwo+Pj4gwqDCoMKgwqDCoCBpZiAocmV0KSB7Cj4+PiBAQCAtMTA2MywxMiArMTA2NSwx
NCBAQCBpbnQKPj4+IGFtZGdwdV9hbWRrZmRfZ3B1dm1fY3JlYXRlX3Byb2Nlc3Nfdm0oc3RydWN0
IGtnZF9kZXYgKmtnZCwgdTMyIHBhc2lkLAo+Pj4gwqAgwqDCoMKgwqDCoCAqdm0gPSAodm9pZCAq
KSBuZXdfdm07Cj4+PiDCoCArwqDCoMKgIGFtZGdwdV9mZGluZm9faW5pdChhZGV2LCBmcHJpdiwg
cGFzaWQpOwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+IMKgIMKgIGluaXRfa2Zk
X3ZtX2ZhaWw6Cj4+PiDCoMKgwqDCoMKgIGFtZGdwdV92bV9maW5pKGFkZXYsIG5ld192bSk7Cj4+
PiDCoCBhbWRncHVfdm1faW5pdF9mYWlsOgo+Pj4gLcKgwqDCoCBrZnJlZShuZXdfdm0pOwo+Pj4g
K8KgwqDCoCBrZnJlZShmcHJpdik7Cj4+PiDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+PiDCoCB9
Cj4+PiDCoCBAQCAtMTE0Miw2ICsxMTQ2LDggQEAgdm9pZAo+Pj4gYW1kZ3B1X2FtZGtmZF9ncHV2
bV9kZXN0cm95X3Byb2Nlc3Nfdm0oc3RydWN0IGtnZF9kZXYgKmtnZCwgdm9pZCAqdm0pCj4+PiDC
oCB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZ2V0X2FtZGdw
dV9kZXZpY2Uoa2dkKTsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV92bSAqYXZtID0gKHN0
cnVjdCBhbWRncHVfdm0gKil2bTsKPj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9mcHJpdiAqZnBy
aXYgPQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNvbnRhaW5lcl9vZihhdm0sIHN0cnVjdCBhbWRncHVf
ZnByaXYsIHZtKTsKPj4+IMKgIMKgwqDCoMKgwqAgaWYgKFdBUk5fT04oIWtnZCB8fCAhdm0pKQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+IEBAIC0xMTQ5LDggKzExNTUsOSBAQCB2
b2lkCj4+PiBhbWRncHVfYW1ka2ZkX2dwdXZtX2Rlc3Ryb3lfcHJvY2Vzc192bShzdHJ1Y3Qga2dk
X2RldiAqa2dkLCB2b2lkICp2bSkKPj4+IMKgwqDCoMKgwqAgcHJfZGVidWcoIkRlc3Ryb3lpbmcg
cHJvY2VzcyB2bSAlcFxuIiwgdm0pOwo+Pj4gwqAgwqDCoMKgwqDCoCAvKiBSZWxlYXNlIHRoZSBW
TSBjb250ZXh0ICovCj4+PiArwqDCoMKgIGFtZGdwdV9mZGluZm9fZmluaShhZGV2LCBmcHJpdik7
Cj4+PiDCoMKgwqDCoMKgIGFtZGdwdV92bV9maW5pKGFkZXYsIGF2bSk7Cj4+PiAtwqDCoMKgIGtm
cmVlKHZtKTsKPj4+ICvCoMKgwqAga2ZyZWUoZnByaXYpOwo+Cj4gRmVsaXggbmVlZHMgdG8gdGFr
ZSBhIGxvb2sgaGVyZSwgYnV0IHRoYXQgaXMgbW9zdCBsaWtlbHkgYSBuby1nby4gT24KPiB0aGUg
b3RoZXIgaGFuZCBpZiB5b3UgZHJvcCB0aGUgYW1kZ3B1X3Byb2Mgc3RydWN0dXJlIHRoYXQgc2hv
dWxkCj4gYmVjb21lIHVubmVjZXNzYXJ5LgoKVGhpcyBpcyBsZWdhY3kgY29kZSB0byBzdXBwb3J0
IHJlYWxseSBvbGQgdmVyc2lvbnMgb2YgUk9DbSB1c2VyIG1vZGUKdGhhdCBkaWRuJ3QgY2FsbCBr
ZmRfaW9jdGxfYWNxdWlyZV92bSB0byBncmFiIHRoZSBWTSBmcm9tIGEgRFJNIGRldmljZQpmaWxl
IGRlc2NyaXB0b3IuIFRoaXMgcHJlZGF0ZXMgdXBzdHJlYW1pbmcgb2YgZEdQVSBzdXBwb3J0IGlu
IEtGRC4gV2UKY2FuIHByb2JhYmx5IGdldCByaWQgb2YgYW1kZ3B1X2FtZGtmZF9ncHV2bV8oY3Jl
YXRlL2Rlc3Ryb3kpX3Byb2Nlc3Nfdm0KYW5kIHRoZSBhc3NvY2lhdGVkIGNvZGUgcGF0aHMgaW4g
S0ZEIG5vdy4KCk9uIGFueSBST0NtIGxlc3MgdGhhbiAzIHllYXJzIG9sZCB3ZSBzaG91bGQgYmUg
Z29pbmcgdGhyb3VnaAphbWRncHVfYW1ka2ZkX2dwdXZtXyhhY3F1aXJlL3JlbGVhc2UpX3Byb2Nl
c3Nfdm0uCgpSZWdhcmRzLArCoCBGZWxpeAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
