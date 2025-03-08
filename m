Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532E0C282DE
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Mar 2025 00:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91CF10E1D6;
	Sat,  8 Mar 2025 00:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q9xroqd0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395CB10EC37
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Mar 2025 00:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPUlN/7GiAJXnsHjxpMbjD1puukEvkDWX5yO9ZWZJMBNhWGAxFWBM/E3ZUzZoYP0Tday3Hc66IsydsKc4E8UMYcCgfb6HjBxBXIY8jCW5k6kcxXwN3oWI816bkgjt2WDHSQ14ulzVb06gm1r0v9emI6MJAPXlRD3dtg7P28rTaTt0iOJxUuwjZe54p2rFjFIPxxCuJQ/QMAnz0PihXD5gRvhS+ri+jKN/Jy+GCGu2iXS8/PUNRIaP4O9dy/smSpJ2574U7kV3n2KveJE3fXjMnlmy5mshoDkaCn3QX2JTeUMtycjDJsOPK/g019M/+dsVEWcSAukd4OQox2GVCrfxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9lwXJje+1TOVlrFWJpE8x/RBngecn4YwvRC8EjApis=;
 b=dXvOSA1HmPL6Csq4PsTTb1PRhWo9s8kLLHHtrNFgHMOQYyEiP2BcDOVfv2Y+5J3RhiyhshWXXtGa/QZbuXFWBfxU025nnvYFrrNUbRkPO6Nq945RLBUyVjAkKPJZlaWHliYljBLBPx9cd1YyDf28ijsBHwJ2Yl4WGPBDfzNIdIB3j6RV+7ZVRYWqwwuDcEvLfQptvOlUIsfnnx5c7d2G2UAQ1PTrXP+wskU/M57yCvSy2DaQsx15o9H7HZDXc90BCxdPaF7dQ2GOh1ooRL+YuQPLsQPSSA85WEjUXe8Fn1PPlzQb5+vRqYLpszUVu6nldn7h3OOFoZLpcxvKg0qROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9lwXJje+1TOVlrFWJpE8x/RBngecn4YwvRC8EjApis=;
 b=q9xroqd0KW6vOWmFSmO5O6FKfIMoZiyiDhBbO94wfDo5B3C3pS2ue1t0XbZ9VtX5XmFOvOec/HGol5/EQjzCjBAhaRrXOQp4T/758nynUf8vM4xojqnUnOuOnFzlsUcT/CoSYbvbXrIskYlujTranDjvJxC5lagH5E1rJFJbKMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Sat, 8 Mar
 2025 00:37:45 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8511.017; Sat, 8 Mar 2025
 00:37:45 +0000
Content-Type: multipart/alternative;
 boundary="------------qPZ3TT4zl7ELfatoVmdtskq6"
Message-ID: <81d7d50d-4600-4afa-93de-56c00a59faed@amd.com>
Date: Fri, 7 Mar 2025 18:37:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Fix the race condition for draining retry
 fault
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250306060309.3222693-1-Emily.Deng@amd.com>
 <b6c5ca92-b76e-4565-b96b-eaea9c6296f6@amd.com>
 <CO6PR12MB54114B136035E851F1C260058FD52@CO6PR12MB5411.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <CO6PR12MB54114B136035E851F1C260058FD52@CO6PR12MB5411.namprd12.prod.outlook.com>
X-ClientProxiedBy: SN1PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:802:20::17) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbee444-45a2-46c6-4b40-08dd5dd97172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUFyOFQvSjMyZDRYb1lxcHJUNDVoMHh4bkw5YXhlYU5xbW5nbXFVdEpoT2o2?=
 =?utf-8?B?dXBDUTY3OVE4bWkwOUR3bmlFUVFGU2dnSlcyclJ4V0JMa3ZLUjY0MDlTLzhV?=
 =?utf-8?B?aUhLVUJoUmNZL01kbjZQSEI3MGgwamkrcHRQS3RTTVQ1VDM5VGxYaDJPWjFw?=
 =?utf-8?B?Tmxlb3lza3JrekJGdkpGRzNQWk5wTlRJOUNrdDgrRGRxZUZQSVhnd2hobmVl?=
 =?utf-8?B?YUJESzlKZFlZVjB5ZUQrZVFqYkYzeUQrZHJtUGZ4NGlGQ0llRk8rbWtaWndi?=
 =?utf-8?B?NzJOMm04MEJaN2dhUStINXNiblBBWDZ2K2xaeFRUTWlhbE5sUUhPdldUc3BI?=
 =?utf-8?B?WnkraEIrUUVyb3Jrb04zbDF2MUV0cGFJNFplK0YvUTBXT2sraldDT2trNjNw?=
 =?utf-8?B?V0ZjL2hWQWVBWDVCWXR5aHpGZUZMMm5LWlhaNGpML0N0U2lBNmNZZXhhVnZO?=
 =?utf-8?B?SVdJamljZGpkL0ZsNGlWRlQ0Vy9uYkZycjEvYlBhWWwzQkd6VjZaNnhkQjNY?=
 =?utf-8?B?MERldjdtbjNMWnBoTFZJMGE0ZEFBZ2lPdlNxRXRFV1lqQ0NBdkFGbll6b2U3?=
 =?utf-8?B?WmxKci9qLzcrSnhzbkFicXFWWHoyWHNCelI2T0gzYVlCRkdRZ2wzNllDVHZP?=
 =?utf-8?B?b25MK2wzNVZKMmNTZDJ1eGlBdjhUNk01Z1FaREhFcU9CdU9YREFOMnY3eFA0?=
 =?utf-8?B?dzdLY2pzamRsT3VhdzlwY3FvYyttMjc0V253SDUxNjMzelFSYTBYUndqRmxz?=
 =?utf-8?B?S21RVlg2YVI3K3A1VDI3MFZDSys4bngxZzB5ejZiNnUrK243cW5saWp6Nm0w?=
 =?utf-8?B?N21ReFpiN0lyMVdDcVI2N0hmei80a1lIY05RTG1SYWphRVkzTE5nVk9zWWEv?=
 =?utf-8?B?NGtzZXdMR2JvSUhvaUZOTUcva3VZM2dlVmw2dEdKL3YxZW16ZW93VDhEMHJ3?=
 =?utf-8?B?QmtkUEZoU1hRZG1PVTZMUENidFllbXdnSnFNWFBXVUVuNCtJbE01eCtERXhK?=
 =?utf-8?B?eWxQZVRUTWo4SnJpN1REalBNVm9xaE5kM0hGdWFHem9nci9vL3R1L3NSS3dZ?=
 =?utf-8?B?SmFiYTg0eks2enZMT05zMVl0bit6WTlkU0IxTFpmc3JsNHp0SnB0ZmdPQlEx?=
 =?utf-8?B?QlV6bEREYyt2UFpLNUpUbDE0UzFEcDYrTStvNjlvUFhSSkhSVnMwVVRIRWpY?=
 =?utf-8?B?ZEMrWDlkbkk4Nld1WjdOVC8xaTNkd1RFeW9YbDY1empaS1gwbW8yWENEUkY4?=
 =?utf-8?B?b1VMa0wySzdPR1NNbnBqcThFb2pmTitWNVJsZGhZRitQWFN0SUpjaElsTVU0?=
 =?utf-8?B?VnByckxkcFMwTEhiL1VPekxYVnk4cWU5Yk53emlEVnZyMkxQQTlhRDZLZ2lV?=
 =?utf-8?B?eVBRUkh2dW1MT2V3YWNsMWxZS0dsWWRRbXpHTW9qdHJRYkI4bUFxMGdrSHp6?=
 =?utf-8?B?b2Q4aHBkTDBhanVNaGpqc1pubkNDY1M5OUNwWCttY25ZZmVhdHVLb1dmZWNR?=
 =?utf-8?B?YUpVVlVuNEgxOGp3K0hyRkVUdkdSSFcwd04wYXRUcU81bVFiV2kvOFJ6N0Rr?=
 =?utf-8?B?ZVh1RnVPRWROeGFhNVk3S1ZZSGxhdWFncHFFWngvMDRhNTA0dHVwMEFjanpE?=
 =?utf-8?B?WXdFVHhnaVdNUnI1a1lKN3NGMFFndzUyZk1BNStxdEJEaFlqdjJwNDk0bVJT?=
 =?utf-8?B?UEV1eDVoTVN6UHBmYnZhT3hUaEZlUDdVTVBibUp5YVJGOFo2TmtSSjZPa0Vq?=
 =?utf-8?B?dDdrYXpqd3Q3RmxQMUZiSG1ucnRhdVZTVGczOUxLU2o5U1NzZkgrMmVxNmgy?=
 =?utf-8?B?a2FuREQ1NDBPZVQxZFM5aEFWUW4vVkVOMnVwVG9MbGlRdnBrTnhzbUhYbEVD?=
 =?utf-8?Q?DApIMnDgyrnMF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0IrMHZHeTZTM2RBMHhndzVyZGMxMlNtWDNuZ1Q3Q1p6LzJDOTF0bWlrQ3lC?=
 =?utf-8?B?U3A3UU9jT2JBUjVMZVArMHZScTY0aWxWcFFpTDFlZmkwTjlZNHNhcHhnUWNU?=
 =?utf-8?B?dm5maGVsaWFuVXJ6b2RveXN6Y0N1TGU5L1RybGo2d01BaEx3UzBrbmwrVk1V?=
 =?utf-8?B?b09OT0kvT3hUSmVid2J3LzJlUFZ3ZStlK002REhBY1pvQWl3V0JEVUVuamxv?=
 =?utf-8?B?NXI5RTlYeUZLa0ZFaXpZMm9ZKzBtN3hTWnRaV1FzSVJIUExDRXZXcHo2Wkxr?=
 =?utf-8?B?clVGZ1RLRlREMnlCaVVEN3VEL3p4Qmc2QUdYTVhNZG1IQkhTbGtEV29LcG5Y?=
 =?utf-8?B?MEd0ZzlHcTdKeEpMMll3cThRMHZsUXd6aW9BR1RnZytOTUFlY05URVVWQmlR?=
 =?utf-8?B?UXZlRnZTb3FQZ1NrbU9BODErc2dQeDBxK3VzdXVucHgvOGNDd2NqWjUvQSs1?=
 =?utf-8?B?b0JkOFJDNkQxMDI1ZStEMStFVmlvVy9kaEQrYXY3R3hDNmhoM0o5b2lVbU5N?=
 =?utf-8?B?YzZ0ZkZWRWI3cjU0KzZXVFNCeE90dUVBUk4wMG54Ym42WGJEL3EyZ1orL2dN?=
 =?utf-8?B?alJnNmVRMExDTUY5bjhNVlhFT1NGSzl0OGNTdjYralNsT1FUMWsxQUEzL3RS?=
 =?utf-8?B?MEFjVVZ4VzNvNEczZWVWUlYyNTB0Qm5FaEFsNDFqRGwyNGZaSmpsL3NWUEt2?=
 =?utf-8?B?U0xuUkpQUis2enJVT05YQkh0dDRZeUJiYWxmWGhiVXIvRml1ZzQxZEw3NWpI?=
 =?utf-8?B?Q3RheURYSmtWUWt0MFR4QnBQTEhUWUhGeC9KYWNMaHdSRDJtZ1JyRGIrVi9o?=
 =?utf-8?B?eFZHZzFMY1JZa2laajhNeVpLWlhNRFplNFNLUnJYU2ZKYkxnc3J5MnhNOUZI?=
 =?utf-8?B?VEgyQU1kVTc1UFBPc1VBYWF3dENBRVViVklycDJSallsRlpJS1E3anVSeHpE?=
 =?utf-8?B?STVnKzQzemJLY3ZGOThwTy8wVXY2OUg5VW1YSmhMRWVNUlpHZm04ZStXM2Vj?=
 =?utf-8?B?YXAyNGhwNUk2dzJFM1RwM05zUmRraUVTc0M1c3E2Wm5VUm1nN3BpcDhXZmxG?=
 =?utf-8?B?clFOdmVSQUUvQ0lTT29VYlYwYXJ0REx5b0NTTWJ6MFhNVlBDSktOc1BhdjFn?=
 =?utf-8?B?RjY2OXpnYXduZXFObGJQMmZMK01EZ1ZlcGphRzlwYjZGSkg0ZC9YcVNzbTVE?=
 =?utf-8?B?WFRxY0pPUnNoYmN0cXEwMktjam1uRy96ODF5ajNSVU1mazd4clYzdUVBVTBG?=
 =?utf-8?B?TFc3dW03TS9jRGRMRGNldHVCQkpIZnV1UDh1cytDOVRGcDEwREV0aUQ1UXBX?=
 =?utf-8?B?V0FsTUJTVE1SVjN4S095VTVBRlA3ZUVYakU0MnV6c2hlTWtpeG5nMEsvUDZl?=
 =?utf-8?B?L1lXTmtoeWxNSkU1QlZzVjFWRW11c3VaYWhXNFlYNGlOWWdoZ3p4UzNDdHJ5?=
 =?utf-8?B?a0xUQVhXaVUwYmRBWWZCV09DQ0tid0VnZi90M2NtYjFEVjV5aTBKMzNFVDlS?=
 =?utf-8?B?NzhGdXFrc3Y4ZTNzYnc1UXk1ZUIzTmgrU1NVRzlXQ3NBWTIvVk9BNzlxdmt6?=
 =?utf-8?B?dXJyc3lnN1NFQUtnMXMxbmNzbk9ldldxV3dJOG5VbFpYemNnOWlPZmVpT0VV?=
 =?utf-8?B?OUVrZDh6VmticEZudW02UGp0czExRWVDUjI1Rm5LQjFHVCtmSStWaDYyeVgr?=
 =?utf-8?B?emxiY0k4Ym9mRVQyNzJGM01mTGUxVDZiL2o1YXdSZXZiZ3AzejBCRlZKOXFU?=
 =?utf-8?B?c1JLazNmZm9MTmphdi80aTQ1c1I0MTVRazlRQ1JqTEJkOEM5Q1FyUklpYlhm?=
 =?utf-8?B?bFVJVW5yWWdoWktsNlZ2QklVK2RSRVllU1ZWSmhNeFVGQ2xWcWhFaUtFUisv?=
 =?utf-8?B?cWFXdDI4d3FoQjZjbjBUNHR1RmdKTEVMUmZ6K2hHNEJKd3Y5VHFjVTRIZWRT?=
 =?utf-8?B?ZFdKdDJVdVg2clAvclhzMisyanNEYTI5RGViZ1VPRG9RODl3RGY5YXBIK3Ew?=
 =?utf-8?B?U3A1Nkc1Z2RwdDd2U2ZpOWhMVTNITm1MOFNDVHpsWDV2MEY4Zk9aSldXM0lH?=
 =?utf-8?B?NFpPZUh0MlBraU5DQlRvQ0ptNlhQVCtwUllaWjdBZkFwa2hYL0lVQ2VlNzNY?=
 =?utf-8?Q?xaqs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbee444-45a2-46c6-4b40-08dd5dd97172
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 00:37:45.0982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UefNsx6+LXcxgmly9czUETsvnpq8CD7IXAAU9YO7REcnAnEFQigid9bBXAhSHleS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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

--------------qPZ3TT4zl7ELfatoVmdtskq6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/6/2025 7:27 PM, Deng, Emily wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
> *Sent:* Friday, March 7, 2025 1:01 AM
> *To:* Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH v4] drm/amdgpu: Fix the race condition for 
> draining retry fault
>
> Thanks for catch up and fix this race condition. It looks good to me. 
> One minor thing below:
>
> On 3/6/2025 12:03 AM, Emily Deng wrote:
>
>     Issue:
>
>     In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
>
>       has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
>
>     is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
>
>     continues execution and reaches svm_range_from_addr. This results in
>
>     a "failed to find prange..." error, causing the page recovery to fail.
>
>     How to fix:
>
>     Move the timestamp check code under the protection of svm->lock.
>
>     v2:
>
>     Make sure all right locks are released before go out.
>
>     v3:
>
>     Directly goto out_unlock_svms, and return -EAGAIN.
>
>     v4:
>
>     Refine code.
>
>     Signed-off-by: Emily Deng<Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>
>     ---
>
>       drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++-------------
>
>       1 file changed, 16 insertions(+), 14 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     index d04725583f19..83ac14bf7a7a 100644
>
>     --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     @@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>
>                      goto out;
>
>              }
>
>       
>
>     -       /* check if this page fault time stamp is before svms->checkpoint_ts */
>
>     -       if (svms->checkpoint_ts[gpuidx] != 0) {
>
>     -               if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
>
>     -                       pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>
>     -                       r = 0;
>
>     -                       goto out;
>
>     -               } else
>
>     -                       /* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
>
>     -                        * to zero to avoid following ts wrap around give wrong comparing
>
>     -                        */
>
>     -                svms->checkpoint_ts[gpuidx] = 0;
>
>     -       }
>
>     -
>
>              if (!p->xnack_enabled) {
>
>                      pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>
>                      r = -EFAULT;
>
>     @@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>
>              mmap_read_lock(mm);
>
>       retry_write_locked:
>
>              mutex_lock(&svms->lock);
>
>     +
>
>     +       /* check if this page fault time stamp is before svms->checkpoint_ts */
>
>     +       if (svms->checkpoint_ts[gpuidx] != 0) {
>
>     +               if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
>
>     +                       pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>
>     +                       r = -EAGAIN;
>
> We drop page fault because it is stale, not mean to handle it again. 
> if return -EAGAIN we do amdgpu_gmc_filter_faults_remove. If after 
> unmap, user map same range again we should treat page fault happened 
> at same range as new one.
>
> Regards
>
> Xiaogang
>
> Sorry, I didn't quite catch that. So, you think we shouldn't 
> remove the fault from amdgpu_gmc_filter_faults_remove?
>
I think return "-EAGAIN" means a page fault with an addr and a pasid is 
not handled this time. Same page fault will come back again and kfd will 
handle it, so remove it from filter to make sure it will be handled next 
time.

In this case this page fault is stale and we do not need or cannot 
handle it. There is no indication it will come back again and we need 
handle it.  I am not sure if should remove it from filter. I just 
concern if should return "-EAGAIN" in this case.

Regards

Xiaogang

> Emily Deng
>
> Best Wishes
>
>     +                       goto out_unlock_svms;
>
>     +               } else
>
>     +                       /* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
>
>     +                        * to zero to avoid following ts wrap around give wrong comparing
>
>     +                        */
>
>     +                svms->checkpoint_ts[gpuidx] = 0;
>
>     +       }
>
>     +
>
>              prange = svm_range_from_addr(svms, addr, NULL);
>
>              if (!prange) {
>
>                      pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
>
>     @@ -3165,7 +3166,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>
>              mutex_unlock(&svms->lock);
>
>              mmap_read_unlock(mm);
>
>       
>
>     -       svm_range_count_fault(node, p, gpuidx);
>
>     +       if (r != -EAGAIN)
>
>     +               svm_range_count_fault(node, p, gpuidx);
>
>       
>
>              mmput(mm);
>
>       out:
>
--------------qPZ3TT4zl7ELfatoVmdtskq6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/6/2025 7:27 PM, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CO6PR12MB54114B136035E851F1C260058FD52@CO6PR12MB5411.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Friday, March 7, 2025 1:01 AM<br>
                    <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Subject:</b> Re: [PATCH v4] drm/amdgpu: Fix the
                    race condition for draining retry fault<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p>Thanks for catch up and fix this race condition. It looks
              good to me. One minor thing below:<o:p></o:p></p>
            <div>
              <p class="MsoNormal">On 3/6/2025 12:03 AM, Emily Deng
                wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre>Issue:<o:p></o:p></pre>
              <pre>In the scenario where svm_range_restore_pages is called, but svm-&gt;checkpoint_ts<o:p></o:p></pre>
              <pre> has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu<o:p></o:p></pre>
              <pre>is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages<o:p></o:p></pre>
              <pre>continues execution and reaches svm_range_from_addr. This results in<o:p></o:p></pre>
              <pre>a &quot;failed to find prange...&quot; error, causing the page recovery to fail.<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>How to fix:<o:p></o:p></pre>
              <pre>Move the timestamp check code under the protection of svm-&gt;lock.<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>v2:<o:p></o:p></pre>
              <pre>Make sure all right locks are released before go out.<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>v3:<o:p></o:p></pre>
              <pre>Directly goto out_unlock_svms, and return -EAGAIN.<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>v4:<o:p></o:p></pre>
              <pre>Refine code.<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
              <pre>---<o:p></o:p></pre>
              <pre> drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++-------------<o:p></o:p></pre>
              <pre> 1 file changed, 16 insertions(+), 14 deletions(-)<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
              <pre>index d04725583f19..83ac14bf7a7a 100644<o:p></o:p></pre>
              <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
              <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
              <pre>@@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              <pre> <o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if this page fault time stamp is before svms-&gt;checkpoint_ts */<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svms-&gt;checkpoint_ts[gpuidx] != 0) {<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ih_ts_after_or_equal(ts,&nbsp; svms-&gt;checkpoint_ts[gpuidx])) {<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ts is after svms-&gt;checkpoint_ts now, reset svms-&gt;checkpoint_ts<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  * to zero to avoid following ts wrap around give wrong comparing<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  */<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svms-&gt;checkpoint_ts[gpuidx] = 0;<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              <pre>-<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled) {<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;XNACK not enabled for pasid 0x%x\n&quot;, pasid);<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;<o:p></o:p></pre>
              <pre>@@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_lock(mm);<o:p></o:p></pre>
              <pre> retry_write_locked:<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;svms-&gt;lock);<o:p></o:p></pre>
              <pre>+<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if this page fault time stamp is before svms-&gt;checkpoint_ts */<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svms-&gt;checkpoint_ts[gpuidx] != 0) {<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ih_ts_after_or_equal(ts,&nbsp; svms-&gt;checkpoint_ts[gpuidx])) {<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;<o:p></o:p></pre>
            </blockquote>
            <p>We drop page fault because it is stale, not mean to
              handle it again. if return -EAGAIN we do
              amdgpu_gmc_filter_faults_remove. If after unmap, user map
              same range again we should treat page fault happened at
              same range as new one.&nbsp;<o:p></o:p></p>
            <p>Regards<o:p></o:p></p>
            <p>Xiaogang<o:p></o:p></p>
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Sorry,
                I didn't quite catch that. So, you think we shouldn't
                remove&nbsp;the fault from amdgpu_gmc_filter_faults_remove?</span></p>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I think return &quot;-EAGAIN&quot; means a page fault with an addr and a
      pasid is not handled this time. Same page fault will come back
      again and kfd will handle it, so remove it from filter to make
      sure it will be handled next time. <br>
    </p>
    <p>In this case this page fault is stale and we do not need or
      cannot handle it. There is no indication it will come back again
      and we need handle it.&nbsp; I am not sure if should remove it from
      filter. I just concern if should return &quot;-EAGAIN&quot; in this case.</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:CO6PR12MB54114B136035E851F1C260058FD52@CO6PR12MB5411.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily Deng<o:p></o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best Wishes<o:p></o:p></span></p>
          </div>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_svms;<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ts is after svms-&gt;checkpoint_ts now, reset svms-&gt;checkpoint_ts<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  * to zero to avoid following ts wrap around give wrong comparing<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  */<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svms-&gt;checkpoint_ts[gpuidx] = 0;<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_from_addr(svms, addr, NULL);<o:p></o:p></pre>
            <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {<o:p></o:p></pre>
            <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to find prange svms 0x%p address [0x%llx]\n&quot;,<o:p></o:p></pre>
            <pre>@@ -3165,7 +3166,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,<o:p></o:p></pre>
            <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);<o:p></o:p></pre>
            <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_count_fault(node, p, gpuidx);<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r != -EAGAIN)<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_count_fault(node, p, gpuidx);<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmput(mm);<o:p></o:p></pre>
            <pre> out:<o:p></o:p></pre>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------qPZ3TT4zl7ELfatoVmdtskq6--
