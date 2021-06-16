Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE0AC49361
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 22:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357FB613FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 22:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357FB613FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FB56E844;
	Wed, 16 Jun 2021 22:55:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8716E844
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 22:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjLcZM/++MRJzizdDHgYmwWiElX3lf/IZXMFml9/IwY1x0plPu37ib5t81clQUIok2nh44ij521P+79bLr2KrsRTNV/iYy3ZQl7zV5TjxusB0V7mYEo4HQKeTVHl4kV5l/e8iDbp9th8P7i6pD8u1n4yP4/r9bIJzBDmR4M67fclukDIr4NI+iekum1z3ORlHvnR7eiMC7Ou9ZMvK38KU1c33zhN6KYvL/DPW/yO2i6HXd5b/+ICuEyJ7xBgTKGfT8hEP3Ti4jRTDQ1MaNJktJ9xMtQ5LtoT+3shpf0WxP+3/1p7dpz2IgHY4JQGzVRVdUVd9jwTLXUe11/J9o4PNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBkC3j5FPgtw+9yjQVdtSwYGuQSSn8FNAiTyy3SdaC4=;
 b=XpRGqlrCs0FpI95QkxHGYjgCrxJL2it1E1jWbDcT9atHmf258m4e2AanS3YXl/YCS89lDQCnzg5c3tY+vfN0vX9SLNdMNM2e2bKztTdkmIrQtE4VSvv01JUslbRxtEat5987LREZr8i5eLTle/FXx7EDDzpWeoLOX57qdu2YuFEW8ICcRB8zEyjMzO8oRauf0Cec/XYr7BSZM92/DevM9WPIEh1oEnRwGzHroM9JZwsqclTyQGOauGEjVPVY1F5wJEvbxMAE1B6HsJEtAL/P6gIBFqMVq8DXVcKTNNvLxEewdDM4UY1EVQGje8PQlQFBmJSpdJ8iOVXlz7rqSMnFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBkC3j5FPgtw+9yjQVdtSwYGuQSSn8FNAiTyy3SdaC4=;
 b=llA/zhSamkRXQYsNT/UxOYNjj2+aVVyEMhGB/PibcGS3pdO50Af5TLcjT99DLDotenNoA+Xr51wuIP9uEizTMcgK8o9HKeIILew/waNfzvVa/ItdU554pWqe0dxG/jS2BzWcK1pnV21cjAHbzS7IQpexIer7PhL7VGN3AQfGRIA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Wed, 16 Jun
 2021 22:55:40 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 22:55:40 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix some double free when destroy queue
 fails
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210616083511.2489-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <f18eb216-073f-0a88-a5d9-7f5d01357049@amd.com>
Date: Wed, 16 Jun 2021 18:55:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210616083511.2489-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::30) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Wed, 16 Jun 2021 22:55:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60db05ba-c301-4de4-639f-08d93119dcde
X-MS-TrafficTypeDiagnostic: BN9PR12MB5034:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB50340929F14B7873BA7909A5920F9@BN9PR12MB5034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7MfbZfNtVDzlteg6BoBsR/Ku9LIQLYTbhnH7FeJb/9w/nwp40TeXGJ/Ik/Z/8fbJGZWxOYTCLVbf+CL9qKaheVezlM5vHhiy/IlL5A6Qg71xgMCzzyxZUZMN3EbvTQekGRTyEqpEIUAUu8IC6jKtjEFTKjEJpUIWv/YQz2izAKxRmng6dvZL++uJ/hb8nOrH9alKXPMUvmNeMqzz8X1J1tLcjJ6C9lZMWL77qsA3XhzbrKBgTGUKiy/BBSJ573NXRe5X4nvl6bsmyZ2eQHt0QXpFMYs4ZltparLtOGrqiWDTf+U1fejeFpgwGb8W+UHfT6562158CwoR57rL3AY1S4pbjKxSaDC9mw/P9z1QxMFZbi/MNUG61L0aW7GUvPRyEGqSRs+4qa529Aa30G3QKdB8WqWmRMZLODVfFjUY3i2M66C9bqzDUAweiq5BoXNrVyQWa5eSYg2Nkh+gem6J1YeFfFPuo1/TnWaBiZ90SdrVfte0aFhYq16YOaqZLmsKktInXRRzDdweyt76A62A2MmstxSshEBUAJIJCEo8ckJtJ8DrWFsAJTa+sb/8bN0mh8Jabu6wSC7Q5T78e3hbPujN0aCaPB8DR7BLMLBrEcVrNjgz3y+iug6FkObbAhbj9I2KxKWl51gGg1cD7fEDkoKSInNDZd768qVQvMEGLip5KDfkni77Gx5KNNBYtkB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(6486002)(956004)(38100700002)(44832011)(316002)(16576012)(8936002)(86362001)(16526019)(2616005)(8676002)(478600001)(186003)(36916002)(31686004)(66946007)(66476007)(66556008)(26005)(2906002)(31696002)(4326008)(53546011)(5660300002)(83380400001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmllb2k5RVIyVVc1NU1IaXpsUHpXZ3lpU2dUQUU3amdYVmd4cVBwRTZEQzc4?=
 =?utf-8?B?U1k2Qy9QZCt2ZTM3TjBQWFBGNmlndi8xTFhDcTVvWGVSMExYalRyd3YwdVBZ?=
 =?utf-8?B?RWlxTEh0bkFlcUVubDc4Q1loVHk5bnVtZTF4RUc0M3pIOXVFYmpNcTF1UmxH?=
 =?utf-8?B?aFI0alZXamNqOXhFdzc1amd0SGRxbzVZc3VsSjFlMGovNjRrZm96cUVCRGZV?=
 =?utf-8?B?aWZhdWo2cS9EMHlCbU9ya1owcXBsWS9HK2RyWTRuTFpNTWN5Y2c5VG1ENE5S?=
 =?utf-8?B?VjFqNWFaWmNpcEFxNjY5WkNOdkRHZ21MbEZ6Q1Jpb2M4bVVya0I2emFzWWF6?=
 =?utf-8?B?RHlTYTlrc0duYkZqYXorRTlMZWxLT0ZCS1EvVU9FT2xoYXdacDkzNThBbjFK?=
 =?utf-8?B?dUR0MWVLdjFWTUkvbllaOWQyVEVSYkVkTGxhc0EwMCtRb3VsTWNhVC9GT1dQ?=
 =?utf-8?B?TU1nRFNtVWFsdU5tWnRYT1Zkc29JK0hUcTRlNHIwcW9mU0VqY3BZeDFyR0s4?=
 =?utf-8?B?N21HdkJWaWxOaGVCSVZXamVQbkNQRGFZemtRQlVIZHMvWTRsSW4wNDdndmM5?=
 =?utf-8?B?bGJBOWxleGlGdmNvdlAyQWFoUStZVS82bEN6Y1BrZU4vTmc1L0tqMXllNW4v?=
 =?utf-8?B?UXNqNDA2b0phRmdXTHoxeU1XRllnZ3NTcXRNR2gwb2tPWE1LclkwRzNRQVlq?=
 =?utf-8?B?SitzRzhuREk4YTd1SWo4RGkxd2YyMXhGNjBMMjEzL3V5WUErcjNOS05KKzFm?=
 =?utf-8?B?VXppZ2hRd0VCK2xxWjZmOHNoYjlLY3RNN3V6OExmWUp0RlJlVzNaYmdlYnlk?=
 =?utf-8?B?eTBZMWFGK3BhaENnRWhYUm5LZkw3ZUpVN1puSldtWVYvWG9HbUJGY2ppRWx6?=
 =?utf-8?B?ZVZXWFhTMnZ0ekxaOUJHcmpoUDdvaUh0SU9xTEh4NFUrbUFUbnZpVFZyMElj?=
 =?utf-8?B?SE5MZXhrK294NXlOcXpBWS9BVkdFQ05sSUNYL1VMR25ueHQzb1RVc2l4cjF6?=
 =?utf-8?B?aEhRc2kzUG0weDJBQnlhOXlIdEJMdW9aelJuYWZBZm9MVkRjMU9oeG96U3pF?=
 =?utf-8?B?U0tQM1ZFU0R3TnNocUpEQW1EVFlkcER2UFlPamo3Q25KKzgyMUt5eU1raVFY?=
 =?utf-8?B?MTJZdWtpQTdWMGU3M3pVUHB1dlpBa0NQVk1BZUl0UG1UMjA5Y1U3QjI0cFhK?=
 =?utf-8?B?VzB2TDZaWER6QkpVOGNNdTY3TU9kdTdMRXF1Z1ZJV25KRkg5YkIveFJPTGhS?=
 =?utf-8?B?YzNEZEpmNDRwZVRSekk0OEhnNU13bTk2emRnMkhSSjluSlF5M0hDWHRJYUM1?=
 =?utf-8?B?U3JBdUNESTFiNlNJeWlnS09Ca0RQa00wTHAxeU1pbzVaQ0R2S3Mxam9JTFFM?=
 =?utf-8?B?ZEptY2w3NlFIZENFbGEzYkI3WEtNM1pYUXcwbFhpYXp6bnFQemVsKzhnWDc3?=
 =?utf-8?B?VGdqQy9FSzdyZjhaOUZ0Z0VPSCtMZG45bENCRzI3UDJqUzhKaHNObjJWODBZ?=
 =?utf-8?B?NXRlSXZiZ0IyanlOOWtaZjFXWVVVbmMyN0o1UHVrMDBQYnhYM0pIZVhHSGl6?=
 =?utf-8?B?VE1WWXNmeDMyei83TUNXNk5ENlpEcHBmbkFSblE5c25ZNTUrZDhNYWlNazlW?=
 =?utf-8?B?OVRPQjAxUGxmZWNDSDFKOGVWTnUySnlZYXUzODg3ZmxPbm1OL1A1R2tVRVAv?=
 =?utf-8?B?VE8zZ01wNkpBbXFOZVZvK0g0SE4rS3liVnA0M1RYSHdlQWN0dnpXdm53a3hG?=
 =?utf-8?Q?rRp5cDQoxD1jVqp8QkWlPkNpJZANnTKtqRU/M6t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60db05ba-c301-4de4-639f-08d93119dcde
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 22:55:40.0525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pfeyx2b8eVP7J3BZj59PjTFu02oMhTcM25djre/ioXcRh99Cupm3tFlN1y1lrKahn+SW6U9SUnxTponqs4MzJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0xNiA0OjM1IGEubS4sIHhpbmh1aSBwYW4gd3JvdGU6Cj4gU29tZSByZXNvdXJj
ZSBhcmUgZnJlZWQgZXZlbiBkZXN0cm95IHF1ZXVlIGZhaWxzLgoKTG9va3MgbGlrZSB5b3UncmUg
a2VlcGluZyB0aGlzIGJlaGF2aW91ciBmb3IgLUVUSU1FLiBUaGF0IGlzIGNvbnNpc3RlbnQgCndp
dGggd2hhdCBwcW5fZGVzdHJveV9xdWV1ZSBkb2VzLiBXaGF0IHlvdSdyZSBmaXhpbmcgaGVyZSBp
cyB0aGUgCmJlaGF2aW91ciBmb3Igbm9uLXRpbWVvdXQgZXJyb3JzLiBQbGVhc2UgbWFrZSB0aGF0
IGNsZWFyIGluIHRoZSBwYXRjaCAKZGVzY3JpcHRpb24uCgpPdXQgb2YgY3VyaW9zaXR5LCB3aGF0
IGtpbmQgb2YgZXJyb3Igd2VyZSB5b3UgZ2V0dGluZz8gVGhlIG9ubHkgb3RoZXIgCm9uZXMgdGhh
dCBhcmUgbm90IGEgZmF0YWwgbWVtb3J5IHNob3J0YWdlLCBhcmUgc29tZSBFSU5WQUwgY2FzZXMg
aW4gCnBtX3VubWFwX3F1ZXVlc192Ki4gQnV0IHRoYXQgd291bGQgaW5kaWNhdGUgc29tZSBpbnRl
cm5hbCBlcnJvciwgdGhhdCBhIApxdWV1ZSB3YXMgY3JlYXRlZCB3aXRoIGFuIGludmFsaWQgdHlw
ZSwgb3IgbWF5YmUgdGhlIHF1ZXVlIGRhdGEgCnN0cnVjdHVyZSB3YXMgc29tZWhvdyBjb3JydXB0
ZWQuCgoKPiAgIFRoYXQgd2lsbCBjYXVzZSBkb3VibGUKPiBmcmVlIHdoZW4gdXNlci1zcGFjZSBp
c3N1ZSBhbm90aGVyIGRlc3Ryb3lfcXVldWUgaW9jdGwuCj4KPiBQYXN0ZSBzb21lIGxvZyBiZWxv
dy4KPgo+IGFtZGdwdTogQ2FuJ3QgY3JlYXRlIG5ldyB1c2VybW9kZSBxdWV1ZSBiZWNhdXNlIC0x
IHF1ZXVlcyB3ZXJlIGFscmVhZHkKPiBjcmVhdGVkCj4KPiByZWZjb3VudF90OiB1bmRlcmZsb3c7
IHVzZS1hZnRlci1mcmVlLgo+IENhbGwgVHJhY2U6Cj4gICBrb2JqZWN0X3B1dCsweGU2LzB4MWIw
Cj4gICBrZmRfcHJvY2ZzX2RlbF9xdWV1ZSsweDM3LzB4NTAgW2FtZGdwdV0KPiAgIHBxbV9kZXN0
cm95X3F1ZXVlKzB4MTdhLzB4MzkwIFthbWRncHVdCj4gICBrZmRfaW9jdGxfZGVzdHJveV9xdWV1
ZSsweDU3LzB4YzAgW2FtZGdwdV0KPiAgIGtmZF9pb2N0bCsweDQ2My8weDY5MCBbYW1kZ3B1XQo+
Cj4gQlVHIGttYWxsb2MtMzIgKFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICk6IE9iamVjdCBh
bHJlYWR5IGZyZWUKPiBJTkZPOiBBbGxvY2F0ZWQgaW4gYWxsb2NhdGVfc2RtYV9tcWQrMHgzMC8w
eGIwIFthbWRncHVdIGFnZT00Nzk2IGNwdT0yCj4gcGlkPTI1MTEKPiAgIF9fc2xhYl9hbGxvYysw
eDcyLzB4ODAKPiAgIGttZW1fY2FjaGVfYWxsb2NfdHJhY2UrMHg4MWYvMHg4YzAKPiAgIGFsbG9j
YXRlX3NkbWFfbXFkKzB4MzAvMHhiMCBbYW1kZ3B1XQo+ICAgY3JlYXRlX3F1ZXVlX2Nwc2NoKzB4
YmYvMHg0NzAgW2FtZGdwdV0KPiAgIHBxbV9jcmVhdGVfcXVldWUrMHgyOGQvMHg2ZDAgW2FtZGdw
dV0KPiAgIGtmZF9pb2N0bF9jcmVhdGVfcXVldWUrMHg0OTIvMHhhZTAgW2FtZGdwdV0KPiBJTkZP
OiBGcmVlZCBpbiBmcmVlX21xZF9oaXFfc2RtYSsweDIwLzB4NjAgW2FtZGdwdV0gYWdlPTI1Mzcg
Y3B1PTcKPiBwaWQ9MjUxMQo+ICAga2ZyZWUrMHgzMjIvMHgzNDAKPiAgIGZyZWVfbXFkX2hpcV9z
ZG1hKzB4MjAvMHg2MCBbYW1kZ3B1XQo+ICAgZGVzdHJveV9xdWV1ZV9jcHNjaCsweDIwYy8weDMz
MCBbYW1kZ3B1XQo+ICAgcHFtX2Rlc3Ryb3lfcXVldWUrMHgxYTMvMHgzOTAgW2FtZGdwdV0KPiAg
IGtmZF9pb2N0bF9kZXN0cm95X3F1ZXVlKzB4NTcvMHhjMCBbYW1kZ3B1XQo+Cj4gU2lnbmVkLW9m
Zi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgIHwgMiArKwo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyAgICAgICAgICAgICAgIHwg
NCArKystCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9t
YW5hZ2VyLmMgfCAxICsKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+IGluZGV4IGU2MzY2YjQwODQyMC4uYzI0YWI4ZjE3ZWI2
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVl
dWVfbWFuYWdlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZV9xdWV1ZV9tYW5hZ2VyLmMKPiBAQCAtMTUyOSw2ICsxNTI5LDggQEAgc3RhdGljIGludCBkZXN0
cm95X3F1ZXVlX2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLAo+ICAgCQkJ
CUtGRF9VTk1BUF9RVUVVRVNfRklMVEVSX0RZTkFNSUNfUVVFVUVTLCAwKTsKPiAgIAkJaWYgKHJl
dHZhbCA9PSAtRVRJTUUpCj4gICAJCQlxcGQtPnJlc2V0X3dhdmVmcm9udHMgPSB0cnVlOwo+ICsJ
CWVsc2UgaWYgKHJldHZhbCkKPiArCQkJZ290byBmYWlsZWRfdHJ5X2Rlc3Ryb3lfZGVidWdnZWRf
cXVldWU7Cj4gICAJCWlmIChxLT5wcm9wZXJ0aWVzLmlzX2d3cykgewo+ICAgCQkJZHFtLT5nd3Nf
cXVldWVfY291bnQtLTsKPiAgIAkJCXFwZC0+bWFwcGVkX2d3c19xdWV1ZSA9IGZhbHNlOwo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+IGluZGV4IDA5Yjk4YTgzZjY3
MC4uOTg0MTk3ZTU5MjlmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9wcm9jZXNzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzcy5jCj4gQEAgLTYwNywxMSArNjA3LDEzIEBAIHN0YXRpYyBpbnQga2ZkX3Byb2Nmc19hZGRf
c3lzZnNfZmlsZXMoc3RydWN0IGtmZF9wcm9jZXNzICpwKQo+ICAgCj4gICB2b2lkIGtmZF9wcm9j
ZnNfZGVsX3F1ZXVlKHN0cnVjdCBxdWV1ZSAqcSkKPiAgIHsKPiAtCWlmICghcSkKPiArCWlmICgh
cSB8fCAha29iamVjdF9nZXRfdW5sZXNzX3plcm8oJnEtPmtvYmopKQo+ICAgCQlyZXR1cm47Cj4g
ICAKPiAgIAlrb2JqZWN0X2RlbCgmcS0+a29iaik7Cj4gICAJa29iamVjdF9wdXQoJnEtPmtvYmop
Owo+ICsJLyogcGFpcmVkIHdpdGggdGhlIGdldCBhYm92ZSAqLwo+ICsJa29iamVjdF9wdXQoJnEt
PmtvYmopOwo+ICAgfQo+ICAgCj4gICBpbnQga2ZkX3Byb2Nlc3NfY3JlYXRlX3dxKHZvaWQpCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVl
X21hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVl
X21hbmFnZXIuYwo+IGluZGV4IDk1YTZjMzZjZWE0Yy4uNGZjYjY0YmM0M2RkIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21h
bmFnZXIuYwo+IEBAIC0zNzMsNiArMzczLDcgQEAgaW50IHBxbV9kZXN0cm95X3F1ZXVlKHN0cnVj
dCBwcm9jZXNzX3F1ZXVlX21hbmFnZXIgKnBxbSwgdW5zaWduZWQgaW50IHFpZCkKPiAgIAkJZHFt
ID0gcHFuLT5rcS0+ZGV2LT5kcW07Cj4gICAJCWRxbS0+b3BzLmRlc3Ryb3lfa2VybmVsX3F1ZXVl
KGRxbSwgcHFuLT5rcSwgJnBkZC0+cXBkKTsKPiAgIAkJa2VybmVsX3F1ZXVlX3VuaW5pdChwcW4t
PmtxLCBmYWxzZSk7Cj4gKwkJcHFuLT5rcSA9IE5VTEw7CgpUaGlzIHNlZW1zIHVucmVsYXRlZCB0
byB0aGlzIHBhdGNoLiBCdXQgaWYgeW91J3JlIGZpeGluZyB0aGlzLCBJJ2QgCmV4cGVjdCBhIHNp
bWlsYXIgZml4IGFmdGVyIHVuaW5pdF9xdWV1ZShwcW4tPnEpLgoKUmVnYXJkcywKIMKgIEZlbGl4
CgoKPiAgIAl9Cj4gICAKPiAgIAlpZiAocHFuLT5xKSB7Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
