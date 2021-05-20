Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D6C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A6961184
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A6961184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636E46E833;
	Thu, 20 May 2021 03:37:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135246E832;
 Thu, 20 May 2021 03:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lvs4/UI67ayUhmsOfUN88Z7scQrdMZM21pSRtB43BeBbj/5XEnm41YszRWqO7aXXeDFLJR01rdq+qpmJ2OfE3gdA7BKzdBpI/xzhIKOWWdaul+uJgeOCB/2rC+JnLAn0HvxHZatWfOZI5mGOKvlNV4wW/Y/PrvcaUrV4lsLa2viGNcLibEEM5XVRxAy0a6TdXvPAZ0WL+3WGiEyrbgEUZg8+mpAkwDYSgN7UMgEZy5z4YaT4sgjaJ2UWOhRnUNbXQS2zGscTNwgHnKLlgY85FqgXKOLXuvAd2YU030q0bOh+8fAN2CyE5ro5BQpeTWC3XDUW5knk9s715loYuFkU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufDOzskts/fYT1CElGhyXyk6pf3A2Tg5uiTy5kfKRzQ=;
 b=RTxgJLLqZVFNrVVvUJf3aETDaktnLTjhHtNSoT2iHTwO2VM6JufvmF5tRFPk778cNbAF5uJ2fcr9AgpqVSw60S+f8fWCmwt9gXLUP7UfUjAVrTvpkGBz1Dt47lrtB6vflY4E3kygLV6GTsRsUFkPx/XBjawx+jrLYFkP5K7G+6pkBY0XOIyB47napFSoRj/qJDfEYtav9Hat03JH094VYhMJM6OfQm/fvdivLSnVHrZ8fNWAMKSft+AtLvDoXs4i2Roj19KpQoMtLsKTxNr032t9weE01kYX9zv9NItaJFDxzsXjWrHTsClJqn73l5UDyu5kdC7sLsmDlUJMuifitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufDOzskts/fYT1CElGhyXyk6pf3A2Tg5uiTy5kfKRzQ=;
 b=3ogwoSTnM2W2eUHaQVjp+uF5cKqTRVS3SoFmDQFSODPSmCVDZFvbBbag4nZ+UdqjqkP5YB9pWpKJ0P3PfMmxU/9sds/5s5gTGoTXliuKhJ7bssnbuRwabMer8T7HB/X5l2uHn4BjQdJCMx1TXV1nouOFZYidI0tOp3qzQ0w804c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 03:37:29 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 03:37:29 +0000
Subject: Re: [PATCH] drm/amdgpu: Let userptr BO ttm have TTM_PAGE_FLAG_SG set
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210520031523.12834-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <786ef553-430b-ba98-952d-68d7b33159fa@amd.com>
Date: Wed, 19 May 2021 23:37:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210520031523.12834-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::41) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 20 May 2021 03:37:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea9629f8-8126-4509-28d4-08d91b4097fa
X-MS-TrafficTypeDiagnostic: BN9PR12MB5273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5273D28C0B5889DCD7504918922A9@BN9PR12MB5273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Sf8k+Cpd2cgOuNmvQNNDCPyumsM6J22T17xDj7JIazGWQTH0YErgmxgoqrK6Bso4zqJQVgPOhmJQtw+vJCLFvg2xHwiUOS7pDKbhPH6GjEyXqQB4FAUVEW59JqLZeC8FCfg6oL6eNBQ3YzKnb+aiaeGM3mAJpTW61j/OFtVEcupPXYLU1YB8OZqWQ4iknNRAGRg+KoppYG6aLXdoINxmtr1jff6TTPiMAzs5PFgVrzV4HAeomZVEsdzUOePXBnEnS0M9JL6uyTOwGr1beg2/88rBVdaGM/bZyYHxcOocoJjz6D74jljVl7xLMDDi3ALcGmYe1FtG/gX3KfZJrb7OTmYWQlHoQBVcrJMtCFP/8R9SHAw9YKbaWZWwo866oW5vUALHK8Wt8oOWim24okwUr9t39aMAhlbH0cQm/VUJ0DyV7Ma9RntUK6RmzGMMlcFQplilZTEPJ+l6dEOQIt2a+W3KSBnpgMECQ0aeHTqysJFGzMdPo2EuQYtOV4JM8Dl518tIcwMdjdBSXX7OWWUQR/7daGuMihP1ur3PVwfCfSMVKqj3E2i61OMzz5q+W351nBO/Rc+IySWJbvRJ0NwdC8MAddQpQF2lxjcpPvum7/WSC3+7hUiFKcfaMQ8meHzg3Jx83UX+eDmxrXX4IdA4AcZUKZxjgSzSHiATLRyXCfPMgrMhjpL2TIfSr2UrAhh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(2616005)(956004)(186003)(16576012)(450100002)(316002)(5660300002)(8936002)(2906002)(8676002)(66556008)(36756003)(4326008)(26005)(16526019)(31696002)(66476007)(86362001)(44832011)(6486002)(38100700002)(66946007)(31686004)(478600001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N3prTk82cmdkTUNaa3NqM1k3SFJOMm1rNFBkR1FRRDh6aXZidUdJeG12aWxi?=
 =?utf-8?B?M0VtSU9uVFd6bDZzZmI4Wm9NQ3QvRG1MYm5mNUVCUEJqclJmNVdRWnZaQ1BN?=
 =?utf-8?B?NGxkdjZpbFFsclN0a2VGRmUyTzRkNGRrRlJEK0ljN1paU0xYdmdDZjc0dExY?=
 =?utf-8?B?VkY4YUZpRmQwb0N3UzJtRnVNSTNoWjJiNTJVQ0Jwa1Z4aXN6WEJRTXo4QkpT?=
 =?utf-8?B?ekg0Si9GVnIvNWJaTHhJNjZwNDIxcFFPZUFVSng4WHJ1MkFoYkUyaWF2RnZL?=
 =?utf-8?B?cmpKa0dNdXE3VkhXSFZSWXd6ZFlIZE1UcjRzamh4c3RhQnVMZzNuTXI4OWJz?=
 =?utf-8?B?TXNyYnIyMEpidytpbFR3Si9nVkZBKzltN24waTBjKzZqamxwaXMyRWIwUTNa?=
 =?utf-8?B?aGVDOFNSZFhPejF4d1dNa2tadnVhVkQ5Z1dmRWtJMUJsTW5IVDF4MXp1T2Fs?=
 =?utf-8?B?NXVnVUx0U1NBdGliWHBNVkVxWmdxMHRPMUtBdk1CQTQ4Z2xkS3k1b2RPNk12?=
 =?utf-8?B?V2p2dnU2WEJFeGREclA2L09aNE1mTHlvcVFuVkM3THk0QlFCcE1Ta05sSFU0?=
 =?utf-8?B?cmIwb1RPY1M4RjkweVFMZG4zRW5mTHNMdGlxZ01RNWo2Y2RldlYzQWplT2JT?=
 =?utf-8?B?ODZOUkU1WDE0bU0xUzMxcGQ3d2RWeXBlN0tqeTQxdHREVmRLd0hZRm9MWnBo?=
 =?utf-8?B?dkd2QURxbEN1NWZUVHB5T0pSam0zM3VqWjJKeTliZzI5elRwNytIWmx1NVVP?=
 =?utf-8?B?dlJsNnh3WEUzN2hJWXZ1VFp1a2FPaEhXbEduTThmdW4xSXNHelRsQnp5Mmhi?=
 =?utf-8?B?ck5wVDB1YzBubldXaDh3VkFjMzAyM0FBbE1sMytUWXppRkRlUTMzcndpeisw?=
 =?utf-8?B?cDdZcU9IYmpINTV0WFl0SmZ4QkVjS1Jpa0V4eFVtdm95clFFY0Y0VDNablU3?=
 =?utf-8?B?RTJ0MEdScnlkMjk2ZFUxM0FKV0VBSVdlbDkzajg5T291bVlwU2xCaEc1dUh6?=
 =?utf-8?B?eXZGRURrOVpJZjB3YW1CUElTZkFEdzRsQkFNODhseURqSXowbUlSME9ZK0p1?=
 =?utf-8?B?YldEVThNSG1NYXVIZWp3V01KdERDa1B0dU9nU1ZzNmR2YkVjQTdqZzZjOEov?=
 =?utf-8?B?SUZVMkV5b1JLSkNmTm1qdEpMN2RRZ2tydmJYSHp2WGNpRE5uUDdiQ1VzdGFU?=
 =?utf-8?B?SVQ4TThvTUpvMWIvNTkyenZ3WXQ1SmpHanNVZWRGdGtWY2dVR0g4RWpESFFo?=
 =?utf-8?B?Z1JOMWpGV0pRWjVwa3NQWnhpNlR2U2VUd0JkVTdlUFp1NjRHcmxJQjZkKzB4?=
 =?utf-8?B?NkZDSmw1UlU1Y3FBcTdGdGQ2aW9JdFNBL3dkWWY1QXlUWlVDMllReDlDdDBr?=
 =?utf-8?B?aCtkS0dSbWkxYUpGL09rTXRYTkswcmJRV2VkemlvVmZTZEtjUGNsbkIwMDQ4?=
 =?utf-8?B?MHNMWWV1bGFMVmw5eG9samhvOGdqQmo5QXo0QUdZejJWZ1NEa3RCMDM4YzNt?=
 =?utf-8?B?YzFTbnlEN3NWZ1U0ek1iYnFnV0EzMWtMN3hWSjh0SHFsYVVGaHNlK1MxZ21m?=
 =?utf-8?B?UFhOdCs2QUhtYzJJRDU4VjhDU2R2cGFGaWFTOHRWck1WdjY2N2hCZVZxMXVt?=
 =?utf-8?B?eENoa1VUZDZaRmNsb1h1UlZxNmtKUFVWb2x4Q3M3YkdYbVJaeUVnTXhERGt5?=
 =?utf-8?B?Y1dtemdaNEhCaEwrK056UnRjV1psMlZqZ1NHRTF6TUI1eEx4ZHh5c0RNTXp5?=
 =?utf-8?Q?yhtf3e1a9fbEwmTt7DPI367EvhkPLu46Y1IOJbU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9629f8-8126-4509-28d4-08d91b4097fa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 03:37:29.2162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LU8jtoqYgZQS4Peqp7nTRFz7CyXkeP0+smQ7DDfTMqf2nV8Qp6g8LtPNPIUxQB/XRjE1Jw1hAvhZuoDFMUGmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSB0aGluayB0aGlzIHdvcmtzIGZvciBLRkQgdXNlcnB0ciBCT3MuIEJ1dCB0aGlzIHByb2JsZW0g
aXMgcHJvYmFibHkgbm90CnNwZWNpZmljIHRvIEtGRC4gSXQncyBvbmx5IG1vc3Qgb2J2aW91cyB3
aXRoIEtGRCBiZWNhdXNlIHdlIHJlbHkgc28KaGVhdmlseSBmb3IgdXNlcnB0cnMuCgpJIGRvbid0
IHJlYWxseSB1bmRlcnN0YW5kIHdoeSB3ZSdyZSBtZXNzaW5nIHdpdGggVFRNX1BBR0VfRkxBR19T
RyBpbgphbWRncHVfdHRtX3R0X3BvcHVsYXRlIGFuZCBhbWRncHVfdHRtX3R0X3VucG9wdWxhdGUu
IEFuZCB3aHkgYXJlIHVzZXJwdHIKQk9zIGNyZWF0ZWQgYXMgdHRtX2JvX3R5cGVfZGV2aWNlLCBu
b3QgdHRtX2JvX3R5cGVfc2c/IENocmlzdGlhbiwgZG8geW91Cmtub3cgYWJvdXQgdGhlIGhpc3Rv
cnkgb2YgdGhpcyBjb2RlPwoKRWl0aGVyIHdheSwgdGhlIHBhdGNoIGlzCgpBY2tlZC1ieTogRmVs
aXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpUaGFua3MgZm9yIGxvb2tpbmcg
aW50byB0aGlzIQoKUmVnYXJkcywKwqAgRmVsaXgKCkFtIDIwMjEtMDUtMTkgdW0gMTE6MTUgcC5t
LiBzY2hyaWViIHhpbmh1aSBwYW46Cj4gV2UgaGF2ZSBtZXQgbWVtb3J5IGNvcnJ1cHRpb24gZHVl
IHRvIHVuZXhjZXB0ZWQgc3dhcG91dC9zd2FwaW4uCj4KPiBzd2Fwb3V0IGZ1bmN0aW9uIGNyZWF0
ZSBvbmUgc3dhcCBzdG9yYWdlIHdoaWNoIGlzIGZpbGxlZCB3aXRoIHplcm8uIEFuZAo+IHNldCB0
dG0tPnBhZ2VfZmxhZ3MgYXMgVFRNX1BBR0VfRkxBR19TV0FQUEVELiBCdXQgYmVjYXVzZSB1c2Vy
cHRyIEJPIHR0bQo+IGhhcyBubyBiYWNrZW5kIHBhZ2UgYXQgdGhhdCB0aW1lLCBubyByZWFsIGRh
dGEgaXMgc3dhcG91dCB0byBzd2FwCj4gc3RvcmFnZS4KPgo+IHN3YXBpbiBmdW5jdGlvbiBpcyBj
YWxsZWQgZHVyaW5nIHVzZXJwdHIgQk8gcG9wdWxhdGUgYXMKPiBUVE1fUEFHRV9GTEFHX1NXQVBQ
RUQgaXMgc2V0LiBOb3cgaGVyZSBpcyB0aGUgcHJvYmxlbSwgd2Ugc3dhcGluIGRhdGEgdG8KPiB0
dG0gYmFrZW5kIG1lbW9yeSBmcm9tIHN3YXAgc3RvcmFnZS4gVGhhdCBqdXN0IGNhdXNlcyB0aGUg
bWVtb3J5IGJlZW4KPiBvdmVyd3JpdHRlbi4KPgo+IENQVSAxCQkJCQkJQ1BVIDIKPiBrZmQgYWxs
b2MgQk8gQSh1c2VycHRyKSAgICAgICAgICAgICAgICAgICAgICAgICBhbGxvYyBCTyBCKEdUVCkK
PiAgICAgLT5pbml0IC0+IHZhbGlkYXRlKGNyZWF0ZSB0dG0pCQktPiBpbml0IC0+IHZhbGlkYXRl
IC0+IHBvcHVsYXRlCj4gICAgIGluaXRfdXNlcl9wYWdlcyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtPiBzd2Fwb3V0IEJPIEEKPiAgICAgICAgIC0+IGdldF91c2VyX3BhZ2VzIChmaWxs
IHVwIHR0bS0+cGFnZXMpCj4gICAgICAgICAgLT4gdmFsaWRhdGUgLT4gcG9wdWxhdGUKPiAgICAg
ICAgICAgLT4gc3dhcGluIEJPIEEgLy8gbWVtb3J5IG92ZXJ3cml0dGVuCj4KPiBUbyBmaXggdGhp
cyBpc3N1ZSwgd2UgY2FuIHNldCBUVE1fUEFHRV9GTEFHX1NHIHdoZW4gd2UgY3JlYXRlIHVzZXJw
dHIgQk8KPiB0dG0uIFRoZW4gc3dhcG91dCBmdW5jdGlvbiB3b3VsZCBub3Qgc3dhcCBpdC4KPgo+
IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPiAtLS0KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgNCArLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyAgICAgICAgICB8IDQg
KysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
X2dwdXZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZt
LmMKPiBpbmRleCA5MjhlOGQ1N2NkMDguLjlhNmVhOTY2ZGRiMiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPiBAQCAtMTQxMCw3
ICsxNDEwLDcgQEAgaW50IGFtZGdwdV9hbWRrZmRfZ3B1dm1fYWxsb2NfbWVtb3J5X29mX2dwdSgK
PiAgCX0gZWxzZSBpZiAoZmxhZ3MgJiBLRkRfSU9DX0FMTE9DX01FTV9GTEFHU19VU0VSUFRSKSB7
Cj4gIAkJZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5fR1RUOwo+ICAJCWFsbG9jX2RvbWFpbiA9
IEFNREdQVV9HRU1fRE9NQUlOX0NQVTsKPiAtCQlhbGxvY19mbGFncyA9IDA7Cj4gKwkJYWxsb2Nf
ZmxhZ3MgPSBBTURHUFVfQU1ES0ZEX0NSRUFURV9VU0VSUFRSX0JPOwo+ICAJCWlmICghb2Zmc2V0
IHx8ICEqb2Zmc2V0KQo+ICAJCQlyZXR1cm4gLUVJTlZBTDsKPiAgCQl1c2VyX2FkZHIgPSB1bnRh
Z2dlZF9hZGRyKCpvZmZzZXQpOwo+IEBAIC0xNDc3LDggKzE0NzcsNiBAQCBpbnQgYW1kZ3B1X2Ft
ZGtmZF9ncHV2bV9hbGxvY19tZW1vcnlfb2ZfZ3B1KAo+ICAJfQo+ICAJYm8tPmtmZF9ibyA9ICpt
ZW07Cj4gIAkoKm1lbSktPmJvID0gYm87Cj4gLQlpZiAodXNlcl9hZGRyKQo+IC0JCWJvLT5mbGFn
cyB8PSBBTURHUFVfQU1ES0ZEX0NSRUFURV9VU0VSUFRSX0JPOwo+ICAKPiAgCSgqbWVtKS0+dmEg
PSB2YTsKPiAgCSgqbWVtKS0+ZG9tYWluID0gZG9tYWluOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMKPiBpbmRleCBjN2Y1Y2M1MDM2MDEuLjViM2Y0NTYzN2ZiNSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBAQCAtMTExOSw2ICsx
MTE5LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgdHRtX3R0ICphbWRncHVfdHRtX3R0X2NyZWF0ZShzdHJ1
Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAJCWtmcmVlKGd0dCk7Cj4gIAkJcmV0dXJuIE5V
TEw7Cj4gIAl9Cj4gKwo+ICsJaWYgKGFiby0+ZmxhZ3MgJiBBTURHUFVfQU1ES0ZEX0NSRUFURV9V
U0VSUFRSX0JPKQo+ICsJCWd0dC0+dHRtLnBhZ2VfZmxhZ3MgfD0gVFRNX1BBR0VfRkxBR19TRzsK
PiArCj4gIAlyZXR1cm4gJmd0dC0+dHRtOwo+ICB9Cj4gIApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
