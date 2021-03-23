Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDEAC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 11:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1793061920
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 11:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1793061920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C62CC6E8A4;
	Tue, 23 Mar 2021 11:38:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058E96E8A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 11:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7Vue09+d6gzSduDOA3c6LhIcHeODxJ7yEg+3C+nRfpgy6Dd8B+AEymczA/Oh75PncGP2fZewPVzSSGkmFzj4O9ihhSjdL5AHHLOLlqexAvA2Po6aDA/5WGahSvO/Oee6CqIp5IjE+6z5oIggiBGO7tLznCfnYV4uueEKu8Xjc5wady2ceBzh9wX8EPTT1ViXmbKs3vzB6pndUBr5+VF3nIR3lO64rMMfL8GrIfy+XtwS7r0bEuYJgGk6broWY+9Ozh7rpWtZaoROT3P2XqXpJRCJQNe49m/Ajuw7kqLnDonx3RLo+6HPFgzTMmgALnXS+PYcE7pCU5kiQamHkfS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0rOumEeJhB6G8vTOSim1/8YexOid2Riq3x+6/q40No=;
 b=Wmo4wUazYZMiZOdfJd0SLxdGraB1FPigYomEcixTRRmQ1BY3o+qrIS8WiRf/G/9Zf5ZpjmrPQmxxH+DOZqkolezY32tz8bLHLQ9KlbiTMMjJ+2NnqjxgxLM29C8YPXSYJaPijLLB/YTf4XhDbhcMbFIO8P/dz3/tNMHGdSYaLx5OjY4qVS1KIK4+tHnHBB+tKKZulx/RoL6r22ECBfPXfRKGzl0oGSQdXMIwZQazBaSrZg0Ii4RF3ePSbg/foKMnYzwxw7ClmQy4WqspjiJu1q9kTHdwKbvlXvl/mKXTCmXomouRx/ewXt55D3zRFoTDFbixJ2ZSWrlgy+LcS3nJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0rOumEeJhB6G8vTOSim1/8YexOid2Riq3x+6/q40No=;
 b=hFt27dc1lcxdTIgewAmduua2LoPnv3TPHxXy+Robs2HGXNrV8YEKWvX2A7wsX1pkd60HnxMBjmivnV/rpN2tlj7Q/NuuGQ9sT44JbALL+e47truK0yYlzm0MffattSod+x6dtkwbNoSCSK4rT7ssP7n56En/KRfHGnsF5HLeNNw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2479.namprd12.prod.outlook.com (2603:10b6:802:29::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 11:38:51 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3955.025; Tue, 23 Mar 2021
 11:38:50 +0000
Subject: Re: [PATCH] drm/amd/dispaly: fix deadlock issue in amdgpu reset
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
References: <20210322081138.3484804-1-Lang.Yu@amd.com>
 <3f417799-f923-7709-ddd3-823ec89126f9@amd.com>
 <DM6PR12MB425041FD84A4F69186FAB8B8FB649@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <aa1bbcd9-4ab6-6b23-0a6f-bde0b9948e9c@amd.com>
Date: Tue, 23 Mar 2021 07:38:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <DM6PR12MB425041FD84A4F69186FAB8B8FB649@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:dc0a:b3ab:a018:1fe6]
X-ClientProxiedBy: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:dc0a:b3ab:a018:1fe6]
 (2607:fea8:3edf:49b0:dc0a:b3ab:a018:1fe6) by
 YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 11:38:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a32f9125-5222-4967-a78e-08d8edf03ad1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2479F0492A0F2227C8C66639EA649@SN1PR12MB2479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4fhMCYCMHQqCgKZjJKaeqx+zBK+b89WgYH5ybhrYm2ot+ydUjMjljm3vV6jETelR7XMIUNdxX6oilV4IE3WPSfsfRNG6ua47cHdeUQkLwBxxGy7XdNpmDHCjQZK54lF/C34f606NVT8LOub5GX3C2aD16Z13sTcGQf3Qb79TKVkrctxv/3pQ1pPJixVSlB8+yvRtvH3aBB1iEdq9f4EmiQdA3hlAfE1Mml8p945CYKCPlo79cO1q1b40gfuQGIuUDDcU/NiJ6VwBdk2i0s4zr1lnxYAdTd3zNkiDiRYsCdEcIfgHcJbhUiXKu5FA87rqXNB/6dQUw++kh7OVrKKhEmHAQGzeNaR3oAMvb4azVvDutu0SbJsBb8dNkM5+8Ua2FCz1tlQRD00sS6YvsFVlpcB197ohAMSgYqftEf6bGix91KlAEzZY9KqDu7p9v6W5xin0gR2TLSdt+znf18InEqtV8F982KeKtoqJZSy4ubv8kyDhVyDJmLdHXNNNxmhqoBx1IS23tCgDoD5a3KRe64FoZkN2nK2LoVtntNKrDXqfFyp1N5RWfnN8aVZw+SUD9wCc+7KJTV7NqEFmnf9IUSI2cS1rbDKBcjhG2mAwKO1pdlUzy1azR67mUbqpSSDzv14MpB33Lr27I9R9V7evUl5zSmKqgU7eIHRSagHC/uD/b5zvgHHd388JZyPWYPXDNcOeiL976nSuVtpRcHYB+XY5+52guGrhwTsjm1dHDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(31696002)(38100700001)(86362001)(110136005)(31686004)(5660300002)(8936002)(53546011)(83380400001)(52116002)(6486002)(54906003)(316002)(4326008)(16526019)(186003)(66556008)(44832011)(2616005)(8676002)(66476007)(478600001)(2906002)(66946007)(36756003)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UXZ0ZUJ6M0w0UXdvWDRSRXM0Y0V2cGkxdHJyaDk1aWdzNjFyZnY5V21wUEhJ?=
 =?utf-8?B?Q3dxRW8xck1WK3hobWpBQS9WSFRhcnkzMFB5VHZQYi9rTE9xczg1UUFWaHpr?=
 =?utf-8?B?VXJDS3k1clNFVGtxWStHZGtXeEFXMmlVM2ZRZ3JiaGNwZ0NvSGwwNmRpamhL?=
 =?utf-8?B?eUN2NUUrVzZLWGJQWVZIRHpFSHBtWTBVcm9FMDY1bitDVStuUUxHdWlVbGpt?=
 =?utf-8?B?bEowemVXMlk2UmNpbXFiNDI1ZmVKRkcwQzRwZ0F0WDVvdG1rV2wvVTk4SzVE?=
 =?utf-8?B?YU1ZQktyYUtpREdJN3RhcW9sSCtRVVRobVVyUEVwaS9CamkzZ21sdjdrTnZ5?=
 =?utf-8?B?dnRpNHRHeHRxUkVTTFY4Q0NhdkFHQTU1Y1I3RE9zNUg5RkhjWmVyZHFad2dX?=
 =?utf-8?B?S0NjN0FDbTZvM3VtUWRRNnp2THhGeGRxVlNDSDdYZ1dGRDBLRHpoV3pOTWxP?=
 =?utf-8?B?MEczb09BdEdKbFdiMUh6UnFiOFhmZnhrbjRTdVVBVW9MNXI2dXlsbjEyNUVJ?=
 =?utf-8?B?OWNLN1pDTloyUC9IaFhnUjJsMlljeHdSK0R4YWN2dWpVZ3FONXRrME9SRFYy?=
 =?utf-8?B?ZmhEMDlRVVdsYUpxUVh0WWpVaFRIV1B6VURCbTNVd1FFZXZRTzdFdXJTUHd6?=
 =?utf-8?B?SDZsaFkzQXE2UjFJdG9RcEI0RE5nT3lmNWlEMlhmQmJ3TVZxYnc5VDh6aUhP?=
 =?utf-8?B?MHRjVWxnWUF4a1VRbGFwOTY1QlpPL2VXQ3pLVS90R3lLam1NdjZPaER6QWE5?=
 =?utf-8?B?eXU1bDJmRVFGWStJbWxtUjNJb0x0aXUzMGhXV3JnVFNoS28yS0tFclI5aG9o?=
 =?utf-8?B?d0RwTmhYNEppdUdaeklzQWw4cUNMMUE3RSt2dzNWbzd4bS8xSlhRbFNRSVB6?=
 =?utf-8?B?djJ4U0hHd0RqelVqTzNUa0ljbzBEcEJWdFBPWmVkZFFVSjQwU280TmFvRUpI?=
 =?utf-8?B?ajgwbUNUbUo1UUZ4QVdaRGZwektZOEh2YUc4aVFhNzBjYXNtcFVGdDBHS0VV?=
 =?utf-8?B?SDFpemNqSDlsUVpYOE04S1kvUnRiUnNndmhoV3NmUGRoT1F1QXR2NFQ2YkFJ?=
 =?utf-8?B?enMydFFoSFZoeFJ5WlNlMGFEZW52blJRdGFhTE91QWxPaEpWRC93Rk5PSmhu?=
 =?utf-8?B?NU1FSGZ0emwwRTB0dGVGQVozV1hJMGM2TmpyUm5JZ3pvRkZKQTVoWTNoTlM2?=
 =?utf-8?B?VFJRZURFSFVZc0pZSzFDTDZINzY4d2ZOU1BmSmdtd2VOaEIvb0l2dmdVS3pn?=
 =?utf-8?B?NDZqRk5TTVNNZmdrNUNLam9MejFOUGFGNjFYWXFZUU9mUThNb1dDaXlBL204?=
 =?utf-8?B?QTMrV29STWkxdmlvL1ZCbXRmZW9US3BpWXFwTkVoUUd3VXYwRENUcGROcGRu?=
 =?utf-8?B?RjZOd3BCM0l1ZHBQanJVdFh0R1JFZmg1eEp6UTBFdVpnNHk5MmZBUTFTTUJl?=
 =?utf-8?B?YnkwbFpzOG1vTit2SUpSZ2h6RHlHZXllamN5cGcwaXBJK0FZekFkWVpYdzFh?=
 =?utf-8?B?bDRVWVFnUmRsQkdqaDl2S2F1USs3TjV1ckFzT08xbzJhY1FvY0hkZHhzYWQw?=
 =?utf-8?B?QWplTlZjRGVJM3R6ZnN5NTRVWjZqWlJwUG5vV3dvSm9HZW5oN0xWd1lHeEJ5?=
 =?utf-8?B?Z2wveGJmU1NpYUExV09lYTgxRG8yYThMTHlrdHc4VHRNSWJlTURabzRXdmt2?=
 =?utf-8?B?RHNlRFhGOGlJOEV1LzhkREE2Tmp1WFQxbDJrdWNYTmt6TEF5endGd0NQTVZ1?=
 =?utf-8?B?RG9nUlByNFdaVmZtSzUxdlpqWmdtd0JIVVBUa1Btei96aThMd1ZLelRXRUx6?=
 =?utf-8?B?QmlGRHBzQmcvdjlDdkkrUGUwTGQvb01JMndxVGhZbUFXbXpNZi81NDdIc1g4?=
 =?utf-8?Q?DvpBhZ0S6c9SF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32f9125-5222-4967-a78e-08d8edf03ad1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 11:38:50.8896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX2gJ/gcq2D6w6PF6ar9P2zIVYS4eIm5gr+RTBboLXkxjfCrH7DoKFPiGoupxNyc1/j66RZuQWwEaw/ybuLaHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2479
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Harry and Nick

On 2021-03-22 9:42 p.m., Yu, Lang wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> 
> 
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Monday, March 22, 2021 11:01 PM
> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: Re: [PATCH] drm/amd/dispaly: fix deadlock issue in amdgpu reset
> 
> 
> 
> On 2021-03-22 4:11 a.m., Lang Yu wrote:
>> In amdggpu reset, while dm.dc_lock is held by dm_suspend,
>> handle_hpd_rx_irq tries to acquire it. Deadlock occurred!
>>
>> Deadlock log:
>>
>> [  104.528304] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
>>
>> [  104.640084] ======================================================
>> [  104.640092] WARNING: possible circular locking dependency detected
>> [  104.640099] 5.11.0-custom #1 Tainted: G        W   E
>> [  104.640107] ------------------------------------------------------
>> [  104.640114] cat/1158 is trying to acquire lock:
>> [  104.640120] ffff88810a09ce00
>> ((work_completion)(&lh->work)){+.+.}-{0:0}, at: __flush_work+0x2e3/0x450 [  104.640144]
>>                  but task is already holding lock:
>> [  104.640151] ffff88810a09cc70 (&adev->dm.dc_lock){+.+.}-{3:3}, at:
>> dm_suspend+0xb2/0x1d0 [amdgpu] [  104.640581]
>>                  which lock already depends on the new lock.
>>
>> [  104.640590]
>>                  the existing dependency chain (in reverse order) is:
>> [  104.640598]
>>                  -> #2 (&adev->dm.dc_lock){+.+.}-{3:3}:
>> [  104.640611]        lock_acquire+0xca/0x390
>> [  104.640623]        __mutex_lock+0x9b/0x930
>> [  104.640633]        mutex_lock_nested+0x1b/0x20
>> [  104.640640]        handle_hpd_rx_irq+0x9b/0x1c0 [amdgpu]
>> [  104.640959]        dm_irq_work_func+0x4e/0x60 [amdgpu]
>> [  104.641264]        process_one_work+0x2a7/0x5b0
>> [  104.641275]        worker_thread+0x4a/0x3d0
>> [  104.641283]        kthread+0x125/0x160
>> [  104.641290]        ret_from_fork+0x22/0x30
>> [  104.641300]
>>                  -> #1 (&aconnector->hpd_lock){+.+.}-{3:3}:
>> [  104.641312]        lock_acquire+0xca/0x390
>> [  104.641321]        __mutex_lock+0x9b/0x930
>> [  104.641328]        mutex_lock_nested+0x1b/0x20
>> [  104.641336]        handle_hpd_rx_irq+0x67/0x1c0 [amdgpu]
>> [  104.641635]        dm_irq_work_func+0x4e/0x60 [amdgpu]
>> [  104.641931]        process_one_work+0x2a7/0x5b0
>> [  104.641940]        worker_thread+0x4a/0x3d0
>> [  104.641948]        kthread+0x125/0x160
>> [  104.641954]        ret_from_fork+0x22/0x30
>> [  104.641963]
>>                  -> #0 ((work_completion)(&lh->work)){+.+.}-{0:0}:
>> [  104.641975]        check_prev_add+0x94/0xbf0
>> [  104.641983]        __lock_acquire+0x130d/0x1ce0
>> [  104.641992]        lock_acquire+0xca/0x390
>> [  104.642000]        __flush_work+0x303/0x450
>> [  104.642008]        flush_work+0x10/0x20
>> [  104.642016]        amdgpu_dm_irq_suspend+0x93/0x100 [amdgpu]
>> [  104.642312]        dm_suspend+0x181/0x1d0 [amdgpu]
>> [  104.642605]        amdgpu_device_ip_suspend_phase1+0x8a/0x100 [amdgpu]
>> [  104.642835]        amdgpu_device_ip_suspend+0x21/0x70 [amdgpu]
>> [  104.643066]        amdgpu_device_pre_asic_reset+0x1bd/0x1d2 [amdgpu]
>> [  104.643403]        amdgpu_device_gpu_recover.cold+0x5df/0xa9d [amdgpu]
>> [  104.643715]        gpu_recover_get+0x2e/0x60 [amdgpu]
>> [  104.643951]        simple_attr_read+0x6d/0x110
>> [  104.643960]        debugfs_attr_read+0x49/0x70
>> [  104.643970]        full_proxy_read+0x5f/0x90
>> [  104.643979]        vfs_read+0xa3/0x190
>> [  104.643986]        ksys_read+0x70/0xf0
>> [  104.643992]        __x64_sys_read+0x1a/0x20
>> [  104.643999]        do_syscall_64+0x38/0x90
>> [  104.644007]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  104.644017]
>>                  other info that might help us debug this:
>>
>> [  104.644026] Chain exists of:
>>                    (work_completion)(&lh->work) -->
>> &aconnector->hpd_lock --> &adev->dm.dc_lock
>>
>> [  104.644043]  Possible unsafe locking scenario:
>>
>> [  104.644049]        CPU0                    CPU1
>> [  104.644055]        ----                    ----
>> [  104.644060]   lock(&adev->dm.dc_lock);
>> [  104.644066]                                lock(&aconnector->hpd_lock);
>> [  104.644075]                                lock(&adev->dm.dc_lock);
>> [  104.644083]   lock((work_completion)(&lh->work));
>> [  104.644090]
>>                   *** DEADLOCK ***
>>
>> [  104.644096] 3 locks held by cat/1158:
>> [  104.644103]  #0: ffff88810d0e4eb8 (&attr->mutex){+.+.}-{3:3}, at:
>> simple_attr_read+0x4e/0x110 [  104.644119]  #1: ffff88810a0a1600
>> (&adev->reset_sem){++++}-{3:3}, at: amdgpu_device_lock_adev+0x42/0x94
>> [amdgpu] [  104.644489]  #2: ffff88810a09cc70
>> (&adev->dm.dc_lock){+.+.}-{3:3}, at: dm_suspend+0xb2/0x1d0 [amdgpu]
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index e176ea84d75b..8727488df769 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -2657,13 +2657,15 @@ static void handle_hpd_rx_irq(void *param)
>>    		}
>>    	}
>>    
>> -	mutex_lock(&adev->dm.dc_lock);
>> +	if (!amdgpu_in_reset(adev))
>> +		mutex_lock(&adev->dm.dc_lock);
>>    #ifdef CONFIG_DRM_AMD_DC_HDCP
>>    	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
>>    #else
>>    	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
>>    #endif
>> -	mutex_unlock(&adev->dm.dc_lock);
>> +	if (!amdgpu_in_reset(adev))
>> +		mutex_unlock(&adev->dm.dc_lock);
> 
> Why is it ok to stop locking if in GPU reset ?
> 
> Andrey
> 
> If stopping locking in GPU reset, GPU reset works, though it's not safe.
> If locking in GPU reset, deadlock occurred, GPU reset never works.
> Display guys should give a perfect fix. It has been blocked for a long time,
> it's time to take some actions.
> 
> Regards,
> Lang

Harry, Nick - In dm_suspend, would it be possible to drop dm->dc_lock 
before calling amdgpu_dm_irq_suspend and then locking again ? Problem
here is that amdgpu_dm_irq_suspend is flushing hpd_rx work while holding
dc_lock but as far as I remember you only need to grab dc_lock when
operating on streams and  planes/surfaces and I don't see any of this
in amdgpu_dm_irq_suspend.

Andrey

>>    
>>    out:
>>    	if (result && !is_mst_root_connector) {
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
