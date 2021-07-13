Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257B6C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 17:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21B961249
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 17:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21B961249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E5F6E104;
	Tue, 13 Jul 2021 17:23:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671FB6E104
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 17:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbxPUtu7npX6PBTOkD+Ga3KKsjUoFEde28lDfQOvyYhkuwfLnyX2fXO74jv5MQMpC+9ZSZIk3NUjS9+/YECDuGDmPyBWSPvYymI+qArq1c6xAZFf5nH1SHdwaSI89W+lLrD88qVd0VUSVFX/MO1CAVdeiTGJclKbqgNMCkFm8Iu0tZk5U5S5T8a+LmFmgyUdE/VGFUtS0THDqB6zSp1v36jlEE0hzfN+agJHbrANcsxyqqr1JYn8mIvA4iBQX2DGAHiJcfj/WyiEUH0V31oW+JiMixtryWT7vHWDKYMp3Eoi5DeM1A+X8vMczBfh0Ip/D5+eaySsupC/oL9fBy6Ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pemi9crh91Dg0yW+Y9AJXTPWwPg/yiRm7CFf3mjjHJ8=;
 b=Vaj6pdOc/Hs78acs6ntOFzvkAdPcspy4XIGLk7ytBt8t4W6wd+4domwcolu64l0oqXvVlFaG327O+Qpa/WgnyG4kmSSfEAfaBJyW0v+AimWPfUGHrX+cbrDqBt6FuhiLk77p4MUUdzXRL5Iab6PHp/Jm6XPP6Z+ardAcD57o8ottNSd+re0p6AuOz0WH+U7px33ckxFT5R9Z09uRXLYjOJbnNA6IkLNupWoqasa+821bkXjXtSjj9ebeHFTXzYT/eyDMjDjveK/+kYgHytdt6YeLmarNGn5nZO25hqf6VD3+ZnSa9UX7XWpSYFj5OmkGECgmGm+2WU791taGl5fubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pemi9crh91Dg0yW+Y9AJXTPWwPg/yiRm7CFf3mjjHJ8=;
 b=sH/nKxsOUiyhiAfrwEBtgeG4FZeN3k+aR8LeCs09KCj8un+rhhsEVSyzjdJCVh5L48FNDi2r8Y/Ugyt35uSoS+hNDrgZkZgMEpnqhjCOY8GBILYlzQIKTpiZajZ0c7jzLBtaMpcQK14vHtfVKLrZ1t/WrkvSq8RW7JCojkFrCl0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Tue, 13 Jul
 2021 17:23:15 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561%4]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 17:23:14 +0000
Subject: Re: [PATCH] drm/amdgpu: further lower VRAM allocation overhead
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20210713133255.16456-1-christian.koenig@amd.com>
 <1bd98b6c-ba8e-de16-9e6a-2c4ab6ab01cf@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <64d68ef7-fbc1-a4df-3af9-4bcc5dcc3341@amd.com>
Date: Tue, 13 Jul 2021 13:23:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1bd98b6c-ba8e-de16-9e6a-2c4ab6ab01cf@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:890e:34c4:757:cc76]
 (2607:9880:2048:122:890e:34c4:757:cc76) by
 YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 17:23:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bebb2c7c-5c64-4942-d7ca-08d94622e5c3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125B2807797CEC838070F6F82149@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBZHI6Uv6BgAp7bAEZ3TTlx3pt7ncXo6XKKLhN3Fe6ECkk+BD2bSs4o4omeSePkIiq7RLC1YqGz4ooeoKIo2wEf3yNYST4N6eBYytD+uS12MAnB/44bS26hjltLckA3k4/3LTOYlWjPeeAJ1q9E/FywepRs6t8sSOdtK6ijVClQslhf89TPvmWdGNkaeqH2tr253W/oFqXQUi3h3Z1wIABhY2TeRLe8I0d7uCW5DGHXfovujETz0UC0JmXhDsA1hA7kYuYIKYiCsEsRmwNCtwiU4UCkqun8Aa9tu6BZtu9swOGotHt3Ke4lg8sw64bpjJ/bFY926e3+D1bYhOzJQBFUefXbqJEZtXuA4caDbaQjh9AE3gn8uWRQHNcT+rwrDDME05C1fEyu5eR/2UAWpAvatdKM7F0wXZEpUoLDOdSJIdmE6VFtdW43DKXbHtxXlWgz9c+/ZPZK59q/m7c+3/Ppp8A1GXEiKXSy/ZJMThK7tZh7yMfVWTPb9vOCfyWJklmed+7ADlubOUxTx4O4O9zE+3yivDIlIUnd9qFDI1DRAbIYLxnjlCYNUXoq7NJL/Tr7GkeYXyM3totycIZdmrpYmOx6ANMqXawzvZi16WLkxekyupkomsCXKealAum2qwDXBQww0QWVAv2FoHdjC2SQQna3Va/dZATlM48cGuXghfPWIq75T4zNck50o6Gqly9aJv6fKjN+m107s129SMJ/7Rv30LdzWfBLnE3NaT7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(8936002)(36756003)(31686004)(4326008)(316002)(110136005)(38100700002)(66574015)(8676002)(66476007)(83380400001)(86362001)(2616005)(66556008)(6666004)(66946007)(6486002)(53546011)(31696002)(186003)(478600001)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmw5OSs1dzZLMEtaL2NlTDBRbVdySStPUnF6QWgyWTM3ZTRITjRPRDUvUFpJ?=
 =?utf-8?B?RVI4YXlyTVpzVDZscWJDQ0RJbXlCVU5HT2ZMZjNnV1FiODdDaDhNaThUdmZE?=
 =?utf-8?B?OTVnSGtsRDF6WG01dkRIZmpacGFYL1g0VjNVWUZqRHA0UnF4V2JGRUIvQTkz?=
 =?utf-8?B?azBRUjAxc2FvNkZHUEl1YVhqeEc0YWwzTi9wemR4aWtGclVjMGpQNWd0SmlU?=
 =?utf-8?B?T1Bid1lYVFRoaUxXUVd2dk1KUXFEOEJtRVhXWjlyR2wvTGNhSnB3Mmw2Mk42?=
 =?utf-8?B?NFB2Z1VSNXF5RjNya2htSVB2b013VkNIU0VrVEJLYkFqdFJuZDBRODdZLzBW?=
 =?utf-8?B?OEo2czFRY0hZSXhqQUdxTmZzamVmY1RxZTBJMTNGKzFsZVk4bGE0SENkSkVD?=
 =?utf-8?B?Z2hQbm1LNS9PUGhZbUtXK0lJdnBkMGJxRlJFVTJPc0lwV3NvQU1hT0Ezdmo1?=
 =?utf-8?B?MkNKUE1EZnJYRkQxSTJFSkl0blNWMzA3V2p5YXhWQk5SMEtVQVpVZ0U4Y3FR?=
 =?utf-8?B?ZTRmMlhJVGtHNjVrRGNQRkZveXI3allHWnVudkNvSHc2VDd1aFZlelp1OFUy?=
 =?utf-8?B?WFRLUEVsOUhDVHdRSmIyc1VTNENEeDNsK0lWVUtZNkphR1dHOTR1eDNDTW1L?=
 =?utf-8?B?RFF0TE5NUDFTOGYvVnJkMXBpMlhJNXhlV3plQjlpenVISXpqYzMrTWw1V292?=
 =?utf-8?B?Mks0MjJWMjF5aU4veUpHRXpNS0F6V1hRMVBOUG9PZ0xtQmUvZmp6WGhDMVEv?=
 =?utf-8?B?d0NvZFFmQWRNVVNuaW1McHpvOXlGWFdMczIrUGw1ZE9tNDIxbVhXcWw3OUYr?=
 =?utf-8?B?a0prTkRxNEhYRXhKbjErOXlQZzhYU2VnS0NOS2hmdmNQU3o2WFJvWjZwc0ZE?=
 =?utf-8?B?aXF2bGduaTdMblYrWWsxb3UvM2EvQmlXekVDRTM1UGlzbUhaQ1prY2M2Tjhr?=
 =?utf-8?B?ck5wZWxOVjAvT0lKNGZiUEliWW1NcW45NTVQaytQSVFUcDFxVW9hU3U0eXEv?=
 =?utf-8?B?V2E4bTRHZk5QaC9OWnA4cmJ6c3o0eEdYRnRsQk5zNkFhZ0hYUzR2SXdEdHVp?=
 =?utf-8?B?MDVaWlZSVnpUMEFTTDRDMFJsTUJzcDdmUVMzMFdaVzNVN1dJQWFHcFRTamhr?=
 =?utf-8?B?TWdEczRqK25QRWN2bGJlVTdBVWdGWnhCSnhSNDRpU1B0QXBXZmJvdnQyaFhx?=
 =?utf-8?B?UzZzNS9NOERpVkgyc1VKdVYySG84eFJ4eXY0Wm5ocit4RlpMNzNZOGtDc0Zu?=
 =?utf-8?B?SS9yRUsvaDlrd3Z2elFjM1E2aE1nRTZML1dZcHRLajlBelpBL3RvOVF3YXVk?=
 =?utf-8?B?UllkNkQvNDRyemV4eFAxN1FuOUFpQTJVbTg2VTh6VG82MlJ4NmhDZzEvK0ZF?=
 =?utf-8?B?SUQ3bjQvY1UxblVnSGJNQ3U5VUVXbnREcVFjNTV2cEl2SFhqUFIvRlVDR2V5?=
 =?utf-8?B?blpWTDJzamZkL1kyMjh2OXhUcDdPMC9ObGJvNTVzN2VWalp2aERqVUUrN0Z6?=
 =?utf-8?B?K1pmeEU1WmZwZEUwcHMyRWQ2OERNd2JVSGU1em5tNEtpWEZSMStUVGxKOFZ1?=
 =?utf-8?B?VGxuU1FjNnNFSElnKzlaeWo1UFQvaFdBanVJRHJYa01jTUdqY2NING5CUUpW?=
 =?utf-8?B?dGFFMjZQOGRtRDJQbndaajVTWTBRWm1EcWF6Q2wxdUsyT3hSbHRkcDVvWGZB?=
 =?utf-8?B?SEJpVmJKOG1Kb2NGejlyTDFrbzFyeStkUHZuWUFMYThZUUcyRUpZdk1wc0h2?=
 =?utf-8?B?L3BwVFZtdFIydklJa1BjTHViOUxuYU1wWmE5QjJFQ0NDQWpyZGpiVEE4TDBW?=
 =?utf-8?B?aiswSUthaVVNRzRUbUVhR09GbjBKdzV2SDRVUlNnQ1g0b0VkcUFSWWE5SW4y?=
 =?utf-8?Q?6yZupHWPA1sRp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebb2c7c-5c64-4942-d7ca-08d94622e5c3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 17:23:14.8818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvF90D0ahy2xxSMpb7dhQBvisXhHKehQaC5MYgBnxEcuAhZjV1zAz2l6OcqL14pETJPedGuuE8j3w64IgkflQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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
Cc: amd-gfx@lists.freedesktop.org, Luugi.Marsan@amd.com, Jenny-Jing.Liu@amd.com,
 Chris.Mason@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBhbSBjb252ZXJ0aW5nIGNvZGVzIGludG8gYW1kLXN0YWdpbmctZHJtLW5leHQuIFRoZW9yZXRp
Y2FsbHkgaXQgd2lsbCAKaW1wcm92ZSBhIGxvdCBvbiB0aGUgbGF0ZW5jeSwgdGhlIHNpemUgb2Yg
dGhlIGFycmF5IGFsbG9jYXRlZCBpcyAyNCAKKFBBR0VfU0laRS9zdHJ1Y3QgZHJtX21tX25vZGUp
IHdpdGggdGhpcyBwYXRjaCwgYW5kIGl0IHdhcyA4MTkyIGJlZm9yZS4gClNvIHRoZSBsYXRlbmN5
IHNob3VsZCBiZSByZWR1Y2VkIGJ5IDk4IHVzLgoKUmVnYXJkcywKRXJpYwoKT24gMjAyMS0wNy0x
MyAxMjoxMSBwLm0uLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBBbSAyMDIxLTA3LTEzIHVtIDk6
MzIgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+IEZvciBhbGxvY2F0aW9ucyBsYXJn
ZXIgdGhhbiA0OE1pQiB3ZSBuZWVkIG1vcmUgdGhhbiBhIHBhZ2UgZm9yIHRoZQo+PiBob3VzZWtl
ZXBpbmcgaW4gdGhlIHdvcnN0IGNhc2UgcmVzdWx0aW5nIGluIHRoZSB1c3VhbCB2bWFsbG9jIG92
ZXJoZWFkLgo+Pgo+PiBUcnkgdG8gYXZvaWQgdGhpcyBieSBhc3N1bWluZyB0aGUgZ29vZCBjYXNl
IGFuZCBvbmx5IGZhbGxpbmcgYmFjayB0byB0aGUKPj4gd29yc3QgY2FzZSBpZiB0aGlzIGRpZG4n
dCB3b3JrZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZyYW1fbWdyLmMgfCA4MCArKysrKysrKysrKysrKystLS0tLQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPj4gaW5kZXggMmZkNzdjMzZh
MWZmLi5hYjhjNWUyOGRmN2IgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92cmFtX21nci5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92cmFtX21nci5jCj4+IEBAIC0zNjEsMTkgKzM2MSwyMyBAQCBzdGF0aWMgdm9pZCBh
bWRncHVfdnJhbV9tZ3JfdmlydF9zdGFydChzdHJ1Y3QgdHRtX3Jlc291cmNlICptZW0sCj4+ICAg
ICogQG1hbjogVFRNIG1lbW9yeSB0eXBlIG1hbmFnZXIKPj4gICAgKiBAdGJvOiBUVE0gQk8gd2Ug
bmVlZCB0aGlzIHJhbmdlIGZvcgo+PiAgICAqIEBwbGFjZTogcGxhY2VtZW50IGZsYWdzIGFuZCBy
ZXN0cmljdGlvbnMKPj4gLSAqIEBtZW06IHRoZSByZXN1bHRpbmcgbWVtIG9iamVjdAo+PiArICog
QG51bV9ub2RlczogbnVtYmVyIG9mIHBhZ2Ugbm9kZXMgdG8gdXNlLgo+PiArICogQHBhZ2VzX3Bl
cl9ub2RlOiBudW1iZXIgb2YgcGFnZXMgcGVyIG5vZGUgdG8gdXNlLgo+PiArICogQHJlczogdGhl
IHJlc3VsdGluZyBtZW0gb2JqZWN0Cj4+ICAgICoKPj4gICAgKiBBbGxvY2F0ZSBWUkFNIGZvciB0
aGUgZ2l2ZW4gQk8uCj4+ICAgICovCj4+ICAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3
KHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuLAo+PiAgIAkJCSAgICAgICBzdHJ1Y3Qg
dHRtX2J1ZmZlcl9vYmplY3QgKnRibywKPj4gICAJCQkgICAgICAgY29uc3Qgc3RydWN0IHR0bV9w
bGFjZSAqcGxhY2UsCj4+ICsJCQkgICAgICAgdW5zaWduZWQgbG9uZyBudW1fbm9kZXMsCj4+ICsJ
CQkgICAgICAgdW5zaWduZWQgbG9uZyBwYWdlc19wZXJfbm9kZSwKPj4gICAJCQkgICAgICAgc3Ry
dWN0IHR0bV9yZXNvdXJjZSAqKnJlcykKPj4gICB7Cj4+IC0JdW5zaWduZWQgbG9uZyBscGZuLCBu
dW1fbm9kZXMsIHBhZ2VzX3Blcl9ub2RlLCBwYWdlc19sZWZ0LCBwYWdlczsKPj4gICAJc3RydWN0
IGFtZGdwdV92cmFtX21nciAqbWdyID0gdG9fdnJhbV9tZ3IobWFuKTsKPj4gICAJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSB0b19hbWRncHVfZGV2aWNlKG1ncik7Cj4+ICAgCXVpbnQ2NF90
IHZpc191c2FnZSA9IDAsIG1lbV9ieXRlcywgbWF4X2J5dGVzOwo+PiArCXVuc2lnbmVkIGxvbmcg
bHBmbiwgcGFnZXNfbGVmdCwgcGFnZXM7Cj4+ICAgCXN0cnVjdCB0dG1fcmFuZ2VfbWdyX25vZGUg
Km5vZGU7Cj4+ICAgCXN0cnVjdCBkcm1fbW0gKm1tID0gJm1nci0+bW07Cj4+ICAgCWVudW0gZHJt
X21tX2luc2VydF9tb2RlIG1vZGU7Cj4+IEBAIC0zOTUsMjEgKzM5OSw2IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKPj4g
ICAJCWdvdG8gZXJyb3Jfc3ViOwo+PiAgIAl9Cj4+ICAgCj4+IC0JaWYgKHBsYWNlLT5mbGFncyAm
IFRUTV9QTF9GTEFHX0NPTlRJR1VPVVMpIHsKPj4gLQkJcGFnZXNfcGVyX25vZGUgPSB+MHVsOwo+
PiAtCQludW1fbm9kZXMgPSAxOwo+PiAtCX0gZWxzZSB7Cj4+IC0jaWZkZWYgQ09ORklHX1RSQU5T
UEFSRU5UX0hVR0VQQUdFCj4+IC0JCXBhZ2VzX3Blcl9ub2RlID0gSFBBR0VfUE1EX05SOwo+PiAt
I2Vsc2UKPj4gLQkJLyogZGVmYXVsdCB0byAyTUIgKi8KPj4gLQkJcGFnZXNfcGVyX25vZGUgPSAy
VUwgPDwgKDIwVUwgLSBQQUdFX1NISUZUKTsKPj4gLSNlbmRpZgo+PiAtCQlwYWdlc19wZXJfbm9k
ZSA9IG1heF90KHVpbnQzMl90LCBwYWdlc19wZXJfbm9kZSwKPj4gLQkJCQkgICAgICAgdGJvLT5w
YWdlX2FsaWdubWVudCk7Cj4+IC0JCW51bV9ub2RlcyA9IERJVl9ST1VORF9VUF9VTEwoUEZOX1VQ
KG1lbV9ieXRlcyksIHBhZ2VzX3Blcl9ub2RlKTsKPj4gLQl9Cj4+IC0KPj4gICAJbm9kZSA9IGt2
bWFsbG9jKHN0cnVjdF9zaXplKG5vZGUsIG1tX25vZGVzLCBudW1fbm9kZXMpLAo+PiAgIAkJCUdG
UF9LRVJORUwgfCBfX0dGUF9aRVJPKTsKPj4gICAJaWYgKCFub2RlKSB7Cj4+IEBAIC00MzEsMTAg
KzQyMCwxNSBAQCBzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0IHR0bV9yZXNv
dXJjZV9tYW5hZ2VyICptYW4sCj4+ICAgCWkgPSAwOwo+PiAgIAlzcGluX2xvY2soJm1nci0+bG9j
ayk7Cj4+ICAgCXdoaWxlIChwYWdlc19sZWZ0KSB7Cj4+IC0JCXVpbnQzMl90IGFsaWdubWVudCA9
IHRiby0+cGFnZV9hbGlnbm1lbnQ7Cj4+ICsJCXVuc2lnbmVkIGxvbmcgYWxpZ25tZW50ID0gdGJv
LT5wYWdlX2FsaWdubWVudDsKPj4gKwo+PiArCQlpZiAoaSA+PSBudW1fbm9kZXMpIHsKPj4gKwkJ
CXIgPSAtRTJCSUc7Cj4+ICsJCQlnb3RvIGVycm9yX2ZyZWU7Cj4+ICsJCX0KPj4gICAKPj4gICAJ
CWlmIChwYWdlcyA+PSBwYWdlc19wZXJfbm9kZSkKPj4gLQkJCWFsaWdubWVudCA9IHBhZ2VzX3Bl
cl9ub2RlOwo+PiArCQkJYWxpZ25tZW50ID0gbWF4KGFsaWdubWVudCwgcGFnZXNfcGVyX25vZGUp
Owo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzIGNoYW5nZS4gSXMgdGhpcyBhbiB1bnJlbGF0ZWQg
Zml4PyBwYWdlc19wZXJfbm9kZQo+IGlzIGFscmVhZHkgYnVtcGVkIHVwIHRvIHRiby0+cGFnZV9h
bGlnbm1lbnQgaW4gYW1kZ3B1X3ZyYW1fbWdyX2FsbG9jLiBTbwo+IHRoaXMgIm1heCIgb3BlcmF0
aW9uIGhlcmUgc2VlbXMgcmVkdW5kYW50Lgo+Cj4gT3RoZXIgdGhhbiB0aGF0LCB0aGUgcGF0Y2gg
aXMKPgo+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT4KPgo+IEBKaW5IdWlFcmljLCBjYW4geW91IGNvbmZpcm0gdGhlIHBlcmZvcm1hbmNlIGltcHJv
dmVtZW50Pwo+Cj4gVGhhbmtzLAo+ICDCoCBGZWxpeAo+Cj4KPj4gICAKPj4gICAJCXIgPSBkcm1f
bW1faW5zZXJ0X25vZGVfaW5fcmFuZ2UobW0sICZub2RlLT5tbV9ub2Rlc1tpXSwgcGFnZXMsCj4+
ICAgCQkJCQkJYWxpZ25tZW50LCAwLCBwbGFjZS0+ZnBmbiwKPj4gQEAgLTQ4Myw2ICs0NzcsNTIg
QEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFu
YWdlciAqbWFuLAo+PiAgIAlyZXR1cm4gcjsKPj4gICB9Cj4+ICAgCj4+ICsvKioKPj4gKyAqIGFt
ZGdwdV92cmFtX21ncl9hbGxvYyAtIGFsbG9jYXRlIG5ldyByYW5nZQo+PiArICoKPj4gKyAqIEBt
YW46IFRUTSBtZW1vcnkgdHlwZSBtYW5hZ2VyCj4+ICsgKiBAdGJvOiBUVE0gQk8gd2UgbmVlZCB0
aGlzIHJhbmdlIGZvcgo+PiArICogQHBsYWNlOiBwbGFjZW1lbnQgZmxhZ3MgYW5kIHJlc3RyaWN0
aW9ucwo+PiArICogQHJlczogdGhlIHJlc3VsdGluZyBtZW0gb2JqZWN0Cj4+ICsgKgo+PiArICog
QWxsb2NhdGUgVlJBTSBmb3IgdGhlIGdpdmVuIEJPLgo+PiArICovCj4+ICtzdGF0aWMgaW50IGFt
ZGdwdV92cmFtX21ncl9hbGxvYyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKPj4g
KwkJCQkgc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICp0Ym8sCj4+ICsJCQkJIGNvbnN0IHN0cnVj
dCB0dG1fcGxhY2UgKnBsYWNlLAo+PiArCQkJCSBzdHJ1Y3QgdHRtX3Jlc291cmNlICoqcmVzKQo+
PiArewo+PiArCXVuc2lnbmVkIGxvbmcgbnVtX25vZGVzLCBwYWdlc19wZXJfbm9kZTsKPj4gKwlz
dHJ1Y3QgdHRtX3JhbmdlX21ncl9ub2RlICpub2RlOwo+PiArCWludCByOwo+PiArCj4+ICsJaWYg
KHBsYWNlLT5mbGFncyAmIFRUTV9QTF9GTEFHX0NPTlRJR1VPVVMpCj4+ICsJCXJldHVybiBhbWRn
cHVfdnJhbV9tZ3JfbmV3KG1hbiwgdGJvLCBwbGFjZSwgMSwgfjB1bCwgcmVzKTsKPj4gKwo+PiAr
I2lmZGVmIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRQo+PiArCXBhZ2VzX3Blcl9ub2RlID0g
SFBBR0VfUE1EX05SOwo+PiArI2Vsc2UKPj4gKwkvKiBkZWZhdWx0IHRvIDJNQiAqLwo+PiArCXBh
Z2VzX3Blcl9ub2RlID0gMlVMIDw8ICgyMFVMIC0gUEFHRV9TSElGVCk7Cj4+ICsjZW5kaWYKPj4g
KwlwYWdlc19wZXJfbm9kZSA9IG1heF90KHVpbnQzMl90LCBwYWdlc19wZXJfbm9kZSwgdGJvLT5w
YWdlX2FsaWdubWVudCk7Cj4+ICsJbnVtX25vZGVzID0gRElWX1JPVU5EX1VQX1VMTChQRk5fVVAo
dGJvLT5iYXNlLnNpemUpLCBwYWdlc19wZXJfbm9kZSk7Cj4+ICsKPj4gKwlpZiAoc3RydWN0X3Np
emUobm9kZSwgbW1fbm9kZXMsIG51bV9ub2RlcykgPiBQQUdFX1NJWkUpIHsKPj4gKwkJc2l6ZV90
IHNpemUgPSBQQUdFX1NJWkU7Cj4+ICsKPj4gKwkJc2l6ZSAtPSBzaXplb2Yoc3RydWN0IHR0bV9y
YW5nZV9tZ3Jfbm9kZSk7Cj4+ICsJCXNpemUgLz0gc2l6ZW9mKHN0cnVjdCBkcm1fbW1fbm9kZSk7
Cj4+ICsJCXIgPSBhbWRncHVfdnJhbV9tZ3JfbmV3KG1hbiwgdGJvLCBwbGFjZSwgc2l6ZSwgcGFn
ZXNfcGVyX25vZGUsCj4+ICsJCQkJCXJlcyk7Cj4+ICsJCWlmIChyICE9IC1FMkJJRykKPj4gKwkJ
CXJldHVybiByOwo+PiArCX0KPj4gKwo+PiArCXJldHVybiBhbWRncHVfdnJhbV9tZ3JfbmV3KG1h
biwgdGJvLCBwbGFjZSwgbnVtX25vZGVzLCBwYWdlc19wZXJfbm9kZSwKPj4gKwkJCQkgICByZXMp
Owo+PiArfQo+PiArCj4+ICAgLyoqCj4+ICAgICogYW1kZ3B1X3ZyYW1fbWdyX2RlbCAtIGZyZWUg
cmFuZ2VzCj4+ICAgICoKPj4gQEAgLTY4MCw3ICs3MjAsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVf
dnJhbV9tZ3JfZGVidWcoc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCj4+ICAgfQo+
PiAgIAo+PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXJfZnVuYyBh
bWRncHVfdnJhbV9tZ3JfZnVuYyA9IHsKPj4gLQkuYWxsb2MJPSBhbWRncHVfdnJhbV9tZ3JfbmV3
LAo+PiArCS5hbGxvYwk9IGFtZGdwdV92cmFtX21ncl9hbGxvYywKPj4gICAJLmZyZWUJPSBhbWRn
cHVfdnJhbV9tZ3JfZGVsLAo+PiAgIAkuZGVidWcJPSBhbWRncHVfdnJhbV9tZ3JfZGVidWcKPj4g
ICB9OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
