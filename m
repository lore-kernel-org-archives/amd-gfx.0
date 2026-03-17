Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E3CF33832
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 09:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2AE10E1E3;
	Tue, 17 Mar 2026 09:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1AGA2Vnh";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5DE10E1E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 09:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfvpHucM6Yzu/xWfE2HmWsTW3wDY2p1rlHVXZEtVcAId0LW2ja9dwJgZILPYPJokNzqPugI7LNtca8sthPb+A/+8Yf9/rZEppnF/MKfzwBoeh343Dh18hCNPmQJq3k2pPz1rER1lmfvBSPuOliyFNOswMQBu0UzgA37VrYI5Mc165za3VZru64DSw11owS6qZUnhZy7bXxydgMEtvqYie2Pz1wvJfYvRv6n+/jsvz9Ir7cBzt5bqSolV8oKsjapzixgQqpKriX8YiMWCzkrau+tT6bY50AQMQIVABadhkdihIs1iVjGTT5cFnf3n+EH1d0q1x+LpwhrA2pTmvkRjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65h0pDUfLrK/nbZygHr7XxkEKcE5ySqzNbsvwD+T6FU=;
 b=u5ufXLnzs+sU1Oje7RgtiIyabfTQglkwmJzd9V0djBcKyxA5xHvB/2RMN9ZpJTu4BYHhK1X7a4J8fUpZQRFpPBWRUFH4aixaWP3gBfAAFRG/xoCn0aTminmBQaGtFW21pdKZ76EjjgoKLZvqFxjX7zBK3okO7u7x+gS3RBqhbIAZxINRfJ6Qq+ZTlcQ484txuuZ1lQ8JoHQ6gKBFFjvkW6BKaPdwB7QJGkVNsVF7x2UqsOdvQkonucbOrAA3zRdHyz8xu8N9992cZmunOSiOVtgGabGbaIz0ttTGQnS+S5/OxTcyX1c1saqOZWahBcjw5LpB2JDPOoGaVFHiGTzglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65h0pDUfLrK/nbZygHr7XxkEKcE5ySqzNbsvwD+T6FU=;
 b=1AGA2VnhdeEXk8pxuQG2A5OeVoxAssSqI97MbOKI+6GTbleWck7u4ZXm1aOzYY2XrvWR5gAXe3+4yRx4FpKt8nPk6gDbLDEy0EkkjszybgHoIf4dgbxpdI2TPXlOWoPMS9XNSrX/DkAspKnVAkXv+75y/E40gtYHCG6v0gqYWTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Tue, 17 Mar
 2026 09:57:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 09:57:27 +0000
Message-ID: <074594f1-59d1-4cd7-9b2a-997106b76167@amd.com>
Date: Tue, 17 Mar 2026 10:57:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: completely rework eviction fence
 handling
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-4-christian.koenig@amd.com>
 <PH7PR12MB6000407BC326A3D9ADB2AC48FB45A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB6000407BC326A3D9ADB2AC48FB45A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7927c8-8c54-4b4c-4895-08de840b983d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: VTI8RLFTQMhegevcUncoNIK0IMDWtrkwPi2UzS9eqhgu93AgCDwJ9o13bT6fKVPnWg9dGwaas4No3MFMRhYrcyp6btxz+Rwyy7ljxRLAO7YtYcCG50Vy3UQv/qNXxR7eehL1MwbmGjocMpjB5iL/dK8FBv1owsb1oGm6C2Z2Lf7pHV/sNUnAH4XgfuxBTbufN1JwJAGAdlmvuYD6Yl+BOVZWDUjtsEbWn2k/QNC5r3/cGzCRU1OvftjLLpOAAUewLazn1wAmROR9Xp0UMFik0FlL/L4sBcBAxmuJVpB4ySgExcHdZQYK/rz2XSD9IgiIbiRIdlLtN5T79noV5uHQAK2U6Hczgc8LH1UZK5S2VNTuKuOPQm7mNz4tSThUHjMPCDon0LweJqgnjIxFmRNZWMjLIRLv8QQGo93Tb/yHjlp1VnKmFH88MvpigjGHZITywLiQWUaIDAHkRjPBrFT+O5YQ8cxcv8TeYAfPicKA0GOHUo7vaHpzu5XkLkDJx18i3GbFHXLBYq5fmYO1geS9Fe1kkx1khFqyRnQ1tOFykq/mNs38UVj0jvd1YLNe542SnHpXvOGG0efWpEOMrXjKIB49OHfUmBEKaReXcqH40zKVFp0wsHiQwohQKes3hh3R4BgUPOL89mL7IsPU6AtnTCVF3amFzwW+i3G0DXtOo0Mv/RMHmeosgHtstQ0FSB+VH+iz/C+C6jAz4ZilARrgigHwUhgenFmfQBUOwX7dTOh9HOue6oPM/tvkx4kS+nQy3+ki+GIZIy7sB4wDAJm5Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndKQ2hpNFVpenhndFJZRDZOZlFMMzNDcndKRjk0bnR4QW5ZUFM2aWRlbGQ0?=
 =?utf-8?B?VFFVUWhnb1NEaFlpUTVlYTcvM05xTldOb29LV1FYbkhVd0l2MTFPNFhxUHY3?=
 =?utf-8?B?V3h5NklPQlpuRlNlTjJzM29COXcvcUNOMHZ4a3hmdFIrSEtTMkV1YVI4b2JN?=
 =?utf-8?B?ckxSeDIyZlBOTWpQWFpSOWlxbGhDTHZ5OHdXaTRYQVlvVVg4Z2lUMzJuNS8w?=
 =?utf-8?B?YURJaWQ1QnBZN2N5T3pHMThKTjBzOWp2MlJUTWFqeXA1NHRrMVNkcUhnRGhK?=
 =?utf-8?B?YTdZbzIxd2h3c2NXL2lValBDbCtNV0V1N3U4cGVpc2M1d0V2RWd5S0tYWVZN?=
 =?utf-8?B?Q3hQUUtlanJ2OE5rQ01UMDc4WDJIVS9kVEE0V0FzYTRMa0VwaSt6cVN3VkRB?=
 =?utf-8?B?SUpsb212TlFOVnB3eEdvL2d6bHl5NTVsTUFqOWZISTBVTnBmdVE4TjRpVXow?=
 =?utf-8?B?LzY2UGw5eFc3SFJrempsbHB2aEhxN1YrZVlkU2FIcEErZ3R6N0IrNE5lU3FP?=
 =?utf-8?B?cTFNK1N2U0RIeGVWTGJpYTdYdkFJcFg0Y3FYakNUb1NsbGF0ZEdrazNNYXFz?=
 =?utf-8?B?NkJnb3dnUjd4WHFMcndjOEEwaUFReTNsYlp0djlQcjE4OTBHZ2RKV1ErYU5C?=
 =?utf-8?B?OHRORDFlUzRRdWk5UDIzN0lWODRZbnFrZmRyMVpOZTI4ejFCUkptMi9GUHgr?=
 =?utf-8?B?Tk8xQWk4QmFpeG4zZ1RITXhOdTV2SFFYd0pYUy9mMURIbFRDSVU1WjRTanJH?=
 =?utf-8?B?NnpzMHZyL0pRcXF4aWo0YzdiNDM5emticHdPWUJIYk9hbkgvTVJMemY0Ymwx?=
 =?utf-8?B?VzFobkNZWEk2cEJmamxOaGd1dVFZRWJCYjkwU0ZpWUZUQy9OYXdYRUVHUHFB?=
 =?utf-8?B?QkFaTnpWWkZKZVpacm9kRUdNL0VmOE1QdmRiazg5aHhBVnVXV0dGRW13end1?=
 =?utf-8?B?YklST3JkWitEUG9nQTRLclRoS1FpbkdpbEoxQmJYbCtESTNZWEdiUDlqNUY4?=
 =?utf-8?B?NkV6TFRPdm1IbTJpQldDZ3pxWGE2NVMyWnU0eVJnK0Q3U2J6OEpCcERlUDZo?=
 =?utf-8?B?aEo1akdmdC8vVlNKTlFZcmRzdUhRbjV1aWhidGgzd0R1N2NHUVRicm5obTZu?=
 =?utf-8?B?ZlYwbEhHOUhYZjR6UG50YXhnNnFEcU1YTVRnUys3ejhRRlhGSG5VZjNiclhG?=
 =?utf-8?B?Z0hrQzRNdXNaaHF3VlBJODBQTkhRMkRQOHJ1c09oQjg2RFRDYjN1THRuRUkz?=
 =?utf-8?B?aENRaXd4T25aVzZ5T1lFVGRYVEZLNlVzSmVWQ2hVendXNkYrM29pS0JpQ0Ez?=
 =?utf-8?B?N1hNUm1nVmZONTVsZTZaWHdGdVVXZU5jNXNldnR6N0d4aFlXSWNoVFIxNnlk?=
 =?utf-8?B?TTU3S2VFSnJDY2Z5ZmVaNWQ2Q2RXY3UrbEtGMGtMSnpxQmNtbXZqbSs1L2xP?=
 =?utf-8?B?Z2RKeFArT0pIR0trODRlRnhMSDgyOTltWnRWVVpSWHJNRWFpRGxpVVM3T2xS?=
 =?utf-8?B?T1J3UVFUMTdMVkd6ckw4UGNJcnJkQlc0T0pzVHEzenVFbUIzVUNkNndpZlcz?=
 =?utf-8?B?K0VGOTZXWjdodjVGcjgvWkNLSk16RmFCZ09kZFJ2cDlyUWRaQkZ3OFZZcklh?=
 =?utf-8?B?WHZUMTdZVGdvWmI3L0NZcEVvNmplOUxuK3ZJWDFRS2JtQXc2YWhDcEZHTUEw?=
 =?utf-8?B?UUgvaTV0T0Z6bzNGbHd3YWxvZ0ZTZDJQTmlicThsc0luWDgxRXo0cjVpZEJw?=
 =?utf-8?B?NXZkclZlOVE1eFh6TjBvQTFOclp3OHRzdXBWRkp2UmV5SS8xSGRtYkg3a3Rh?=
 =?utf-8?B?aTdFSGh5eUI0SGFDUnJ0aTJ5NFZ5Y2NmMVpnc0ZLQ1RVQ0JJcWpWTmZtMzY2?=
 =?utf-8?B?QkZsZ3hTQTZrdmYvVndEdjc4cTYwWFEwNjlXTmhLS1Y0SzZWSjVMaTA4dk9Q?=
 =?utf-8?B?bko3ZzY5cjZiTlh5bzl3S1dTOEUvNmp2TTN5dmxtZTEyZkFZL2RkK2M0cVpT?=
 =?utf-8?B?cGpreXl4bzQ3S0Fsb3puaTV5OW1rYkx3S3hiWmZDWGhjemtrQ21qTVB4aFNl?=
 =?utf-8?B?M1d6cXJ1Nk9ORGt0TWY2bzNaWFRLU0trWmlkY01qbTYwYmVYS3pHaWNWd3hu?=
 =?utf-8?B?QytocFZEc0NtbWZrMjJPK213NUZ1azVrRXd6L3h4VjczUitsNUtXQU5PRXMz?=
 =?utf-8?B?dVdLTVZZWDZMUWk4TW9tbjRaM2hlUkNUUml3eHdweVFwNS83bzV4YUhvV1JW?=
 =?utf-8?B?SmtmQVZHOHkrM0pJZHRPRTV3S0FUQ1RzNTIwcWtQQWRzUmhkVk9mQmNmWHRz?=
 =?utf-8?Q?a0XdFrOpIC2Nn2h4SN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7927c8-8c54-4b4c-4895-08de840b983d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:57:26.8899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGHpp8ClgEX+DLBqOJO0EI830zyL+UbChlVzNE7bqLXPS3cpQmaSTKqATe1K6wGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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

On 3/13/26 09:28, Liang, Prike wrote:
>> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +                              struct amdgpu_bo *bo)
>> +{
>> +     struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>> +     struct dma_resv *resv = bo->tbo.base.resv;
> 
> Before adding the attached fence, there requires allocating the reservation fence slot first.

No, the caller does that using the drm_exec.

Additional to that it is way to late to do any memory allocation here since that could cycle back and wait for us to attach the eviction fence.

So by reserving a slot here you would just create a potential deadlock.

Regards,
Christian.
