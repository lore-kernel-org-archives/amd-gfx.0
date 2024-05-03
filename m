Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14A9C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 05:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E46E10F131;
	Fri,  3 May 2024 05:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oOAMuZjN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 176F510F131
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 05:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Agk5XpItdM6SpsRvrftSXkJgTXJ9C2QLlc5ee36HQh46GeNt0777Gki9zTcwcv4u+dVDJyPydhwOpz6OfgG2VJpaWiswBa9SuMpAUllP2XxHzXtRWzh7W92yNJFLlFWNNQmHSQ26tyQ9k/k/T4V4Kb1LwXiEODmFt5Rgm/ieRCHMqhMzwsU19FYKW8LXh32KoM/mDIX9RKs/36PPB1h3I40gIKfxWwNp3cc7qAt3pO7F60RalPIx0SIJJckXc4B2nVpKFcKCjXa4Ug0jYAHpXxLJQtb9rokBKUZtjqK6CmlLoL+nVU2he2KF3NeyH3D+4ROknUzYkhmwESyMFn0KDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1ZMFjPqJGdjXyzJ18B7EJy3xfU0WKjhao998KhdAqw=;
 b=ggi8iE4kghIffYJAAh/KH7fyl3uC+eNV49sf5De8F1ep6ei7K0nsibQiTE3SMkq9ZC+PqP0+6IH2ijmjVFiCiCHPdcSJ+TGCHz05SDZbT0FNxv91p1v/ksZDzeNMKooH9Fk3I207hIAe4WzKcXRqUpjYK+qygPiq/hxW/+dYZBxyYMomPpsbuHi/f9iHc0s0PPmZXu03mt7xU7IUOaOl8AuHu9TBQgg1WvctYAn3sqXshZ/V04Gnyv15Kz3tS4/fmTw1pf47YBiLxJeyYaDiZRQgb7PJ6981d1oPc33+K+/39Ve8IHpG9fXUrP8S0kzxN3iG5AVFeXDqprL1g0g27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1ZMFjPqJGdjXyzJ18B7EJy3xfU0WKjhao998KhdAqw=;
 b=oOAMuZjN1/O9jVcD2MWxD3ZmmyGFoU5Swfnn+w31W2+r5FkR1hd9lnBs4hfNmsbz89uf5Wg1SS6tm5GkhwmPfaUoZmxJqzNbaOtxaP4R0Af7gxW30Nkgx8wcMGQuT1Fn+tWQpBjCxfMm9X3uT+Jn0/k3Gi2FX01UL0LAJsAqv1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 05:14:41 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 05:14:39 +0000
Message-ID: <77793bdd-93c7-e2fc-4e86-4bf249f5c1d3@amd.com>
Date: Fri, 3 May 2024 07:14:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 03/14] drm/amdgpu: add new IOCTL for usermode queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
 <20240502163152.1382-4-shashank.sharma@amd.com>
 <CADnq5_PVxJVAJ0+X=QWJYauTY8t8FOgNSgakcquq5Li-85pWGw@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_PVxJVAJ0+X=QWJYauTY8t8FOgNSgakcquq5Li-85pWGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e2f561-2987-4970-7d45-08dc6b2feebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFZlWGZIRzlCdFBxbmVLa3Y3TU1GditJWndTeDVoWWVUclU2N3pyR0hvbDdJ?=
 =?utf-8?B?QVl5cDFmWWJrblJUenJQZlBJa0RTMm4wSVh0ZXV0b1dWUmpMUGtUYmR3U3pB?=
 =?utf-8?B?TG9BSHNudlljcVVEWmxGVUNNZ3dWZnFleldUdHZBMS90L2U4cDQrM25kWkFt?=
 =?utf-8?B?eFgrWWxGSWVoVmN0MlB1OXlKNFFPRDM5UmFKOVBkZ1Z5dnJvUFhKYkZvbElw?=
 =?utf-8?B?aWNoQmt0dHBlaHVQUE50ZGRxU1BWU0Y0ZmVGVTE3TmpIcUYvM1Rma2swTHBQ?=
 =?utf-8?B?L1FoWjJFWmVKU3Qzd2NpNllJMVdxZXVUeVNnY0RFK3ZVK3NhY2NEakhOOTNv?=
 =?utf-8?B?ZnFEalVKY0J2UTI5Y0VFbUo0aWlLeGoybDhUNGhKTnFnZmEyWVUzWDdlZlg4?=
 =?utf-8?B?L1NkRFBTakQ0a0ovSTIvMXdNbkdaWnJ0bURYT0kvQ2FWZnhjQkxveGQzYSs2?=
 =?utf-8?B?OUxJTzl6dFRLRXJBeE1qNjR4L3ZuRlVwUHdKQUs5SU5IT0llOElkVTlSTk9t?=
 =?utf-8?B?MFRkSTc2Vmw5VDZMam1mNjNDS2syN3pBV0thVEtaYjh0RFZVbmR0elBtbDR3?=
 =?utf-8?B?S2gwVXR1MWh4aWNUcGFwWDRJQ2NnVlllSzA4cHFRTnE3WU1aRDB2d1NBeVE0?=
 =?utf-8?B?SG4vRCtaN2ZLdllyZ2R5a2hnaFdCSmt1S3Z6bnRRM3V6TFhJT0ZvSGZMR09p?=
 =?utf-8?B?Q0VaZHA3MVpmRDlXS25UbVV5bUxQVW9XT240Q2NaS0NpM1RQL1lmekkwdlkx?=
 =?utf-8?B?ZExDSXVnYUIvRlIyeTlDUGFZLzlZRDFBMjYyVXVrU29TSXZvbTZDaUNld0FM?=
 =?utf-8?B?SGd6bWxKZkphTXRudUVMT1FlOXloQ0xIWUhURHBRMG9tU2FJeHlUUGM0cGlD?=
 =?utf-8?B?eVNDQnB3WnNMMHNFSjBicnJVcW5JZVE3ZWpVR3crTUJhSnk5VnhnY0dLSVY0?=
 =?utf-8?B?WTVUcHU3T1J1bVRJYXBXakxzekx4OGlFU0p3eGJBaGFvTHZmQVJZV1hZVDVp?=
 =?utf-8?B?c0ZvNkpMUGJaNTV2S2ZqNDBFL2I0VG1Ub29vRVVzT1lSL3lGK09EN3NhY3lE?=
 =?utf-8?B?b2hPc1g0VS95UDJWRUQva09YUVZ3Rm54M2hrZVpGeTZ5bmVyTjVVeWR1UGxY?=
 =?utf-8?B?c09QNDNvTzl5WTVSUjJzbWEwOGtTTkFoTUZlWmtzMitBMG5sVVltRFNZOXEv?=
 =?utf-8?B?TVZKR3NpSFZNS25HS0VHWkNoOTUwWUFTREZXTzdYSENpeHlnUFJ4aUgvTGJm?=
 =?utf-8?B?dlFGR09KbjhsTUN3dG1WYU8zVWN0ODdSZWJtNEErV0ROYzdhMzdiZE5ESzha?=
 =?utf-8?B?RW4xWE01MmFLWUZYb3FMWUl0eFFhWUxxTGRZY0dqbXArbDQ4L3Fwa25sUDd3?=
 =?utf-8?B?WCt3bXhSbC9YSWNtbTIzUDhVVlVzc3ZKeU91bVlub1VmYk0vRCtwdVZlN0Jz?=
 =?utf-8?B?UVhodlMrd1pqaDROaDFhTVBHaFlqZXJIU29FZ2lqOHJ6aFEwWkFjTlFCSjVY?=
 =?utf-8?B?WHFzR2JhbGlIY0ZqeXo4cnZzd0RjMTNBMGNjWTZFYUpKc3BOTlhQM09meU45?=
 =?utf-8?B?Ym9UTEdkamYxRkJxa1FzQUQ3WnEzVHAyNFd0S3BvUUVHTUhSdkZUQkhPOGEy?=
 =?utf-8?B?UExsNGFpV2NaWDlqMUJOeTlUSGt2WFRtK0MzekdqRXVaQXZlV0NCRDBWQm45?=
 =?utf-8?B?U2NxTnVJNmNWUGl0M01KdCtuNkh6a2FNRldYYTZNWWZkcXNWUkdhTHFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmZYWkkraEtEQlNjTUd4UFVDQlhKVCt3djB6VWE3M2puS0NUSlNRbHEzdlJX?=
 =?utf-8?B?TmNYVW1xZHBON3NtbDBUdXpDZUdvNXBURlFhOUlPZCthSzZwRDRxaVUzY2dV?=
 =?utf-8?B?Tlg3a1JwZ1pMSGEzNWM2VUt5aktnVURhVXpHNVJNdjlRTm9OVWIzeFRLVjli?=
 =?utf-8?B?UmRmRjBCQklpNXkvZE1NVmFnOG10N0xINlV0c2paSC9pR1V0d3JNMVZYamM3?=
 =?utf-8?B?RTZtZmtJYVAwVFlEYWw1eWJtNlcrejJTeUN6elJBMTVIb1dtaFdCOGV6MlZH?=
 =?utf-8?B?aElNYXlyYm0xc3RFUUNZWVpjRkNiUzNnWW92eGF6ci81MDRiUVNZZUlPelBD?=
 =?utf-8?B?TFBKam5KUXk0aEN0RGNMbHd0ZDhwRU5sWGE3bm9ONWhUN1cvUU5sZ29GV2lu?=
 =?utf-8?B?NFRDL2JlbHhlNnF3aE5NY2tVNzNqTEFGWXNXR3dVb2tJdVd3TjBlb0lLdE9C?=
 =?utf-8?B?d1ZOVkdoUHYzQmZWL2VDUXdjZkQrTnZzYlhQSFZReXgvTFBXNEpqUWFBdEhr?=
 =?utf-8?B?aFpQVHMvSTBZMDVNL0J4U2tEZTNUVnFzZWFHZ0dxYm0yVi9oc0VmTzNWVjFm?=
 =?utf-8?B?MDJ5LzJaZFBLb1ZGYmpiZTBvc21QK0dYN1cxUVZwVlZRbXVmVVlPWDYrRWNl?=
 =?utf-8?B?T0ZtMEpyL1d5L3lLbXVKVVpBbzR5VmpzaVREUy8raWlqSm4rMUlST0VzZkhD?=
 =?utf-8?B?MjhQMkJjN3dXNVpjOHZSSVh3cnJnSzVCaVVWVXFyMEN4OUJjcXlUSjErZGJs?=
 =?utf-8?B?bndIRCtVZTAwM1IwaWRCT3VKYTdkWG81Qk4rVWRKdjRlYTIxd05kR3djOE5F?=
 =?utf-8?B?MHhqSk1Hc05ZVHZuV0hsR0RoZk5KUXJxU3pWb2Q1cUhXck4wRjhiV0FMNmli?=
 =?utf-8?B?NkdLZFJMeE9yRzZnV29tTTd1N05MVTRER2lYTUNxTUNhcUNQQ3FEdW50S0pQ?=
 =?utf-8?B?YjZ2bFlxMVJtUkZpYTJSQkZaSm1OaUxCbUhMTjlQYWJBZ2FYYmR1ZllibktG?=
 =?utf-8?B?R3FORzBIWTI2SisrMVJ4UmkwU29wOER1QjBrbkNpTTRkN3NUMzlVb2x2TnFI?=
 =?utf-8?B?RXJTWE1SckZLaXdqL0d2d1NZY291Y3pNVmVUcTBtMDNmMlVWSmtqTFJjQUF1?=
 =?utf-8?B?QitNVHc3bCtpQ2d4emsxVHVyZkxJQnA1RTYxTG9wNVZCTjQ0NENuZE8xK3Z0?=
 =?utf-8?B?MzFkdktRQTlqMGJJa1lWa2pWdWttRG9JNm5FbEFFTmZxTHZ1UTlkZlNwMCsx?=
 =?utf-8?B?Zmp0OHRMSk5DUVJuRVBzcmJFYUgvdnZKQ1VWZmo2Zi83OGdXbjhiak90S0t6?=
 =?utf-8?B?RmhreTZZbFg5enpWOU9icFdIQ0pPVXJhZ2NXUkczb3dFT3NOZG10d1l4cEpR?=
 =?utf-8?B?a1FFc01ZSU1uK2tqN3kvZVozaDZWUWo3RkN6akZ1OHFMRk4vTDRlSnFPRUNt?=
 =?utf-8?B?RC8ya21vNUJNWk1OZWZadHVwcnJNWWUzVkJ6aDJzVWg1R29PUVFPeVFPejFt?=
 =?utf-8?B?VzlKZFpZT0YrSFROTllJZHRvOEg1WnFISmNrZVVhaC8wS2Z2N01WbTd6STM3?=
 =?utf-8?B?ekVNQytleEFNa1JWd2hnREZOenRyQUNFSDdFVE1YbWIyV052S0ZteUdlOTlO?=
 =?utf-8?B?UlhlN3hYcTUrRFNZcWMwcit2dzBJRzVrWXlWc2JmZnZjdzlxZDJlK2crQlJq?=
 =?utf-8?B?ZnNCSTJhNlJYSFVZZXhNSTlxUzQ0aXBhL3dzdlVtOUpqWWJzU2ZJcjAvZDQy?=
 =?utf-8?B?ckxHamRmSGt2UEN0b3lWc1dJM0o0Yks3UG02Um5ncWk0cHpEbCtTcElvS2xw?=
 =?utf-8?B?dmpGSzF5VkQ3YVBWZ0xQWjBucW1PbStYdHdxcXVPYnV4Y0tsZ2FlYUhpZ2cx?=
 =?utf-8?B?cXRiTUszKzRJa1QycEhlcjZOQzJCZ0NxZ0Fuc0xUOVNIZ3NrOWUyTGpjRFRD?=
 =?utf-8?B?V2V2UC8wY1A0WE9zaVErc0Irb2t3VXU1SGt0K3NaVkpDNGFScFlzZHl5YnZ3?=
 =?utf-8?B?N1V3bU9VbzAweFNFMCtXblRCb2k0VlkwdEhOWUxoamFBa3lXbE9QNS80Ykw2?=
 =?utf-8?B?Mmk0WmxVUVB4SXljNDVrdFJvY2M3Tjg5NXQrK0MvYm9zeW1SeDhLcHMyUHda?=
 =?utf-8?Q?VgWQc2MPNxeOQGSH1M5Q3BtWk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e2f561-2987-4970-7d45-08dc6b2feebc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 05:14:39.5224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tG3ECq7pdb7axSgK/Oj0ILzJmLJsnDdHq3Oc7rV7iZhyXhypKTEz/d2qEGCPoVBB8yvnZWFmJ+MKtw4JeQZ0SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 02/05/2024 23:25, Alex Deucher wrote:
> On Thu, May 2, 2024 at 1:27 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch adds:
>> - A new IOCTL function to create and destroy
>> - A new structure to keep all the user queue data in one place.
>> - A function to generate unique index for the queue.
>>
>> V1: Worked on review comments from RFC patch series:
>>    - Alex: Keep a list of queues, instead of single queue per process.
>>    - Christian: Use the queue manager instead of global ptrs,
>>             Don't keep the queue structure in amdgpu_ctx
>>
>> V2: Worked on review comments:
>>   - Christian:
>>     - Formatting of text
>>     - There is no need for queuing of userqueues, with idr in place
>>   - Alex:
>>     - Remove use_doorbell, its unnecessary
>>     - Reuse amdgpu_mqd_props for saving mqd fields
>>
>>   - Code formatting and re-arrangement
>>
>> V3:
>>   - Integration with doorbell manager
>>
>> V4:
>>   - Accommodate MQD union related changes in UAPI (Alex)
>>   - Do not set the queue size twice (Bas)
>>
>> V5:
>>   - Remove wrapper functions for queue indexing (Christian)
>>   - Do not save the queue id/idr in queue itself (Christian)
>>   - Move the idr allocation in the IP independent generic space
>>    (Christian)
>>
>> V6:
>>   - Check the validity of input IP type (Christian)
>>
>> V7:
>>   - Move uq_func from uq_mgr to adev (Alex)
>>   - Add missing free(queue) for error cases (Yifan)
>>
>> V9:
>>   - Rebase
>>
>> V10: Addressed review comments from Christian, and added R-B:
>>   - Do not initialize the local variable
>>   - Convert DRM_ERROR to DEBUG.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Reviewed-by: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 121 ++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>>   3 files changed, 124 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b52442e2d04a..551e13693100 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2929,6 +2929,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>
>>   static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index effc0c7c02cf..ce9b25b82e94 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -23,6 +23,127 @@
>>    */
>>
>>   #include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_userqueue.h"
>> +
>> +static struct amdgpu_usermode_queue *
>> +amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>> +{
>> +       return idr_find(&uq_mgr->userq_idr, qid);
>> +}
>> +
>> +static int
>> +amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>> +{
>> +       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       const struct amdgpu_userq_funcs *uq_funcs;
>> +       struct amdgpu_usermode_queue *queue;
>> +
>> +       mutex_lock(&uq_mgr->userq_mutex);
>> +
>> +       queue = amdgpu_userqueue_find(uq_mgr, queue_id);
>> +       if (!queue) {
>> +               DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
>> +               mutex_unlock(&uq_mgr->userq_mutex);
>> +               return -EINVAL;
>> +       }
>> +
>> +       uq_funcs = adev->userq_funcs[queue->queue_type];
>> +       uq_funcs->mqd_destroy(uq_mgr, queue);
>> +       idr_remove(&uq_mgr->userq_idr, queue_id);
>> +       kfree(queue);
>> +
>> +       mutex_unlock(&uq_mgr->userq_mutex);
>> +       return 0;
>> +}
>> +
>> +static int
>> +amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>> +{
>> +       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       const struct amdgpu_userq_funcs *uq_funcs;
>> +       struct amdgpu_usermode_queue *queue;
>> +       int qid, r = 0;
>> +
>> +       /* Usermode queues are only supported for GFX/SDMA engines as of now */
>> +       if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
>> +               DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
>> +               return -EINVAL;
>> +       }
>> +
>> +       mutex_lock(&uq_mgr->userq_mutex);
>> +
>> +       uq_funcs = adev->userq_funcs[args->in.ip_type];
>> +       if (!uq_funcs) {
>> +               DRM_ERROR("Usermode queue is not supported for this IP (%u)\n", args->in.ip_type);
>> +               r = -EINVAL;
>> +               goto unlock;
>> +       }
>> +
>> +       queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>> +       if (!queue) {
>> +               DRM_ERROR("Failed to allocate memory for queue\n");
>> +               r = -ENOMEM;
>> +               goto unlock;
>> +       }
>> +       queue->doorbell_handle = args->in.doorbell_handle;
>> +       queue->doorbell_index = args->in.doorbell_offset;
>> +       queue->queue_type = args->in.ip_type;
> Validate that ip_type is valid here.
It has been validated at the entry of the function.
>> +       queue->flags = args->in.flags;
> Validate that flags is 0 until we actually implement support for the flags.

Noted

- Shashank

>
>> +       queue->vm = &fpriv->vm;
>> +
>> +       r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
>> +       if (r) {
>> +               DRM_ERROR("Failed to create Queue\n");
>> +               kfree(queue);
>> +               goto unlock;
>> +       }
>> +
>> +       qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>> +       if (qid < 0) {
>> +               DRM_ERROR("Failed to allocate a queue id\n");
>> +               uq_funcs->mqd_destroy(uq_mgr, queue);
>> +               kfree(queue);
>> +               r = -ENOMEM;
>> +               goto unlock;
>> +       }
>> +       args->out.queue_id = qid;
>> +
>> +unlock:
>> +       mutex_unlock(&uq_mgr->userq_mutex);
>> +       return r;
>> +}
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>> +                      struct drm_file *filp)
>> +{
>> +       union drm_amdgpu_userq *args = data;
>> +       int r;
>> +
>> +       switch (args->in.op) {
>> +       case AMDGPU_USERQ_OP_CREATE:
>> +               r = amdgpu_userqueue_create(filp, args);
>> +               if (r)
>> +                       DRM_ERROR("Failed to create usermode queue\n");
>> +               break;
>> +
>> +       case AMDGPU_USERQ_OP_FREE:
>> +               r = amdgpu_userqueue_destroy(filp, args->in.queue_id);
>> +               if (r)
>> +                       DRM_ERROR("Failed to destroy usermode queue\n");
>> +               break;
>> +
>> +       default:
>> +               DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n", args->in.op);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return r;
>> +}
>>
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>>   {
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 93ebe4b61682..b739274c72e1 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -54,6 +54,8 @@ struct amdgpu_userq_mgr {
>>          struct amdgpu_device            *adev;
>>   };
>>
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>>
>>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>> --
>> 2.43.2
>>
