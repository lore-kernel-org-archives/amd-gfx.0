Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE70EC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 21:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B08310E7CA;
	Wed, 13 Aug 2025 21:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RIsFnHFU";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A74710E7CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 21:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvZSNDOL3KsCYCVSVYtHVVAkiOFjy6ki+6PTv0wFnnCpHcbC38aDETeDxIc/5gYdG8VdU5VEuFG4EwsCGzUIhGpsMherEG8nM0LCq0YHf1pjjPHJA4LCirYXnlVleqSWJaieME8psqSLIUOJjxij0Va2AWkJZWmNl1prCTTK6tAL/VaZE1Wy5bliAldjE/9e1YB6znYpIPRXNgCilYwZlOclSeNLAk0fACTtsZB+PZqVA9qH/OSUaQFByYiWB/H5xZkkGyA3vfdcPAJpalH2SP/thwyiDQ/bZZanpMXZbcsORShrX+SEL3nw+tp80EadPxuUtovLWsUHQudpf+tuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt62eO/el8mTk9BHxBXRcE+8BQxCzKws5sUNOMyjooc=;
 b=fcMgegX8QQ8teGvDSL3mVFj4gXd+sVJx/Q0RF+SysgJ+zyYHBzZBpfnVjFYuJ/HD1O/sqNa51ryjYMgrcMGmqbO0Xi7s2g+aRTXGDmVLbi+oFFH4OzszLjnt8KrV12P9kJ/UU+bF03L+Ha3Nh/a9seMxAuqOBxvb8xUvLqPzaJlXrea55ZYXDyZ2ab6xGZV0XHSoYR7rbpxq8hntCHg4RgTCHhxux8/XyOQ+Rjg+8AvKIwmNUa5C6S4pQ1Brq/5rNeD7dSJMh1ZpOFZOZZrUeUO4hzZvUfhjNnF7m2hs9UrE35gfy+v95TMgOq/V/ezT1wkZNTFTyqoLpNAbzVkNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt62eO/el8mTk9BHxBXRcE+8BQxCzKws5sUNOMyjooc=;
 b=RIsFnHFURtacQpqiVIWKEGb9fxkhqNO+E7pYbaLMuChYiNQxRRnGCHQdTh/Nw2TLCCoaz5bfm/wo48dUyJ4X2GFtzzzC46aMYY+L7W6x4Luat9CYGd0ZwVDlyVfYJIfW7IAr06OwP3biSfBh7c6B5gsJc4Uc3Jteeua5mlE/kcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 21:16:06 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 21:16:06 +0000
Message-ID: <376e6482-7319-426a-3d67-994b9581c678@amd.com>
Date: Thu, 14 Aug 2025 02:46:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Wu, David" <davidwu2@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::14) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb6b57e-26ed-490d-3008-08dddaae9da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2tkajZWeWtWb2VNT3NieDZaTkpLeVJBNjdQNmtDV2Jlcm1FaGJ5QzZmTkc3?=
 =?utf-8?B?NVVON1NNZCtheklBTE5sRm5XTkJlMXZRcVNJVzlmWlVkVWJvTXFDQUdhMER2?=
 =?utf-8?B?eSs0eVR0NXJwekdGTnZkeUtHMmhUU1N4ZDFiRTN5dHQ2c0dJZEVUaTlwV1R6?=
 =?utf-8?B?M1FKZTB3U24zTlBrYWFlZEdCdm1Ub3g5c1YxOFV6TDdOUElLWjQveDJ3L29k?=
 =?utf-8?B?ZUY3QTNEb2paODF6TE5ZRSs4YTNRcU9TSWcrZEduSldJck1Nb2paRXcxT1Nu?=
 =?utf-8?B?ZmQwYXF6aGRtblVXQXRQeVdZRlRzbVBXQkFScmdWRWhpK1FKclp2TE1ZZlgr?=
 =?utf-8?B?dyt0N1l1SUswMVh1R1ZJdXJ5cjkwUVdwZ1ExNjZyNXlFK0diekp2OGFXbkQy?=
 =?utf-8?B?VWE2T0Y0MVh4SE1DQ0h5dFIxbUNMaXBNSTd3ZEU4STNETFJpdVkwSStmVkRZ?=
 =?utf-8?B?d3NJS1Z2OFBVT1k3YzRvdmkrWU9Wb0xqWElQM3RkZkMyMVF3cFpEZy9YdFBP?=
 =?utf-8?B?ODIrTCs0TzhURCtZRjBzRnhhdWNBaHU4UUFXZFNsTlZBQ1lWakFPc2c4aHVK?=
 =?utf-8?B?ZHppVWcwSXdmR2FHNjVUOEN1SEtVRzhhbzlpNXJsaFJpNDlrMEhGUUxEd2k4?=
 =?utf-8?B?WnlmVHdvL01aNnUrMFIrTG9YVnIvNWlJOEJYZXQwYlFnWVlycFcvR0pNVzZY?=
 =?utf-8?B?L1d4cFhNbCtWU0xGS2pDaENZc1BIbm1ISnBuMkVnaWpPYnFqdE9BMlFVUVN4?=
 =?utf-8?B?aWtCUW91emJnd3JuUTU2RkUrYkhXOW9oR2ZjS3Qwbld5WEcrUzV0MGxZb2Mz?=
 =?utf-8?B?YmFoWi9KaDJxSktPZHF0Y2haeEtqN1FCVW9nd2VSVEQvbWZxTER1eER1czBU?=
 =?utf-8?B?eUxlTnVRMTI5SjB2TVEzdmRzN2h5eFVIRzEvZWR5ZXI3YTBVUVdIV3B6YVl6?=
 =?utf-8?B?STRzM21JWUxtYTBsR3FmUUtjSGg1VFhmVklGNklRNFA4WjU2Q21GQ2JKbUVv?=
 =?utf-8?B?M00rYVl5d2syZ0JscHB6QjJZUTZMalpkbXl4eHhWWWxQYjNSR1dieHVsaERa?=
 =?utf-8?B?dUd0ZndDbzhVeHpsSG1MTGY0WlYybFkyZk84R2wzT1d2a2hJLzVmTlVKNjM3?=
 =?utf-8?B?aXJvUDM3dUlBbWZLaFNmMldpZE4vWUFzeXdEYU0rb2ZtcU1HNk1GL0VKYzh5?=
 =?utf-8?B?enVmWWdUTVZ3eXNpQ2s0bTlBelpLTUUxUFNVRnA0bitsakhGOUFmQ3RvZW94?=
 =?utf-8?B?UXlQdVZBcUg5UWpNQWJuamYwbTFuWS9nYjRSRHRJTkdjdXpzajczM0VFT1M3?=
 =?utf-8?B?dlF4bnd6RTM1U2pZdjNPMUFYZDRONU5reUg4Mnhsd3dQYnRYcXpyS3dlYW1k?=
 =?utf-8?B?QXo4R2l1K0h5ck1obkxKRkhBOXd5dmx2bjRGYjg4VlpUbjFKTXhHbGJkYjFC?=
 =?utf-8?B?WTBzTU9KTERsY1ViSTBXVExGZXFNdnA1MUJBS2JqczNIS3JkS0hxVTRoUW9w?=
 =?utf-8?B?SWRsTUJLYzZXaTY2WTNFNk9qU3lIdFA5UnJOejJjaEpNQWkvQy9sVEZvb3Mw?=
 =?utf-8?B?Yy94TG9oV2lvQ3g5blIzUzc5Q3lDUHRpRXFjekJNS3VieVd4bTZLSnVYZ2h3?=
 =?utf-8?B?YlhCMTFtei9sT0FLZUdIOS9qWnZkeFBpckcxK0xtZ3IyUlZWbE5ra0thOTIw?=
 =?utf-8?B?Sm9HcTRUdUF3bWhRV29wYzVieHZTS2ZiVDYxT1gxR3FuQ1F6MVROSXlZTmQv?=
 =?utf-8?B?blhKclVxLzF2Mk1ycjg4Qng0Yk1JTHNPVHI5a0ZsL0VyTHR5Vm5HQjhGdzBS?=
 =?utf-8?B?NVFFdk1ldm1YQnFRNlJiYkVVbWxxUHBqVTFtSGNlWXIrb2pta1NTaC9mMkNh?=
 =?utf-8?B?YnlmVGdFTjVpaXc1bzRobGVMenZZRjBwNUNWa25OaytZcHhKQVA4bzNNS0h5?=
 =?utf-8?Q?TV7xoeAydKM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9wZWpjeUJHOTVlakxQUnlsTmdZUEtVUHFlWlZpZ2RvY012K0EvQWZ2TEU0?=
 =?utf-8?B?dHdiSmV4N2lSWDg2c1Y0TytYVUV5dStmeW1Za1UzVUZldm11QUswamVwLzBV?=
 =?utf-8?B?R2VxdWNLM0tyc2p5dmk2MSt0M0pSSWcra2d6bFp1QWtYbys5cHFkNkV2U1ht?=
 =?utf-8?B?bHQzVWtrTm0rNUQ5WGZCU2l2U0h6UFdxdFZmcnRSdHFIbjlKMEl2YTNYUTk2?=
 =?utf-8?B?MUZLOUczQ2prZFhaVk5VeWxrVlJ3NWV1ajVMalZidUdCUkRQY3dNVDIrSnRn?=
 =?utf-8?B?M0lqTE9UUDQ0VjRLaFVoc2E2U3hWNDUyNnBYamhSVUVpV1VUZnpTU0xSOG1o?=
 =?utf-8?B?azZCOHRqZWZzMkkvemxBajArYnAxWG5TSXd4YlpFblRZNGtLK2xENE4wNFNV?=
 =?utf-8?B?S1VVQW1rd2l3MlJrUVFCUmdHcW1Hc3dWd3k1V2l5NFJNbUR5dWZRZ0VPa0pl?=
 =?utf-8?B?dngxdmVXeUY0ckY0NnVNYkFBZVdnYitmSk0wSDAvaXhvUUhxSmY5MTl4dEJR?=
 =?utf-8?B?aHcrSXUycU5ZTzN5UjgwYklRLzJqRndFbDRpU2RBTzhTSXc1ejFUMWg1UWZT?=
 =?utf-8?B?QWtDY2JLZVh2M3A1WW0xMHNzcWZwME9YR3F2Qkh5dGQ5a2hHYkNjekZoU0xq?=
 =?utf-8?B?UkZCL0JlWXp3YWtDY0pwNFh2RGE2MXNMTU16cFVHaUtaZ3FPbjFudmkwaE54?=
 =?utf-8?B?dXNpS0FtS3NsVWRGQllVcVgzS3htOUdLN0Q3b2s0U0hSRTRkUnBRNTlKbmhu?=
 =?utf-8?B?M1F1ZG9MOGFYaXNnYzY0K1Yxa3M2dTJXdDE1ZVBNQ3NhdWM2MXd4ZjBKUzcy?=
 =?utf-8?B?bHBZZXk2M3NFZWpFeHA3cjRkRUVDcW5WT0xRNHdsRnMxUi9aVVZSNHcwWTZl?=
 =?utf-8?B?VHNEV21jdlZ4TVZIV2RaK09pbkJ2MlBaWmFiQzM2emVMZzBDZEIvZEJSUGFa?=
 =?utf-8?B?LzV0VXgxNEpGc3hKY1AvTEdOTzlmYWg2YWZuMHBrTFQ2UDg0dWhwQUI4QkQ2?=
 =?utf-8?B?eGkyeEhJRHFqbXVqK3p0MmtBbFhEVnNERFBQL1F4RXkrY2RTRllyb2FlZTMz?=
 =?utf-8?B?RDJYclZKaUJHWHpuM1FSek5oQ0pEK05LQnJWQ2kwUWMrSkY1Z3FEVVBhKzVW?=
 =?utf-8?B?alo5azBjOU1ndGJJOVFFNkMybU8yV1haN3AyTXpXNWhnVVZnVW1pRVVvVld0?=
 =?utf-8?B?MHlkWGJmWkRsazJHMTI3aGlPMktmbDAydWJwQUZEbENmd2VNaGdpRk5oZVZV?=
 =?utf-8?B?dmZ4VXE4cUpWb3RsTmo2YzFWc25keWZ0Tms2Z3JjTzJBajU2U2E4VmNLU2hx?=
 =?utf-8?B?OUVJWGxIbmlnQUw5TnZWdkdQYTJseU1oUUhlTmg3Tm5ndm9aOE9rOGRzUzhR?=
 =?utf-8?B?ZTV4UFVRRXdDd0p3YzZGTWdXNjFaeEdkQmlqZnlNMzNrbXlQMUtVMEtFY0lt?=
 =?utf-8?B?NXBlRmlhUjAwUzZQVXBVMy9KUk1ZTUUxZ1hDZFNpZ0VSY1d4ZGlWbDlOeXhQ?=
 =?utf-8?B?S1pVWWNsWC96RVRScWtpYndtUmhOaXp4amtJeVJMUjBUVm9sNWNmbU1zUFVO?=
 =?utf-8?B?OCtXUTFmSXF4QnNUKzBJeXBVdnR5dm9uTHNxZ2thQjZ4OG1tdmR0SDc3c2Rk?=
 =?utf-8?B?R1o1RklpSDFxdGtUTDZyc3hoWHFOZW9YcUFtNzg0U3l2Vzc0NERpQklZb3NH?=
 =?utf-8?B?Ykhka2FRaS82b3ZFV0REbEVzeU9zSWczQ2ZNa0Z5TjdpVFlVQUhQdjBDMkEr?=
 =?utf-8?B?Y1M5TkVXaUJ1aHBDa1NOWFJPNUlDNnRhajE4WERmczhpeWtZL1lPWEhKUjNh?=
 =?utf-8?B?MlVxTVhlSzhNb0lIL0xRRy91OGdRZ3IzOHpHeTVPVXo0MkpBc0R6SFdWOHhH?=
 =?utf-8?B?dDFLQVgyYlU4V1dUZ0VYOEd4NU1MdlIwK0tiQjFTckpiSlZGNTNScCtZLzg2?=
 =?utf-8?B?MkhJK3dwdm5qR01VM1RNV2w5MzZqVmZQa3B2R2ViNW9FbWRlZXFSTGpUK1Jp?=
 =?utf-8?B?bVFreU9GUlg0R1RHaS91cERDME0xcFF4OXZqWVlqTHJialBVb1F5RU5UNTcr?=
 =?utf-8?B?UWp2emxkQWNzdG9lWjdUYlpobjVSem5oZkkyWmYvOVpqQjl0ZkRvWXhvVThB?=
 =?utf-8?Q?AokIE/dDUZbv1MbI1vwGKwv1O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb6b57e-26ed-490d-3008-08dddaae9da6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:16:06.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkwFqetjPpDrfOwi/U4p9t/aIds3F6mYWTUV/bjq9P3DyjgO9S6Trxzth1KXIq/dJVgvIZ8My0Et8oa2pyF2nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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


On 8/14/2025 2:33 AM, Alex Deucher wrote:
> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
> <sathishkumar.sundararaju@amd.com> wrote:
>>
>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>> Hi Alex, Hi David,
>>>>
>>>> I see David's concern but his suggestion yet wont solve the problem,
>>>> neither the current form , reason :-
>>>>
>>>> The emitted fence count and total submission count are fast transients
>>>> which frequently become 0 in between video decodes (between jobs) even
>>>> with the atomics and locks there can be a switch of video power profile,
>>>> in the current form of patch that window is minimized, but still can
>>>> happen if stress tested. But power state of any instance becoming zero
>>> Can you explain how this can happen?  I'm not seeing it.
>> Consider this situation, inst0 and inst1 actively decoding, inst0 decode
>> completes, delayed idle work starts.
>> inst0 idle handler can read 0 total fences and 0 total submission count,
>> even if inst1 is actively decoding,
>> that's between the jobs,
>>    - as begin_use increaments vcn.total_submission_cnt and end_use
>> decreaments vcn.total_submission_cnt that can be 0.
>>    - if outstanding fences are cleared and no new emitted fence, between
>> jobs , can be 0.
>>    - both of the above conditions do not mean video decode is complete on
>> inst1, it is actively decoding.
> How can there be active decoding without an outstanding fence?  In
> that case, total_fences (fences from both instances) would be non-0.

I mean on inst1 the job scheduled is already complete, so 0 outstanding 
fences, newer job is yet to be scheduled

and commited to ring (inst1) , this doesn't mean decode has stopped on 
inst1 right (I am saying if timing of inst0 idle work coincides with this),

Or am I wrong in assuming this ? Can't this ever happen ? Please correct 
my understanding here.

Regards,

Sathish

>
> Alex
>
>> Whereas if instances are powered off we are sure idle time is past and
>> it is powered off, no possible way of
>> active video decode, when all instances are off we can safely assume no
>> active decode and global lock protects
>> it against new begin_use on any instance. But the only distant concern
>> is global common locks w.r.t perf, but we
>> are already having a global workprofile mutex , so there shouldn't be
>> any drop in perf, with just one single
>> global lock for all instances.
>>
>> Just sending out a patch with this fix, will leave it to you to decide
>> the right method. If you think outstanding total fences
>> can never be 0 during decode, then your previous version (v3) itself is
>> good, there is no real benefit of splitting the handlers as such.
>>
>> Regards,
>> Sathish
>>> If it is possible, maybe it would be easier to just split the profile
>>> and powergating into separate handlers.  The profile one would be
>>> global and the powergating one would be per instance.  See the
>>> attached patches.
>>>
>>> Alex
>>>
>>>> can be a sure shot indication of break in a video decode, the mistake in
>>>> my patch was using per instance mutex, I should have used a common
>>>> global mutex, then that covers the situation David is trying to bring out.
>>>>
>>>> Using one global vcn.pg_lock for idle and begin_use and using flags to
>>>> track power state could help us totally avoid this situation.
>>>>
>>>> Regards,
>>>>
>>>> Sathish
>>>>
>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>> Hi Alex,
>>>>>>>
>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>>>> The suggestion of moving it inside the lock (which I prefer in case
>>>>>>> someone
>>>>>>> adds more before the lock and not reviewed thoroughly)
>>>>>>>      - up to you to decide.
>>>>>>>
>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> David
>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>> If there are multiple instances of the VCN running,
>>>>>>>> we may end up switching the video profile while another
>>>>>>>> instance is active because we only take into account
>>>>>>>> the current instance's submissions.  Look at all
>>>>>>>> outstanding fences for the video profile.
>>>>>>>>
>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>
>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
>>>>>>>> handling")
>>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>> ++++++++++++-------------
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>      2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>          struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>                  container_of(work, struct amdgpu_vcn_inst,
>>>>>>>> idle_work.work);
>>>>>>>>          struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>> +     unsigned int i, j;
>>>>>>>>          int r = 0;
>>>>>>>>
>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>                  return;
>>>>>>>>
>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>> -             fence[i] +=
>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>>>>>> +
>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>> +                     fence[i] +=
>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>> +             total_fences += fence[i];
>>>>>>>> +     }
>>>>>>>>
>>>>>>>>          /* Only set DPG pause for VCN3 or below, VCN4 and above will
>>>>>>>> be handled by FW */
>>>>>>>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>                  struct dpg_pause_state new_state;
>>>>>>>>
>>>>>>>>                  if (fence[i] ||
>>>>>>>> @@ -436,18 +442,18 @@ static void
>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>                  else
>>>>>>>>                          new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>>>>>>
>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>          }
>>>>>>>>
>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>> -     fences += fence[i];
>>>>>>>> -
>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>                  mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>                  vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>                  mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>> !total_fences &&
>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>                          r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>> false);
>>>>>>>>                          if (r)
>>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>> amdgpu_ring *ring)
>>>>>>>>          int r = 0;
>>>>>>>>
>>>>>>>>          atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>> move this addition down inside the mutex lock
>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>
>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>> -      */
>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>> -             goto pg_lock;
>>>>>>>> -
>>>>>>>>          mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>> move to here:
>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>> I think this should work for multiple instances.
>>>>>> Why does this need to be protected by the mutex?
>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>> David
>>>>>> Alex
>>>>>>
>>>>>>> David
>>>>>>>>          if (!adev->vcn.workload_profile_active) {
>>>>>>>>                  r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>> amdgpu_ring *ring)
>>>>>>>>          }
>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>
>>>>>>>> -pg_lock:
>>>>>>>>          mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>          vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>>>>>>
>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring
>>>>>>>> *ring)
>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>>>>>>>>
>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>
>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>                                VCN_IDLE_TIMEOUT);
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>
>>>>>>>>          uint16_t inst_mask;
>>>>>>>>          uint8_t num_inst_per_aid;
>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>
>>>>>>>>          /* IP reg dump */
>>>>>>>>          uint32_t                *ip_dump;
