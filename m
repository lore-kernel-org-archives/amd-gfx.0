Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FC2C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 11:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B92610E2C9;
	Wed, 16 Apr 2025 11:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBx/sGCr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C0510E2C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 11:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf4XuE0vHNzZKaAoz6eW/w5SJQxKFP59uAQGZRoRIBy5fVPEEKLpeuQWVDdU/kThQtohLhlx/6S299/jcAMWr6PWdfermEMoXWCDMYRSZB4CSBFlmQNLelqtC/KmDis/jrT7j/WtRnMYbb0YVW11U3K4W7QARzJPjPoCQpyewiM8LB6DlLqC/EjjWMrFjP6LcN5WGbbJhC/YxwU6lAOGReYJNqebKEVYofFHstY617YygllxGCpxVTNuPwt0nql76MyXq1VRwHonZDlOUeLmp+vJczlq+ZoI97aFw/FcuDkF1fbTojU3dbUqlu5NUpFdFHqUvG1V01ITRzql2ucJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S85hKDKWWpXVAK79Vt9p1Mm3wS3Ildqp0dAVzYWOvo=;
 b=H2tn7E8mhjoOYPgNTKXk4MSRIyHz9R0H/AdVgZGb40vMShWfw1+9HjlrT3tlX7L8SF5vUasRJEkSzNrcgJcDvNACk35tkgipuWJsJDgXPm5kZ/48Od2iHBi4N+YmDEoMsOry1t+Zm69haubR5VWTKf3WsFDN+361+MJumLvGziN3wTwv0U3T3ZR9z4JWHbU4f+YANLWGSIKI32ywud4laDkBL+6gZZElhV+Ni60IxWkn4g6q7ycWWUVk7q353322qHEYc1jI4rhBmvD04HjIuL1a8GBtN8SgEoUrp3Z0QPO3uDg5LBSw0NCiZMKFIrjnAB0OYBiF1bwf9Dd0dzEIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S85hKDKWWpXVAK79Vt9p1Mm3wS3Ildqp0dAVzYWOvo=;
 b=zBx/sGCr/B55nTBgNr/tgmwy0tGdnIeEi0kgJPlsS0nOMC51KDoxKshpKuxR+HBiOGWljcgAf76HmySQpklJYobzAmpFqG8CSfCwdb9DTqGvMNDStD1UW8M0eRuYkM66ZihxUM+KRSjsG3C8Lsc6YqQGzvrr9jlbOfC+1O5lZBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 11:02:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 11:02:31 +0000
Message-ID: <b89e4f0e-158c-4bfc-a5ae-8c95841850b2@amd.com>
Date: Wed, 16 Apr 2025 13:02:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: set the evf name to identify the userq
 case
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250416085029.2278563-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b49cb6f-0daf-4b68-5a78-08dd7cd62f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlAwSVBQYzFkcDVFTkFHMXhoNFpWS0hiV1JhZEJ5ZVczZ01oVkQ5SkcwZHk0?=
 =?utf-8?B?TWZySXR4RHI4UDZlSkNtNGozNUswYzV4TWhQbFRxNDR3SkI3bmZ4OUZFeE9a?=
 =?utf-8?B?MDdzUldIQ3VHZVRGQ0RPNldrK0wrMDdORytMeEJBbG5ZTVZkd0Zlbmx1a05C?=
 =?utf-8?B?MU95UncrUit4WS83NnRRZS9kZThLd1VKUWFJaWgySnUvVFVIQ2ZOSDdvQlM0?=
 =?utf-8?B?U0s3bitDVUIwM21KUnU5OG5iSVp1RFNqL2pmL2JsNXRTSENKZU1pTEN5Nk1y?=
 =?utf-8?B?VkxScWtnTW1kNkptNk0xdGpFeERKUUcySGdBYUgwRGh2RXp6aHJGU3VNZFVp?=
 =?utf-8?B?UjAxaVhOVllKcmRLeG5hb2FxT2pTYUFOblZrYUtXZTRLVFE3ZTQ0TGxhbyt6?=
 =?utf-8?B?d3AwaThmMVJEVHl5aERObm5aZXJlVkpiUkMzWUdIMVBYSGxURlhKMTZWWlp0?=
 =?utf-8?B?SlBiY1ZQdC9GaWwzN2VUUTNqMExlelJvYm1VNUJmc0Z0eVVKVE9IbjUvTFJP?=
 =?utf-8?B?N3lvWDVDRnJyZXUrSGlSMVhnM29DbmozNDNUVWtOMFUvNWprazJueDVnZTFH?=
 =?utf-8?B?K0V3V3VuWU44c3NUaS9XUUpOMlRLU3ZHcXNuVzV1dld1REVVUWFQZVZSNjhG?=
 =?utf-8?B?R0pQUU9UbFdyMVZvaVlyRTRuQVRuQTZpaUE4Ny9qRmEwUzRueklVOENzeFJs?=
 =?utf-8?B?eHRaNWExNElUV3RqYXZEYlJubXpLRGpqV05EWFRyVUkrSkpFUEtpZ0dlbzZn?=
 =?utf-8?B?dDg0SkhCc2sxNmdvK3F1eU5ycVZJdzI3aURNTjRaNmhOUVRVY3JkU21kUjdP?=
 =?utf-8?B?bUJENHVlUDJrRm1sQzNKUWc3T3VVampnSUJwZHgxRkRQa0FFdUFoZ1RTa3Ni?=
 =?utf-8?B?QVY1Wk9QV1JLOTVDMTRyZEs0VnpEUVU1U1JsUnBCTDRta0xxQ2I4bjlWOVNU?=
 =?utf-8?B?dzViNW5mZy94V1phMi9zTlhkQ0VyS094bkdwMHFpQ1VXT1NlODdvc2NNcysv?=
 =?utf-8?B?VWxtQjBIQTZXQm5MUEVqWHBNcEJXTEZiNWdmaFVhWHZBR1hzNkxKMkgvbGVV?=
 =?utf-8?B?M0hXdFJ6aGxiZ24yUFdDcmgra0RuWjQ0ZFV0ajB1WENTVHhqM1ZCRlBaVVNy?=
 =?utf-8?B?a01VbUU2c0YraTcrVkowLzcxNlU2Yit3d3drb05ieEsxNFdUZm83UWVZMThh?=
 =?utf-8?B?M2lLcngyalNSSktGeFZSWXNrSG9oT2VRdHgzamJ4WUlnMXVwNFVjK1VRbjdi?=
 =?utf-8?B?bVljMHFkUXdkWkRxUzJSYnQ1N2VBYnhrQ1lxMFpBUXpBZXhYTmhFcmZyd2ZJ?=
 =?utf-8?B?aS9VSHArZzBpbVlXaHYzUWVqSTZwb1dIaWsvRVJ1eldsdmU5VXlKNXRYVEt1?=
 =?utf-8?B?Yys2UEx0Ui85Q1VNSzhYSSswMHQ0YS8xTVRUT1kzdVkxS0NKNmZTamZ6alVF?=
 =?utf-8?B?Y1dmaWxUTTVmU1FPdEVSNTBITzd6cG1WZmNjOEtwL3RlbFArbUFLU3pUbExB?=
 =?utf-8?B?K2loL1U3MVliZ3FrQmIrOHdiWkFqVUlBUk0yRFFuaTBQY0swamxIamIyb01R?=
 =?utf-8?B?bzUweWJ6M1p4ZU5nbzlHRzAyb1dLTTZVbXlCZk1FWVRzSUluTGYyK1p4bTFo?=
 =?utf-8?B?bW9WSVJTQTFITVBUSGxvUFNXMG93M0dnVWZrcU1hZEdNMDh5L1FxT01hQ3Rt?=
 =?utf-8?B?anVSNWZpNk40UmxLWFk4NjllTUxyOVRnNUZjQ3hhN1p6OEM2SmhyckRJNUww?=
 =?utf-8?B?a3M1ZFQ5c1dwSmxWY1pQSWMwbVArNkFQVkU2TFlqR2g3Wmtlb1l5anhFb0Ez?=
 =?utf-8?B?V3RaOEFWbkpwM1lTN1BvakhqWHRLMVZxbVAxRTZPNGVYdGNFM0FlUVVPM0xS?=
 =?utf-8?B?U3RhZU1sWG9NTVA5MlBPcFFXZ3NxOEFmc0pQbkh2UERrMk9nSWxPZXEva1Fl?=
 =?utf-8?Q?ZJjz+s4iCfo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDB6eU1wN21aanhheXV0aWh1T1hFYkdGVU1xelJpSlNoSmd5K3Iza05yRlla?=
 =?utf-8?B?ZDRLRC9VeHdOallyNS82WXVQZVVxeFhIMGFCRm8wREFpek5jWmJGMkJibldR?=
 =?utf-8?B?U3NtSG5MWE1tcTA0dm9zS1RBMElaS2U3dkZNcFhvZTFsczd5TFN4NGw3Njdw?=
 =?utf-8?B?VFhVZXE0NVRrbVdQcnRoeExjTElBbDl5eGdyckNIN1JRN1BxdGl1NlM3Z1Vl?=
 =?utf-8?B?OG1WUGFiY1VUNS94MjY3SDlrYUR3Y0VBY3ExM1ZTT1dQZUU4VlBab29JNkhm?=
 =?utf-8?B?Q0p4ZmdkOWJKQ0FET2FqVVVwSTd4N0kzd2pOR09kZG9SSWN6NFUvdTNBWGRt?=
 =?utf-8?B?aEtuMC9ra2FGaTN6L2RNMVZyWnhVWmNSbXdCRDB2Qis2enNLWDkxWkZaT0tI?=
 =?utf-8?B?ajRRc3p1N2d1Z05JZXQyNXI2RVdyU0haU2czUFJML2dQRnpLcW84dEhkVldq?=
 =?utf-8?B?bnNFYlBLQ1JkT3g5QnQ1Q2NOd3ZwK3BkTGxGaEsreG4zSHp4dVhZTHZhSjkw?=
 =?utf-8?B?TmVCcFFPZXRvdGJ5LzBFY0lzaTF4MGlWSUJFSk9uUjBMU0xKQ1p4Z3Rkd2R5?=
 =?utf-8?B?eGRXdDJtVmp5LzJxcC9wMjdReUtJVWxCcWx5WStqNVlYeFBsa2RwalFMQ3NO?=
 =?utf-8?B?L1F0VGtKMGN0MjQvYkZhN01oUG51d29DN2FaczhjdGNMUm10bUFKYW5XSzB3?=
 =?utf-8?B?R0JCTDFYLzJCV0c0WnA5a1Q3aElJbUNFd3U0bWZkcTMrSFpZeUR3cUJiMElW?=
 =?utf-8?B?L2MyWnpFZUZtZTVBaVB2ci96c1c4U1ZOT25QbHc3ZEZrU2N4allhLytSYVdT?=
 =?utf-8?B?Y3FLT2wwNldqUGZ5S2Nmd05OUkxjWGp0VVBJUlRhdU5QUTdPcUE3a1krenRJ?=
 =?utf-8?B?NXNUaWt2a1R2NWJERkd5T1dvWi9vSnZWSHIzZ1BRMm1XSUJxS0VKbG85TytL?=
 =?utf-8?B?N0p1WUszajVkMERZRVNXLzJpYm1zMHpwNVhxR0RYNkJKTEJXQVRZZFVqYll4?=
 =?utf-8?B?SzE5UEpENEMzUUhlaHp3V3h4dXZZRmhWSmlUS3BPMmhPckZDWTlJeGlRbHdn?=
 =?utf-8?B?cnZIWDIvOEt3TkUzbXNXR0hiS1A4NU9DdkxqSkxySzQ3dnRNUE5mUmdwbS9l?=
 =?utf-8?B?TTlyK29IY0VpazQxdW5CT1JJY0NqaVNMOWRCbXE1WXFibEg2S0hpZExVYnhM?=
 =?utf-8?B?UDdGMllKNU1QTk1CTTRKQnczeFZYaFNBMmJxTGd3akxMVEYzb1dpVUhsMG0z?=
 =?utf-8?B?RWpJYlR2TFVFZU5aaHVnSTBpNlRrYnhhOS9Vd0hzUXRMZmt2OTZHdXQyVzhE?=
 =?utf-8?B?OFBIdlhER0gxU2VjSEduUm9EWGhObFRyZEpUcElkc09SS1JLaDFXTHQraVVW?=
 =?utf-8?B?Z011YW56UW1xSDZ1b2VGUUt4cTZ6cjlVam92aHBJU0NyWFpFdFp5bUVQTktL?=
 =?utf-8?B?dFAxRHY1OWhxVnZLQjBaVDBNY3owVTFNVWVaNEgxbjZDTU9oeG41UWJld0sx?=
 =?utf-8?B?WFhqNkhyMW11S2pKVkVha2pnTHVCNjIrc0c4Qy9UeUxhMENsbW00a1FOc1FI?=
 =?utf-8?B?ZW9VY3ExKytBUGdkYUdIbTdSUjBKbWZkSVpIRDMzZ09BSld1YkJEQTdsSkpu?=
 =?utf-8?B?bEk4cnA5SHNvdTBuVWk5a1YvRHVSV1hPZlVqd0g2OW5vT3UxR2g3WXlxaS82?=
 =?utf-8?B?UnE2NFduMFcxVmQxUHlMeHhSdVhDakhHQnlaNXlVUFZ0WHZlMXk5VVNTbXcr?=
 =?utf-8?B?MlFWbUpUZ1hYM2xPRnVlRHdwckZzaU0wT2tqMHBZbjlXRW1lVDRSTFI4dnE5?=
 =?utf-8?B?QlNyK2R3aHRJR3JXeW04a1RJYnJEQmMzNEthUGxyd0R0NkloUkhOcVdLUzBw?=
 =?utf-8?B?N3JuOWNuMWhwRXJKVXRIRWVQZ3FtYVd1cEdGV0d5S2U5NWJzYWFrYVpVVk5M?=
 =?utf-8?B?Zm1HKzM0WXVCYWY0N211dWN0OEFpbDdNVmNWemhLOTQzdzliZE5nL2lCTGFM?=
 =?utf-8?B?Q1FEVXZQRjdnQW1tYUwwQWZJL3YyM1UzWk91dVhtMW9xTVdVOFNjT2lVeSto?=
 =?utf-8?B?OFNTVEljZWJGVFM4R3QvNVFuWnUzUFJsTXpUdmlYZE5mczVqL1dRMGRnWURa?=
 =?utf-8?Q?Pibb0hbBKYRGp95zfVtRtcn4A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b49cb6f-0daf-4b68-5a78-08dd7cd62f53
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:02:31.8097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hrf2vOCYt0/a/oiuC9k5XJ3mhxam5c25jSkzzDPzOKWeqtLDDwdBdM1iIhZ+FR/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
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

Am 16.04.25 um 10:50 schrieb Prike Liang:
> The evf fence name can clearly identify the userq usage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 7030d721196b..b34225bbd85d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -31,7 +31,7 @@
>  static const char *
>  amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
>  {
> -	return "amdgpu";
> +	return "amdgpu_userq_evf";

Please use amdgpu_eviction as name here.

Apart from that looks good to me.

Regards,
Christian.

>  }
>  
>  static const char *

