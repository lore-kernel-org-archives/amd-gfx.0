Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFAAC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EC661A1A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EC661A1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 688E56EB67;
	Thu, 25 Mar 2021 16:03:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4266EB67
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA8YE6oko4aTIb2pPvm5AdTK6NzeBVdEac1iagHtI/RvBn8i8YJ0DoUOxHKytkn3oUQcXLq53Krfn4+tbK0BcKod1wWYNM3+zC4Pw38rfDv5516nAvtIKZYruV+CcEOMrRyjtEoVQcc/+eQ2wLucFOut0z0rv1DVwRMH4QVUcWaLWrqLSoGu5/u856/7JOND8SU1X2o1GrrJ7dmSryudSHF+FbOJ66rTdlmo4VAqbArsEb7fP/EAA/YPikyZipRj1H94xX8f+lwRykofYnuodLTvJSq171hfLsGq7pKSwlQPpiwnG4zMtG8wZFgYqpGlEb+seULxg/7Sc/AZj7n+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEB0wdTlFNCcNzBpX+/bhS+W0oVsw3ItGXCRH0nmsc0=;
 b=FS6SpXlxxgFtz9BRUmZHQBeljSvJV7PZir4GkVJBg43eEjNa+vSFQdRS+2GUh6fmw1C6ZiLuUTP7Q4vMRwM2JUHIqsP5qcZ/s3hBj8K9it33JHbtmbP7/BUDL9QHbQmfBlJMB+hNh6FycEYJOKvlNUXfEXCD7UhYIltoXTdKS+WGgiFVDx4oAWr04qfl9coQ7hT3zk7pkiwZ5BnTaaEWgbBmw3sJmvgAZO7hmIKMVshIUxMoclvKycWu9QL+TMpoR28SBcmJI18q8yEVvRlK92XMYedhftlKWNYxcHWqbgwn8gxOOLIln4oXQxlXz+OA3+nIcqNPQOf9WQ7qzPF5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEB0wdTlFNCcNzBpX+/bhS+W0oVsw3ItGXCRH0nmsc0=;
 b=ngP/yTbrDGldW3S3BmzGz3cZyn7oEr4WcUf1O9pUvwziRGYj53HkL9p4jybS/iqhZR4c33Qxhy0tUH6toOaQi9kAKxkLbIJ780YieEM3twIIATKt/GEDPkYTjsOv9C9DAqv6aU6NsL9hsONgXXmYO5nvk1wYNCPjAekXcskoXto=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 16:03:31 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.036; Thu, 25 Mar 2021
 16:03:31 +0000
To: "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Need to support mixed memory mappings with HMM
Message-ID: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
Date: Thu, 25 Mar 2021 12:03:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
Content-Language: en-US
X-Originating-IP: [142.116.84.209]
X-ClientProxiedBy: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.84.209) by
 YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 16:03:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4beaf918-b36f-4a92-cb5c-08d8efa7894f
X-MS-TrafficTypeDiagnostic: BL0PR12MB4930:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4930142E008D21E970327D5F92629@BL0PR12MB4930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0n0Dx3XL+iZNXYcpshfwsbAgtpvUm2ctxDpcBoOUS/mboomP8bJojhHMDZxKdWSNES7aLegtEBQd7vft2SrXNRgkm0WgAvxng5s0M1U5ngUtt/AC48t9cYaHBcGUY7zywPN84jaBAZ4DLtMpJ4qZAFLfamNcre7Y4hF/6cRspd3KbnuhPBaSE6gu3296mR411GG/JDbnEXHh2cNgf8teEqUuZc4cFgHU0wdnY6Tz4bFNvGgvvV2y2LFOEt7DTnARec2BIPIXIBW8+mONIyWHkIQJ/IEyB+Jni+PB2DQn4RPDajjXB/EO5CAtOfdL0VDWetkF2lrBf8yT/vCrVyID+jlRSZG8Ne9u3Z7vrqpSYy1B0bNnkgxo7hu0TERkPNgOuPzHrchY4/WU8MmWkCH/FJMAvTBioliP/EXJoOP5dyqi279qMKvqBB35y4euuN6rGMZVPKB4WVTkWon0Ta1RdU50WWNn/odH0AVd2aUjhjNbLJVA0XAc5Mt5GKYH7eNZLy4pPLzVASA6kwC8UG36Zqyg76Q0uusym70I2TyGSz2nzQ7C7KnBUm7BuBrl7chW5KCGnLn6vfqGxjSO6IRfpiflUqjmMl31A3lEnEOJv81xq/SNYlPeLw4oKDBkOl+A3o6rT/9M5P3Ola+UbletHXiAXx9rYYjHdylcG4zShxWuRvdoCWfct8lVV+VWdX4OC0xBpLal6RVGvR3uittoLtw7rNDITXhqHf+wvqdlSj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(44832011)(66556008)(31696002)(956004)(36756003)(2906002)(2616005)(66946007)(83380400001)(8676002)(498600001)(8936002)(16526019)(86362001)(16576012)(26005)(31686004)(5660300002)(38100700001)(110136005)(6486002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dWFlNW04YkFSMVpUSGFGSnYyOFcrU1VoZldnK1BvUlZ2ZFc5YkI4K2pxNnVy?=
 =?utf-8?B?bVVsSjBrdkxkTG9KWi93NmV1d2RDMGwwWmR3THJTRytIb1FVc2lzNDJoK0Zw?=
 =?utf-8?B?ZGZOdkVRMHptMEt1bVBOeTg4ZGxKeldUS3gyUEdVM292SkorTVUxdEcwYVg2?=
 =?utf-8?B?N3I2SDVpVEtvcTlYcWpEUW1paERBbkxnMkRkMVJvT1hFYk5QbjlUVnptOHQz?=
 =?utf-8?B?Si9YRHd4TTFlMlk5N1pOTktQK1lRc2VlU3NBSDN0SW90S1luUzlHZjI5YmYr?=
 =?utf-8?B?aXVpQjNieDlZVFdSbTh4NnZOOGxYUnhEQ0ZUYXMySktVQTVySE1ucmltclJI?=
 =?utf-8?B?N0J1VXQvWU81ZzJpN2xWRzlSWC9WS0VjMStWNFdaVzl0a3V4ckxpVmx3ampW?=
 =?utf-8?B?L0RJZHVvNndDWG00UGpvU3NrVWl6T3hmZG96RGVHbUY5cHI4Ty8vWXdVSmVx?=
 =?utf-8?B?WTlQdnpSVXVnZzB3UDM3ZWZ3cGkraTJ0aXFxZVZOZ3RHY0FJQmFOdlJ6TURi?=
 =?utf-8?B?RGtuQ29JSUhPN3JFN25LaGlqdEVmNkFCcmxJVVJ4Y1hnQUhWS1NSMXpYSXhN?=
 =?utf-8?B?a1RWQitrTG4ycHFjaW1GNVlDc3hpTUV3YkpHd1F4WXNxbkN1b2oySnFpQjRj?=
 =?utf-8?B?eE9hd0kxbGp6MTJXS2dHVVdQRWhmTFlGTUl6d0krcVQ1VHpRN0N3RGZLd090?=
 =?utf-8?B?R05MYlIzcEhpUnl4TkZSaVY4M2t3UjRNQk9CMnJQVzhOREdBQW41b0xGeHZr?=
 =?utf-8?B?SVVuL0RrZi9sTnlxUzI4ZExRQzlzU2k0aWViWXl0SHhDZHhDaHV0cHdhVlFG?=
 =?utf-8?B?bFlqVk5BT3JPSG9pVWZtRSt5NXZuNE1ReVB6V044MktCUVJNNEtaWXllMDNG?=
 =?utf-8?B?Rm5obWtvMU56N2VSZTcrMmtzMnJ6SFBzUGlrSjlQb1p6WnhoRzNDM3JCWWk1?=
 =?utf-8?B?YitZNVF0WWw5UG9HZHlXNVZseWs0UTd0WVh2YnM0MVNXNFVlNmVrMDM5dFdz?=
 =?utf-8?B?SU54WGNORkNMeE9oT0lEMjZkUE1LaWR4L2hvWnNPdVVsNlYzQ3FoVExWVG9q?=
 =?utf-8?B?eUpVUmZweStqSDl0YklpamI1dkJWeDBQTnQvTnV5QmN4UmN4ZGx6OTJzaGww?=
 =?utf-8?B?NzFDbFI0VXlNa0dnV29lNlFPRmo2YWV1MC9UOVlodStZVE12V2pPdGc2THhm?=
 =?utf-8?B?T0Vya215ZUU2QUFNT2ZGSmh2VmR0dmRlck9PMGtzbXlSY3I3aVgxKy9UV0VH?=
 =?utf-8?B?SHplT3F6QlRzYUZ3WlJqUDlaR09EYUxUTjJuT0t2NzBjcDhNTWhPM3dsYitY?=
 =?utf-8?B?Yi9HTHQ4aTNIQW91THpjaStTbStJMGNhRHRJWHJ1bE5NVnNlY0xPTlVKTkhq?=
 =?utf-8?B?RUlTR2ZkUmRSdDMweUFYYzBlWUZoanZtSXRBVTQ0SGlZaXQvSmNVWjV3THc1?=
 =?utf-8?B?NFFTaTVSUklYenJXRTA0WkV3ay8yQTFVbDd1SkJNWkFVQXRzR1pRaWdOekJk?=
 =?utf-8?B?MlZhRStkVDQ2eHpHZ1Z0ZXlqalhDWG5kZnh4SEs0Y1VJL2JOSDF5LzMzUHo5?=
 =?utf-8?B?dXhLWEdENDNKVFJUSVR2M1ZSWWVaSGdpYXVSUUkreHVwRFh3K1V2aVRwQnAx?=
 =?utf-8?B?QTQ1WVJmMG03N1pyMVQrU1JEMmZXNDFyNGcxMjJ0eStYYzJaVGkwNUl1YWk3?=
 =?utf-8?B?d1NIWkJCNXFZR2NtT0xsNUVNcmVhYmttc3pUWVA2cEdvbnloNGhJOTBRdExR?=
 =?utf-8?Q?tXlv0jrywnQL614Zd2PPybtknH7Q9/eXmN0/eQ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4beaf918-b36f-4a92-cb5c-08d8efa7894f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:03:31.6673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWERfe2UGZiIgHn4LJSTpdNrg6bsTQg0GkIrNJ1Y+eZDn5195twNnYX2yuegT4ZnU/PfnGAArFufQ2iYb2RgtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
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

SGksCgpUaGlzIGlzIGEgbG9uZyBvbmUgd2l0aCBhIHByb3Bvc2FsIGZvciBhIHByZXR0eSBzaWdu
aWZpY2FudCByZWRlc2lnbiBvZgpob3cgd2UgaGFuZGxlIG1pZ3JhdGlvbnMgYW5kIFZSQU0gbWFu
YWdlbWVudCB3aXRoIEhNTS4gVGhpcyBpcyBiYXNlZCBvbgpteSBvd24gZGVidWdnaW5nIGFuZCBy
ZWFkaW5nIG9mIHRoZSBtaWdyYXRlX3ZtYSBoZWxwZXJzLCBhcyB3ZWxsIGFzCkFsZXgncyBwcm9i
bGVtcyB3aXRoIG1pZ3JhdGlvbnMgb24gQStBLiBJIGhvcGUgd2UgY2FuIGRpc2N1c3MgdGhpcyBu
ZXh0Ck1vbmRheSBhZnRlciB5b3UndmUgaGFkIHNvbWUgdGltZSBkbyBkaWdlc3QgaXQuCgpJIGRp
ZCBzb21lIGRlYnVnZ2luZyB5ZXN0ZXJkYXkgYW5kIGZvdW5kIHRoYXQgbWlncmF0aW9ucyB0byBW
UkFNIGNhbgpmYWlsIGZvciBzb21lIHBhZ2VzLiBUaGUgY3VycmVudCBtaWdyYXRpb24gaGVscGVy
cyBoYXZlIG1hbnkgY29ybmVyCmNhc2VzIHdoZXJlIGEgcGFnZSBjYW5ub3QgYmUgbWlncmF0ZWQu
IFNvbWUgb2YgdGhlbSBtYXkgYmUgZml4YWJsZQooYWRkaW5nIHN1cHBvcnQgZm9yIFRIUCksIG90
aGVycyBhcmUgbm90IChsb2NrZWQgcGFnZXMgYXJlIHNraXBwZWQgdG8KYXZvaWQgZGVhZGxvY2tz
KS4gVGhlcmVmb3JlIEkgdGhpbmsgb3VyIGN1cnJlbnQgY29kZSBpcyB0b28gaW5mbGV4aWJsZQp3
aGVuIGl0IGFzc3VtZXMgdGhhdCBhIHJhbmdlIGlzIGVudGlyZWx5IGluIG9uZSBwbGFjZS4KCkFs
ZXggYWxzbyByYW4gaW50byBzb21lIGZ1bm55IGlzc3VlcyB3aXRoIENPVyBvbiBBK0Egd2hlcmUg
c29tZSBwYWdlcwpnZXQgZmF1bHRlZCBiYWNrIHRvIHN5c3RlbSBtZW1vcnkuIEkgdGhpbmsgYSBs
b3Qgb2YgdGhlIHByb2JsZW1zIGhlcmUKd2lsbCBnZXQgZWFzaWVyIG9uY2Ugd2Ugc3VwcG9ydCBt
aXhlZCBtYXBwaW5ncy4KCk1peGVkIEdQVSBtYXBwaW5ncwo9PT09PT09PT09PQoKVGhlIGlkZWEg
aXMsIHRvIHJlbW92ZSBhbnkgYXNzdW1wdGlvbnMgdGhhdCBhbiBlbnRpcmUgc3ZtX3JhbmdlIGlz
IGluCm9uZSBwbGFjZS4gSW5zdGVhZCBobW1fcmFuZ2VfZmF1bHQgZ2l2ZXMgdXMgYSBsaXN0IG9m
IHBhZ2VzLCBzb21lIG9mCndoaWNoIGFyZSBzeXN0ZW0gbWVtb3J5IGFuZCBvdGhlcnMgYXJlIGRl
dmljZV9wcml2YXRlIG9yIGRldmljZV9nZW5lcmljLgoKV2Ugd2lsbCBuZWVkIGFuIGFtZGdwdV92
bSBpbnRlcmZhY2UgdGhhdCBsZXRzIHVzIG1hcCBtaXhlZCBwYWdlIGFycmF5cwp3aGVyZSBkaWZm
ZXJlbnQgcGFnZXMgdXNlIGRpZmZlcmVudCBQVEUgZmxhZ3MuIFdlIGNhbiBoYXZlIGF0IGxlYXN0
IDMKZGlmZmVyZW50IHR5cGVzIG9mIHBhZ2VzIGluIG9uZSBtYXBwaW5nOgoKIDEuIFN5c3RlbSBt
ZW1vcnkgKFMtYml0IHNldCkKIDIuIExvY2FsIG1lbW9yeSAoUy1iaXQgY2xlYXJlZCwgTVRZUEUg
Zm9yIGxvY2FsIG1lbW9yeSkKIDMuIFJlbW90ZSBYR01JIG1lbW9yeSAoUy1iaXQgY2xlYXJlZCwg
TVRZUEUrQyBmb3IgcmVtb3RlIG1lbW9yeSkKCk15IGlkZWEgaXMgdG8gY2hhbmdlIHRoZSBhbWRn
cHVfdm1fdXBkYXRlX21hcHBpbmcgaW50ZXJmYWNlIHRvIHVzZSBzb21lCmhpZ2gtYml0IGluIHRo
ZSBwYWdlc19hZGRyIGFycmF5IHRvIGluZGljYXRlIHRoZSBwYWdlIHR5cGUuIEZvciB0aGUKZGVm
YXVsdCBwYWdlIHR5cGUgKDApIG5vdGhpbmcgcmVhbGx5IGNoYW5nZXMgZm9yIHRoZSBjYWxsZXJz
LiBUaGUKImZsYWdzIiBwYXJhbWV0ZXIgbmVlZHMgdG8gYmVjb21lIGEgcG9pbnRlciB0byBhbiBh
cnJheSB0aGF0IGdldHMKaW5kZXhlZCBieSB0aGUgaGlnaCBiaXRzIGZyb20gdGhlIHBhZ2VzX2Fk
ZHIgYXJyYXkuIEZvciBleGlzdGluZyBjYWxsZXJzCml0J3MgYXMgZWFzeSBhcyBjaGFuZ2luZyBm
bGFncyB0byAmZmxhZ3MgKGFycmF5IG9mIHNpemUgMSkuIEZvciBITU0gd2UKd291bGQgcGFzcyBh
IHBvaW50ZXIgdG8gYSByZWFsIGFycmF5LgoKT25jZSB0aGlzIGlzIGRvbmUsIGl0IGxlYWRzIHRv
IGEgbnVtYmVyIG9mIG9wcG9ydHVuaXRpZXMgZm9yCnNpbXBsaWZpY2F0aW9uIGFuZCBiZXR0ZXIg
ZWZmaWNpZW5jeSBpbiBrZmRfc3ZtOgoKICAqIFN1cHBvcnQgbWlncmF0aW9uIHdoZW4gY3BhZ2Vz
ICE9IG5wYWdlcwogICogTWlncmF0ZSBhIHBhcnQgb2YgYW4gc3ZtX3JhbmdlIHdpdGhvdXQgc3Bs
aXR0aW5nIGl0LiBObyBtb3JlCiAgICBzcGxpdHRpbmcgb2YgcmFuZ2VzIGluIENQVSBwYWdlIGZh
dWx0cwogICogTWlncmF0ZSBhIHBhcnQgb2YgYW4gc3ZtX3JhbmdlIGluIEdQVSBwYWdlIGZhdWx0
IGhhbmRsZXIuIE5vIG1vcmUKICAgIG1pZ3JhdGluZyB0aGUgd2hvbGUgcmFuZ2UgZm9yIGEgc2lu
Z2xlIHBhZ2UgZmF1bHQKICAqIFNpbXBsaWZpZWQgVlJBTSBtYW5hZ2VtZW50IChzZWUgYmVsb3cp
CgpXaXRoIHRoYXQsIHN2bV9yYW5nZSB3aWxsIG5vIGxvbmdlciBoYXZlIGFuICJhY3R1YWxfbG9j
IiBmaWVsZC4gSWYgd2UncmUKbm90IHN1cmUgd2hlcmUgdGhlIGRhdGEgaXMsIHdlIG5lZWQgdG8g
Y2FsbCBtaWdyYXRlLiBJZiBpdCdzIGFscmVhZHkgaW4KdGhlIHJpZ2h0IHBsYWNlLCB0aGVuIGNw
YWdlcyB3aWxsIGJlIDAgYW5kIHdlIGNhbiBza2lwIGFsbCB0aGUgc3RlcHMKYWZ0ZXIgbWlncmF0
ZV92bWFfc2V0dXAuCgpTaW1wbGlmaWVkIFZSQU0gbWFuYWdlbWVudAo9PT09PT09PT09PT09PQoK
VlJBTSBCT3MgYXJlIG5vIGxvbmdlciBhc3NvY2lhdGVkIHdpdGggcHJhbmdlcy4gSW5zdGVhZCB0
aGV5IGFyZQoiZnJlZS1mbG9hdGluZyIsIGFsbG9jYXRlZCBkdXJpbmcgbWlncmF0aW9uIHRvIFZS
QU0sIHdpdGggcmVmZXJlbmNlCmNvdW50IGZvciBlYWNoIHBhZ2UgdGhhdCB1c2VzIHRoZSBCTy4g
UmVmIGlzIHJlbGVhc2VkIGluIHBhZ2UtcmVsZWFzZQpjYWxsYmFjay4gV2hlbiB0aGUgcmVmIGNv
dW50IGRyb3BzIHRvIDAsIGZyZWUgdGhlIEJPLgoKVlJBTSBCTyBzaXplIHNob3VsZCBtYXRjaCB0
aGUgbWlncmF0aW9uIGdyYW51bGFyaXR5LCAyTUIgYnkgZGVmYXVsdC4KVGhhdCB3YXkgdGhlIEJP
IGNhbiBiZSBmcmVlZCB3aGVuIG1lbW9yeSBnZXRzIG1pZ3JhdGVkIG91dC4gSWYgbWlncmF0aW9u
Cm9mIHNvbWUgcGFnZXMgZmFpbHMgdGhlIEJPIG1heSBub3QgYmUgZnVsbHkgb2NjdXBpZWQuIEFs
c28gc29tZSBwYWdlcwptYXkgYmUgcmVsZWFzZWQgaW5kaXZpZHVhbGx5IG9uIEErQSBkdWUgdG8g
Q09XIG9yIG90aGVyIGV2ZW50cy4KCkV2aWN0aW9uIG5lZWRzIHRvIG1pZ3JhdGUgYWxsIHRoZSBw
YWdlcyBzdGlsbCB1c2luZyB0aGUgQk8uIElmIHRoZSBCTwpzdHJ1Y3Qga2VlcHMgYW4gYXJyYXkg
b2YgcGFnZSBwb2ludGVycywgdGhhdCdzIGJhc2ljYWxseSB0aGUgbWlncmF0ZS5zcmMKZm9yIHRo
ZSBldmljdGlvbi4gTWlncmF0aW9uIGNhbGxzICJ0cnlfdG9fdW5tYXAiLCB3aGljaCBoYXMgdGhl
IGJlc3QKY2hhbmNlIG9mIGZyZWVpbmcgdGhlIEJPLCBldmVuIHdoZW4gc2hhcmVkIGJ5IG11bHRp
cGxlIHByb2Nlc3Nlcy4KCklmIHdlIGNhbm5vdCBndWFyYW50ZWUgZXZpY3Rpb24gb2YgcGFnZXMs
IHdlIGNhbm5vdCB1c2UgVFRNIGZvciBWUkFNCmFsbG9jYXRpb25zLiBOZWVkIHRvIHVzZSBhbWRn
cHVfdnJhbV9tZ3IuIE5lZWQgYSB3YXkgdG8gZGV0ZWN0IG1lbW9yeQpwcmVzc3VyZSBzbyB3ZSBj
YW4gc3RhcnQgZXZpY3RpbmcgbWVtb3J5LgoKUmVnYXJkcywKwqAgRmVsaXgKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
