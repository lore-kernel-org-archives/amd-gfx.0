Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D1FD2127B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 08:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154EA10E37B;
	Fri, 18 Oct 2024 08:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bez77sh/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6766C10E37B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 08:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VboLEN1lT6QgrlmUeh1i31+xp1PTZZ1ZKJ0kvfLy8xES1bDb4liXLMyoPihKmDANytlcPYstg/f+6UtpmHOCNkYQANqkiLYxFio8gLqAX2WYOb0DbyiDsF3tyxB4i6R9K+05VnTTFrgTYJmjv+YFz32Bm5mGKQbRC/YIGoWDXnNPqA1VqVz7RdiopgNYDA2NrKjTX2Cp00iQ9e1nWm4sqO6TiT3YoMB8tJV17/XGrEn1d1Lv7el2mTirfYo7w6JJYwqrQ8FSUDre2yjVOMwD3HGt8Ghd3doOk+/gwNYwOdibyWOYCJ6S96ZRq+dskGFcY/xdzMz6nwQuDwkX1hu9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4DSWDO4YL/IkZoThzYMm6SgpaH18VNYJPaCvOYaTMc=;
 b=ngu2hakqtqdBcenJZXuIbGB4IyNlKVVWvxR6Xzvf9oDlDf7NnceH75jZ6cjm6rwTKKaYxvoUQ3biydlrCaAj9K/LgkIgf5cbxS0MeEuB6sZK0PQsgd/hFD8+81aSDOpAgeVD1tdZoU5ps4BstptafpP4or0H4dh+/KzfyLgt46yno+rt0WjCawPCTz4yFm0dEvoaxkIuDWDYAmWH/+Qcr0ZdTROFU3KIheLS/xyf7sOStWFdMQgYYQTsUujS//Iq7Rx7qfi9WJ0fPjd39kIHC5vcbdBZMNsrQExRXHC+nd3EIzhcRztvKdOrnG/5QM2GBuQoLpRfk5Mfjz7K3sGkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4DSWDO4YL/IkZoThzYMm6SgpaH18VNYJPaCvOYaTMc=;
 b=bez77sh/G4TR/KDbGdbzGnMQB62qRhjnlPaNn0CqrmBRlNrrUDSEG3q/WK5iVY2n6V053X7XZDNd7Elyh2Rt1Hwkmqs31RLV4seSMHAjtxswR5f34GWiO3fFz1wRfZvyxrHEEMCmJUT2ntTyDoM46ydwdqHKxHFVB2OHxcklUAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 18 Oct
 2024 08:47:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 08:47:07 +0000
Message-ID: <5963f22c-eba6-4c9a-a341-a5a1b6d45f37@amd.com>
Date: Fri, 18 Oct 2024 10:47:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add the command AMDGPU_INFO_QUEUE_RESET to
 query queue reset
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241018081934.2185681-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241018081934.2185681-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: bdae74d7-a9ad-4932-bdbd-08dcef5172ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDhmZjN6Y1lnSHlLOW8yZ29maG90bmxkWEpndWtsNnJ5eHFIVXFqQkdwNU1H?=
 =?utf-8?B?VlF4Y0RKWGY4UjJsSjVwaytCQytVUEpENXhJOEQrQzA4QlFnVmNnbm9LUnJC?=
 =?utf-8?B?UEV1blZ4alBTQXE1Tk1ZU1MrWlNXSDlQbGxTZGUvYlNETmFxQ1VDcnMzeVRj?=
 =?utf-8?B?SW1RY0kydUJsYzllK1VDempsNGhQZmxacytPcGFZV2xLL1cxUGg0RS9yUFEx?=
 =?utf-8?B?aFhNcDc1YmNzVllVRDRLaERBWFlsd0lCV0xzVWhvNFgvbitPNXIrajRJM21T?=
 =?utf-8?B?ZXRBelJKN1o5WFcxUDFZQ0VScFJ3eTZsT25UR0lDb0dGbHNrTmhOS05nNEgv?=
 =?utf-8?B?OW5xSU1GYS9lSXF1Q2JxZjNrdExXUCtSODFhckkrT1I5RnhKcGhNemQ2aW0w?=
 =?utf-8?B?d1l6bU9rNEVoWHBSN3czK0J0aG9HYTBXbkpOdGdYQmZDZWU3NUVJc1p2SjVn?=
 =?utf-8?B?dGt2YnphSktVSVlmK0IzdmowYTZVYU9jZ1k2ODh2Q2tQdFdaeTBnTDdZYlRR?=
 =?utf-8?B?ZnhDa3NpTDhFSWw0VWtOeVQ3N24waTgyTVVWdG1MVG5RY1JrYmlBSGVndzRS?=
 =?utf-8?B?VTRTV3pJSFN3d1BTdU1JU3AyT1JRSFo4OStpbHpBczVLbGVpVUxyYVpXWHdR?=
 =?utf-8?B?RXBCeGdGSEZlcUpYbWlqTHJoZWQ1dThhckorL0pjREg4L1labWtVYzFTRTkz?=
 =?utf-8?B?WWwybHNlbDJyNFVJSStVc1lJUVZTNU1Gd0JxR1FsblVDZFN6eTc2MytiODB3?=
 =?utf-8?B?YzZxYkF1V2ZGaERjQzJVdW5JM2RmbnoyRlkraktaS2ZXUHllcDRJaUJvNGp3?=
 =?utf-8?B?aXQ2NDNoc0VNbDdiVmp5UDRwOVRsalJSWGpnMWNvazBtbEtZZXJsbDVPZDBk?=
 =?utf-8?B?ejI1emF2eHRTSytPck4zRGRGTE5UQ1NxT2RGUUJ1SGduN01pamMzRk0zUW5i?=
 =?utf-8?B?bnRvU1JPaEVYWGRncndNVkUyRlh5Qjk4cndUdERORTNFUjlZZlE4YWZXdkhj?=
 =?utf-8?B?VE5zY0N6ZGozVmF4QWxkcFNidjRRQVp0ZG15Y25PNUZlZHJwczNKZHRYRnVJ?=
 =?utf-8?B?S2svOG5FdUM3WWZyOXRNcXhTQ3VBVlk3MDBTQ0tGNUd6TFYxUGVRSktUbjRn?=
 =?utf-8?B?WnNXVUhDM3VDN0h4bnRMWW4rYTVtSmJBL2FwQ2JtQlV0UlRZcFJJd0pXZHdM?=
 =?utf-8?B?QWpwaTRDTTlMVkN0RnlhcWMvY0ZEYzIvY1IyOGswelhmN3VZNTBhcG1xWHd0?=
 =?utf-8?B?UGF6bzZlS2E0am0vRS9Eb2czaUNEYnZMRm8wZm5wcDR3Tkl3NjQ2ZE5lc2xJ?=
 =?utf-8?B?NzdhVzQyMVdOSWM2Mk95ZVdTOTBhWWhoYzlMaVh3ZVc2Z0VGQXpSNmFQNWtl?=
 =?utf-8?B?dld4UGRxQ2Y4b080STlDV0hmZXovZm1qNFNSSHJZTUMyeHlFR0VXMDZyRFJ1?=
 =?utf-8?B?MzU3dDlwWGRrcmFoMFBCTVJSRzJKb2RaQjhtTjlpckZKTU5uRUUwVE0wZG9l?=
 =?utf-8?B?K21pSDlWcHJxOEZ4OVplME51aEJVbHZTRDMvUzZTVW5aa3QvajFKdk1Jc2ZX?=
 =?utf-8?B?YkMwUUltbnRla0t0WVltTHE5ZDJrSWw2amJLMzVCMUpiN21yZTYzb0dKWkRC?=
 =?utf-8?B?cSs2cjBTTEFtd1dVR1F5NU5wenN4TmRpbzlNQzgrU0NrblNCdG5zSnBZNmtw?=
 =?utf-8?B?NEhJM0FXWWs5N0dHSnE2UGVSSlFGWVFHL1E4V0tMZzgvTWkzM1NhMS90dTZB?=
 =?utf-8?Q?HOj6BAXXOppEqZGW0o8il1YTTL8pUkTJ61xtw2c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGpCaGR2R2FCaGt5UWZ3Z3BZQ0laOFA2NEMyZ1lzT1FUK1lhVkUyL0VVQjJB?=
 =?utf-8?B?Wnl0bUVMVWtYamNhSU5KcDVtaGR1TTZ4M3E2QlpGQkxkMjRITlI2QlNIRVYz?=
 =?utf-8?B?VFRoVjE4anhERjNtNUNMdjh2bkNrY1FrVDNxWDlYR1VSNlBWZjdadW4xWk1p?=
 =?utf-8?B?bUZrODFVSlFmc0lWc2VET2I2NXY3RDB2aCtVTndtSDBabjBwRGtmUnByTWk3?=
 =?utf-8?B?SlppdXZJbUI3eWZVa2RrMnE3a1pDSk43SWZZeStCL0d4LzlycXdJYmJVeU1F?=
 =?utf-8?B?Q1JxVWlINVRPT0xMTjhWRGpTM2ZoOG9IeEM4SXk4aE1iYURCSHlzUlNaNFFQ?=
 =?utf-8?B?dFZvak5WMkJ5Qm5adHMwbDlJaWlrUnZMZ2xzZGhnTmFiaEozV0ZpYnIvZk0r?=
 =?utf-8?B?MHczTWVveU9iUU9qeS9QZldZWmFJeVluVlg1ZytWbHdWZkJpTTNhTXRia1hD?=
 =?utf-8?B?Z0lWbENVYjFpdXVQT000REthb1JwUlRHSTV4dkw5WS9rdXpzdld3eFJrSmxp?=
 =?utf-8?B?TFhraGdKdnFOS1JJZTVhWGJPVDdxbU5QdmwvakhMWVhmYmMwSDFlQ2I5L2M2?=
 =?utf-8?B?S2NSc01qT0FjS09JVHhaZXhQWEUyQ3pYVnpFcUJiaTBKcVpCL1FWSFhkUG15?=
 =?utf-8?B?WUU3bGdKbUFGWWp2NWZpMXRBeUIvd1NrS0FNL2ZndENidTllNS8xM3F0U0pS?=
 =?utf-8?B?M1hXNy9vZTdNZ1V2MUNWTFE5Nzgwa2dSYzFXSlFHeFN0Y1NWaTdZZDBjbnlB?=
 =?utf-8?B?T2NjVkxIbjQ2VCttTHMrZGUvb3R5aHMvNE94QnAyUHR0ckV4alJ2Ylpya3Zn?=
 =?utf-8?B?eEJ6VDh1am5nWE1QcEdLRE5mZXpnd0NQRDZJcEJUWG5LdVVURy9LTUxpNXJy?=
 =?utf-8?B?VzNvMU9tTW1OMEtGdGw1UnZGaHR4dGhkQVNmWDdpS3J1OFZIOFpDYXZpYlZE?=
 =?utf-8?B?TlMzWm42VTF6TUViajlOWWJ0ZENLQU1CaDhEUm1DaWtGcnI3cFc2OFBkSWI1?=
 =?utf-8?B?M0ZYSjA3WXM4b2RLZnhDL1VpbmQxTG9ydG5xWENncXBrcHAyU0lWRGxxcmE0?=
 =?utf-8?B?ekFMSWZObFpHeXU3aVRLSmJDVVgzbFJ6UWVsdStHU2dJTTM0b3FubUg5a29a?=
 =?utf-8?B?MWI1NUd4Z25sUGpsVTZ1MUxWbFdybjRJTjdOek9jZVBtdlhoYkozRjBjLytS?=
 =?utf-8?B?YUVrUW1pTnZEOWlTUVNNQnVvT1lya1lSek5sMnZmRVB1VXFrM1cxRjk0enp5?=
 =?utf-8?B?S29zUk5ibjZhN3J2VllnckxxQU5XK1RibTRKaHIyWEpkYkFFK0lKR0lNV0pC?=
 =?utf-8?B?eUhFVDY0OVhmOHArOElMM0U2Vm01ZFU5aUxDWE15NUo3aTVRbHZ4b0dFMDRQ?=
 =?utf-8?B?Sm5ZZ0Urb3NobjNLdlRzcVdqZllFaVZySFpwd0YxOW9wQmo3NHpsbWZrekhp?=
 =?utf-8?B?aHltRC9EL2JFbkQ0Nm1qZXYxcTBUQzhzZkR5QVpTVDFHdkVuWGlmUkExQTBD?=
 =?utf-8?B?YnhaazBLb1JNYmtoSXFFdXJ0WDVncnl2WjRPdFB2MDR0VmEzZTJta2JtUXZo?=
 =?utf-8?B?UTlMbEVWakwyZzBNd0pnUExtU0pUaFlxdUZYOGljMlFFbnNCWGhBNDdBUEtW?=
 =?utf-8?B?ekJNR0gxSUY5ZE9ZemRYMjYxaVBQN2t6b2RUOEhnZzIySDlLaUVTQ25odlY3?=
 =?utf-8?B?WkNyZTVZaDk3dkJwcmNaNGY2Tks5TzE5blBYendoQVZjZmhrV05JM2RNbkZw?=
 =?utf-8?B?eWNtYllhNko1UmswcWJ1WXdmOEx5VmZWYXZ3YnNiY0U4ZWxmWk54dS9oN0wr?=
 =?utf-8?B?b1d6SFRRRFdnR2Zyd0FKM01MdnRIUXNsL0FNRnBJcU5YUmE4VjFYbnNsb3F1?=
 =?utf-8?B?VlBPTlRheE1NNXI3azBVR3JlZ29SUysrRERLQjVKSmxFU0JOMHpHakRyVU9V?=
 =?utf-8?B?T0g0T2JUREgxY0NCbWZQbGVINzBrUHdEOHRFS3FqMEI4cnh4ajRKa29NQStP?=
 =?utf-8?B?TEtVYmlMNHBWZHd4c0dRSHo3NldGSVI2WXVpbElzTG8xYWp3cU1QT0R4TFRV?=
 =?utf-8?B?Y0JGVDg2ZkJsVUI2WXFub0tNTDVBejdkeG9hcGJ4LzNhb3FhTTJScmpRdHg1?=
 =?utf-8?Q?3/QE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdae74d7-a9ad-4932-bdbd-08dcef5172ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 08:47:07.5986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrVuCrvSpQqB/+HbknwW2sDpUJMppnGlaJP1hfR+CpN4eSYrDS89D2ujyz79MMqr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
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

Am 18.10.24 um 10:19 schrieb Jesse.zhang@amd.com:
> Not all ASICs support the queue reset feature.
> Therefore, userspace can query this feature
> via AMDGPU_INFO_QUEUE_RESET before validating a queue reset.

Why would UMDs need that information?

>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 +++++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h           |  2 ++
>   2 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b53c35992152..87dee858fb4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -577,6 +577,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	uint64_t ui64 = 0;
>   	int i, found, ret;
>   	int ui32_size = sizeof(ui32);
> +	bool queue_reset;
>   
>   	if (!info->return_size || !info->return_pointer)
>   		return -EINVAL;
> @@ -1282,6 +1283,32 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		return copy_to_user(out, &gpuvm_fault,
>   				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
>   	}
> +	case AMDGPU_INFO_QUEUE_RESET: {
> +		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
> +		type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
> +		ip_block = amdgpu_device_ip_get_ip_block(adev, type);
> +
> +		if (!ip_block || !ip_block->status.valid)
> +			return -EINVAL;
> +
> +		switch (info->query_hw_ip.type) {
> +		case AMDGPU_HW_IP_GFX:
> +			queue_reset = adev->gfx.gfx_ring[0].funcs->reset ? true : false;

Please never ever use this coding style.

If you want to convert anything into a boolean use the !! operator.

Regards,
Christian.

> +			break;
> +		case AMDGPU_HW_IP_COMPUTE:
> +			queue_reset = adev->gfx.compute_ring[0].funcs->reset ? true : false;
> +			break;
> +		case AMDGPU_HW_IP_DMA:
> +			queue_reset = adev->sdma.instance[0].ring.funcs->reset ? true : false;
> +			break;
> +		case AMDGPU_HW_IP_UVD_ENC:
> +		case AMDGPU_HW_IP_VCN_DEC:
> +		default:
> +			queue_reset = false;
> +		}
> +
> +		return copy_to_user(out, &queue_reset, min(size, 4u)) ? -EFAULT : 0;
> +	}
>   	default:
>   		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>   		return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index d9bff1c3b326..3b17d82fd1ee 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1052,6 +1052,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>   #define AMDGPU_INFO_MAX_IBS			0x22
>   /* query last page fault info */
>   #define AMDGPU_INFO_GPUVM_FAULT			0x23
> +/* query queue reset */
> +#define AMDGPU_INFO_QUEUE_RESET			0x24
>   
>   #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>   #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff

