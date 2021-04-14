Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27BBC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 17:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B640C6105A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 17:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B640C6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D55C6E4B1;
	Wed, 14 Apr 2021 17:10:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5126E4B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 17:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku74FoSiQAPXS0SMY48q6x3geza4VLx1xn+KLo8BljbTpTDkdc4amhNdO+7lqnAdxtwPJnmetc5asSCXOxRgDtUd/yH3IegoVg8JwBD6ZD24Uc6FtzbGCK0i+4KSXC7aP/pHdAURHbZOt3uPsckJ1tqUWWb4UIKmNo8QvxfTiOL4HIKG3JwpMp3bXL8VdYgjVo/ceyJBxew+TMPGmYr7rPPvNOo3Nxq/+4nM4avwgvq63RV/tDNmiDGBW7vwrfkNjmoi2ppDhD0fy87Rm45c2kOU7YWqfQR9lcAeNfmxveIQ7zOmzseaqv/uxhH/SG+oqYvZWb6jcIpXVdy1XPgHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMcp4PmiO1GN0qzsEOLuXsL62DQBk597pUXOWJCF0xQ=;
 b=jR3NpSuVb36u1mE0PVlE/aDkzM+yVjg5ip6hLF2wmXErn5haYIdOvtB5qPVlafxrJ/JVs+/VHZVTTqbtfjWYwtvtXqnsNi2qf66n7Hju+NcNBfJ980EIxjjvk7z2c7mbzibF1FT3dHFJXs1dzT/iewtKZ+OtJXO8etari62AdO1XT72bX8Dz3eSNgAjN/GjMSOYrBSMAocfGqbENS+53bG5sM2+a8rAe+qGQqg1ibT4MoNqv7AqGgtZKFu0IjRDSfGkFtErytbZTJuXre3UDHljGbxFB+ZnXmNnJiohB9RbvbZpaZ+kJ40k4oUkPKk4kGyrngBWxXXSuQOeOkBflhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMcp4PmiO1GN0qzsEOLuXsL62DQBk597pUXOWJCF0xQ=;
 b=OL6drUQfblRov4LRGdYR2//zfg+WRxxUdx5zhva4iJ9TUQSaoWF8My3VjM5bb0X0rjyjygxe7CmStSstIIn0m5BFKpfLJVKf+Ob4gXMqeEfFo7zDZABRsO2mUZ2v1qn0Q10pXAbbRUcEHTeWlk9UrOUS5Ihtfd18NCEqISkGhJY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 14 Apr
 2021 17:10:20 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 17:10:20 +0000
Subject: Re: [PATCH] drm/amdgpu: Add double-sscanf but invert
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210414152126.24685-1-luben.tuikov@amd.com>
 <cef16c21-0399-aa94-72bc-ef88089e3bb3@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <850b882e-a275-a316-4bd6-b75aebf82027@amd.com>
Date: Wed, 14 Apr 2021 13:10:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <cef16c21-0399-aa94-72bc-ef88089e3bb3@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Wed, 14 Apr 2021 17:10:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d255130b-69a4-4af9-3f27-08d8ff682eee
X-MS-TrafficTypeDiagnostic: DM6PR12MB4959:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB495994436ED8B7577F207CED994E9@DM6PR12MB4959.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3yYI7lV2ugc8D6pxhz0ULCHenbbF/rIOFBOuZUi71JExHb9QuYW/wgYA6MIowx71oMUTR/9hFIODzqGad2gyuYotPO6g5nyzGwmuEyIB13EubCRiFmxvEjTx3eaK+rUEzpn62i1y8lip9rSjpv59gQfRySrGfPMNfpG9pLprJxmJvUltyIz8Ti4lLmtrNaXoQ0Esr/Ij69y4maOYKIHoUqCjx8i3KbfsGZjnAX+hUKALEdVHhIuY/FS13f3N3sLAe8MYVg9LkZe/QlgJl2qdTzFYGKrYQhhKE4npmWnJj7ZuwP2pIDZ+lcTJaHsThlSkOPMQ7Zm15adsTdw+fspAIRo104nC071vxOm0NZ2MOBYyHTT5LfESFPixfRpnGjfUkq5XJ8V6/5PAIDgzCl/S/fCqw08NM+lmJ/BGieqbLMYPHEvZs/2zOtKNXJ+mpFVqHEIQOUFyNtYQwG9KVD4s0ppJJt9kWZICorBld42Nj+kn+yCpOOsurmRvEH18yyOmimg6GlWEc1KBBfsEPSF+yfWoUWhmZihaEpOUVmzk93AFNaOzQzw6sa8ka1x3+KeS0I/1/cOQKcSYpKECyYpgCq0a8AZ4R3hlTZBKGhNRt6iya+vphfeXLvNN6vY4PQY6mw+KQ5PoNsfXSCmrmHRvXry1M2UY3BuOTf7co9ZPLLvy/flmOMsueC1OubdCVwF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(31696002)(66946007)(4326008)(478600001)(6506007)(6512007)(38100700002)(54906003)(956004)(316002)(16526019)(186003)(6666004)(36756003)(83380400001)(66476007)(6486002)(2906002)(26005)(53546011)(66556008)(31686004)(5660300002)(8936002)(2616005)(8676002)(44832011)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cEpMZXd3SUpRbHc1ZHlHWHBHN29IR0xDRU1GUHdBZGZSYitFVm8zV2VTckxL?=
 =?utf-8?B?MmQxMDZycmJBQmUzVU1DN3NkUEFBakVJb3kzTUJLTU44djgxeUVkWkIxS3RH?=
 =?utf-8?B?K3FkbEZCSmlic01INDEzT0ZnQUUrV2lVVWtHUllESldmNWhnUmtNTjdlcGhW?=
 =?utf-8?B?MWNJWWV5elZWN3NTblU4c0xUR2EvZ0Y0RHgzZVpHU2JnYkw2ZjIraFducFZu?=
 =?utf-8?B?Q2xpNHRmdHkzMC9NSWRYMU5vamF0VjdFV01wbUxnOC9TM1NSeVJkekNYMkx2?=
 =?utf-8?B?c0pia0dBVUgwVmZWSitZZ1VKZ3ZnOEpHeldOeGc3SW5GTFJBSjY3TlI3R0Vw?=
 =?utf-8?B?ZEd3SDVKa1J6bUt6K3ptWVRKVk83VUFhYjRzQ1NlbTRmczEzQ0ppUVdwSWFo?=
 =?utf-8?B?VVlkVVpVMXpvYmJhTTJPV3VtVGJtSEFpRFpsNEpRT0U3Ukg4V0lWVHI2d2NC?=
 =?utf-8?B?WHgrWk53ZjV4ZDdTd0tDZUhJUjVwVHdWblMrL0tyd2xYME45T2hUNWdCY3I1?=
 =?utf-8?B?aWt2TW8xRTlKK3hUcE5ZM3IwRTNKOXBNOEdSYmROdTdTdDllbFpzbmZ1MmdQ?=
 =?utf-8?B?QUZtQmZ5RFM1enpUcjc2Z3JQQWRTQ2tmMlpFNkJQQ1UxTFdwdXlpaGpPU0Zu?=
 =?utf-8?B?ZEl6eEFHVXROU0xMa25RWnVlWDZySE5mWnN5WVlqUDRTa3VhRjhPZ1RtOFFz?=
 =?utf-8?B?TG5LTFdmVVRQL01mUHN4WTJBTzR5bkU0Q0Z6SGtPekV2a2J4RElTdnFqekRU?=
 =?utf-8?B?SlJMK1lUSG5OaHBQMVA3aTMwdDhHR0JBbTJ1eWxBYWVOWjhuTTJIY0RxdlNa?=
 =?utf-8?B?NjBveXhHUFIxU3JHSkxMZkRKTWVKQkhUUkhXNUJjN0Rib2FUdTFTK1lPbmow?=
 =?utf-8?B?MTdJM2FDcDVHaVJkd241ZlRZSmZmN3NybGVnaWs0a3E1THE0N3Z1MHZtdWww?=
 =?utf-8?B?eEhqUy9MN1lUSUZsOVh2UGNvcVNJcFJKaWFRellpMk1vSkhOQ2g5dkRxZGMy?=
 =?utf-8?B?ZnJEc2ZkZkUvZFllR1lLUVd4bTdSNUhUeFNHSmFsd1Q4dXhMekFLemVFOEFs?=
 =?utf-8?B?dGYvQVNrMzJLdHpxTXVSZGUyRWpYcEZxYWZ4a2xpazNhOUI3aGRxUWdheUF6?=
 =?utf-8?B?dExDWFAxajFhaXFCOHl5cUx5ZTJiU1p1WHVwR3JKdnZidSt0MDBoekF6cmhy?=
 =?utf-8?B?RU1XUjdYT2JkUVErcXN0Nkx1M0N1aG41YzVtYXdHS0JWOGhtS2hTTk5TM2pn?=
 =?utf-8?B?VERjVVFOUnhiRXhscUMvdkFVQmYvbmVuSVFzKzhPYjVFTEVQNnBCZjNzeGVK?=
 =?utf-8?B?cmFGRHVDK09DM1ZSaFV2aWpaMFFtWFZ6QnlEVHQ4V214eUlNZTc0UDNVUmYz?=
 =?utf-8?B?NmZUMHFlV2p0c3E4U1BmY0JIbWc1ZFZmNWxiYUcvc3RWUURFaVFZZGNNSzdD?=
 =?utf-8?B?WjA0bFd0L1JsZm1sWGhGLzV5L3J3Qkw5aFEwSmxYRjdBV1l0eExyVXprUURY?=
 =?utf-8?B?ZmJkYXAzN2FYQjZCb0g2WVdIQU5lWndweFpnSFJoM0J1TnFmVzRmV2E1WkpT?=
 =?utf-8?B?aU9DZjA0dVc5L1VEVnhwSFROU0RUcVRqeDVQTXRKaWZWVmZEeXZRNjVUeks2?=
 =?utf-8?B?Rlc5bzlkbTg4RUFKSU1pV3VuRGhKdGh2Z2FnditienFqTlVkM21lWjJ4Tklo?=
 =?utf-8?B?cXAyS3h5cU5KWFgwbC9pbWM1TzZvSDFqNWFaQ0VGL0RkSUFTUmlaY0NGMFFS?=
 =?utf-8?Q?RqSE6y0ilZgEa0a9FYQWVWKheKu3fpmXnX4r4gD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d255130b-69a4-4af9-3f27-08d8ff682eee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 17:10:20.3151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkK/F/pkBGInrDYtsBjXb7ejy37wOQUvIKBvTcLyhrTh6vkccQw3GdfEAoNozMR8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVhaCwgJWkgd291bGQgZG8sIGFuZCBjZXJ0YWlubHkgbW9yZSBlbGVnYW50LCBleGNlcHQKZm9y
IHRoZSBzaWduZWQgaW5wdXQuIE5vdCBzdXJlIGlmIHRoYXQncyBhIHByb2JsZW0sIGVpdGhlciwK
dGh1cyB0aGUgdHdvIHNzY2FuZi4uLgoKUmVnYXJkcywKTHViZW4KCk9uIDIwMjEtMDQtMTQgMTE6
NTggYS5tLiwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gRnJvbSB0aGUgc3NjYW5mIG1hbnBhZ2U6
Cj4gCj4gwqDCoMKgwqDCoMKgIGnCoMKgwqDCoMKgIE1hdGNoZXPCoCBhbiBvcHRpb25hbGx5IHNp
Z25lZCBpbnRlZ2VyOyB0aGUgbmV4dCBwb2ludGVyCj4gbXVzdCBiZQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGEgcG9pbnRlciB0byBpbnQuwqAgVGhlIGludGVnZXIgaXMgcmVhZCBpbiBi
YXNlIDE2IGlmIGl0wqAKPiBiZWdpbnMKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3aXRo
wqAgMHjCoCBvcsKgIDBYLCBpbiBiYXNlIDggaWYgaXQgYmVnaW5zIHdpdGggMCwgYW5kIGluCj4g
YmFzZSAxMAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG90aGVyd2lzZS7CoCBPbmx5IGNo
YXJhY3RlcnMgdGhhdCBjb3JyZXNwb25kwqAgdG/CoCB0aGXCoAo+IGJhc2XCoCBhcmUKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1c2VkLgo+IAo+IFNvIGEgc2luZ2xlIHNzY2FuZigiJSpz
ICVpIiwgLi4uKSB3b3VsZCB0byB0aGUgam9iLiBUaGUgb25seSBwcm9ibGVtIGlzCj4gdGhhdCBh
Y2NlcHRzIHNpZ25lZCBpbnRlZ2Vycywgbm90IHVuc2lnbmVkLiBJJ20gbm90IHN1cmUgaWYgdGhh
dCdzIGEKPiBwcm9ibGVtIGluIHRoaXMgdXNlIGNhc2UuCj4gCj4gUmVnYXJkcywKPiDCoCBGZWxp
eAo+IAo+IEFtIDIwMjEtMDQtMTQgdW0gMTE6MjEgYS5tLiBzY2hyaWViIEx1YmVuIFR1aWtvdjoK
Pj4gQWRkIGJhY2sgdGhlIGRvdWJsZS1zc2NhbmYgc28gdGhhdCBib3RoIGRlY2ltYWwKPj4gYW5k
IGhleGFkZWNpbWFsIHZhbHVlcyBjb3VsZCBiZSByZWFkIGluLCBidXQgdGhpcwo+PiB0aW1lIGlu
dmVydCB0aGUgc2NhbiBzbyB0aGF0IGhleGFkZWNpbWFsIGZvcm1hdAo+PiB3aXRoIGEgbGVhZGlu
ZyAweCBpcyB0cmllZCBmaXJzdCwgYW5kIGlmIHRoYXQKPj4gZmFpbHMsIHRoZW4gdHJ5IGRlY2lt
YWwgZm9ybWF0Lgo+Pgo+PiBBbHNvIHVzZSBhIGxvZ2ljYWwtQU5EIGluc3RlYWQgb2YgbmVzdGlu
ZyBkb3VibGUKPj4gaWYtY29uZGl0aW9uYWwuCj4+Cj4+IFNlZSBjb21taXQgImRybS9hbWRncHU6
IEZpeCBhIGJ1ZyBmb3IgaW5wdXQgd2l0aCBkb3VibGUgc3NjYW5mIgo+Pgo+PiBDYzogQWxleGFu
ZGVyIERldWNoZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+Cj4+IENjOiBKb2huIENsZW1l
bnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+Cj4+IENjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVp
a292QGFtZC5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jIHwgNyArKysrKy0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5j
Cj4+IGluZGV4IDQ0ZGZiMzYxM2UzNy4uMzhhNjkxYTNiNjAwIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCj4+IEBAIC0yMjksNyArMjI5LDggQEAgc3RhdGlj
IGludCBhbWRncHVfcmFzX2RlYnVnZnNfY3RybF9wYXJzZV9kYXRhKHN0cnVjdCBmaWxlICpmLAo+
PiAgCj4+ICAJaWYgKG9wICE9IC0xKSB7Cj4+ICAJCWlmIChvcCA9PSAzKSB7Cj4+IC0JCQlpZiAo
c3NjYW5mKHN0ciwgIiUqcyAlbGx4IiwgJmFkZHJlc3MpICE9IDEpCj4+ICsJCQlpZiAoc3NjYW5m
KHN0ciwgIiUqcyAweCVsbHgiLCAmYWRkcmVzcykgIT0gMSAmJgo+PiArCQkJICAgIHNzY2FuZihz
dHIsICIlKnMgJWxsdSIsICZhZGRyZXNzKSAhPSAxKQo+PiAgCQkJCXJldHVybiAtRUlOVkFMOwo+
PiAgCj4+ICAJCQlkYXRhLT5vcCA9IG9wOwo+PiBAQCAtMjUzLDcgKzI1NCw5IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3Jhc19kZWJ1Z2ZzX2N0cmxfcGFyc2VfZGF0YShzdHJ1Y3QgZmlsZSAqZiwKPj4g
IAkJZGF0YS0+b3AgPSBvcDsKPj4gIAo+PiAgCQlpZiAob3AgPT0gMikgewo+PiAtCQkJaWYgKHNz
Y2FuZihzdHIsICIlKnMgJSpzICUqcyAleCAlbGx4ICVsbHgiLAo+PiArCQkJaWYgKHNzY2FuZihz
dHIsICIlKnMgJSpzICUqcyAweCV4IDB4JWxseCAweCVsbHgiLAo+PiArCQkJCSAgICZzdWJfYmxv
Y2ssICZhZGRyZXNzLCAmdmFsdWUpICE9IDMgJiYKPj4gKwkJCSAgICBzc2NhbmYoc3RyLCAiJSpz
ICUqcyAlKnMgJXUgJWxsdSAlbGx1IiwKPj4gIAkJCQkgICAmc3ViX2Jsb2NrLCAmYWRkcmVzcywg
JnZhbHVlKSAhPSAzKQo+PiAgCQkJCXJldHVybiAtRUlOVkFMOwo+PiAgCQkJZGF0YS0+aGVhZC5z
dWJfYmxvY2tfaW5kZXggPSBzdWJfYmxvY2s7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
