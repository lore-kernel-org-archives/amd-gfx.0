Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD825C02197
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 15:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABC310E359;
	Tue,  4 Feb 2025 15:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RDi3RSGR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C0810E359
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 15:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEW5VAC1ZwSA6EIWR094Icoes+pC3qJ3JZp3V3RFXqRIDPGgE/zCsEzQycg+ESSukFdon18hRMuU2WY3V1/l7rk4SBBTu0mx0oxzMqVNNv5ECSJK11DR1HhryBU2lxOOXPcRkQ45cqBcANaN8X6u7NwLPecdJUuMLWo5l6BLA2kp77GAROZEiohBJi9RqjZzEVQxOvml18Hy4o6qGPcAAmlINtFZ1faq1zOGTsyOpMDxsxl5FkFwePM82cEroSMwK93trKkjgQ5dUkSO52bhu3/Ly01crvlK/eM7bydYEmiMwC+KnxmI/b4cRZMw8y3Mn4rneC5NBJS4D9BQypkFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5NjUrvyPsZHu+OvqizDOP6Ewb1UaCf8z4nO32ppdtA=;
 b=DKTAPO6lNodBbKY2/hy7ehECFocKURCQV+o9B422Xz+dBGTvhxfj/SS2gHVhjoDA0gtaoeXuHkil3l/uKtIVZviKwmns2Gs9i2uRtopeU+nL7kjNA4NibNv92e+RNOjoGtn5t/i57QeF3LLhW9jzp9X85zDFzSS0N7jM6MFYauCsmhBzLrq0E27IjsX8E5NANkYRwJEVUDZRAc6uFmLqMlQSl7GJ2NtEd1fY8Sf894KvGbzoUHruSxHSTB1ECKBMjj5jT2CychW6gwJAetsj9FRPXCKdoxlHYx54GYJpvpU0jefM0w73e6xDVHzCDcyd9fP0a+BBF+PVOq3MRzdOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5NjUrvyPsZHu+OvqizDOP6Ewb1UaCf8z4nO32ppdtA=;
 b=RDi3RSGRTI37UvTxGO/mNhu4/6CgrCFpJMBmagyCVI9LnfJk7Zl5967By1cF0O/pQWKGp4z0V2uoNUgyqDL09oRBRWHRwZZMwOgRduK+i8Z6ensE5QrIPMLvzbBJItxJTFktTAtjyWrwuzajtkXsipsqi6XUwUuzRKDI8HVRwV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 15:35:35 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:35:29 +0000
Content-Type: multipart/alternative;
 boundary="------------BmUkl0BUFBU0KOuvThz50QfE"
Message-ID: <3f03c719-17fd-4d17-9046-1698be10fd36@amd.com>
Date: Tue, 4 Feb 2025 10:35:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/44] drm/amdgpu/vcn2.5: split code along instances
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-2-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR0101CA0249.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::7) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 16134fe6-b425-4557-202d-08dd45318ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGc2eWdMeS9VTXl1QTFZLzZMaHFnUVJOZzMySG51NUUyd2dRUnhiVDR2ZW1L?=
 =?utf-8?B?SEhlVVBWNmg5Y3FRNEpnUEN6eC9hZHdvZ2dFek5wRkdWQnNHVUJVdmF2ZG1L?=
 =?utf-8?B?RUJFWGhSdXJsMFM3UkxyNnpYQnlvbHlkSWVYRFg5SGRUUTRkeFprSmxMM005?=
 =?utf-8?B?STRwK0pJSUNqYVhqZTlTRzdpSDNMYTZFaHNYc3FuaFdwVUN1cnM5dENXOTJq?=
 =?utf-8?B?T2pMeC94YTRqMU1VdStoMjlQS3RmRU10eTgyakpBbmRlNElrR2I2MEhYMDg5?=
 =?utf-8?B?OXQ5MWJEcVBWMUVUTE5STmRhTEFKWlZDakNEOGEwcllRUFlXejdsbnRsQTU5?=
 =?utf-8?B?bWZhUHYyL25IWlNVT0wyaEk3NGpUZzlGNCtsRmJnYkExRUUwS0lxTHJtNFFB?=
 =?utf-8?B?YjNBNUplQVY1THFWU1hEbVRMTTNzZE40Z1NnM083d2VPdHhkeEdRQVlmTXR3?=
 =?utf-8?B?Zldlck9tTFMyaVdkckE3VFdQWHJ3Sk9jNjduVlNEWWdwOEJvdjQ1akdyQjUv?=
 =?utf-8?B?NTZySzA3azdydW9NbU9TcjFnK1RUWjJqcU9YY2ZJdjhNaWVoK00yZWh4QnIz?=
 =?utf-8?B?RTREanpLcU91TEpSSHBpRlgrWVZwcGIzTlNYZmNBb3JXS0hXNDlkYTIxR2NV?=
 =?utf-8?B?QTdBamd3U0tYVFV1dFdhUjlYWW91K2d4ZVFtOE9wL1BvaVJnMFcxeHBVK1pm?=
 =?utf-8?B?WkYyaG10ZjdKTVdBVkdmVXBhMGNYcDVHa0hhQmI3SHNSU2RxVThpcEdXVnZF?=
 =?utf-8?B?RVBvR2ZyMGdqd2xDSXBPREJqU25tc3EwOGU3VElTdUpjcEFDcmdJSEg2UWhw?=
 =?utf-8?B?d292RWp0UXgwS3pVMWNkMkxsemR0L3BzV2tORUQ3QldLRTRSS1RmR3IvZnNw?=
 =?utf-8?B?VDZ6eDJONUJ6WnhZdVY3MENtS1dlU0RiR0dkeU44VFZKUUU5ZVRoRk53Y05o?=
 =?utf-8?B?M09DbGRjdFRtb0hQcGFkdzgzdVpJSVgvYWM0ZWR5SzltOFNTMHg0Z3kyRUt4?=
 =?utf-8?B?VzQxaUhtRWpiejAvRzdWdHM2OTNxWlU4UHdVQUpCUjIwSUtXd2xHREtEVlM1?=
 =?utf-8?B?MWNMRDBubDBmZ25wRkduOGxKYXNLMHdueVR5OEpBNzhSd3FKakhndHVUaGRn?=
 =?utf-8?B?SzF0RzAzR24ydmxNUndKbDVGMEl1SlloUG1qVzlDYndDQVhOV2xPL1NRdmFC?=
 =?utf-8?B?cGliQ1crblJQOVVqVFJqZm5ibXBkSTFBSHBwMU9yeGN2bkVJbE5iNC85Vitu?=
 =?utf-8?B?cG9GNEpBTU14ZDRSa1NlN05IL0FwVTY2a2dTbGhEUy9wcy85SmRnQmlsSWQx?=
 =?utf-8?B?NEVpY3dwSTM2c2prWG9wUjNCVUsvSG42eFJhR2VpWStPY3pzd1BNZ3ZORlEx?=
 =?utf-8?B?Q1huOThFWHRoTmVjbHk0dzg5UkdkZ1hNaUpFb2tYc0F6Q1NpWVFXb2tLRUhL?=
 =?utf-8?B?QVJ3UXNpd1Y2WSs2ZzZmOXRZL1hVN3ZVUjVBdEZ6OFFIZ2VMQ2FiR1owbGN2?=
 =?utf-8?B?S0RVWDljT2RuREtqMHJzU0tyeVB0TUF0azd1WnQ1VUpYdmt6a3NSWlIvWkgw?=
 =?utf-8?B?L29SRnA4c0tBSXllMlZpRXNEejNLUmhaSnU3VFdPeHFoMVgzWDBrbHlQVTRl?=
 =?utf-8?B?eWRJUnpTQUdxODhvMkFuWXJoTFZvVWlHM3o2ZDRYMitlaW5DWmRvQ3VSUEFM?=
 =?utf-8?B?dkd3TlNaanV2Y2R5N0dZK3V0UDBIeHQ1MFZwbUtpTjAwQnR3bFYzcXM3UVMw?=
 =?utf-8?B?UXN2WFVsODMzRi9tOWZ3T1ZLU2lid1dQYlQ1Wlp1NWhIRXRDWEgwT2tJM3lh?=
 =?utf-8?B?cTNjRjN0Ukx4K2ZidWxpS2wxdFFQYVlJbGMrSU1MTVM2dlhaYjUzWStkdkQ2?=
 =?utf-8?Q?1YZzOzkv+4p73?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emsyY3JyOHdNdjVkQzBZUHlLZm5sSmVRL1JsWlVVYmNocDY5MytUNVlUWDdI?=
 =?utf-8?B?blRhNkJETFF2WmhSNVYyOWhJVUpIQWIrZnNxa2pKVlZuZWp6a1RadWhzVVI4?=
 =?utf-8?B?c3JDcmozSkdML3JRbTIyNDhnMHI5blc1MHM4UHF6c1pJalVIOWVCRWU1NkZX?=
 =?utf-8?B?WnIrS0JHVUVMZTBsMlBsbHJxeGNQTW1TT0h5eCsvQXgxVERzcGw5T2ZFSkR0?=
 =?utf-8?B?elJEeXkySklvd2R4TkduN2syTzV3YmtDeDM5S2NScWc4OU11K2w3aDJ3U1dM?=
 =?utf-8?B?YVV5QUp2RDkrZ2k2UFN3QllPeG9xM0NOUWFQZUFxT3pReWxLTHc4SWU1V1ZD?=
 =?utf-8?B?Rjk4MmQrZk51R3Uvdk1Qb2cybnJuQVkyMGlEcUJ5ZW1UMmpxSTl6NlJKYUF3?=
 =?utf-8?B?TVBpbmlKa0hreEdEQ1A2aGxFNERUQk9Wd1pTK1pKQ3p0Und2ZTdVRk1tNmRt?=
 =?utf-8?B?TFFoM2lLVUw5SysrWjR4TjJtc0x4SS9LWXhzcDljd0lLKzM2NlQrby9JRlhS?=
 =?utf-8?B?N1lyZVlsMWpRTTNUYUtwNFpTV1pFMTdGS0lWRWk3SzZkLzI0NnBQTzdkQ2JK?=
 =?utf-8?B?T3Z5M1NtUElkRmJQbllhZWVWdjRQcGZLcy9uVUorRmF0bFNhMUxJNWRETVhj?=
 =?utf-8?B?SW11eXpNZytHdENBL2NJZkMwZlAyOHNaMmE0a1FrTGgzSXIvRmxlZlZ6djRk?=
 =?utf-8?B?V3ZuSThwQTBKUjNEMlhSTGNlWWN0TFUvNHlKNnBSVnhsK015ZzFObjRPS0hJ?=
 =?utf-8?B?SFZSRSt5VjZBbHFkM0tELzZSNTFCdkNoRDlwWlNnWGkwRTVEbnNFcDY0MktN?=
 =?utf-8?B?NlpmbFY0SEZ1OVJ3MVB4dGpZb0NEMktWajRrR3VLRktoaldYMEhlY1dvb2Ru?=
 =?utf-8?B?WXZBWmpPS3FHY1VsV3Z5MUhiVXBIclJTcndQM2N6K3RSOURBMWpEcEV2dFhR?=
 =?utf-8?B?S1l0MXRtTWU5Z1JRZzBaV1lHcWtFcXkrMmZtaGdzRmhHR3JCYmRydklaVVds?=
 =?utf-8?B?SnBGNERnUEhJY3pBOTlsNm9PU1dnTlV6VGdPb1JhMTNFUXRCMWZUK3dRbVZ2?=
 =?utf-8?B?OU5Kb0dSMTQyQkJYS2p6SW9jYmMxN3hVTTBacHVEYXBRdXk5NmdYbmhadkdz?=
 =?utf-8?B?S051UDB2ZjJVbUJFNVp0NUh3M3p1a2EzMWhRS0dSRWlHQjcwR056SUlYYUlD?=
 =?utf-8?B?YlpaVVZkZkswUEtqVmpRNzJFQUF4TW1NWGEweDFqdkc0RDVlSW9IWDc2L2Yx?=
 =?utf-8?B?M2k3eFNtU1oraDhEaTdrMnpzMFJPcERIZG5KaGxYdkMraFR1REhWdlpsTlVm?=
 =?utf-8?B?RGl1WXlFUHdvTnBRanBCcmJLUGxBckNJRWxkTlhpeXFwWFROWEc5OFNPWFVw?=
 =?utf-8?B?QVI1d25kaHZGZFBzak4yN0V5YjljVnJzQWR3blVpZGhxVHEzZ0FrTFZPSHlC?=
 =?utf-8?B?b2RhWHJ6NVNOSkZkUkI0ZFVva0ppZXNNYzFJMVc5V0swRkZTNTV1Y3ZqUHdy?=
 =?utf-8?B?RUsyOENBZENnUFA5S2c0REdhYndyUGpxalRrSzRpWTI1dU1URi9LVUdEbDZr?=
 =?utf-8?B?aWJHTlRvTHk2aFpZaTlMcnVGbjcxQ2haTzZwankzSTUwajk2aFBhSG5aNklx?=
 =?utf-8?B?UnlBR3VXMXd6STFTRFIvQ0tPTTh3VEtnNTQzazhUcGE3TnJJM1lZbk1tVWxm?=
 =?utf-8?B?VE5sS1BzeGRmeXoxclIreWY2c3NCc2FQZFVBR2FZTG43eTR0cnovYXNyd1pz?=
 =?utf-8?B?YlQxUC9vQzY3dXVNWlp3SklQMCtGVkhLdGhOYlRWTWQwU2w1amRyYkZmTEZJ?=
 =?utf-8?B?WXlOY1lpNW9OaWQrTmtxQXphMjdyeHZZNGVzV0Jpa08xQTR6OHBONFJhb0tl?=
 =?utf-8?B?MWZIT3pMT0FxeldjTCtTQ2Q3bDVBSldsMHJWcFFaTU15NFRKa3Q4YnRVV1JM?=
 =?utf-8?B?aWx6VnJiRUNiNExkZlVWQVpOd0JqSVNkcC8veFkvRmVNQXJMVGFnQlVlK3g5?=
 =?utf-8?B?VGFFZzIzZG4rRGpxNSswOVlCbVI4NXllMTk2bTlCaFliUWp0djVWWVp2dHNY?=
 =?utf-8?B?K2VEeWlpdURIREhsTlNWTUs3NFM0MWJ1MEMzY3RiY0tMNmNrdzR4TDZmcW8r?=
 =?utf-8?Q?zRmYoYQ6rIPut9Ro1EpeKqgGH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16134fe6-b425-4557-202d-08dd45318ddd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:35:29.5430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9mLyB/ovuPwbp3m2Dj9cue+WAHKto8QfqUntHK5xeN865VcottwIZKeEZPiby6HCRgNPqN0o5rWHLh5UGRxzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585
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

--------------BmUkl0BUFBU0KOuvThz50QfE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:56, Alex Deucher wrote:
> Split the code on a per instance basis.  This will allow
> us to use the per instance functions in the future to
> handle more things per instance.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 841 +++++++++++++-------------
>   1 file changed, 411 insertions(+), 430 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index b518202955cad..b9be304aa294b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -452,64 +452,62 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
>    * vcn_v2_5_mc_resume - memory controller programming
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to resume
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
> +static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
>   {
>   	uint32_t size;
>   	uint32_t offset;
> -	int i;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
>   
> -		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
> -		/* cache window 0: fw */
> -		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> -				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
> -			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> -				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
> -			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
> -			offset = 0;
> -		} else {
> -			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> -				lower_32_bits(adev->vcn.inst[i].gpu_addr));
> -			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> -				upper_32_bits(adev->vcn.inst[i].gpu_addr));
> -			offset = size;
> -			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
> -				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
> -		}
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return;
>   
> -		/* cache window 1: stack */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
> -			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
> -			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
> -
> -		/* cache window 2: context */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
> -			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
> -			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
> -
> -		/* non-cache window */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
> -			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
> -			upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
> -			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
> +	size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
> +	/* cache window 0: fw */
> +	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> +			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> +			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
> +		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
> +		offset = 0;
> +	} else {
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> +			     lower_32_bits(adev->vcn.inst[i].gpu_addr));
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> +			     upper_32_bits(adev->vcn.inst[i].gpu_addr));
> +		offset = size;
> +		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
> +			     AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
>   	}
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
> +
> +	/* cache window 1: stack */
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
> +		     lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
> +		     upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
> +
> +	/* cache window 2: context */
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
> +		     lower_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
> +		     upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
> +
> +	/* non-cache window */
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
> +		     lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
> +		     upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
> +		     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
>   }
>   
>   static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> @@ -612,117 +610,115 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>    * vcn_v2_5_disable_clock_gating - disable VCN clock gating
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to disable clockgating on
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
>   {
>   	uint32_t data;
> -	int i;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* UVD disable CGC */
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> -			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> -		else
> -			data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> -		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> -		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
> -		data &= ~(UVD_CGC_GATE__SYS_MASK
> -			| UVD_CGC_GATE__UDEC_MASK
> -			| UVD_CGC_GATE__MPEG2_MASK
> -			| UVD_CGC_GATE__REGS_MASK
> -			| UVD_CGC_GATE__RBC_MASK
> -			| UVD_CGC_GATE__LMI_MC_MASK
> -			| UVD_CGC_GATE__LMI_UMC_MASK
> -			| UVD_CGC_GATE__IDCT_MASK
> -			| UVD_CGC_GATE__MPRD_MASK
> -			| UVD_CGC_GATE__MPC_MASK
> -			| UVD_CGC_GATE__LBSI_MASK
> -			| UVD_CGC_GATE__LRBBM_MASK
> -			| UVD_CGC_GATE__UDEC_RE_MASK
> -			| UVD_CGC_GATE__UDEC_CM_MASK
> -			| UVD_CGC_GATE__UDEC_IT_MASK
> -			| UVD_CGC_GATE__UDEC_DB_MASK
> -			| UVD_CGC_GATE__UDEC_MP_MASK
> -			| UVD_CGC_GATE__WCB_MASK
> -			| UVD_CGC_GATE__VCPU_MASK
> -			| UVD_CGC_GATE__MMSCH_MASK);
> -
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
> -
> -		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -		data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> -			| UVD_CGC_CTRL__SYS_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_MODE_MASK
> -			| UVD_CGC_CTRL__MPEG2_MODE_MASK
> -			| UVD_CGC_CTRL__REGS_MODE_MASK
> -			| UVD_CGC_CTRL__RBC_MODE_MASK
> -			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
> -			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> -			| UVD_CGC_CTRL__IDCT_MODE_MASK
> -			| UVD_CGC_CTRL__MPRD_MODE_MASK
> -			| UVD_CGC_CTRL__MPC_MODE_MASK
> -			| UVD_CGC_CTRL__LBSI_MODE_MASK
> -			| UVD_CGC_CTRL__LRBBM_MODE_MASK
> -			| UVD_CGC_CTRL__WCB_MODE_MASK
> -			| UVD_CGC_CTRL__VCPU_MODE_MASK
> -			| UVD_CGC_CTRL__MMSCH_MODE_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -		/* turn on */
> -		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
> -		data |= (UVD_SUVD_CGC_GATE__SRE_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_MASK
> -			| UVD_SUVD_CGC_GATE__SMP_MASK
> -			| UVD_SUVD_CGC_GATE__SCM_MASK
> -			| UVD_SUVD_CGC_GATE__SDB_MASK
> -			| UVD_SUVD_CGC_GATE__SRE_H264_MASK
> -			| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_H264_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
> -			| UVD_SUVD_CGC_GATE__SCM_H264_MASK
> -			| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
> -			| UVD_SUVD_CGC_GATE__SDB_H264_MASK
> -			| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
> -			| UVD_SUVD_CGC_GATE__SCLR_MASK
> -			| UVD_SUVD_CGC_GATE__UVD_SC_MASK
> -			| UVD_SUVD_CGC_GATE__ENT_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
> -			| UVD_SUVD_CGC_GATE__SITE_MASK
> -			| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
> -			| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
> -			| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
> -			| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> -		data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return;
> +	/* UVD disable CGC */
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> +		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +	else
> +		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> +	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
> +	data &= ~(UVD_CGC_GATE__SYS_MASK
> +		  | UVD_CGC_GATE__UDEC_MASK
> +		  | UVD_CGC_GATE__MPEG2_MASK
> +		  | UVD_CGC_GATE__REGS_MASK
> +		  | UVD_CGC_GATE__RBC_MASK
> +		  | UVD_CGC_GATE__LMI_MC_MASK
> +		  | UVD_CGC_GATE__LMI_UMC_MASK
> +		  | UVD_CGC_GATE__IDCT_MASK
> +		  | UVD_CGC_GATE__MPRD_MASK
> +		  | UVD_CGC_GATE__MPC_MASK
> +		  | UVD_CGC_GATE__LBSI_MASK
> +		  | UVD_CGC_GATE__LRBBM_MASK
> +		  | UVD_CGC_GATE__UDEC_RE_MASK
> +		  | UVD_CGC_GATE__UDEC_CM_MASK
> +		  | UVD_CGC_GATE__UDEC_IT_MASK
> +		  | UVD_CGC_GATE__UDEC_DB_MASK
> +		  | UVD_CGC_GATE__UDEC_MP_MASK
> +		  | UVD_CGC_GATE__WCB_MASK
> +		  | UVD_CGC_GATE__VCPU_MASK
> +		  | UVD_CGC_GATE__MMSCH_MASK);
> +
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
> +
> +	SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +	data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> +		  | UVD_CGC_CTRL__SYS_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_MODE_MASK
> +		  | UVD_CGC_CTRL__MPEG2_MODE_MASK
> +		  | UVD_CGC_CTRL__REGS_MODE_MASK
> +		  | UVD_CGC_CTRL__RBC_MODE_MASK
> +		  | UVD_CGC_CTRL__LMI_MC_MODE_MASK
> +		  | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> +		  | UVD_CGC_CTRL__IDCT_MODE_MASK
> +		  | UVD_CGC_CTRL__MPRD_MODE_MASK
> +		  | UVD_CGC_CTRL__MPC_MODE_MASK
> +		  | UVD_CGC_CTRL__LBSI_MODE_MASK
> +		  | UVD_CGC_CTRL__LRBBM_MODE_MASK
> +		  | UVD_CGC_CTRL__WCB_MODE_MASK
> +		  | UVD_CGC_CTRL__VCPU_MODE_MASK
> +		  | UVD_CGC_CTRL__MMSCH_MODE_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +	/* turn on */
> +	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
> +	data |= (UVD_SUVD_CGC_GATE__SRE_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_MASK
> +		 | UVD_SUVD_CGC_GATE__SMP_MASK
> +		 | UVD_SUVD_CGC_GATE__SCM_MASK
> +		 | UVD_SUVD_CGC_GATE__SDB_MASK
> +		 | UVD_SUVD_CGC_GATE__SRE_H264_MASK
> +		 | UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_H264_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
> +		 | UVD_SUVD_CGC_GATE__SCM_H264_MASK
> +		 | UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
> +		 | UVD_SUVD_CGC_GATE__SDB_H264_MASK
> +		 | UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
> +		 | UVD_SUVD_CGC_GATE__SCLR_MASK
> +		 | UVD_SUVD_CGC_GATE__UVD_SC_MASK
> +		 | UVD_SUVD_CGC_GATE__ENT_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
> +		 | UVD_SUVD_CGC_GATE__SITE_MASK
> +		 | UVD_SUVD_CGC_GATE__SRE_VP9_MASK
> +		 | UVD_SUVD_CGC_GATE__SCM_VP9_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
> +		 | UVD_SUVD_CGC_GATE__SDB_VP9_MASK
> +		 | UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> +	data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
>   			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
> -	}
> +		  | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
>   }
>   
>   static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
> @@ -774,65 +770,63 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   }
>   
>   /**
> - * vcn_v2_5_enable_clock_gating - enable VCN clock gating
> + * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to enable clockgating on
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
>   {
>   	uint32_t data = 0;
> -	int i;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* enable UVD CGC */
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> -			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> -		else
> -			data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> -		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> -		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -		data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> -			| UVD_CGC_CTRL__SYS_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_MODE_MASK
> -			| UVD_CGC_CTRL__MPEG2_MODE_MASK
> -			| UVD_CGC_CTRL__REGS_MODE_MASK
> -			| UVD_CGC_CTRL__RBC_MODE_MASK
> -			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
> -			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> -			| UVD_CGC_CTRL__IDCT_MODE_MASK
> -			| UVD_CGC_CTRL__MPRD_MODE_MASK
> -			| UVD_CGC_CTRL__MPC_MODE_MASK
> -			| UVD_CGC_CTRL__LBSI_MODE_MASK
> -			| UVD_CGC_CTRL__LRBBM_MODE_MASK
> -			| UVD_CGC_CTRL__WCB_MODE_MASK
> -			| UVD_CGC_CTRL__VCPU_MODE_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> -		data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
> -	}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return;
> +	/* enable UVD CGC */
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> +		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +	else
> +		data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +	data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> +		 | UVD_CGC_CTRL__SYS_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_MODE_MASK
> +		 | UVD_CGC_CTRL__MPEG2_MODE_MASK
> +		 | UVD_CGC_CTRL__REGS_MODE_MASK
> +		 | UVD_CGC_CTRL__RBC_MODE_MASK
> +		 | UVD_CGC_CTRL__LMI_MC_MODE_MASK
> +		 | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> +		 | UVD_CGC_CTRL__IDCT_MODE_MASK
> +		 | UVD_CGC_CTRL__MPRD_MODE_MASK
> +		 | UVD_CGC_CTRL__MPC_MODE_MASK
> +		 | UVD_CGC_CTRL__LBSI_MODE_MASK
> +		 | UVD_CGC_CTRL__LRBBM_MODE_MASK
> +		 | UVD_CGC_CTRL__WCB_MODE_MASK
> +		 | UVD_CGC_CTRL__VCPU_MODE_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> +	data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
>   }
>   
>   static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
> @@ -1006,197 +1000,185 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	return 0;
>   }
>   
> -static int vcn_v2_5_start(struct amdgpu_device *adev)
> +static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
>   {
> +	volatile struct amdgpu_fw_shared *fw_shared =
> +		adev->vcn.inst[i].fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
> -	int i, j, k, r;
> +	int j, k, r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, true, i);
> -	}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> -			continue;
> -		}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, true, i);
>   
> -		/* disable register anti-hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> -			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>   
> -		/* set uvd status busy */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
> -	}
> +	/* disable register anti-hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> +		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +
> +	/* set uvd status busy */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>   		return 0;
>   
> -	/*SW clock gating */
> -	vcn_v2_5_disable_clock_gating(adev);
> +	/* SW clock gating */
> +	vcn_v2_5_disable_clock_gating(adev, i);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* enable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -		/* disable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -		/* setup mmUVD_LMI_CTRL */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> -		tmp &= ~0xff;
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
> -			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> -			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -		/* setup mmUVD_MPC_CNTL */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> -		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> -
> -		/* setup UVD_MPC_SET_MUXA0 */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> -			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUXB0 */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> -			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -		/* setup mmUVD_MPC_SET_MUX */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> -			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -	}
> +	/* enable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>   
> -	vcn_v2_5_mc_resume(adev);
> +	/* disable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* VCN global tiling registers */
> -		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> -		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> +	/* setup mmUVD_LMI_CTRL */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> +	tmp &= ~0xff;
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
> +		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> +		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +	/* setup mmUVD_MPC_CNTL */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> +	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> +
> +	/* setup UVD_MPC_SET_MUXA0 */
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> +		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUXB0 */
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> +		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +	/* setup mmUVD_MPC_SET_MUX */
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> +		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +	vcn_v2_5_mc_resume(adev, i);
>   
> -		/* enable LMI MC and UMC channels */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> -			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +	/* VCN global tiling registers */
> +	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
>   
> -		/* unblock VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	/* enable LMI MC and UMC channels */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> +		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>   
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -		for (k = 0; k < 10; ++k) {
> -			uint32_t status;
> -
> -			for (j = 0; j < 100; ++j) {
> -				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
> -				if (status & 2)
> -					break;
> -				if (amdgpu_emu_mode == 1)
> -					msleep(500);
> -				else
> -					mdelay(10);
> -			}
> -			r = 0;
> +	/* unblock VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	for (k = 0; k < 10; ++k) {
> +		uint32_t status;
> +
> +		for (j = 0; j < 100; ++j) {
> +			status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
>   			if (status & 2)
>   				break;
> +			if (amdgpu_emu_mode == 1)
> +				msleep(500);
> +			else
> +				mdelay(10);
> +		}
> +		r = 0;
> +		if (status & 2)
> +			break;
>   
> -			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -				UVD_VCPU_CNTL__BLK_RST_MASK,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> -			mdelay(10);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +			 UVD_VCPU_CNTL__BLK_RST_MASK,
> +			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		mdelay(10);
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -			mdelay(10);
> -			r = -1;
> -		}
> +		mdelay(10);
> +		r = -1;
> +	}
>   
> -		if (r) {
> -			DRM_ERROR("VCN decode not responding, giving up!!!\n");
> -			return r;
> -		}
> +	if (r) {
> +		DRM_ERROR("VCN decode not responding, giving up!!!\n");
> +		return r;
> +	}
>   
> -		/* enable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> -			UVD_MASTINT_EN__VCPU_EN_MASK,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> +	/* enable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> +		 UVD_MASTINT_EN__VCPU_EN_MASK,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -		/* clear the busy bit of VCN_STATUS */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> -			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +	/* clear the busy bit of VCN_STATUS */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> +		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>   
> -		ring = &adev->vcn.inst[i].ring_dec;
> -		/* force RBC into idle state */
> -		rb_bufsz = order_base_2(ring->ring_size);
> -		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
> +	ring = &adev->vcn.inst[i].ring_dec;
> +	/* force RBC into idle state */
> +	rb_bufsz = order_base_2(ring->ring_size);
> +	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> +	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>   
> -		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> -		/* program the RB_BASE for ring buffer */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> -			lower_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> -			upper_32_bits(ring->gpu_addr));
> +	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> +	/* program the RB_BASE for ring buffer */
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> +		     lower_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> +		     upper_32_bits(ring->gpu_addr));
>   
> -		/* Initialize the ring buffer's read and write pointers */
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
> +	/* Initialize the ring buffer's read and write pointers */
> +	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>   
> -		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> -				lower_32_bits(ring->wptr));
> -		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
> +	ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> +	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> +		     lower_32_bits(ring->wptr));
> +	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>   
> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> -		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
> -
> -		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
> -		ring = &adev->vcn.inst[i].ring_enc[1];
> -		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> -		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
> -	}
> +	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
> +	ring = &adev->vcn.inst[i].ring_enc[0];
> +	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> +	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> +	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
> +
> +	fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
> +	ring = &adev->vcn.inst[i].ring_enc[1];
> +	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> +	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>   
>   	return 0;
>   }
> @@ -1425,72 +1407,66 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   	return 0;
>   }
>   
> -static int vcn_v2_5_stop(struct amdgpu_device *adev)
> +static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
>   {
>   	uint32_t tmp;
> -	int i, r = 0;
> +	int r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v2_5_stop_dpg_mode(adev, i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v2_5_stop_dpg_mode(adev, i);
>   
> -		/* wait for vcn idle */
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -		if (r)
> -			return r;
> +	/* wait for vcn idle */
> +	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +	if (r)
> +		return r;
>   
> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__READ_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* block LMI UMC channel */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
> +	/* block LMI UMC channel */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
>   
> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> -			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* block VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> -			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	/* block VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> +		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -		/* reset VCPU */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	/* reset VCPU */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__BLK_RST_MASK,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		/* disable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -			~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +	/* disable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -		/* clear status */
> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
> +	/* clear status */
> +	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>   
> -		vcn_v2_5_enable_clock_gating(adev);
> +	vcn_v2_5_enable_clock_gating(adev, i);
>   
> -		/* enable register anti-hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
> -			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> -			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> -	}
> +	/* enable register anti-hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
> +		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> +		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, false, i);
> -	}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, false, i);
>   
>   	return 0;
>   }
> @@ -1811,16 +1787,19 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
> +	int i;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	if (enable) {
> -		if (!vcn_v2_5_is_idle(adev))
> -			return -EBUSY;
> -		vcn_v2_5_enable_clock_gating(adev);
> -	} else {
> -		vcn_v2_5_disable_clock_gating(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (enable) {
> +			if (!vcn_v2_5_is_idle(adev))
> +				return -EBUSY;
> +			vcn_v2_5_enable_clock_gating(adev, i);
> +		} else {
> +			vcn_v2_5_disable_clock_gating(adev, i);
> +		}
>   	}
>   
>   	return 0;
> @@ -1830,20 +1809,22 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret;
> +	int ret = 0, i;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	if(state == adev->vcn.cur_state)
> +	if (state == adev->vcn.cur_state)
>   		return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v2_5_stop(adev);
> -	else
> -		ret = vcn_v2_5_start(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == AMD_PG_STATE_GATE)
> +			ret |= vcn_v2_5_stop(adev, i);
> +		else
> +			ret |= vcn_v2_5_start(adev, i);
> +	}
>   
> -	if(!ret)
> +	if (!ret)
>   		adev->vcn.cur_state = state;
>   
>   	return ret;
--------------BmUkl0BUFBU0KOuvThz50QfE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:56, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-2-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark1tk8wrane" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-2-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 841 +++++++++++++-------------
 1 file changed, 411 insertions(+), 430 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b518202955cad..b9be304aa294b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -452,64 +452,62 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
  * vcn_v2_5_mc_resume - memory controller programming
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to resume
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
+static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
 {
 	uint32_t size;
 	uint32_t offset;
-	int i;
-
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.inst[i].fw-&gt;size + 4);
-		/* cache window 0: fw */
-		if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
-				(adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
-				(adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
-			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
-			offset = 0;
-		} else {
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
-				lower_32_bits(adev-&gt;vcn.inst[i].gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
-				upper_32_bits(adev-&gt;vcn.inst[i].gpu_addr));
-			offset = size;
-			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
-				AMDGPU_UVD_FIRMWARE_OFFSET &gt;&gt; 3);
-		}
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return;
 
-		/* cache window 1: stack */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
-			lower_32_bits(adev-&gt;vcn.inst[i].gpu_addr + offset));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
-			upper_32_bits(adev-&gt;vcn.inst[i].gpu_addr + offset));
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
-
-		/* cache window 2: context */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
-			lower_32_bits(adev-&gt;vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
-			upper_32_bits(adev-&gt;vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
-
-		/* non-cache window */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
-			lower_32_bits(adev-&gt;vcn.inst[i].fw_shared.gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
-			upper_32_bits(adev-&gt;vcn.inst[i].fw_shared.gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
-		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
-			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
+	size = AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.inst[i].fw-&gt;size + 4);
+	/* cache window 0: fw */
+	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			     (adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			     (adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
+		offset = 0;
+	} else {
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			     lower_32_bits(adev-&gt;vcn.inst[i].gpu_addr));
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			     upper_32_bits(adev-&gt;vcn.inst[i].gpu_addr));
+		offset = size;
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
+			     AMDGPU_UVD_FIRMWARE_OFFSET &gt;&gt; 3);
 	}
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
+
+	/* cache window 1: stack */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
+		     lower_32_bits(adev-&gt;vcn.inst[i].gpu_addr + offset));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
+		     upper_32_bits(adev-&gt;vcn.inst[i].gpu_addr + offset));
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
+
+	/* cache window 2: context */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
+		     lower_32_bits(adev-&gt;vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
+		     upper_32_bits(adev-&gt;vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
+
+	/* non-cache window */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+		     lower_32_bits(adev-&gt;vcn.inst[i].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+		     upper_32_bits(adev-&gt;vcn.inst[i].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
+	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
+		     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
 static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
@@ -612,117 +610,115 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to disable clockgating on
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
 {
 	uint32_t data;
-	int i;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
-		/* UVD disable CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 &lt;&lt; UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data &amp;= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
-		data |= 1 &lt;&lt; UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 &lt;&lt; UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
-		data &amp;= ~(UVD_CGC_GATE__SYS_MASK
-			| UVD_CGC_GATE__UDEC_MASK
-			| UVD_CGC_GATE__MPEG2_MASK
-			| UVD_CGC_GATE__REGS_MASK
-			| UVD_CGC_GATE__RBC_MASK
-			| UVD_CGC_GATE__LMI_MC_MASK
-			| UVD_CGC_GATE__LMI_UMC_MASK
-			| UVD_CGC_GATE__IDCT_MASK
-			| UVD_CGC_GATE__MPRD_MASK
-			| UVD_CGC_GATE__MPC_MASK
-			| UVD_CGC_GATE__LBSI_MASK
-			| UVD_CGC_GATE__LRBBM_MASK
-			| UVD_CGC_GATE__UDEC_RE_MASK
-			| UVD_CGC_GATE__UDEC_CM_MASK
-			| UVD_CGC_GATE__UDEC_IT_MASK
-			| UVD_CGC_GATE__UDEC_DB_MASK
-			| UVD_CGC_GATE__UDEC_MP_MASK
-			| UVD_CGC_GATE__WCB_MASK
-			| UVD_CGC_GATE__VCPU_MASK
-			| UVD_CGC_GATE__MMSCH_MASK);
-
-		WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
-
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data &amp;= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK
-			| UVD_CGC_CTRL__MMSCH_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		/* turn on */
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
-		data |= (UVD_SUVD_CGC_GATE__SRE_MASK
-			| UVD_SUVD_CGC_GATE__SIT_MASK
-			| UVD_SUVD_CGC_GATE__SMP_MASK
-			| UVD_SUVD_CGC_GATE__SCM_MASK
-			| UVD_SUVD_CGC_GATE__SDB_MASK
-			| UVD_SUVD_CGC_GATE__SRE_H264_MASK
-			| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_H264_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCM_H264_MASK
-			| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_H264_MASK
-			| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCLR_MASK
-			| UVD_SUVD_CGC_GATE__UVD_SC_MASK
-			| UVD_SUVD_CGC_GATE__ENT_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
-			| UVD_SUVD_CGC_GATE__SITE_MASK
-			| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
-			| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data &amp;= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return;
+	/* UVD disable CGC */
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 &lt;&lt; UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data &amp;= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
+	data |= 1 &lt;&lt; UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 &lt;&lt; UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
+	data &amp;= ~(UVD_CGC_GATE__SYS_MASK
+		  | UVD_CGC_GATE__UDEC_MASK
+		  | UVD_CGC_GATE__MPEG2_MASK
+		  | UVD_CGC_GATE__REGS_MASK
+		  | UVD_CGC_GATE__RBC_MASK
+		  | UVD_CGC_GATE__LMI_MC_MASK
+		  | UVD_CGC_GATE__LMI_UMC_MASK
+		  | UVD_CGC_GATE__IDCT_MASK
+		  | UVD_CGC_GATE__MPRD_MASK
+		  | UVD_CGC_GATE__MPC_MASK
+		  | UVD_CGC_GATE__LBSI_MASK
+		  | UVD_CGC_GATE__LRBBM_MASK
+		  | UVD_CGC_GATE__UDEC_RE_MASK
+		  | UVD_CGC_GATE__UDEC_CM_MASK
+		  | UVD_CGC_GATE__UDEC_IT_MASK
+		  | UVD_CGC_GATE__UDEC_DB_MASK
+		  | UVD_CGC_GATE__UDEC_MP_MASK
+		  | UVD_CGC_GATE__WCB_MASK
+		  | UVD_CGC_GATE__VCPU_MASK
+		  | UVD_CGC_GATE__MMSCH_MASK);
+
+	WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
+
+	SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	data &amp;= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		  | UVD_CGC_CTRL__SYS_MODE_MASK
+		  | UVD_CGC_CTRL__UDEC_MODE_MASK
+		  | UVD_CGC_CTRL__MPEG2_MODE_MASK
+		  | UVD_CGC_CTRL__REGS_MODE_MASK
+		  | UVD_CGC_CTRL__RBC_MODE_MASK
+		  | UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		  | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		  | UVD_CGC_CTRL__IDCT_MODE_MASK
+		  | UVD_CGC_CTRL__MPRD_MODE_MASK
+		  | UVD_CGC_CTRL__MPC_MODE_MASK
+		  | UVD_CGC_CTRL__LBSI_MODE_MASK
+		  | UVD_CGC_CTRL__LRBBM_MODE_MASK
+		  | UVD_CGC_CTRL__WCB_MODE_MASK
+		  | UVD_CGC_CTRL__VCPU_MODE_MASK
+		  | UVD_CGC_CTRL__MMSCH_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	/* turn on */
+	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
+	data |= (UVD_SUVD_CGC_GATE__SRE_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_MASK
+		 | UVD_SUVD_CGC_GATE__SMP_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_MASK
+		 | UVD_SUVD_CGC_GATE__SRE_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_H264_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
+		 | UVD_SUVD_CGC_GATE__SCLR_MASK
+		 | UVD_SUVD_CGC_GATE__UVD_SC_MASK
+		 | UVD_SUVD_CGC_GATE__ENT_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
+		 | UVD_SUVD_CGC_GATE__SITE_MASK
+		 | UVD_SUVD_CGC_GATE__SRE_VP9_MASK
+		 | UVD_SUVD_CGC_GATE__SCM_VP9_MASK
+		 | UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
+		 | UVD_SUVD_CGC_GATE__SDB_VP9_MASK
+		 | UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
+	data &amp;= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		  | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
 			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+		  | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
@@ -774,65 +770,63 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 }
 
 /**
- * vcn_v2_5_enable_clock_gating - enable VCN clock gating
+ * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to enable clockgating on
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
 {
 	uint32_t data = 0;
-	int i;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
-		/* enable UVD CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 &lt;&lt; UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data |= 0 &lt;&lt; UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		data |= 1 &lt;&lt; UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 &lt;&lt; UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return;
+	/* enable UVD CGC */
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 &lt;&lt; UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data |= 0 &lt;&lt; UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	data |= 1 &lt;&lt; UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 &lt;&lt; UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
+	data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		 | UVD_CGC_CTRL__SYS_MODE_MASK
+		 | UVD_CGC_CTRL__UDEC_MODE_MASK
+		 | UVD_CGC_CTRL__MPEG2_MODE_MASK
+		 | UVD_CGC_CTRL__REGS_MODE_MASK
+		 | UVD_CGC_CTRL__RBC_MODE_MASK
+		 | UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		 | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		 | UVD_CGC_CTRL__IDCT_MODE_MASK
+		 | UVD_CGC_CTRL__MPRD_MODE_MASK
+		 | UVD_CGC_CTRL__MPC_MODE_MASK
+		 | UVD_CGC_CTRL__LBSI_MODE_MASK
+		 | UVD_CGC_CTRL__LRBBM_MODE_MASK
+		 | UVD_CGC_CTRL__WCB_MODE_MASK
+		 | UVD_CGC_CTRL__VCPU_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
+	data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__IME_MODE_MASK
+		 | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
@@ -1006,197 +1000,185 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v2_5_start(struct amdgpu_device *adev)
+static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 {
+	volatile struct amdgpu_fw_shared *fw_shared =
+		adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
-			continue;
-		}
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-		/* disable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v2_5_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
 
-		/* set uvd status busy */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
-	}
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
+		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* set uvd status busy */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
 		return 0;
 
-	/*SW clock gating */
-	vcn_v2_5_disable_clock_gating(adev);
+	/* SW clock gating */
+	vcn_v2_5_disable_clock_gating(adev, i);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
-		tmp &amp;= ~0xff;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup mmUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
-		tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
-			((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			(0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			(0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			(0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
-			((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			(0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			(0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			(0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup mmUVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
-			((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			(0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			(0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
-	}
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-	vcn_v2_5_mc_resume(adev);
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		volatile struct amdgpu_fw_shared *fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev-&gt;gfx.config.gb_addr_config);
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev-&gt;gfx.config.gb_addr_config);
+	/* setup mmUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
+	tmp &amp;= ~0xff;
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup mmUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
+	tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup mmUVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
+		     ((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v2_5_mc_resume(adev, i);
 
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
+		     adev-&gt;gfx.config.gb_addr_config);
+	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
+		     adev-&gt;gfx.config.gb_addr_config);
 
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (k = 0; k &lt; 10; ++k) {
-			uint32_t status;
-
-			for (j = 0; j &lt; 100; ++j) {
-				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
-				if (status &amp; 2)
-					break;
-				if (amdgpu_emu_mode == 1)
-					msleep(500);
-				else
-					mdelay(10);
-			}
-			r = 0;
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (k = 0; k &lt; 10; ++k) {
+		uint32_t status;
+
+		for (j = 0; j &lt; 100; ++j) {
+			status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
 			if (status &amp; 2)
 				break;
+			if (amdgpu_emu_mode == 1)
+				msleep(500);
+			else
+				mdelay(10);
+		}
+		r = 0;
+		if (status &amp; 2)
+			break;
 
-			DRM_ERROR(&quot;VCN decode not responding, trying to reset the VCPU!!!\n&quot;);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+		DRM_ERROR(&quot;VCN decode not responding, trying to reset the VCPU!!!\n&quot;);
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+			 UVD_VCPU_CNTL__BLK_RST_MASK,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-			mdelay(10);
-			r = -1;
-		}
+		mdelay(10);
+		r = -1;
+	}
 
-		if (r) {
-			DRM_ERROR(&quot;VCN decode not responding, giving up!!!\n&quot;);
-			return r;
-		}
+	if (r) {
+		DRM_ERROR(&quot;VCN decode not responding, giving up!!!\n&quot;);
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
-			~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
+		 ~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
 
-		ring = &amp;adev-&gt;vcn.inst[i].ring_dec;
-		/* force RBC into idle state */
-		rb_bufsz = order_base_2(ring-&gt;ring_size);
-		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
+	ring = &amp;adev-&gt;vcn.inst[i].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring-&gt;ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
-		fw_shared-&gt;multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
-		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring-&gt;gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring-&gt;gpu_addr));
+	fw_shared-&gt;multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
+	/* program the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		     lower_32_bits(ring-&gt;gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		     upper_32_bits(ring-&gt;gpu_addr));
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
 
-		ring-&gt;wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
-				lower_32_bits(ring-&gt;wptr));
-		fw_shared-&gt;multi_queue.decode_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
+	ring-&gt;wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
+		     lower_32_bits(ring-&gt;wptr));
+	fw_shared-&gt;multi_queue.decode_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
 
-		fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring-&gt;wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring-&gt;wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring-&gt;gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring-&gt;ring_size / 4);
-		fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
-
-		fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[1];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring-&gt;wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring-&gt;wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring-&gt;gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring-&gt;gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring-&gt;ring_size / 4);
-		fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
-	}
+	fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
+	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring-&gt;wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring-&gt;wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring-&gt;gpu_addr);
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring-&gt;ring_size / 4);
+	fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
+
+	fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &amp;adev-&gt;vcn.inst[i].ring_enc[1];
+	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring-&gt;wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring-&gt;wptr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring-&gt;gpu_addr);
+	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring-&gt;gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring-&gt;ring_size / 4);
+	fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
 
 	return 0;
 }
@@ -1425,72 +1407,66 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v2_5_stop(struct amdgpu_device *adev)
+static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 {
 	uint32_t tmp;
-	int i, r = 0;
+	int r;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v2_5_stop_dpg_mode(adev, i);
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
+	/* block LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
 
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+	/* clear status */
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
-		vcn_v2_5_enable_clock_gating(adev);
+	vcn_v2_5_enable_clock_gating(adev, i);
 
-		/* enable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
-			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-	}
+	/* enable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
+		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
+		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -1811,16 +1787,19 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
+	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (enable) {
-		if (!vcn_v2_5_is_idle(adev))
-			return -EBUSY;
-		vcn_v2_5_enable_clock_gating(adev);
-	} else {
-		vcn_v2_5_disable_clock_gating(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		if (enable) {
+			if (!vcn_v2_5_is_idle(adev))
+				return -EBUSY;
+			vcn_v2_5_enable_clock_gating(adev, i);
+		} else {
+			vcn_v2_5_disable_clock_gating(adev, i);
+		}
 	}
 
 	return 0;
@@ -1830,20 +1809,22 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret;
+	int ret = 0, i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if(state == adev-&gt;vcn.cur_state)
+	if (state == adev-&gt;vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_5_stop(adev);
-	else
-		ret = vcn_v2_5_start(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v2_5_stop(adev, i);
+		else
+			ret |= vcn_v2_5_start(adev, i);
+	}
 
-	if(!ret)
+	if (!ret)
 		adev-&gt;vcn.cur_state = state;
 
 	return ret;
</pre>
    </blockquote>
  </body>
</html>

--------------BmUkl0BUFBU0KOuvThz50QfE--
