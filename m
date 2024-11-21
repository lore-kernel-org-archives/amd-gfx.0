Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23E2D7877D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 15:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6CD10E990;
	Thu, 21 Nov 2024 15:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qLoOKyyr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 023E510E990
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 15:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwMcwPzIxbsJzuXy6GyxfUh0Fh+6vHRUbhBPblycHg/Sz2qpdfBAcQ/RNxj2IshPyogptds5xFcYrgFEIOM4X9wTOD8GQIZF8UZdraq3huGcskh1yo8pWWWGGeKwmpRH1L95YlMaBF/cFhg9mxD/QDVmyrksyxKvSWxLNfNVxVFPOVZBmINvh/cap0tIF/SFRGw+dPL/xd8kDco5X+fVeVEtegCq4EHxCXdBf5xxRugPNbH1jitVxKLKrotStJakuVoiXQOnH43+GUsY0JNfF7BgAxvF/uIU6ogNAmXQioOqaJL0BNeZt/1nB89+hhN53h4AlvJc9r0j1nMK5BMFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4X1ZWYhiV+NVwrUR9BZl0tNy6H7XT0BU3zp5/riH3A=;
 b=P0dkuuwRXY5TkftVw6613OwJ2ONYrDzXVc3/THXuT1DAbDCcF5iuUdRGqSfITK0iybLxGG/LmV9RULdnXhFFtAseRomBI4dLCb39SgbWI3vVbYSdP857c1ENSeXtkmOSBXf1Klpd5rCe6WxlzHJrYE5jvHKZDDOWZeRBILUBGtX3Bbf93Dpbkg5FWGXvNXyUn+TAhTpZwIXaXJ796kVw8NoJUeIg6IWjt/VWi3n9UgAFH00fGIYJxmWqaGr6NX+gZ9KrWc3kfVvkPiNxn///pBGszv2VimJoo9wMG3J6/meIR3nFqPzjlyOUXvfnQEgvAkM8To+u01NSaIij6YvByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4X1ZWYhiV+NVwrUR9BZl0tNy6H7XT0BU3zp5/riH3A=;
 b=qLoOKyyrgbDMitNYURH+ShZWIFcsVrkIc1c4EP+ov9tSyQZHOo3F6PtuHO4LqW/uEDGHfOY3uP1TLxE4M20PkdsJGG3aQVZRpDvnLE3eNwSEFbfDJtEN37NHBmWfSxx3PanrbHfF0OgVHk//m+f1f6Tul9R2/pvL+mXcuAME3x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.15; Thu, 21 Nov 2024 15:19:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 15:19:27 +0000
Message-ID: <1489df29-fe03-49d1-8191-b64f4e686c32@amd.com>
Date: Thu, 21 Nov 2024 16:19:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/amdgpu/sdma7: update mqd init for UQ
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241121131055.535-1-shashank.sharma@amd.com>
 <20241121131055.535-6-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241121131055.535-6-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: f23332f6-905d-4254-d46c-08dd0a3fe391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NStWZDZ2TXhnbzk3ZnpVYlNhcEVYdTYyS1NwcFpSUWhFYkVQTTZTMFlSVFZP?=
 =?utf-8?B?MXlWeHhDSzdNVU9sUWIzRWN5NndPdzlYbWFrcHd1OEVwYzRFSGZORWo3VlpE?=
 =?utf-8?B?TmcwZS9MalVKVDdpdlBMQ0QxaWMvZTZPd0ZOVnU4WU80Nkh3VVZIUHo2K3Rl?=
 =?utf-8?B?SzZYR01rekxMTWJ6N1dmNWs1KytLY2ZPYTdvVWhzd0p3M2xjbjZkT1RxK3pu?=
 =?utf-8?B?UUlkNDN6aXNkelRkd2dmSkZEUlB0YzRBZENnMHZSbjhXWWQ3Nmtpei9zNVlz?=
 =?utf-8?B?ZXpaUDc5UzF6VVljbnIyZXVvSUY4TjFsZmVmcTVpdTQ4SjlVRlNGbWFtZlpi?=
 =?utf-8?B?ZlZTTm1YTThqSEw4cXRsYnRIRjF5dHFNN3hJa2hhZENGY0hudjRZMWR0MmZk?=
 =?utf-8?B?bzNLR1gzUEZqSnNqeks3R2dCQzBEQ2MrdGM0N1U4cHlRQ3JVR3ZzTjE3Q2I0?=
 =?utf-8?B?Q0hBWHMza3pZMk9UYzlVT2hlSmwzbzliWmd0SUNibjZGeG01SE9hYUljdGpx?=
 =?utf-8?B?dEtNeGZmOC82V3lLNDJLTzdSRks3N2hYYndjSU85U2FwK3dGci82R0Q3UkRn?=
 =?utf-8?B?b2VYRU1wMXByd1lNYTF2V0hnQnl0cjJNczdVWk5Wc2dLWitROGJrYmt0Y2Iy?=
 =?utf-8?B?UlpKWU9TWlFHaFR1Y1IweE9Hb1J4bWd0aTkrSVZ0YWZuc1BEakllUEcyS3BX?=
 =?utf-8?B?WU1HY0xkSDlpYjBSRlVlR3RHR0Jmd0F1R3YzKzlBdktrWWRGUjIwWnFsRDhN?=
 =?utf-8?B?NDk3Z0FFc2w3SCt1Y3ZQZ2hIOGdPeEVaam5kbm04K2hXcTdpWlcva24xY1A1?=
 =?utf-8?B?T04zajJSQ2xneGFkWTQ5K2Raa3BZZkYyK01mVjZFUW1xdVpFY1QwUVN1VzFx?=
 =?utf-8?B?M1kxUW9lR3ByMVcyY0ROZTJTaVV5TnFZTmhrcC95eFNVQ1BDTnVWWHkvUGdn?=
 =?utf-8?B?ejVUMExUeEJKaXdocHFtZW1wRFB3K05DSnlyeEp5eWYyUmpVaTRZT2hac25X?=
 =?utf-8?B?eFhVWGJKSi82SDV5Ymd2MkxiNkltOUpjL0kwcXRPTUdqRExwMXhzTFU5Y1cz?=
 =?utf-8?B?VWswM2RZY0RmSVRvdDFPOTgrV1FpeGltOStWL3RIM1M3aHVFaFA0cmVBMzI5?=
 =?utf-8?B?eTJFVXU0OVF4NFJIejBlM3d2SlMybDI0ZU1UYmYzL08vRVhGOTA1SkhvNmZr?=
 =?utf-8?B?ZW1XdllhdEN5UEloRmljWHp0UEF1d3VwZUgySFBtSVgrZjkwa0N6TVBYOWlC?=
 =?utf-8?B?UWVWMkZVU1QwOFhyNVVUUnkzM2QxbXltamwweXJvckJPSG9FNlFZWTlXMzY0?=
 =?utf-8?B?UCtzRG9CRnlzVFJMUVh6YitnNWZjci9zcDRxQVNuSjA3MTJlcERpQnNaUlpP?=
 =?utf-8?B?YU13TFBGWTl2eHJjU1pJVm5qalJiWTFpbnpIZ0hSN2I1QjNtb1JqNFpNZEJ4?=
 =?utf-8?B?WUJDTDBNSVlsdHdicC9nd2Z4dkJBU2VHeXV6OEZuZHJVODI1ckxIUkhOT2Zl?=
 =?utf-8?B?ZTNWbGVYSmVvVTFZd3ZVeEsvdXBKQ0tLa0tNMkdDSEN2bTNBWGNVSVdNcVNt?=
 =?utf-8?B?dno3Vy9MbEJ3aENQdmV0M2RmYzJYSldlRVFkM3lSV3dYeUczSGdRWlpDTVNW?=
 =?utf-8?B?ZXUvZE1kTXBWZCtHQjMySlNzRGNxNi9zSW9sK0Fld1p2Y0M4K3RSZGFrN3Vw?=
 =?utf-8?B?MG1kdFE5bFVneEN1M01LenZLakVCdUQzUGdvKzZKVjd0VTBST2Rua3JjUkFn?=
 =?utf-8?Q?1lP8Ob3xq9Sya5LuPEyfUYBa57xB1hCIzlE1ySn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWF5ZFZxSVNXcHZkOE9OdmJFRU11amR0SFROVWpDZEIyNlJuVnlUb1hkdlVq?=
 =?utf-8?B?VnFHSS91a21paFYxY29EZ1pQeko3NmwxRC9ndlF1TzB4dFdIK0VzVlN0OFVa?=
 =?utf-8?B?RjZoa01uQUdzNVdCdm9sbmk2Z3RPbnJ2cVVOV3p3dkJtWCtaay9KeW1PV295?=
 =?utf-8?B?NHpUSmtQSmlqRXVlZ3REQmNPRWJaVm8xVDlPQUZJQkVTcGQ2Zy9nWTN5Q0x2?=
 =?utf-8?B?Tit0SWc1YWZYM0JqOURVOTEyWFpocU5JdThFWDR0cGY3ODJYcndRU0tPL0lv?=
 =?utf-8?B?eWs1Vm1lZDI1U3NmemZXdE5ZSlNiSEgyWDNkNG85bkpaNnNIaUpBMDNWZEhj?=
 =?utf-8?B?eUNVOUd3Nis3NkpNc2FzM1F4S3YyNTVxdDhIdjVxS0RPdWEyYUlROGpLc3dv?=
 =?utf-8?B?MVh4cjgzb0hJT2EwTGVCZmxiSUlUZkhJSVJhY0hqeXk5RWdPc3Q1OXRTaDhV?=
 =?utf-8?B?TXM1Q1RubnVhYUZtdG00Rk82V1JFdVkvTm44SHNpZUorMXFSODIrcllCSUdJ?=
 =?utf-8?B?eE9LekxscktyVlFocXhCR3JjNWZQb3JKOGdNWm1MZHpNbjQ5em9Cd1ptcVp4?=
 =?utf-8?B?WUl0MytNMFpidDlPaWN2UDZlSzZWMzZjU3dybndCK2hROHV3UWxhamJRSnVp?=
 =?utf-8?B?V3dlMDYybEp5Vm1TWWowVmQvOHNWTW1wYVUvYXQ3V0FZTGFOWU1tMWRyaTdN?=
 =?utf-8?B?d2xXM0FyVWxQcTVxc2tucGpwcE4yQW5TQVFRNVFFdCswNmZHQlNHbSt0V3RO?=
 =?utf-8?B?TFdwN2xVcFE1SStmaEprUDUxTkt6R3NJaEdDVnRWcnNMdzBjM1FKQmdtTmUr?=
 =?utf-8?B?d1VudXZ6Nmx0dmUyMnREb0RvUWV3ZVZSd3Zoa2VBTDR4UFhwMXNjWDd0TkVZ?=
 =?utf-8?B?UXJvTHUzaFJodlVWbGZRcUs5OHJaRXVBNjhOMnR6YVNHTFVMaWVoRS81a043?=
 =?utf-8?B?OU5jOUl2ZmtNL0N5SDN5cm41bVlWclF2cGk5K09hZ2hEV2FoUU13UTVVYXBR?=
 =?utf-8?B?NlBiOFlER0ZCKzl0YzFrMnZCOEJtMFVmNWo2bjRLL1JZekkxNmw5Mk12K2Nn?=
 =?utf-8?B?aGJ4YU52R2wyanlEMHJIa2pqWm43LzZtajhGR3cvRmxvRjFpVCtDck1UVjcv?=
 =?utf-8?B?dHNHZkRkQ0lNOTc1NEpPdTN1dUJXV0ZESzdZc2tHWThKZ1p2Y0wzNHJDOUJ6?=
 =?utf-8?B?dWc3dm1GZzczN3hocU1mYnRpZkRvWkZPZzRJY29GbTQxdGtzWVJya3FmTWlz?=
 =?utf-8?B?SjVqcTJ5TEUwOWRkcUk0d0NyYWN2NXFpdXNwYmtRYm5JbTRvNHcwb2NIYWYz?=
 =?utf-8?B?Z0ZBNU5PRzBHcWJObWtRQ0ZPbmk1eVJWNG1EWmhlWnBDU1ZzMjZxcGhCam9V?=
 =?utf-8?B?UGpvbzBiOEpIb0tUS3FMckh0N3ZWMzhvci8xZUc2M1laMkRWTGR5cmdxOVA4?=
 =?utf-8?B?QXlYdlRoc29YT1BLS0VKZHBBTnhTU2lMaTBvSzlMVzdkOTFjUm1VQjhmZ3N3?=
 =?utf-8?B?dmFrVi9DSkdoek90NnNGREZGTXJQakRvaU1CWTRTRUhDRVQzZUJ3TXdzR1lw?=
 =?utf-8?B?WXYzQVJHSGltWTc5anBwaVJpcmxGemwvaFdzOEhJbmE4LzZVeU56RDBKZFo5?=
 =?utf-8?B?Mk8yYzNFejJ1VGJOOERIK0ZNUTRwMGdLNjl4RG5RalZHazVRWGg3NDlDWGJE?=
 =?utf-8?B?UDdzWEpQeWZaMzNBNC9kQUxlU0I5ZlErN2MwZ2NvYk5QSVg4ZDlJNk9LWHcr?=
 =?utf-8?B?Yy9kZ1dwbk15OERZN01pb1hEVGlkSVpJSUdzSjZxNVRGNy81QzFjWFhjU1M5?=
 =?utf-8?B?elNNRTR0UnI3NzYwRW1ZWVU0RzJMcHB0OU9jUmVhSVc4TkthZThjZzVJd2Nk?=
 =?utf-8?B?N0doWUUrRHcxcFJvTy9PRVJxV2wwdEVJMmRBM01ZangyY1pNOGZVVFdpN3Fq?=
 =?utf-8?B?YWdRVlJOT3NtQTJ6d1Z2cXhxZmtoVXpuKzh1OWIydHIwbmc5ZTlDS21lait1?=
 =?utf-8?B?UlYvdC9NOU1OM3huQ0RUVGRUVCtNUHFTNlhpL0tFRGl6WDNCdFJmellzamEr?=
 =?utf-8?B?QzhMMW14UlIxMExZTEZqcjhxbXJOL0ladG9XNDFMampaRGFNUEx6OGxsQ1BI?=
 =?utf-8?Q?YvagEbaqxqArg5IWF+Rxnxldl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23332f6-905d-4254-d46c-08dd0a3fe391
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:19:27.6336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWxJVEd1lVjc7DUVLXy3bPmNZtWB9pILlUh8lduBenad1NPywSZjBTcbVH1mCJY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
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

Am 21.11.24 um 14:10 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Set the addresses for the UQ metadata.
>
> V2: Fix lower offset mask (Shashank)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index eb35ec9f3da2..fc9cb989aa6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -887,6 +887,9 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
>   	m->sdmax_rlcx_rb_aql_cntl = 0x4000;	//regSDMA0_QUEUE0_RB_AQL_CNTL_DEFAULT;
>   	m->sdmax_rlcx_dummy_reg = 0xf;	//regSDMA0_QUEUE0_DUMMY_REG_DEFAULT;
>   
> +	m->sdmax_rlcx_csa_addr_lo = prop->csa_addr & 0xFFFFFFFC;

Please use lower_32_bits() macro here.

If the lower bits can't be set on the CSA address we should have 
rejected that in the IOCTL and not silently mask that here.

Regards,
Christian.

> +	m->sdmax_rlcx_csa_addr_hi = upper_32_bits(prop->csa_addr);
> +
>   	return 0;
>   }
>   

