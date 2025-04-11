Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADA3C369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1169F10EC3E;
	Fri, 11 Apr 2025 17:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W6NDiRv5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9577210EC3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xh05OLhcGM0q6HOclw4HdywYF90A0x3oPfFjsitKeeLDb8VXbRgdSsAZA3Logzm/tw3uzTX+9Pq27B0t4BOulXpRD4Xe0+1prfKtGXLSQrInUfgOppL/eks8i+MCUUkCnjlXCsAgFxlGx+zKP02Sanz4MRcfl4e4BO8oDDaGMmhUEke5NsWrNU34XV8KSbj1HgOKlGlBs/1XN3FZorfESOt3IdlbWNi+iw3O0JSNjovoskAGOWpmy8oD9YCTqWLHC4KPuiVO9oS1eNheYFeSnr6rXJifcKekaxPUlpa+OavOxtSaDomx/x72LQJ8i/hoFQXXctk48m9KZHmJS9gM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3Gym2HqF+JYRD97NEinGA8d9/DUPC/BS0Y3o0iH6TE=;
 b=AdwUO2V/WJYCesTzG3YpBd+wlTsAC7ZPIWyxFYsqRfsNVcNVY8qidIGEl+XzyjfEZYiSquTlycuai/4mlCHCE8fDrWvaBrTQRHNMsgiiIlaAWE3XSkpvvt9nvBBkGoi5oLvjDddwlSZzMJVQyO0uw8we5fk7YAj7mK6imu4Tbja7f79ttLXxq7JL/hpzE3E39U1+Yqii9rDYQNfhIsT9uO0AWH5zifw1+G5nOgzFXqR1HKf31GYYuO8ZVz6OuKysa4u5Hp3GfbtDXGMn8SW4Z6aZObh6Jcum25+lb04XusgK8rsFH3fROfwJBA3WQhE+8b0Q0HBjuu6EnL40fZKcEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3Gym2HqF+JYRD97NEinGA8d9/DUPC/BS0Y3o0iH6TE=;
 b=W6NDiRv5xR1Etu8ZzoiEjFYe8nWRPh25ffTiY8oWGNByU8hqxYepnOVLAob+f0ARWhHtkqPvFJm2OGvIcP5qJD0NEWXN7FyMAxHAa3mnJsmakhB8Rp/u5fMPzxIzZC0RxMv6Tlom18fEtP4hqM8QxmlmvbQXhN9RMzkr+isz8Rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:14:29 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:14:29 +0000
Message-ID: <3ab6f33c-5737-4257-a93f-0e6911ca4ec2@amd.com>
Date: Fri, 11 Apr 2025 22:44:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] drm/amdgpu/gfx12: add support for TMZ queues to
 mqd_init
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-11-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-11-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: d48675e4-7145-428f-8b7b-08dd791c514c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXZEenJwL29WdG1OVEdVM0ZOU3NTbzlkUjBEQ2h4SG1jdlZXVU5HZndtdkdp?=
 =?utf-8?B?YlI1NDJBS1Z3MXhrems2VldKQXU5MEl1bDlYMVJTZTc1dmdtT0VFUSsyMXdu?=
 =?utf-8?B?VWRPOGFuaDVOM3owSW5EKy9EWjV1cExQWnJuOHg4UytEWHRSY2hHaTFnUS9v?=
 =?utf-8?B?U3E2WjVnWE5pM3RDTGdrblJydDh2ZFpueElodDg1SzViNzU1cGZjM3BZd1Ur?=
 =?utf-8?B?SmI5cy9yOGRyR040MHhwMS96Qy93ZTNXYU5RTTdvR1NCYTg0ZHpwRGtOTitn?=
 =?utf-8?B?cSs3cGJFcTgwbzEzRm5HaE9HNTdsd2UySlJvUnRWUEU3d201cHNyK3RMUkYy?=
 =?utf-8?B?OGJwbW5GSkVXL0tKSzM2WlRBVklGaklXMFhxV1p4bFNRbHk3QlFPSGw3UU9t?=
 =?utf-8?B?M2FsVWNvdjFCT0tGVnpCN3U2MnFmdVlLZWxCZWVrNHh2Z011ZUFXVTJYaXJl?=
 =?utf-8?B?SWIwNjRSNDVuOXYvMFZaekp0Y09MRHN5dGt6SENDR2JmYlYvV2R2ZEhrcVgv?=
 =?utf-8?B?R1VhUGViMGJFTVBtNDMxTDliYXNnZUdZNG52Q2I2TDNWc2RvZzZZS0x2elV3?=
 =?utf-8?B?YVkzWWJJVjl1dkUzRzlNZDk0Vi9pbGVXamM4TDM2anl6bE9UU21XL1VjVWJu?=
 =?utf-8?B?Y2txVkVYdFpaZjZHUWwvVzFsclJmc0haV3dnQ3FGb2NTTWxGalFmOTQwZmpv?=
 =?utf-8?B?WGk5WUZId0lWcEFVLzJWM3lEZytHM01vbVYxdXd0QXVCNzlUK1lFd1Z2OC9m?=
 =?utf-8?B?eUhTbm1pY1JOYmxjSk5vZmQxWUwrYVpzQjVCYlpEZ1hNbXJ0WVRjVWpLcjdX?=
 =?utf-8?B?VUtSVWtMMHVCRlpPWVhXNy9Ic2UvOUFzbmhTRG1MV0wxTTVrcFBYRVBtckdr?=
 =?utf-8?B?OU9lUEN0c2dObUlRQkl6VE50VHAzcEZoMmJEVjc4MDBoZXBBUUZXUk9CbWt4?=
 =?utf-8?B?c3J0YWxaZTJ2eHpnclc1djBCTFEyOW53bDBELzR4dk0wNXB3QTdYVmVNV1Zj?=
 =?utf-8?B?S0NnN0ZXbjZyMm5oaFhVZE1YZllHS1pYWlViUUhhK2dtK3JFNzNMQTI4dHdS?=
 =?utf-8?B?eDYxaysrNnN0ZlUwa2FBQmRsbjVTYnBVQ1ZyVmZSZnhQVTJ3UVk0ejlBc0hu?=
 =?utf-8?B?T040OUxscGZUSVdBK2wvcjRIbEdndlRkbi9sNmxrdlRPbDg4dlhaakVIRitw?=
 =?utf-8?B?Qmo1c0djeEpaWWZKV1BGSXd6dlkrTjREdzJNbDFYdUpUdFU0MGNqQ2ZDVnhV?=
 =?utf-8?B?bWJ3YmlRTllxanFTd0oxY3pJMmJoMXBPYWlGU29VS2RiR2NOcDFsT1VlZHJY?=
 =?utf-8?B?ckhpUE5kd2drWGRqWmYxL3FpVkUxLzl4WjN6N25nU282TjFaSHFBWks3RThu?=
 =?utf-8?B?NzdlTkNtUzBQTDRkV2hDWXlEcUNTZThuSmthL0ZQbHhpaGdGamFFSFlzekM5?=
 =?utf-8?B?aEhEdzdPZjhmOXp1S3ZoSGRDM1lWS0w2ejliYnVVYXk3cUxQRzlJcDl0Wmhm?=
 =?utf-8?B?eVNRRHpIT0pFNi90NUJTM0djaEtsaFdEQlRuYnU1SW1QSnU0SEQwcFFNMHVS?=
 =?utf-8?B?NWo5SWxCMEdUeUxUQW5sNThQaWZoQkVkK3JFVno3TDRlbnJnU01ad2xieXdw?=
 =?utf-8?B?dmtKWGdZVW9ZNFJCWk9RaTB2WkJMNVMwdGpYMlExZ3BNdi9DcTIwbWdYd3NU?=
 =?utf-8?B?SklyVSswVHY2R2Y3UlIwZVMxV1pWQUFTZmU3R3M4Y3BPQ2s2Y1YrRFc0Qzlj?=
 =?utf-8?B?dmt2MGVTT1luYzhWVXRtWlU5NUhtOHphNVFuNHE0VVk0Z01WSGdqdXppeExX?=
 =?utf-8?B?bW81dzRLb1R6NFlKZjl1WnB3VW15a09xbXBuN1ZlcmFvZ2xoZEJ1TjhBWEFi?=
 =?utf-8?B?Wk5YMzd1S3A1Zy8zRDc0SFg1bTlXZ0xiTkZXanlVZEdkdWhhZWgxWVlPY21C?=
 =?utf-8?Q?zC41ZNzLEGA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdMWHFRbzBEbzVkT0R6NkZSTHFhZVZNeDc1elh0UmoyOXlhWXExZmZTZnp1?=
 =?utf-8?B?ZXZlR1hVRExZUE5KbTduUjlQeE81QVg3YXpJS2xzNHlaeFZFc29STjJkNkdt?=
 =?utf-8?B?ZS9aWHI5NGx6YWZpWTBUUDhJTHVvbkc1OUxxall4cC9jMDBHcjIwOUk1Q2hK?=
 =?utf-8?B?RmpQRjF6dVdqZ293eTVDWTZoR0RvNk1DMU1kdHFqQmN6bW1xbk5LUkErTldO?=
 =?utf-8?B?Z1hkbWllRjIzbVhpYUd1bHFWaWdoRjc0OGxqVTBva3dIaU8rZlo4ZHJnbGVE?=
 =?utf-8?B?akZ3cm1aRVF1OWV6ZThZYTAyMGtwUkRvdGJqNDVMVzVGNlpTUUtUL1dJb3gy?=
 =?utf-8?B?enV2Y0RtNW9VdVlUOWJmY3pCOFdzbk4xYXY4VVI2djVsK0NhY2RETGwzUFBp?=
 =?utf-8?B?OXNiK29FeExEODhhTHdWc3M2M055WG5Ib204dVhIdWZQSVZVQWV0NXNYRFFu?=
 =?utf-8?B?dXBLS1dWNnBKL3pwRHFXbjZ6RG1uOVBiQWRHMU43eUsydzl2U21ReTI2a3pY?=
 =?utf-8?B?TDlLakxiem5kTkU1dXZUS3Q4YXMyMEt3TjZvUVloK0t3TmhheDJhL05maDNk?=
 =?utf-8?B?N2pSWVJvOThPc0xtWm5TNUxvUWFIOVhkVllac2dJK0ZBTm9jR0c0dHlEeEVV?=
 =?utf-8?B?REp4aHhEYzMyTG5jdW90THVVSWJYVTFBMGd3Q0U0bHpKckIyS09BVW15TThL?=
 =?utf-8?B?YU56NjFnVzZ0YXkxYmxRTUovSFplRXcrU25pQm5yRDV3N3VWT29sWnZWOWN6?=
 =?utf-8?B?QmNFQWFtU3VKSWdESjhneGRLNklIbGNkL3V0VytKeU9LTmR4TEs1WXVCbTBT?=
 =?utf-8?B?aEIrS1ExV3ljSUxOSlpwN2YrLzBmYmczU0owbkxmWXZNNkgwbUxCK3lZVVhO?=
 =?utf-8?B?dG14UWNyNXZCQ0lpNUtaRXhIRUhpMXpWMU5IUmVoYllUU1dENXExbmpSZkpr?=
 =?utf-8?B?OFpmQ0MzTTRUaGZlaGxNclJDWitpU2tyVzg3Nm5ZVjdmUGZQUHdZUVZBck55?=
 =?utf-8?B?V09lbXVGdllMK2Z3M2hhcmhhRjZKeGNMY1ZxeTlNTHVJSHc1eWk4VUZWUjd2?=
 =?utf-8?B?OXNOVkZwNzF4Y3IwSmxsMS9VQXRCd2JCQWR6cnVEY09DdGttOExodkRSRk1h?=
 =?utf-8?B?MTdlZFBTM2htSEdiZGVqZWhCRHJaMmJqMFJ2bU5vVmxWc1FHNkZUaGsrRFBw?=
 =?utf-8?B?SjllMHBjaTRZdG9OUnBFb1FncVh6c3hUb01PYjlXOG92Skp2K2tvUVJZM3I0?=
 =?utf-8?B?N2RleTR0b3p6ZEc0T0N3eGZxaGJTQi96c0VWWVd1cWdxUmRjMTBFZGxPV0tp?=
 =?utf-8?B?YjVKYm1WK2hjZFlTVHVtN1ZPK0lEUjMwNmFrSUxUOWhEbE5xdnNiL2N0RTFD?=
 =?utf-8?B?K1FacTA5WWZZZkMvN093WDVwQ0crWGpJdFZZSWZMdVBhYWRNWmRKdU1YVTFX?=
 =?utf-8?B?SnUrbW9RM0loV2VLbnlpR0J3R0dzblF6djAzVHRrdUpUcjFrRmdZU29hS3VT?=
 =?utf-8?B?K25LUTBBQWRBTFJNQ2gyNk9DSEdnQy9IT2pkQWFDLzdJa2xVWE9LbUZpQWtx?=
 =?utf-8?B?dlBORTVkMnZKc09BeUVTbHAyYzZ3aURVUTlFNXFycGoyeUFvay9uQm9jcVBN?=
 =?utf-8?B?YWxyN2YxSTEwOERVMTYvZjBLaEk1QnpWRTAycUNhSUxpOXBUT2FZWmkzVnZm?=
 =?utf-8?B?ZFdZd1UyQVZiWGVERE9QOHZwOGh5YmNGS0o3dnpzWitaYktuNTM1R25zUHQ2?=
 =?utf-8?B?c3FXUEpVR3NBeHJreW5GNDNhNnVsb0R2M2oxK3pqL3BTVVhkVUt3U0JIV2dx?=
 =?utf-8?B?S0FFYzJHZUxLdW1XaFhtWWlRcWp2eWVVUHAyZVpjRktqVXpEYnUvT29mNzE0?=
 =?utf-8?B?OWlZZ2d1aHdFdE9NeDc1MFFabUt3d3NVRXVabXBJNm51emtBT1lWQ2FVWTll?=
 =?utf-8?B?RkJVejRMYWhVWkh3SFJzbkJzTEhQRkxlcUNwdEd0amFXQzN4blRlck5FZlpB?=
 =?utf-8?B?dWZicTZPelFlZ3EvNnBNNEg1dTFxMmxxR1grQ2R3NmJyRlErUGdkMWFGbDBL?=
 =?utf-8?B?WXFKNVpFNzZUZThhSUpVM1lwQ0lDV2VmN0NLcWptTDdFWWJrTnM4UFdqSXFi?=
 =?utf-8?Q?k8SMO+U2lmUtnj2QkKMbcpZvz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48675e4-7145-428f-8b7b-08dd791c514c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:14:28.9641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tueaj34FpE5aQONx689Gl9daQyhxGE21aEPhmWrigYvPUTyWGrE8qQhagFESqeLS+MXRjpuauTKWF1sOKWuPCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:24 AM, Alex Deucher wrote:
> Set up TMZ for queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 2474006b1a340..da67f27d65a33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3013,6 +3013,8 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
>   #ifdef __BIG_ENDIAN
>   	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
>   #endif
> +	if (prop->tmz_queue)
> +		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
>   	mqd->cp_gfx_hqd_cntl = tmp;
>   
>   	/* set up cp_doorbell_control */
> @@ -3164,6 +3166,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> +	if (prop->tmz_queue)
> +		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
>   	mqd->cp_hqd_pq_control = tmp;
>   
>   	/* set the wb address whether it's enabled or not */
