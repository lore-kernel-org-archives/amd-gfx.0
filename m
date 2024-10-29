Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991BDD2AB3C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 14:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870D510E163;
	Tue, 29 Oct 2024 14:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mp0X1sXY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065C410E163
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 14:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqt1QNEUO/PnFTdBMzuaiGQ8IjG6FErNw6LHT9io67UPExZlwIOg+V+0PzF4EQY66Ab3daiThMdTLr9b8CZ04YdWULYQOduTm29lUaYXpuB3WXlm+v9r2akvrtRuZi0aBI2fR3sCRjVHDc6RxrNKM/VV9Q1M5xXEgby5ZbpyfrKQrOG6vzcnsm4ntCA3CP6ei5ukc/2kSSeHnnddvOhHCKVYEoE1gxjZI5Y/nCVt7l8mctdF4USwqnDFoNbYtru8pZUx53bypMGfib1piOEWBxt12yF4iyZAI6mcE81XnVWuJdbrRH+RxxP+TZKTVwVTvOIb9J3b3WLQChBAzTFeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L26uXEwIxMshoqBEVZdL+bOmYqq+IkJEhZ0I+vYzI6Q=;
 b=oyALXBQ56RMTOP3Q8koc5DsuytLcolVYX3h9NF9yXFgRX5UHTy/ZV3TerBE/l34NCJUGFRdMG7Rl2EvrMkO7oSK0yaFEOJrXiIguxt7Tl+T0qHSdCvN2FqFYOZKpAFWzuWtJF4vbO359Za6PXJV9TDO28r1K0lj7egL+k4PVbuSn4r4LDJcQI6DY9mXqWFXOTfFir8BVeWHtuYPZRCBVt5O7YVV+5Ab3mtQ6ubbKCBij0oKbwz2SzZ1lShipstSwZgH7WvY0412/UPVku4WqtLsFsiG/arRAF1Fg0sH7eRH/RYdrReAKCv05M3WeynflNnUC+VZMt7SvjOuMMRzQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L26uXEwIxMshoqBEVZdL+bOmYqq+IkJEhZ0I+vYzI6Q=;
 b=Mp0X1sXYuhdgogCVb7jU9io3KSfBtbksN8JjzNmfE8boET/qGW4SuBrxKfCnejgPwHaHDYb01fibftA8l5qZVFa+l8+MVdxGfqi4wUDrj/3Ia5oXEgjA9s0Hj0jCbKSxQkyY2iNiry0gC1yVGs0StywAhpWMo7DrzI+4jziyEww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 14:03:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8093.021; Tue, 29 Oct 2024
 14:03:57 +0000
Message-ID: <8bcdc50f-2135-4faf-9f24-d901c3809a20@amd.com>
Date: Tue, 29 Oct 2024 15:03:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add userq specific kernel config for
 fence ioctls
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20241024121027.3397-1-Arunpravin.PaneerSelvam@amd.com>
 <9ba915e5-2266-468f-a978-f89a33bb9fc8@amd.com>
 <CADnq5_OduwSsD+ZCRwSF1+2HwDRGjgZ_V0R8QYuK6LxrQ7Zz4Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OduwSsD+ZCRwSF1+2HwDRGjgZ_V0R8QYuK6LxrQ7Zz4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 0725b976-d538-4ae0-f3a9-08dcf8228796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0pJeVpvNXJob1NxY2ZSQjNTUUxPZ1ZmUVB0OUFRV2FxUjNURzFtcHVKWTUr?=
 =?utf-8?B?UFFsU2xUN2FVbGtmOU0xckQ4UW5uL0IxOTRITnhIOGhabEx4eXVBa2dZOHhx?=
 =?utf-8?B?bi9hWFdLVXFIT0dhUGhOdHdBdGxmWk1sNjZhL25sRzN6cEFQTHlZczNmekps?=
 =?utf-8?B?WWszd09mUm9tdlNNT3o1VkxYZm1rRGlQdWFsb0c0NTA0WmVPcEtNVVlheThs?=
 =?utf-8?B?VnUwZUNzMHg2M0t1UmJtSHM5WC9WNUpnYUV0aHUrU1BHV0tHQkh2WFhVMnpW?=
 =?utf-8?B?TDJORXUyQ1RwOVFXOXdtTWxPWnVyUXQzalRPdWdDek5vWnZqcEFNanUzQVJa?=
 =?utf-8?B?cE40SWhVdHhBNzRWVXdHRkhIaWtVRitld2FTcHpYb2lnL01JV2pmU05zV0pw?=
 =?utf-8?B?Sm9heTFwYU9jaUxyQUZrYys4N1l0OENUV1U1d1pGbk1PczFNZlN4ZHVyZzRV?=
 =?utf-8?B?V2JHT2JMczcxMWtUK2JPWFFIUWFNUE5POGFRSS9aNE9PQVNLYlVROThKVzRt?=
 =?utf-8?B?VXRzT0pnTnV0RElqZm1jcGRTLzVtT2tYWHVES1ZleGVBOHNTVlN2NGRzSmtS?=
 =?utf-8?B?ZzU0bmdybjBYSXM1SkhXOUJ5NEYwWlROTklEWlpmQUY5c0FqbSt2SEU5VC94?=
 =?utf-8?B?STNNR0gvUmpVQWUxNkJxUkZjekl4dFR1b08vR1FtTWlPb1lKM3pjWmI3QSs5?=
 =?utf-8?B?ZHQ0cjFNVC9xUzRjdHVzYzMyV2I3bktabXJYQlQ1NzVaTFlzVzg2SnRHRVBm?=
 =?utf-8?B?cUVoSlk0S2VuYmsrelVtM2o4aGlDVDgrRGpSc3M5THdoT2p3ZnB6czB5b2s2?=
 =?utf-8?B?VGNRTGJmK3J4a2xOZ3V6WkNlVzVVK2t1VjNTQ09OOFhUTXcyZmNLZDdreUQ5?=
 =?utf-8?B?SUFZODVRZHkyUnd3SlFGZHdqQWpiMnZjamswRm5BU3ZIMTRNOEtLWDVEd3RW?=
 =?utf-8?B?L0FVTmN2SEloVzJ6QWZOMDBGRCtIdVFpa1VucUlrRjM0L1h2REZpbTJxWThS?=
 =?utf-8?B?MG0yckphTk01cDhQei9KVlAzYk1jSncyZDhDeHFBbG5FeUJGc29kSjdVVGM1?=
 =?utf-8?B?SGlhanBReUQ4M1JnRnZSM21maUVRMG9pdnBUVFdIYXJ0SDhOeG0rMEhCdDc1?=
 =?utf-8?B?N0Ird3RLQlBVTjlaVGdwUXlKajdDdUE5RmVmTGNqa3A5ZDdIWDdPdXhINTh3?=
 =?utf-8?B?djZnQURWNUdJam92aWNHa2V3VC92Sjhna2dtbjJtYlNmL0ozMG0weExHYjh1?=
 =?utf-8?B?Z25vMGN4OXdWakZ6ekFNQmJwTGczRjZxUXpDZjZIZzNub0o5U29MTnkzZDNE?=
 =?utf-8?B?eTVDTEprQ3c4OUNNbWJDcU9jWTRhZ2FFaElpTlZhaXpTSjRnYm4zcmJVTURy?=
 =?utf-8?B?NUY3UGMvRGdmZGxiVnQ3S0lacS9TNWw4a0pTRGpXZWJpbmtCeVhmZ3FLOVJt?=
 =?utf-8?B?emIzWEsxekdGa21vdFptRVY1K0ZUUHNHcE82NlBMSzRUd2Q3UFd4ZmhrSUVv?=
 =?utf-8?B?cGhyMGEwbHFVZ2xVVjhHNDBkbGlFbTFmVDArMGFST0E2enFWM3dUSTNneWwz?=
 =?utf-8?B?OW9uL3dicDd5MXpxYVpkRy9MT0U4dXhUT3dpUk8zdS9WZjR3UTF5MkNBc05k?=
 =?utf-8?B?N1FsTllyMzArU0xDMjZlZjJsZitPL2phbTdhaEJFRTFZY3c2dnNaU2dGNVRi?=
 =?utf-8?B?NzBHVytKVEwwcHltRTV1OExxcUFHWTBxQTRUM01MMStpRzhKUzBVZlo5SS9y?=
 =?utf-8?Q?y1a1fiPCcT3MYm7RWaQLLo3pYXv3yxC+Py4UOnB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFduNm9CcXRkL2sxOFpvNWppUWxkTFZPRUJmU0w5ZmljQnVDQlN1V0JyWWFF?=
 =?utf-8?B?WitQb1ZsMWlWM1J5THB4N3FHM29LQ3YrK0pmYWJLSzg5VWJCTTJCanRFc0lM?=
 =?utf-8?B?ZlJmWXlpSFNWZ0NpazRGVjkwOHJ3VTFONHltWklMTlB0blBMWEkzZUtjV2dP?=
 =?utf-8?B?V1dzRWdKU1pPYlZicFlhd2NwWFkydllBaXZNWjJ5bkFEaUxUVDlEclBZSFdw?=
 =?utf-8?B?ZFdCeG5GZVZ3OEJrZGVCdUNMRDYveGlpUGN5bklWRUVPcEh6c2RpWHg5aTl4?=
 =?utf-8?B?TmpSN243WW1TTDhtSDRxMlhWc2VMZHd1U0JuUUUwZmRaSERGdjFsL2Ryb0tY?=
 =?utf-8?B?R0VyZ2JHVGVJaUZtTHF4N2N3N1JkQ2pDVlJTM1ZnQWZONDN6ekc0OGM5eGdW?=
 =?utf-8?B?b2E2alVpZDBxL1pRY3dpeEV6VEMwNDVWeE4xUUN5L0YxWHRiNXh0YmhLU0pR?=
 =?utf-8?B?QzZ3S1FVREtZNEtPSGd2Ym1uSmlxS3RtWW8vYnFWQW0xbUpWU0MwRTlNVHVC?=
 =?utf-8?B?ckFXRWJKVkdWUjlyQ0ljV3pIaExkV2Z3YVJpTkQrMXpSQXNraEhiOG1EeHNl?=
 =?utf-8?B?QTM4TDJMYlJUQ0Nvak04UkNSK1lyWmxNTFZUUEx5S0hqcnBjcnBNb1ppSVdL?=
 =?utf-8?B?TGxGR0lZMTl6VFhqN0xLY2ZVVFE4eHZGKzIwTk5KQ1RDdEpwK1dZWlUvODdy?=
 =?utf-8?B?U2tYY2NaQzZQUjZub2NkUm9wYURGWldMQ2I3clc5V1ZJY2E4bC81UU0rWW1S?=
 =?utf-8?B?MnB0ckY4VkwrWFY2emFDM2RQdjRWUkJjT2o4NVpsTXVIOGEvM0djeGlMU2pN?=
 =?utf-8?B?bHBraE5UZ2dWRUxNRWZBZ1p1YjFseUJYU1VycCtPRFoyMFo0UDJnVnduL3p3?=
 =?utf-8?B?WjRZeXZnNjF2a0p1QXN0M1RQdUpVZERFcEZjam5VSnQzYUo0TEh1ZXpPZXBh?=
 =?utf-8?B?Q24xdG5IbDh6MlIzdVg2N2xubGdLWkRCajROQnlPbEM5UjVpT09UQ3VVSkJi?=
 =?utf-8?B?bGU0dDFSWERCcXIvWms2T000UEcwS0trUEwyL0NZTlpUQ0tFS3FzbWRoYjhk?=
 =?utf-8?B?Wng1NUJyK3hIOVA0bWV6ZkY5b1JEaE9mMUY1bEhTZmZMWTJXYnN4ZDdtNThC?=
 =?utf-8?B?d2ZscTEva2xJSUU5ckQxODcyTXhmaldvT25NVUQ5eDBFaG1kZlJMNEgzTTJ3?=
 =?utf-8?B?OHJqS1Y3bW9aYnJnRkVXbHJrcW9ib3JaUFROYXJaRnZVdG04ZWMvalgrajMw?=
 =?utf-8?B?c2FqTVFyQVI4OS9kT1gyR2tFcDlQN0t1MWZ3ZUtSYi95NmMzSnVLRFloZG9J?=
 =?utf-8?B?VXJIYzhLQUk4QUVBZXRZQzJpNnpSckpVdDF2SC80OVlDZUVXdjkwakdLOUtD?=
 =?utf-8?B?OXJ0WU9SbkxwRU0xZmxTQWpXYzM5Tmt2Z2hObjdzSStQTGx4U20vYTZ2dyti?=
 =?utf-8?B?OGY1U2pHNEV0SGJFa20zMWljeFY3Uzc4UEszamtqb0M1U05HaXVzTjQ1UnF5?=
 =?utf-8?B?QXcrQ3U2V29DSWc2NFQ1ZWkwRnpwRVNKemxsN0hYc05uVElCYVVKUEVuMGdP?=
 =?utf-8?B?cTJiMjVWWmp3VVFSaHNNcEp3aU1aa0RqZ3JWSytwZzRFVSt3TjBiUFZGTGQy?=
 =?utf-8?B?T2FhY0ZFSnoxb2orY2hIMG00YUN5RkJOVHpzV0JiNmFSK3Q5Rk1UTGVaUlFu?=
 =?utf-8?B?RVNqSVoxRVpFMTFuaDBYWWs5VG9QbzZRTjAxYVR1VVdqL21yUVo0eVhWK3dk?=
 =?utf-8?B?NlRUVkVqcG5vb0hyS0dqbWFCbzFyRSt4VGErT0RmSTJmMENNenJCVkc2ZFlp?=
 =?utf-8?B?RFpXTTN5REJ3czc0dFdnNlRQa2dQc25RK3ZHTUd0T1dQUGFWVDlxVUVPM1Y5?=
 =?utf-8?B?c01JOElIM045VnRZZng5SkcvVEdlSkNzUkJTU2dzakhEL016czJtQXJwdmNm?=
 =?utf-8?B?VUNsc00vOVZzVzFSdld0Q1ZCbEpuSnl3ZXlLTFFPL25WRWpWZjhReE1LWkdR?=
 =?utf-8?B?czVveFZKeXJwTExYS0c5OWpkS0J1R1FYTnRBWE8rb1AxUWVLZHNFd3o5d1Zr?=
 =?utf-8?B?R3ovUGR4RFh3RkxPZjJnK08vMC9iR2VFR0lQOStRdWw5bGJ0WTg4a3paSDFJ?=
 =?utf-8?Q?aRFI7Hd+3HPxKFp5tJt3v/Owz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0725b976-d538-4ae0-f3a9-08dcf8228796
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 14:03:56.9992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GphkXc0vOBxa8VVi/4+vo2uSu94T6J5DZWDFZ66d9zauoX/qHUoz5fs4CXNzDZTx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

Am 29.10.24 um 14:32 schrieb Alex Deucher:
> On Tue, Oct 29, 2024 at 5:38 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 24.10.24 um 14:10 schrieb Arunpravin Paneer Selvam:
>>> Keep the user queue fence signal and wait IOCTLs in the
>>> kernel config CONFIG_DRM_AMDGPU_NAVI3X_USERQ.
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  4 ++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 ++++++++++++++++
>>>    2 files changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 70cb3b794a8a..04eb6611d19b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2971,9 +2971,11 @@ static int __init amdgpu_init(void)
>>>        if (r)
>>>                goto error_sync;
>>>
>>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>        r = amdgpu_fence_slab_init();
>>>        if (r)
>>>                goto error_fence;
>>> +#endif
>> That here makes no sense. This is for the kernel queues and not for the
>> user queues.
>>
>>>        r = amdgpu_userq_fence_slab_init();
>>>        if (r)
>>> @@ -3003,7 +3005,9 @@ static void __exit amdgpu_exit(void)
>>>        amdgpu_unregister_atpx_handler();
>>>        amdgpu_acpi_release();
>>>        amdgpu_sync_fini();
>>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>        amdgpu_fence_slab_fini();
>>> +#endif
>>>        amdgpu_userq_fence_slab_fini();
>>>        mmu_notifier_synchronize();
>>>        amdgpu_xcp_drv_release();
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 279dece6f6d7..bec53776fe5f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -318,6 +318,7 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>>>        .release = amdgpu_userq_fence_release,
>>>    };
>>>
>>
>>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>    /**
>>>     * amdgpu_userq_fence_read_wptr - Read the userq wptr value
>>>     *
>>> @@ -502,7 +503,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>
>>>        return r;
>>>    }
>>> +#else
>>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>> +                           struct drm_file *filp)
>>> +{
>>> +     return 0;
>>> +}
>>> +#endif
>>>
>>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>    int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>                            struct drm_file *filp)
>>>    {
>>> @@ -797,3 +806,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>
>>>        return r;
>>>    }
>>> +#else
>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>> +                         struct drm_file *filp)
>>> +{
>>> +     return 0;
>>> +}
>>> +#endif
>> Not nice, but since CONFIG_DRM_AMDGPU_NAVI3X_USERQ depends on
>> CONFIG_BROKEN at the moment probably ok as intermediate step.
> Wouldn't it be better to return an error in these cases?

Good point, the functions should never be called in the first place but 
better save than sorry.

Christian.

>
> Alex
>
>> Regards,
>> Christian.
>>

