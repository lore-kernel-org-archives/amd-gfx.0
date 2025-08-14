Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E23CA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 21:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB64010E120;
	Thu, 14 Aug 2025 21:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3hjupCg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2360210E120
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 21:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+E70jDtUogPihawppOMdcFoCFWUY14axg3hXynQojEW9+10YCms90OKpeO7gfHkx92MBGYbQpyVc3J8EzWRt46Cw42q43rqA21drMkaXWOyhqqVgf52WWD2KYOJYScBa6WAga1H/ts8f5O9V/9vOFycZR4aNsly4Fc/XE3h/vPRIKjyA8vrMIcte4S8ozPPe4UeXYpe+zSn7zOwK/2uib/onJjRHRVAdzGEIMlOPA1rqUx0wiEJdqjj2fjmRWYMopt3Dz7V9j0Z2QaebGm5kDE0YnKmL1lNOCET+mtA45KCYFBl0KTfqBg0cWV7jmu9SFH1cAg2ZYuvfnw1gQWxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNnizcAq5oCm5pwNArm45u1rSpmy9ZurO5eAF3GFr8U=;
 b=rlVw6MBlCgg1H+FUphD19cbS8k6OkijBswYKstrFE9tqCcnI8soY78r91No/uLqU6r1hk+BT6KFW3lZpshnu7Et3b3B760RuFywhbuHRFCLZ9OA02axTMnC9y2CivQImbU9xGXbeJysFbvhikcAll99nTycRRYX0Y+Ri163kSyvhPPLzA7ZTL90Ty7u7wzuE1BPW7po0cCslE2PL+aa35GCtioKTw/jrm1+tK88DbyCzisEmI1NnRZtBBmYRpoi3899h6lck86cAsYj1dBy5+VIt37ZjMYtClkIRlTLpVhGkgXq3eNGGPa7EysoCBlukDstZ0TGL2cd8ezivP2lPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNnizcAq5oCm5pwNArm45u1rSpmy9ZurO5eAF3GFr8U=;
 b=q3hjupCgPC3grs8f+iYcFuW2e3lzFEBiml5T+hC7YXXGRbF/uC2yYTCen7c2eJeSw51QonCx+DaApJHGY+nri5pfP0t7sbF9vvf4CrVeVJkVrZR2iWfnqCmouD+peT2PfVwXJsPrXByT4B/dUJICu4rcrxtuc4a0lPDno7fPx6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 21:39:51 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 21:39:51 +0000
Message-ID: <f1827014-8450-4f36-84f6-bf6a2e8ac822@amd.com>
Date: Thu, 14 Aug 2025 17:39:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <85af1027-5a09-40ce-987e-9f4ad8fe2b5c@amd.com>
 <CADnq5_O2gnR8GtAaL-937R97Kwtb50QNh+Y3V_TzsLGLbT8CLQ@mail.gmail.com>
 <ad01beb5-e17c-4ace-8707-4cd5f52de2c8@amd.com>
 <CADnq5_Of2gkZoyE9V-3ySEMvc20sVG9S8rz8x5uRLCX=OEnnvw@mail.gmail.com>
 <7a8991f7-1eb7-4307-ac72-1281a50bf4d5@amd.com>
 <CADnq5_NutFtDzq3xwcfLr6dHtWaEKDwV5-kXrDpNBCM2DjWb-Q@mail.gmail.com>
 <04e0a9f2-d8ea-4383-8fb6-b7422d6f9ff6@amd.com>
 <CADnq5_M5GGUMmpnVD39i_6K0NJKsXVrbqbRiWjby-NRcZeY7yw@mail.gmail.com>
 <31283d92-805f-49a2-a0b2-20146b79354b@amd.com>
 <CADnq5_OH9Jpkfm0b2keQRO6Wx1nj-dGfFs5mvkfQ83ZC3ox5xQ@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_OH9Jpkfm0b2keQRO6Wx1nj-dGfFs5mvkfQ83ZC3ox5xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::30) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: d521b30f-208f-4c81-ef51-08dddb7b1963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWFJRWhndlZnL3dod1gxNFJySmxCTU01Yk9YTkgwSVdhNHd5MVY0a3NwUEQz?=
 =?utf-8?B?L1V5dHVydHRMSVVNMDh3T0MvMndnRlMxQ1pIN0p1ZkpEVUF4ZVY1RmJHVWdl?=
 =?utf-8?B?RXBONnREcjZsTStHQ29nNlRaMm83L1RtVnB5RkhKYjZSeGZJSXRuNFJxK0Vi?=
 =?utf-8?B?QjVwK0w0YitkNlUvM2hTWE00QXZaYWlNZU5JWVo3VFNJU3g2OENRZHlIUWVO?=
 =?utf-8?B?SzZvdm5IL3VXWXZzdmFtVVJaQ2orSEtRenV1ZHlHekd6WE1aWDJObE9LZHdt?=
 =?utf-8?B?eXRWaWRBcUZtVXpmODZUeEdoRkluRDAvTmJlRm16MDRLWEZacGFVODRNNHBj?=
 =?utf-8?B?aFBYL2RrN09lOVhsMkh0NnBhSjZhTlU4K1pEQjFSRzkyMTVIQXFaeWRxVWxM?=
 =?utf-8?B?Sm1Uc1drSGlJUi9tRE83bUlXOTg5TzJvck8vaEJJcXFwWFl1aU5oTkxGLy8x?=
 =?utf-8?B?R1Rvb0Z6YU01VHQvWUI4YUorbEp0MzB1ekl2byt1VVRSY0VLNldEa0w3a0JS?=
 =?utf-8?B?OG5Tc01uK1Bxc1U3SWk5bU42WlVrZndQay9vMjRkVmloSXduNmFoZGM0UzYy?=
 =?utf-8?B?UFIxU0pPUnptOGNCWTAvckU1elJ3bExvTVN6VDg3bTVDRDcxcGV1TzFCaVVG?=
 =?utf-8?B?V3RndThKeHB3NnFMYzZpR1ZaRXdObFFnYWZUVitzVG1uV2ppMWRzZ3FPOTVZ?=
 =?utf-8?B?ZGRDQjVXOWlRRFphek9Wbjg4aUcyRUEvd2NPc09oVlRQMnhJbnF0RFNtTm4w?=
 =?utf-8?B?RjVUeHFmNkNYNERoM00wM0VnaU9oQU9ScFFjZ2FNUnE5a1dSQkplUGpGNSt1?=
 =?utf-8?B?Y2ZNcWJjT0VXOUI1ZGhLZDlBOThHYklvY2pLZTZJcm1pUUFVa3JzZDl6N0NO?=
 =?utf-8?B?NHZRVmFWR3g0eENYbmJOOE1zd3hiUmV3MEJvQ3UyT2wySDk3VktvWTZ4Y0J6?=
 =?utf-8?B?a0t6UDA0SUgwbUFpVlE0ZWRYUzIwVjQvQitlczVsNFBWZERiRnM2Mmlvc0Qr?=
 =?utf-8?B?azZkSjA5MkF2ek9ISTE2b0NjaGYycGcybnlqTUR1WFo1TkJ3UFZHQjJKQ2tJ?=
 =?utf-8?B?Q1RJZVUwWG5WL05Lc0M5TE5vcmFHMG8yQmtqajJGUU9aak9sRWxrQWdzaW1K?=
 =?utf-8?B?Qk5yVUlhMFZ4MFJ1bG0wMm16bll3Nms3V3NXWUJ2K0g4ZFhtNzlaelYxQ2V1?=
 =?utf-8?B?Qm5HclM3Y2xpNmh4ejhGNnRJWEltbW1ZRU54WW5TNDFpeFNBSHJrSDBXdncx?=
 =?utf-8?B?OGlkM2k3bGQ2cjhCNVNpWWgxRHF2WDlFU3R0c3VJU1ZIbE0zTkcyTXRqd0d4?=
 =?utf-8?B?R0VSWDUrTzBubWJ1ODE5STBCNEtoUWgzQVJEVU42SGZ0WmNwT1I2a1ZIbStr?=
 =?utf-8?B?TTFxRDVLSkpJdTBxMWYxWlhYWWFDQ3Q3MEpKdHRENjJEcHo3WHVFR1hnR25U?=
 =?utf-8?B?aldpUUFtSElnbGh2YTdYdWRKRXBvVXJuZTcwUG1nNlZ1Uk92SGR0VTdkRWhV?=
 =?utf-8?B?ZzM5Z1JpVk45MW9kYnU1YnJJV2VNSiszenV4b3piaDhnRFRGcWN1eG1JSjFx?=
 =?utf-8?B?Q1M2R0dZcFo5c3BtWWc0OUNMTTIyWi92cG5xYUZENG1NdHdBZi90SVV2UDVG?=
 =?utf-8?B?V1V0eEJMcE5aOXVodlFzdldtQ05tQVRvSWpYVUxON1QrK0pCem1LS2FmY0s3?=
 =?utf-8?B?ejg1ek45eVF2cVEvaVptN3RLeVFsbjllSmpYQUtsbHQvMlJ2Y3FtVStLQzAv?=
 =?utf-8?B?TnRiek8wdXQ1K2RTcnc1clRubGdpR3UrSEgvQkdoU3lPZmVMZThvc3dWaEZW?=
 =?utf-8?B?TUc4RWNBOXRvYlpQMmp5Q2QyaGRualhvbUJOdWJRUERwSlRZQXV2Rm1kTXp2?=
 =?utf-8?B?bGxFSEsyUzBkdktVaWJNU2xVa3VjZGsrMlU2RzZtT3pzK2VaQzkzeGI2aWxm?=
 =?utf-8?Q?c5FUOGRjfF8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3M3MWlaN042dk5Gdzg3UWJYbWhxUUJnRHZxZ292bm91YmthWS91U3h1NmxH?=
 =?utf-8?B?ZkliMlQvM1pBRHpuaUs2RVJJdFovU1NJK2JXSWZ1aEJhMHNaSHl3ckRGaXFx?=
 =?utf-8?B?Yk1tLzYvOFdkZGVuaHZOZGk1Y1hnd2NmMjg2ODFXWUtBemZMSEIzMEFJeDhN?=
 =?utf-8?B?WU1lcWQvRW5pcUd2U2YvY3N2K0ovTW14aEYxb2g0Y2NzMWhLWTdFUmsxM3hv?=
 =?utf-8?B?bVNvVklxbExLSW9xUzJCWU1jK1kwWVZhQTAySTRIOVJjUWxiVmFwb2hwY2Nw?=
 =?utf-8?B?TVlHZ3BtQ1RWRGV1dDhIRENIbFhJejVmeVkwWmcxREFKN1Ezd0hBWCsraGIz?=
 =?utf-8?B?K3oxa0paQUg3UWplbFlIRERreENPOGlScFlFa1pjdC93Q1JydDZXSHcwM0FR?=
 =?utf-8?B?dDM2WnlDa3RLVThWM3ByQ2hERkV5NzRtU3RBeDFseVdwYyt5a3BIcHh2R0Rp?=
 =?utf-8?B?T3Y0YjgvZGpUVkpXb1JNRmtWbHRxeWYwbXNMa1l1Mjl3TjBVTmJMYWRMeDE1?=
 =?utf-8?B?bWxlbWcvdnFoRm9pZWhBQ2hEZU9GQ29sWXZMVWlMYkpIMHRITDB3S3owZGg0?=
 =?utf-8?B?STBQRVU0L1BrV1U3UE1CU0Ezb1Q5cHZGTzVWOFZqQ3Y2MDM5Z0xKSlM4aEtP?=
 =?utf-8?B?dWc2S3RUL2RBVWphVTIzQWpmN2xndFNEcnhrSXR1T0dNZWRNUFo2OUNrQWtH?=
 =?utf-8?B?eGlWRVJEWG1FNXlMcHE2U0tBYUR3c095Y2UzTjM4RzkvY2w2VGZpUHVFYXg2?=
 =?utf-8?B?TFJLNkRVZEs5VzU0MEhIY1R2SElnWjkwdmhPeTU0cGExZkkxRk01bVgzb2Fs?=
 =?utf-8?B?a3hsSnlBc3FrSlpwZ28vQ3g3dnVQYlA4Mml4d1Y5Mnh1WmppMWZxbWtBUjRM?=
 =?utf-8?B?YndvdStKb2hXL3ZwbUIwQ0tpWkg1cnp2SUtCcktvZ0h6ekpwN2VyemMvZ3Rn?=
 =?utf-8?B?ai9KakVHWll5U2piY3dqQ0RjMkhLc0dKMmkzNUJoSHFGL3NwcEVFc0t2R0t2?=
 =?utf-8?B?SThiM2ZLVVc5RDhXVlBQL2dPcVdUMnoydlN2U2hWbCtXVFhRdms3QTBzbjUz?=
 =?utf-8?B?c1BiL1hPT0MrZ1hLaTJyZmxGU0dmYXlrbTJOV3g1TGZzYWFJTjlKTzE4WFBQ?=
 =?utf-8?B?aXJuTkp5TW84b3pDb1EwR2p5ekR5enlON1RrZm9oY2V6UVdOWnMrTGU5T2s1?=
 =?utf-8?B?d0VWVWkwRk1RZG1kK1FNcStJdGlVVjRtVGY1QjE3d1lzenNFOTZrZGFEQnNi?=
 =?utf-8?B?cHNlbkp0MXZ0MXJiZktKT2h4M002WmNvUUVHTmo2cXpFS0RVOTBxUDVTY0dW?=
 =?utf-8?B?Ny9iRS96WmZDdzl2dnBsUVZmaHR5RnNCa2RFemdjM0h3TzRYZmk1V3JHVnVT?=
 =?utf-8?B?a0xsaklRL3Rub0JWNTgyUFNEVFlCU05QeEdmTGRUbE16cXRzeXlpODQzWlZV?=
 =?utf-8?B?TGJNcndnWGczZ0IvVzdQOG85b2tHeUx3dEZ5eHNhMGtGU2Vpd3B6TUhUU3E1?=
 =?utf-8?B?bnVWYkV4byt2RS9tbjg2ZXlsRXd2RWhOWlJvQVFOVjVCM2grZzQ3b0hTQ0R2?=
 =?utf-8?B?VUx5TWx0NGhjMkh0c2plU0xXRVAyYjMxM0ZYRWk5TUJwd2x6NGJta2NIeVhW?=
 =?utf-8?B?MEZTcm5iTGtXdnp3Q0xLV2JXVEV4NDFBSWVvZE12Q0cyR3d4amhEZFE5OVpF?=
 =?utf-8?B?YXV3cnRsTktBemhtTUY1LzFpelpUR2JlTmpaYXdremVXZjhydTBBYWVGbEla?=
 =?utf-8?B?ZWlVNnBCdnIrdkNrYlZIWk5WM3VRbkVUSHU0VXdZNGh6Tmo0ZkNCcCt0bEFQ?=
 =?utf-8?B?SktWODJaZVhOZE5ITHZDRFoyak9LMVBkRXh4NmFxYVBWemN5UVQ3TERuL3hz?=
 =?utf-8?B?aWRKcEI1L0xxT2ozYk15UWE2dTFEVk9yWENzQURZRFlZbDNaU3JxR2cxUGI4?=
 =?utf-8?B?Si9wbXdtaWYvR0JYdld0ZGUwZ1k4L2Z1aHhleVdMdDg3dk1UWjFUS3BrS2dN?=
 =?utf-8?B?MWhjSldZelVnekJ5b2xlK0ZzeHhpbGlkc24zS0gydStCWWRabStvNGFuWkV1?=
 =?utf-8?B?bnZrWnlqdFVld3hkTlVhY2dRSERJLyt3alU0a0ZvWEk3NXJObUo2QzY4SW9K?=
 =?utf-8?Q?5Hb2d5mJ9IG+jhWMOouoJSx8+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d521b30f-208f-4c81-ef51-08dddb7b1963
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 21:39:51.2131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q74Cziyre3bfy2Hu5xE3cQZGbgrpQIEqP3KI+2wHEgpXXLR0arge+yJlxxZZsMJ2PaLmxYMDeqDB5XktuaxErw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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

after discussion with Alex offline it is clear now as the power profile 
switch is fine and should not
affect the user experience (such as mpv playback).
Alex, please correct me if my understanding is incorrect. This patch 
(v3) is also good.

Thanks,
David
On 2025-08-14 15:43, Alex Deucher wrote:
> On Thu, Aug 14, 2025 at 3:18 PM David Wu <davidwu2@amd.com> wrote:
>> On 2025-08-14 14:00, Alex Deucher wrote:
>>
>> On Thu, Aug 14, 2025 at 12:44 PM David Wu <davidwu2@amd.com> wrote:
>>
>> On 2025-08-14 12:01, Alex Deucher wrote:
>>
>> On Thu, Aug 14, 2025 at 11:35 AM David Wu <davidwu2@amd.com> wrote:
>>
>> On 2025-08-14 08:56, Alex Deucher wrote:
>>
>> On Wed, Aug 13, 2025 at 7:06 PM Wu, David <davidwu2@amd.com> wrote:
>>
>> On 8/13/2025 6:11 PM, Alex Deucher wrote:
>>
>> On Wed, Aug 13, 2025 at 5:47 PM Wu, David <davidwu2@amd.com> wrote:
>>
>> On 8/13/2025 5:03 PM, Alex Deucher wrote:
>>
>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>> <sathishkumar.sundararaju@amd.com> wrote:
>>
>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>
>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>> <sathishkumar.sundararaju@amd.com> wrote:
>>
>> Hi Alex, Hi David,
>>
>> I see David's concern but his suggestion yet wont solve the problem,
>> neither the current form , reason :-
>>
>> The emitted fence count and total submission count are fast transients
>> which frequently become 0 in between video decodes (between jobs) even
>> with the atomics and locks there can be a switch of video power profile,
>> in the current form of patch that window is minimized, but still can
>> happen if stress tested. But power state of any instance becoming zero
>>
>> Can you explain how this can happen?  I'm not seeing it.
>>
>> Consider this situation, inst0 and inst1 actively decoding, inst0 decode
>> completes, delayed idle work starts.
>> inst0 idle handler can read 0 total fences and 0 total submission count,
>> even if inst1 is actively decoding,
>> that's between the jobs,
>>        - as begin_use increaments vcn.total_submission_cnt and end_use
>> decreaments vcn.total_submission_cnt that can be 0.
>>        - if outstanding fences are cleared and no new emitted fence, between
>> jobs , can be 0.
>>        - both of the above conditions do not mean video decode is complete on
>> inst1, it is actively decoding.
>>
>> How can there be active decoding without an outstanding fence?  In
>> that case, total_fences (fences from both instances) would be non-0.
>>
>> I think it should be non-0.
>> I do see a hiccup possible - i.e the power switching from ON to OFF then
>> ON in the
>> middle of decoding, i.e inst0 idle handler turns it off then inst1 turns
>> it on.
>>
>> How would that happen? As long as there submission cnt is non-0 and
>> there are outstanding fences on any instance, the video profile will
>> stay active.
>>
>> there could be no jobs but it doesn't timeout yet and new jobs will come in
>> any ms - note all fences are done at this time. The idle handler sees no
>> fences
>> and no jobs so it turns off the power - but just ms later a new job is
>> submitted
>> from the same decode session which could be mpv player as it does not
>> need to
>> submit jobs without delays. This will turn on the power.
>>
>> I'm not following.  Every submission will start with begin_use().
>>
>> yes - it does - it can power on vcn but this happens in the middle of a
>> decode session which has 10s timeout to call its own idle handler - in fact
>> the other instance's idle handler will power off vcn because it does not
>> know it needs
>> to wait until the decoding session times out.
>>
>> I don't follow.  If there are no outstanding fences, there is no
>> reason to not power down the VCN instance and disable the video
>> profile. If there are still outstanding fences, then the VCN instance
>> those fences are associated with will stay on and the video profile
>> will stay enabled.  If the engine hangs and eventually gets reset, the
>> fence will be signalled and then there will be no outstanding fences
>> so the idle handler will eventually disable the power profile.  The
>> idle handler will keep getting rescheduled as long as there is still
>> oustanding work.
>>
>> inst0 and inst1:
>> inst0 sends jobA, then ends jobA and no more job submitted in 500ms and
>> job queue is empty - at this point  inst1's idle handler sees no
>> outstanding fences/jobs
>> then power off.  However inst0 starts to submit job after 500ms - inst0'
>> idle handler
>> has not started/scheduled to run but inst1's has finished already which
>> does not know inst0 has not timed out or called its own idle handler.
>> This violates the
>> logic for idle handler's timeout condition. (i.e 10s timeout designed
>> but timed out in 500ms)
>> all this means it powered down too early for inst0.
>>
>> I still don't follow.  Here's a sample flow.  Job comes in on inst 0
>> and then slightly later on inst 1.
>>
>> Inst 0 job submission
>> Inst 0 calls begin_use().  This cancels the current inst worker
>> thread.  It enables the video profile and ungates the instance.
>> IBs and fence packets get submitted to instance 0 of the engine
>> Inst 0 calls end_use().  This schedules the worker thread for
>> VCN_IDLE_TIMEOUT jiffies in the future.
>>
>> Inst 1 job submission:
>> Inst 1 calls begin_use().  This cancels the current inst worker
>> thread.  It sees the video profile is enabled and ungates the
>> instance.
>> IBs and fence packets get submitted to instance 1 of the engine
>> Inst 1 calls end_use().  This schedules the worker thread for
>> VCN_IDLE_TIMEOUT jiffies in the future.
>>
>> inst 0 work hander runs.  Sees outstanding fences on inst 0; skips
>> powergating inst 0, skips disabling video profile. Schedules the
>> worker thread for VCN_IDLE_TIMEOUT jiffies in the future.
>>
>> inst 0 IB completes and fence signals
>>
>> inst 1 IB completes and fence signals
>>
>> inst 1 work hander runs.  Sees no outstanding fences on inst 1.
>> powergates inst 1.  Check if there are any outstanding fences on other
>> instances.  Sees the no fences from inst 0 so disables the video
>> profile.
>>
>> now there are jobs coming from inst0, so inst 0 idle handler won't run.
>>
>> inst 0 work hander runs.  Sees no outstanding fences on inst 0.
>> powergates inst 0.  Check if there are any outstanding fences on other
>> instances.  Sees the no fences from inst 1, sees that video profile is
>> already disabled.
>>
>> inst 0 work handler runs? could or could not - right? depends on if there are more jobs for inst0 and also
>> if  VCN_IDLE_TIMEOUT jiffies has passed for inst0. There is possibly a point in the sequence that inst0
>> stops submit jobs but its idle handler has not run yet. Should we wait until all instances have finished their idle handlers?
> The work handler will run unless it is cancelled in begin_use(), but
> in that case, it will get scheduled again in end_use().  If it runs,
> but there is still outstanding work (fences), then it will get
> scheduled to run again in the work handler.  All we are about from the
> power and video profile perspective is whether or not there are still
> outstanding fences.  Once all fences are completed on all instances,
> we can disable the video profile regardless of whether then the idle
> handlers have run or not because the hw is already idle.
>
>> if not then we will run into a power OFF(by inst1) -> ON(by inst0) for the active instance(inst0, expected ON). (active - I mean
>> those have not timed out in VCN_IDLE_TIMEOUT jiffies and still can submit jobs in any time.)
>> if this could happen then we powered off too early. (I did not say we cannot do it but it is not expected)
>>
> VCN_IDLE_TIMEOUT is not a timeout.  We could call it something else.
> VCN_IDLE_CHECK_PERIOD is a better description.  It just runs in the
> future to check if all of the fences are signalled.  If they are not
> signalled, we schedule the worker to run again further in the future.
> If you reduce the time, it will check more often, you can potentially
> save more power, but you add more CPU overhead because the handler may
> run more often.
>
> Alex
>
>> You can insert additional job submissions anywhere you want in the timeline.
>>
>> Alex
>>
>>
