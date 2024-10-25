Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF706D0C609
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 13:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F5910EAC1;
	Fri, 25 Oct 2024 13:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a/ZxuU4Y";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2A210EAC1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 13:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjRmulGTqfcrbtGvAhdsWQxoeOzczw4kU+tFY/MpU52gb2dFZcVXAHJXJZ7h9UGuRemPatkwq3UzlhhWdYJVmtPVa4/uqGROMpvALrrJ7fH9aoqzfa+iaZ7AscLJi2cO4wHXV0DmXEQJAa9OSg4TjXdU3shHq4xmK7q32NyskKgoba23ogWL+V/F9U0KfHILTAjE3uyfYA/kzjKuthr9lNSZRy1WgFEJzvulqFR3/ICeLxIE8ThjW2b1JlbH8gOI5t0IbGaA68E7fnl5GGPbgeXTRBrcdN8LmSASn8ja4IxE3V2+kVEGFCp9DAyXZUta0BHB879O8eNzUQJGpys5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/JCICb4Dcy+qNXgz7fmqYVIJzd+9QwFt5iuQHNsBJs=;
 b=dJY/kogHeHwz87HrxQmzCu4aQc1EOY6+1zJT9IjUEs9UIzmrxK9pvSW6YIm14yXlGtntBnk7jQ8Ru3bCYOj1G3wUc6RKH9bd8I9TpwGDAeagJQwnQDZLbfNexYevhmGyAtsOE/X6b9vV+p8PhuGAS0f2A1kbYw8k+UaXuCBKjvHkc61GY3iz+tn5yXUJzNO9qzjcrcxx15HXXMjFQ11FEebd5xpgwkpEEsgasxc86Tsyen0ughlakGbuKEQ7A/5toK0jZHM7KveAralMK/P/sie7uZXCE5TyDlsWNUNPLbzlq32Zk1ym37z3TH0q7j3t2e9F16bai0g34NgfCJ+7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/JCICb4Dcy+qNXgz7fmqYVIJzd+9QwFt5iuQHNsBJs=;
 b=a/ZxuU4YqMSvJr+1x0BqlpVGctAWZZdO/2qbD1NdRdSwxvRzqNCfV0JVqror7icq22O4sM2VFIGU4ErBA6GBeJkalanW9OKdqpRYxwewxBWapN+jHJD0zHc7JYNIfibkH91sJvqDf5hiozn/aJighqHTqFmIYQvwKtwHJqIl5P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 13:06:53 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 13:06:53 +0000
Subject: Re: [PATCH 22/29] drm/amdgpu: sw_fini for each vcn instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-23-boyuan.zhang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <f16dfcae-49e1-95d6-fd95-239bb6746796@amd.com>
Date: Fri, 25 Oct 2024 18:36:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241025023545.465886-23-boyuan.zhang@amd.com>
Content-Type: multipart/alternative;
 boundary="------------A8775000AF5C6F6D2F3AECB3"
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: e64d2f5c-b232-488d-d9f1-08dcf4f5e54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?citxWEg5b2g1MGdxc0ZZOXQ1U2FMeUoycURCSm1FN3ZRM0o0ZEllQnl0cE90?=
 =?utf-8?B?NlA2d25sVUJQMTRhTzN5aU9LdzZLSEd0bnppYitUU3J2amN4R2VlTkFjOUtW?=
 =?utf-8?B?bEpGYVVPOHBQNm4vdHNKc1ZYbjhGanBVUGdUenBXUHRyMTdOZUw1aWtIOU5Z?=
 =?utf-8?B?aUZuUEl0N214WGd4SWpSMUtBQlBkUFdoK0pOeGllM25MZ3RxckRySFZxVnJO?=
 =?utf-8?B?UEo1aG44M2ZNSk9SRGxIamF1ZTVtc0RIY0NiTngvdnBRNHIzVThCbGxFVzJX?=
 =?utf-8?B?WG9oZEpWSlRYRFA3UTZXR3RZQ2xvcWFBQko4SWF6ZkREdU1hVC9ja3pRc1B6?=
 =?utf-8?B?N2JsL1ZGU0V6RGlFV0JlNE4xdHFGczdvYU44TllCbjdRZlplK2JvU2pBT1p1?=
 =?utf-8?B?TEI4QVoyMXR6bDdYWjVMNGltbVNpKy9uUjlKVXQwRzlveFV1Sk5xSDAzZFpU?=
 =?utf-8?B?MURCaHozUlJ1SlVWUDlhMmUwb3NoVXFlNjcvV1p2NUYraU5WMTdWN0c5U3lU?=
 =?utf-8?B?bjMrNzMrOFNEVDduUnBMQ3NNcWoyNTEvQ1NjWmttZUtiNUFaa1R3WWY5R2p1?=
 =?utf-8?B?QVFGRWdmRCsvS21DWEcxZFE0NXk5b28zbnE3bUJTNkozZTlaeE5LaCtkK1Fy?=
 =?utf-8?B?V0tFRTBRMzNaOUR1cGdKZGNFZjk3KzN0eUdQYms2cnR2UVBSd1dzZzM4anFl?=
 =?utf-8?B?eG5rUy8ySytLQmY0ZUwwS296dUoyTVNoQWlyQ0lEQWVIQWpscVlmTTJOTWhk?=
 =?utf-8?B?WGxqSE9kNUZ5b0F6SGc3QjRnYTFGT29oSDNQWTdjRWJMUEFqN0xUYm4wejRS?=
 =?utf-8?B?TC9zclR6a0hNdzRuY3g4WHEybEdtbXJYMGtNQkZnS3JIclliNE0vbWFXL2VC?=
 =?utf-8?B?dWhWVTM1cU5seGV5UlYveS9ZdHp2TG12UndpYWtCdnMySk5xN2VGZ1hESlRV?=
 =?utf-8?B?QU1WSkF0SHowczRGVlcxeG5DRWc5ODlJaGFBcnlRQUFlczQxQ3FBNFVBVWNJ?=
 =?utf-8?B?MGZUS2xMbkdVTEtSRmdFZ1QvYy96MG9rdzY3bjdhUm84VFdCY2FXSzltWStx?=
 =?utf-8?B?U1lvQVFpcklaeUIxbktJU244V2NDV00xTmI4UGpjUEVVQk1CVy9rR2NkQnZH?=
 =?utf-8?B?RGRmT0lzVWg5OHMzcjE4Y1NzdHlZeE93bkhFMHZOeGppeCtzMmNaL3hNbWc3?=
 =?utf-8?B?WHI2N0g2YXFINWZneEsrWmpSa0UveGhsWG9JeDJ6eGtZb2hJUEt2bW1VNCtx?=
 =?utf-8?B?SnlNSW93Q0dIaE02bVoxM2pUalFZRnJSUy9jS2luNngzMkFBY1paUjh6QXJt?=
 =?utf-8?B?NFF2cE1XWUxQVGVUcXFqby9WUEI1RWs0aE51d1B0azFaSG80MkFXbGc3ZWdi?=
 =?utf-8?B?c0xDNVlhRGVlVGZhZFhIWTdXR29XNlc1VlYzN2w1cTBFNk1XMUZUZmxuUTdM?=
 =?utf-8?B?eWVRN2lVNkhSUlN3Ym9tdi90L3VjY1NPZElaZ0pZOFZuR216TWF3OHprbEhV?=
 =?utf-8?B?aXI3N2JOc0xVeUZCai9mdjZ2aGgyUk1wMEk5RmppZlNhWmwxMlZnTnJESUhl?=
 =?utf-8?B?c3lKYjc3SDVSZnN1UDRYbTdHN3ZQdmYzZkdCVVh1blF6bXJqV1J4aWs1Zkkw?=
 =?utf-8?B?NDRuSFhQd2UrdVh5aUg2TUxoRTF5cm5lcEVPWERsNU8rSExRMjJZeitCVjQz?=
 =?utf-8?B?TTRtY0VPNjZuTFovSENITEltd3JiZWdBdXZ3alZJK2pnV1Y1MVhFRW8xQlNM?=
 =?utf-8?Q?FhG/c4ZvdgU/B3rrJA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdHSnVwL2E0RGZicDJnRVo5RHhXVkp3c2U4SjUzVDlHRjF2bHI2emIzcW00?=
 =?utf-8?B?RDg5Z1RmTEpjREIzTVNUWXhGeDVmZVB0VWNjWjJZek4yQncyT3k1Zy9wMUtQ?=
 =?utf-8?B?cERtV3YwbG5vbW9jNVAyaGtlbVRWQ0V5OU5kR0Q4WUt4QkZLZVNqMzh4K25z?=
 =?utf-8?B?bUFTVGtCV3N1SktFU2duTi81YVVtK2NLaG9nejc3MDlyalh4QkR4YitacHBN?=
 =?utf-8?B?QUIvOTUxdDZnVVcyTVVGTUFQQmIxS2tYQU9oN1RuNVhsRDdWSlN4WVlFS0Nv?=
 =?utf-8?B?Nk1hYy9aOGNZOFcraUgzYmNBWE5PMGE1SVJyeC9PUXZBNG1sTG5qRWJlMGI2?=
 =?utf-8?B?eG5XN0RjYjliYVBMK0RwZGo4WXdJR0pKU05CTmwwaVhDN3R0KzExNzkrMEhJ?=
 =?utf-8?B?RXhZWndxZkN1T09CclpYWGJmZW9VTzNqeUxOU3MzdW0zeGlMUkNYREZhN3Q4?=
 =?utf-8?B?c01Teit5L1E4dk1NNUtJR0VOT1RvT1RvUmJWRUhXOGlyTVR6a0x6VmJJRFRv?=
 =?utf-8?B?b2l6b2V0S2wrZUprWnhQc1piZGlDRFlzL3VqVmhSNHlPc0loNnBZMndJYlpF?=
 =?utf-8?B?N0dYckNXSG5VYnBNVFhqaDZwRkdKRzlHSzh3M1ZjNC9Gb29WcExkWCtocm82?=
 =?utf-8?B?NHZUYktwQU5ndHpNVkFwTkN5ZVl5aEs3Rm91aHl1UmJoNFFNMVd0d3lFVmZW?=
 =?utf-8?B?UnZ4MVNwbytJNEI5Ynh1UlN4VGlRVEMxczRGT0VEWEtISU12Z3ZHVks4S3dy?=
 =?utf-8?B?ME91K0RFczl5bU41ZGFkNEN2TUhpM3hqcU8ySG5sSUZlcCswOEcwcmsvbTky?=
 =?utf-8?B?R3BXUW1UMHh1Q24wSitUMG1QZmJNU2VySm1SUHNKOHBHaENuWTY5S093NUdJ?=
 =?utf-8?B?WTZZd3hST0s4ZDI5MHZWbnhjTExCU3dqbWg5cFZoRFNSUUluc2FNUy9BMUl6?=
 =?utf-8?B?UHVPc0pIODY2OU5Bb0hNWTNyeXk3ZTJpRlRNcUpubFh1RTdtTFBlR09nSjQ2?=
 =?utf-8?B?RlpLUEVCc2FFVVhBcXB6b281Q2lqTVIrZzN6cENYTzB4QTR3OURXMzN5eS92?=
 =?utf-8?B?eHhmQ2YrNlpRbHFNTHZTRWlnczhNclppRnNEMzhvcnpNOThmekl2ZklaaXFD?=
 =?utf-8?B?YTdwK3Uwc2drWXpXa09VTXFJQXNTRUROMXRudUE0TTVyWXgvVENtdFVCK3pZ?=
 =?utf-8?B?YS9TSWpyUmNhVCtBbm82SGU2WjRuRlhpK2ZEbHFwSytGSHBMZ3RXRDBRZUZ3?=
 =?utf-8?B?MFJuc1JrM1JOcmgzWjFHZlJINzUxeFZzU0xxdE5La0dNL0tmVCt3MVpZaDRh?=
 =?utf-8?B?WFl2VEVIcjRwd0tqNy9EbzJUMy9mNTczeGxsbzdTWVJwcHRXbU9nQ2FEMnE4?=
 =?utf-8?B?dXpvdm16N3daSGNTSW9Lb09TOUdka1NvTmJlT1RveHNIQ0k2cmY3NjVlUzFp?=
 =?utf-8?B?ZStXdVZTZkFycm96RWg0eGp2ekp2VlhtMTFxMlI4RXJRRVlKVTUrVzA0T3cw?=
 =?utf-8?B?NzZqNDJpbStQNDlYeXRDMGR4OFR3OXJod3Y5ZndBUVVBV2lseDJrbjlVRW5o?=
 =?utf-8?B?Z2o4TWUxWHZTNXJvT2ZXOVdEUTVNM1N5d0lidjFwTld0TzVaeGc4NWI5c09R?=
 =?utf-8?B?OUFmNVg1V2c1Nk8rT2NaMDBDbjFwb0tvajA5eDRySlE2c1JybWZ1MXg4bG1V?=
 =?utf-8?B?QS95WHZtNWJPd1B6eWhQM1pNS3lEc053bGJoQjhRSFpLdFplTG03elJzOWlS?=
 =?utf-8?B?WjEzMzBjQlo3NDZzLzBRcHZLdGY2dzZ4Sk1KYTMrKy9nTHJkMTY3MG96cU5x?=
 =?utf-8?B?NWFQb1NJRURnd3NMN1FFTUM3cEpFblV4cjdRczE3aEg2NkxoWkprS0JJM2hM?=
 =?utf-8?B?VHNua2gxbmpzRFd6aVJLT2dkTTlNYkxpQ25BS1A1VXAwNWxRam5idERvYVA3?=
 =?utf-8?B?UXgwWlV2VEdmajI5TEVnTzg5MURYQVp3Z0tJeWVCbzhNZ1dhTTdNUEpoek15?=
 =?utf-8?B?VkhPNHdCd3dSVE0xSDlyVkIySE5kWVZ0a3EwQStINHdPL2tnRk9aVktYbThL?=
 =?utf-8?B?TTJ3YVlGRlFKbTJyRTlZOW1uckdGS01rQ1Fwc05CY3BDVHpGWHBJVDJ1ZzZy?=
 =?utf-8?Q?76jfjZ5J4iq/MG47hiKqMqfMU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64d2f5c-b232-488d-d9f1-08dcf4f5e54d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:06:53.4484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYSnKRttA8UPopGHp2X+nmPSvRM1YChZjGKw47WgDmUFSJzvLiWLjKIXWK77ExRpst0+xvtynfuGL3oytOuePQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
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

--------------A8775000AF5C6F6D2F3AECB3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Looks fine to me as the changes are done to accomodate per instance ip 
block only
Acked-by: Sunil Khatri <sunil.khatri@amd.com 
<mailto:christian.koenig@amd.com>>

On 10/25/2024 8:05 AM, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_sw_fini(), and perform
> sw fini ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 36 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 ++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 21 +++++++--------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 16 +++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 +++++++--------
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 +++++++--------
>   10 files changed, 81 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2c55166e27d9..d515cfd2da79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -248,33 +248,31 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
>   	return 0;
>   }
>   
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
> +int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst)
>   {
> -	int i, j;
> -
> -	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> -		if (adev->vcn.harvest_config & (1 << j))
> -			continue;
> +	int i;
>   
> -		amdgpu_bo_free_kernel(
> -			&adev->vcn.inst[j].dpg_sram_bo,
> -			&adev->vcn.inst[j].dpg_sram_gpu_addr,
> -			(void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		goto done;
>   
> -		kvfree(adev->vcn.inst[j].saved_bo);
> +	amdgpu_bo_free_kernel(
> +		&adev->vcn.inst[inst].dpg_sram_bo,
> +		&adev->vcn.inst[inst].dpg_sram_gpu_addr,
> +		(void **)&adev->vcn.inst[inst].dpg_sram_cpu_addr);
>   
> -		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
> -					  &adev->vcn.inst[j].gpu_addr,
> -					  (void **)&adev->vcn.inst[j].cpu_addr);
> +	kvfree(adev->vcn.inst[inst].saved_bo);
>   
> -		amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
> +	amdgpu_bo_free_kernel(&adev->vcn.inst[inst].vcpu_bo,
> +				  &adev->vcn.inst[inst].gpu_addr,
> +				  (void **)&adev->vcn.inst[inst].cpu_addr);
>   
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> -			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
> +	amdgpu_ring_fini(&adev->vcn.inst[inst].ring_dec);
>   
> -		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
> -	}
> +	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +		amdgpu_ring_fini(&adev->vcn.inst[inst].ring_enc[i]);
>   
> +	amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
> +done:
>   	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
>   	mutex_destroy(&adev->vcn.vcn_pg_lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 4809da69bd1b..ce8000ca11ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -485,7 +485,7 @@ enum vcn_ring_type {
>   
>   int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
> +int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>   int amdgpu_vcn_resume(struct amdgpu_device *adev);
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 808d69ab0904..44370949fa57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -222,8 +222,9 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
> -	int r;
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
> +	int r;
>   
>   	r = amdgpu_vcn_suspend(adev);
>   	if (r)
> @@ -231,7 +232,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	jpeg_v1_0_sw_fini(ip_block);
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, inst);
>   
>   	kfree(adev->vcn.ip_dump);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index a86cff00d761..7b5f2696e60d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -245,9 +245,10 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
> -	int r, idx;
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
> +	int r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		fw_shared->present_flag_0 = 0;
> @@ -260,7 +261,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, inst);
>   
>   	kfree(adev->vcn.ip_dump);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 9967ac3fc51b..d135e63e7301 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -297,17 +297,18 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
> -	int i, r, idx;
>   	struct amdgpu_device *adev = ip_block->adev;
>   	volatile struct amdgpu_fw_shared *fw_shared;
> +	int inst = ip_block->instance;
> +	int r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> -			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -			fw_shared->present_flag_0 = 0;
> -		}
> +		if (adev->vcn.harvest_config & (1 << inst))
> +			goto done;
> +
> +		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = 0;
> +	done:
>   		drm_dev_exit(idx);
>   	}
>   
> @@ -319,7 +320,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, inst);
>   
>   	kfree(adev->vcn.ip_dump);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index e89088e3cd1d..d00b7a7cbdce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -306,19 +306,19 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, r, idx;
> +	int inst = ip_block->instance;
> +	int r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			volatile struct amdgpu_fw_shared *fw_shared;
> +		volatile struct amdgpu_fw_shared *fw_shared;
>   
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> -			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -			fw_shared->present_flag_0 = 0;
> -			fw_shared->sw_ring.is_enabled = false;
> -		}
> +		if (adev->vcn.harvest_config & (1 << inst))
> +			goto done;
>   
> +		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = 0;
> +		fw_shared->sw_ring.is_enabled = false;
> +	done:
>   		drm_dev_exit(idx);
>   	}
>   
> @@ -329,7 +329,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, inst);
>   
>   	kfree(adev->vcn.ip_dump);
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 1b492197c2b7..7c3a62f84707 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -258,20 +258,19 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, r, idx;
> +	int inst = ip_block->instance;
> +	int r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> -
> -			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -			fw_shared->present_flag_0 = 0;
> -			fw_shared->sq.is_enabled = 0;
> -		}
> +		if (adev->vcn.harvest_config & (1 << inst))
> +			goto done;
>   
> +		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = 0;
> +		fw_shared->sq.is_enabled = 0;
> +	done:
>   		drm_dev_exit(idx);
>   	}
>   
> @@ -282,7 +281,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, inst);
>   
>   	kfree(adev->vcn.ip_dump);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 5b61000f3004..5a3de3dbc3c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -219,16 +219,16 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, r, idx;
> +	int inst = ip_block->instance;
> +	int r, idx;
>   
>   	if (drm_dev_enter(&adev->ddev, &idx)) {
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +
> +		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = 0;
> +		fw_shared->sq.is_enabled = cpu_to_le32(false);
>   
> -			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -			fw_shared->present_flag_0 = 0;
> -			fw_shared->sq.is_enabled = cpu_to_le32(false);
> -		}
>   		drm_dev_exit(idx);
>   	}
>   
> @@ -239,7 +239,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, inst);
>   
>   	kfree(adev->vcn.ip_dump);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 4d944636d02b..2c9f863c40b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -227,20 +227,19 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, r, idx;
> +	int inst = ip_block->instance;
> +	int r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> +		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   
> -			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -			fw_shared->present_flag_0 = 0;
> -			fw_shared->sq.is_enabled = 0;
> -		}
> +		if (adev->vcn.harvest_config & (1 << inst))
> +			goto done;
>   
> +		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = 0;
> +		fw_shared->sq.is_enabled = 0;
> +	done:
>   		drm_dev_exit(idx);
>   	}
>   
> @@ -251,7 +250,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, inst);
>   
>   	kfree(adev->vcn.ip_dump);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 8efedf943581..9d67e884952a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -194,20 +194,19 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, r, idx;
> +	int inst = ip_block->instance;
> +	int r, idx;
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
> -
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> +		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>   
> -			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -			fw_shared->present_flag_0 = 0;
> -			fw_shared->sq.is_enabled = 0;
> -		}
> +		if (adev->vcn.harvest_config & (1 << inst))
> +			goto done;
>   
> +		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
> +		fw_shared->present_flag_0 = 0;
> +		fw_shared->sq.is_enabled = 0;
> +	done:
>   		drm_dev_exit(idx);
>   	}
>   
> @@ -215,7 +214,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_sw_fini(adev);
> +	r = amdgpu_vcn_sw_fini(adev, inst);
>   
>   	kfree(adev->vcn.ip_dump);
>   

--------------A8775000AF5C6F6D2F3AECB3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p>Looks fine to me as the changes are done to accomodate per
      instance ip block only<br>
      Acked-by: Sunil Khatri &lt;<a href="mailto:christian.koenig@amd.com">sunil.khatri@amd.com</a>&gt;</p>
    <div class="moz-cite-prefix">On 10/25/2024 8:05 AM,
      <a class="moz-txt-link-abbreviated" href="mailto:boyuan.zhang@amd.com">boyuan.zhang@amd.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241025023545.465886-23-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>

Pass instance parameter to amdgpu_vcn_sw_fini(), and perform
sw fini ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 36 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 21 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 16 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 +++++++--------
 10 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2c55166e27d9..d515cfd2da79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -248,33 +248,31 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
 	return 0;
 }
 
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
-
-	for (j = 0; j &lt; adev-&gt;vcn.num_vcn_inst; ++j) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; j))
-			continue;
+	int i;
 
-		amdgpu_bo_free_kernel(
-			&amp;adev-&gt;vcn.inst[j].dpg_sram_bo,
-			&amp;adev-&gt;vcn.inst[j].dpg_sram_gpu_addr,
-			(void **)&amp;adev-&gt;vcn.inst[j].dpg_sram_cpu_addr);
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		goto done;
 
-		kvfree(adev-&gt;vcn.inst[j].saved_bo);
+	amdgpu_bo_free_kernel(
+		&amp;adev-&gt;vcn.inst[inst].dpg_sram_bo,
+		&amp;adev-&gt;vcn.inst[inst].dpg_sram_gpu_addr,
+		(void **)&amp;adev-&gt;vcn.inst[inst].dpg_sram_cpu_addr);
 
-		amdgpu_bo_free_kernel(&amp;adev-&gt;vcn.inst[j].vcpu_bo,
-					  &amp;adev-&gt;vcn.inst[j].gpu_addr,
-					  (void **)&amp;adev-&gt;vcn.inst[j].cpu_addr);
+	kvfree(adev-&gt;vcn.inst[inst].saved_bo);
 
-		amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[j].ring_dec);
+	amdgpu_bo_free_kernel(&amp;adev-&gt;vcn.inst[inst].vcpu_bo,
+				  &amp;adev-&gt;vcn.inst[inst].gpu_addr,
+				  (void **)&amp;adev-&gt;vcn.inst[inst].cpu_addr);
 
-		for (i = 0; i &lt; adev-&gt;vcn.num_enc_rings; ++i)
-			amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[j].ring_enc[i]);
+	amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[inst].ring_dec);
 
-		amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[j].fw);
-	}
+	for (i = 0; i &lt; adev-&gt;vcn.num_enc_rings; ++i)
+		amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[inst].ring_enc[i]);
 
+	amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[inst].fw);
+done:
 	mutex_destroy(&amp;adev-&gt;vcn.vcn1_jpeg1_workaround);
 	mutex_destroy(&amp;adev-&gt;vcn.vcn_pg_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 4809da69bd1b..ce8000ca11ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -485,7 +485,7 @@ enum vcn_ring_type {
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 808d69ab0904..44370949fa57 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -222,8 +222,9 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
+	int r;
 
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
@@ -231,7 +232,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_sw_fini(ip_block);
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index a86cff00d761..7b5f2696e60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -245,9 +245,10 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int r, idx;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 	volatile struct amdgpu_fw_shared *fw_shared = adev-&gt;vcn.inst-&gt;fw_shared.cpu_addr;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
 		fw_shared-&gt;present_flag_0 = 0;
@@ -260,7 +261,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 9967ac3fc51b..d135e63e7301 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -297,17 +297,18 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int i, r, idx;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
+	int inst = ip_block-&gt;instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-			if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-				continue;
-			fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared-&gt;present_flag_0 = 0;
-		}
+		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+			goto done;
+
+		fw_shared = adev-&gt;vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared-&gt;present_flag_0 = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -319,7 +320,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index e89088e3cd1d..d00b7a7cbdce 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -306,19 +306,19 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, r, idx;
+	int inst = ip_block-&gt;instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_fw_shared *fw_shared;
+		volatile struct amdgpu_fw_shared *fw_shared;
 
-			if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-				continue;
-			fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared-&gt;present_flag_0 = 0;
-			fw_shared-&gt;sw_ring.is_enabled = false;
-		}
+		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+			goto done;
 
+		fw_shared = adev-&gt;vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared-&gt;present_flag_0 = 0;
+		fw_shared-&gt;sw_ring.is_enabled = false;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -329,7 +329,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev-&gt;vcn.ip_dump);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1b492197c2b7..7c3a62f84707 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -258,20 +258,19 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, r, idx;
+	int inst = ip_block-&gt;instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-			if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-				continue;
-
-			fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared-&gt;present_flag_0 = 0;
-			fw_shared-&gt;sq.is_enabled = 0;
-		}
+		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+			goto done;
 
+		fw_shared = adev-&gt;vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared-&gt;present_flag_0 = 0;
+		fw_shared-&gt;sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -282,7 +281,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5b61000f3004..5a3de3dbc3c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -219,16 +219,16 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, r, idx;
+	int inst = ip_block-&gt;instance;
+	int r, idx;
 
 	if (drm_dev_enter(&amp;adev-&gt;ddev, &amp;idx)) {
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
+		fw_shared = adev-&gt;vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared-&gt;present_flag_0 = 0;
+		fw_shared-&gt;sq.is_enabled = cpu_to_le32(false);
 
-			fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared-&gt;present_flag_0 = 0;
-			fw_shared-&gt;sq.is_enabled = cpu_to_le32(false);
-		}
 		drm_dev_exit(idx);
 	}
 
@@ -239,7 +239,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 4d944636d02b..2c9f863c40b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -227,20 +227,19 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, r, idx;
+	int inst = ip_block-&gt;instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
-			if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-				continue;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-			fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared-&gt;present_flag_0 = 0;
-			fw_shared-&gt;sq.is_enabled = 0;
-		}
+		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+			goto done;
 
+		fw_shared = adev-&gt;vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared-&gt;present_flag_0 = 0;
+		fw_shared-&gt;sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -251,7 +250,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 8efedf943581..9d67e884952a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -194,20 +194,19 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, r, idx;
+	int inst = ip_block-&gt;instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &amp;idx)) {
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
-
-			if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-				continue;
+		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 
-			fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared-&gt;present_flag_0 = 0;
-			fw_shared-&gt;sq.is_enabled = 0;
-		}
+		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+			goto done;
 
+		fw_shared = adev-&gt;vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared-&gt;present_flag_0 = 0;
+		fw_shared-&gt;sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -215,7 +214,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev-&gt;vcn.ip_dump);
 
</pre>
    </blockquote>
  </body>
</html>

--------------A8775000AF5C6F6D2F3AECB3--
