Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BE2C25B4F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 14:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C63112029;
	Tue,  7 May 2024 14:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5d313nzK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD28110FF6D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 14:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5w4bWHQa8+kdSnqorRVdAxfY/JefJKhpa5L2Pyrw2miPwdLYSbiaMep0WX5Ma2xqWxiQRZLtLnwyWZVx/PY5/TLr4lSJxw1+71UJHo4jAR166z04n3vSRrRcZ5ZSNIJ5cD7mAmpp9rt1T5WdWIfh0kKjL5GExGovzowojbohfwhhXk2aCT9nOJnlXcOidN1U92oTGhwvL/YosjiZIzvEUp+2qbFhBslbSrUhycrW7HyLyzMpqYEXTr9NI6cX4ofdW0UcYzg2ZlNMCoN3I2uDO4Em+zdL6mXqJkjB/dbzNNtAmHUCBIq1/O+eXxVz+tbaDC29IO9TyNNlJvsRuWFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR/mqR5RDZq0R5SwoCAWKXIdK/iO7KN+af97ShHmS3M=;
 b=IVbk96fTV6yzCkWBZG0leJtIw8dqCG3pr4l0XHheXOlI8r0RIdDQc3T11A0gpMFTNWCRgoCUI0poNYah5h9tbFY7fQPGUdsPUYIeveF7/mgkGa9vjDQ76EZWu3QtwLd9Y/k1GmyN8h+pQLPst/+MYe9iG2O7ylRdoQmUDXFjqJq2oNoo4TZ1qCbdtKeLDlV1lx+kcxv3SlQeYivo5XjmpTWzkKaRCiY7Wy3vhyqZOQDELBIQl4NTbHDZIMtNS0ROh4uLE0LY0W8QTg5D93wHmz5HXqsyYtNy15ktD5hrZR8hwuV+kj51ZtJMbeoEj5sl1zGWmX81iith0+VW1iRXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR/mqR5RDZq0R5SwoCAWKXIdK/iO7KN+af97ShHmS3M=;
 b=5d313nzKJOjdtd+dNNGsSY4cYT2EUmWN4eBD7/kmJIJmtxWGyaWFUlNK6uyoOaA8KlLWlIY1R+zZwDP2rVUWu9rNZ9QKZ4mqc2gOK3IkGxWl3VHPw8b6TkA6IJikYiCyqYZUtUB/qvuIJeW98g2YRyZHCpx8zpOmZlbjJuIDfvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 14:51:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:51:51 +0000
Message-ID: <2eff77f1-d811-4a13-81ac-9c2ff18ebb75@amd.com>
Date: Tue, 7 May 2024 16:51:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the BO release clear memory warning
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, tvrtko.ursulin@igalia.com
References: <20240506134842.4688-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240506134842.4688-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0123.eurprd09.prod.outlook.com
 (2603:10a6:803:78::46) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: e2785b04-469d-4296-142c-08dc6ea53a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHJxa2dXV1pRRi9qbmxZejI2b2tKcUJsVHJ1d0E2Z0RkSFRRUkRVamhlSlNX?=
 =?utf-8?B?YmtPUUJjaVRuazVCc1NpQXlpbXExM1d5SEdqNVFsd0JoMDYyTFJLOE91SXZo?=
 =?utf-8?B?WlZHeHZDS0dmWnBCdjZlNnY5TElBYTZIa1BwV1M4QnBoN0FTQ3VUd3ZOQStX?=
 =?utf-8?B?UG5jRThTbUx2YWZXcHAxSkxHM09KZUhkN0xlZHVJMUxFbDg2QzAxaEV0K3oz?=
 =?utf-8?B?UVhSRXJHOFVGZ3hhRGVWaHk5U2gwTGFJMXhVRHUrSWZYeGFTNHFlY1kwSU5L?=
 =?utf-8?B?VzJhZG93ZUhYai9YelhPRVVYR0pLWnRWSW9iM1A0Tk91SkdRcXQvc2RURWF4?=
 =?utf-8?B?Mmc0YVE0dTNIQmFvKzc2VzZyaXNxNUpmOXlIcTlkbHhIMDErN211RzMySXpm?=
 =?utf-8?B?ZUFJMGk4T1ZUZktVQkV2d1l4QWM2VncyOEsvQ2d4VytCbTdQWmJlTTdCNFVC?=
 =?utf-8?B?ZkpvNUQxVFdFbnZoRVZ3dVdoSm1PV2pHSHBzN1ZxR0hQSkY3aTNVV0d0R1c5?=
 =?utf-8?B?K2dUaG9yVzgwdXpyWW9oV0hBbUtUSE1pbE5kSXZpREFIYUNxY3ROSUI2M0cv?=
 =?utf-8?B?cmxqWExKWkQrQ2t6TDdTR1BiV3UwZUNTeUZNbVVxQzhZR0hnVWRoQk04aC9E?=
 =?utf-8?B?VW1SZnlKK0wwTWYvdzZrUTZYa1BjZ2tDeFZhUWcvRnZwcEJsZHptc3M4a3V6?=
 =?utf-8?B?bjNtS2hib25aMFRTc2h0dUx4UUZ0clBqVkQ2aUdiTFFIYjE1cHJDWEVCZUc5?=
 =?utf-8?B?M3pVYmdkUVVNYjltQisyL2FFem1idTFNN0l6cE1yYjFzSVY2K0owNEdXS1dn?=
 =?utf-8?B?WVo1NEZmamFFM2FXajBXejRzV2w0Um02aUVUVDROREdqWE9CcWZHWG45dVFO?=
 =?utf-8?B?cW9vb1VRaXVMTit4ZXVBemticXJLUFZjM1dDT0RzTFkzdlhDOGUrZWorUHFj?=
 =?utf-8?B?c3Foc3Bha0tPdFZaK2tJc2plTExocEhFSUhla3g2bDN1Y3dYVnNZQVh1a1N2?=
 =?utf-8?B?SHVQcEo0WTgvWk5xeEFqWHlJclpsd0FZVXgrQW42K0F4QmlJZ3JPbmp0UHRX?=
 =?utf-8?B?SHhCTXBSMFZUN3oyd0gxYmp6WGVzaUhhM08velJvamo0aFgvaW11TGZLaVk2?=
 =?utf-8?B?Z2laMmt6YlNRcXBnUnVCbVZTSkVvK0hEYW1UZFNnUzlMWk9oWW9FTGk0cXpI?=
 =?utf-8?B?R09JNmtDbUpUUHZqK0EyMGJRZ3RZZUQybFRWWmRweENBRURNNVM3eitJeUVk?=
 =?utf-8?B?N3p4TnYvV3RxZE50bjNIM2R0ZWFzeFRyY2JLVGVoTm9CVm0wakhZQ2hucmpl?=
 =?utf-8?B?Q3ZPL2xLNWFVQlFEaGJwYWxnRmxTQmpWdXd0Z1RabGQraGVLQ1RzcWpWd3pC?=
 =?utf-8?B?TldIWHRyTHRVVS9CNkZaZ2VCZ3c5Rnk3cTEzbFRhQ0J1bzhnMmRUL1BQWlEy?=
 =?utf-8?B?UDhFMnZrU2VwSGJ3a0NCckxPVFlwdjFnNm5lVUdHOGN5eTUrODJTdG5RQjBu?=
 =?utf-8?B?M050NFdOVFI5NlY2dnR6WjdLUHdndks2c1p0anRyWDlQYnBIV2RDY2s1TjQ5?=
 =?utf-8?B?NTRab1BlNGRMYkpSQXl6VjBkeS95Tzk3cDRMMmRJSFp6ZmFzOWFvYThNMUth?=
 =?utf-8?B?dnUyU1BNd3J0U0FoWk5laE0xd0o3U1pFaEhYYWYrSU5UUTl3Zk9lZjB4WVdN?=
 =?utf-8?B?NkNSalpxZVhnQjFhUVU4NDJqZ2xwWVo2N3ZSakgzaUdiL3plMFl5dFBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzA5c1RHeEhwOStybGVITkNwNjFYZEZXOE1aWTFhanoyMXgxLzh4MkpjcWpU?=
 =?utf-8?B?bllmZWVyRVVUNVNPWEVjcmVKWTBNYXozVTViR3Bsb1dJNE5mdnRnQWhtbGRr?=
 =?utf-8?B?RGxxOXlLNzd4ME0rN0JjYkpLNVhJeERhUHhORXpONVpLMzl5L3B2emIvMFh4?=
 =?utf-8?B?T2dQVEovWWJmS09qM3lLcG16UnN4bitFS0hqNXo2SFJvdEhVTm10Q09rSjRs?=
 =?utf-8?B?YW02NUwvd2xVYzZRTTM3UW5oUmxrTHJVZE5FbTF2bmJXWVNXTjkvRzFDTjM2?=
 =?utf-8?B?R1J4eWFWZ0FrUDlsQ1ZSSDNtQmNWQUlFSkJoYkFzVlp4RzJtOUFLcDlyR3p6?=
 =?utf-8?B?bllZQzRKMjgvNnJCTzRzR3NONkpJVDVGSDBoM095TFcvQnZ6OTBYU0xSU3g3?=
 =?utf-8?B?SkhwbmNFRTMyRHdYWVR2R29BN1hsVTJMZXVFU1kvUVNjQWhUdHFNbVcxRG9x?=
 =?utf-8?B?RFl0YWhFcCtSZ01pdUM4aVNrSDEzNVFMRm5abzNxQkZibWt5d1RSam5vemRj?=
 =?utf-8?B?L09adUNkekFHY1dMQ1Npbjg0dUk1elJiN3hUWWsxTVk1OEdSVVdOellJQUYw?=
 =?utf-8?B?Z3I3WFFJcys3VWVHRTIvTDlvaGJWck96cXFFSXJFUTNVSjlIZ2xOVDBCa3Uz?=
 =?utf-8?B?UVh6S2p4RitRR2FvVmxybUQ4dDZXblB5RUNYanNuQ2VmV2xRby9LT1VsQmRZ?=
 =?utf-8?B?NkZwT2ZiZmlidE16WGc0eWJQYlFYTnk2aXJza1UzUExOZHh2R05pekcyNHJV?=
 =?utf-8?B?VFoyd2ZzaGlEQTVBN2JHM3owTkRtY01NeFB5NXRRNll4ZFZXWGY0L0g4MlBk?=
 =?utf-8?B?dkd2UXlIRThxZkN5MVlLNnNpaXhPeUZnaWhlWmw4dTVQS2JPL09ZYUk1b1JB?=
 =?utf-8?B?cGRPeDREbmRVSERCQzc1QUtGcVRCZVBPU2FEeDIyYjN1QTF4U1Z2NXV5VC9Q?=
 =?utf-8?B?U0pCL0ZFekFLc2c4NzVUR1I4YnNrS3dIOUh2M2VaZHdVN2tKZWMzUkJhVE8w?=
 =?utf-8?B?VVltcDNJQldheXFyS2h2ditLYkVQeTBUV1pjQ2hzQkIrS0IvYzJqUjJJUncv?=
 =?utf-8?B?ZzBVaS9TR3RtL01uUDFOb09jQTNSUzBBV1NIQkhJTmZPenQrZ2NVRG5GNm96?=
 =?utf-8?B?UFl6amNTdm85OVZmZGQzR1kxTUFuRThXNHZQUStzNk1PeWRVVGZTdlI1QzB2?=
 =?utf-8?B?YjlJQVFQWFc5alY5SkxlUjZOMlR6TVJ6eUh0b3BjN0ZlL0wzZDA1MTBEckZK?=
 =?utf-8?B?NDI3TDJkRWQzS0x2OXNhTktrMjRCblVvTUFYNlR3UGgvWjIwTmUrWTBmZnNM?=
 =?utf-8?B?VmoxQ2hzQ0lrS3VGWmc4QVl3VTZyTkpSeGY4OXF0KzlGWmo5L2I2U0h5Lzdl?=
 =?utf-8?B?TWhpUVFqVGFyMFdTbHQ5OG42bFN3c3dWc3lNejRRaVk2a0MzaVUydFRucUo2?=
 =?utf-8?B?Z3Y4VTZhcU9DQ1UvbG4rZnJ6WVMrNkF0TytZaW5OVFBQVGRPRHhib3RaSTBv?=
 =?utf-8?B?TzdNQzNMSWR1Rlo0RnkremNlY0VHc3ZzdDVqRDlYbGJwRnhMcnF3NWpLajla?=
 =?utf-8?B?cUQ5L1VML1FLWEVGYjExdjMvRWdhRXNWbXlrem0wa2NaSksrSmFLNWtTYzFv?=
 =?utf-8?B?K29mQzQxTzU5emY0VTIwNHJWOU5WRWN0eEwrbVgxSWlyYmtmdklPNVJZM1Qx?=
 =?utf-8?B?WWw3dGtkK0FMNi9tSExaMDE1ZkY0bS9rdHJCVUM0M2NZZDg2S3JIYVg4UU9T?=
 =?utf-8?B?RVMxUXVpcnBoN210c2tCOGY0cThzRVJWMTVqOWwycGhtZ3hQUEFSWDFKNUEw?=
 =?utf-8?B?MyswQk5EcW5VcTNiYS9LaE9kUVFSSFdYZlpPNFY5SW5wcGdMZzArbC9kRWJV?=
 =?utf-8?B?VGZwUGpLTXFYbDNzNXl2UWtCSDV2blVHNVNJWG5SSVpxS0ZLczc0YXhndUJI?=
 =?utf-8?B?QTdESXRTcVlVY2V1REhEakh3SDh0a3NlNXcycVBGZUtHdkUySDhVTkNXMWN5?=
 =?utf-8?B?UU9nbEV1eTRTYnBWbEVpU3d6bkRxcUZyQXljZ2VvbjI5Sy9TUmdDbGN1bFIr?=
 =?utf-8?B?ZGtQU01yYTJZMEF0ak9xMjVwNi9yRVhFWVdscDgranBhMGk2bHdlYnV3VkF3?=
 =?utf-8?Q?FD7kt5IrqzN6BmstcansG1CUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2785b04-469d-4296-142c-08dc6ea53a8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:51:51.3630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycKL7/wHGUkJNBnj9ek1XW8eU7PFArnReVLbzxizsFYvRaQnfpGYrPRWIkIahbX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052
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

Am 06.05.24 um 15:48 schrieb Arunpravin Paneer Selvam:
> This happens when the amdgpu_bo_release_notify running
> before amdgpu_ttm_set_buffer_funcs_status set the buffer
> funcs to enabled.
>
> check the buffer funcs enablement before calling the fill
> buffer memory.
>
> Log snip:
> [    6.036477] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
> [    6.036667] ------------[ cut here ]------------
> [    6.036668] WARNING: CPU: 3 PID: 370 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1355 amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.036767] Modules linked in: hid_generic amdgpu(+) amdxcp drm_exec gpu_sched drm_buddy i2c_algo_bit usbhid drm_suballoc_helper drm_display_helper hid sd_mod cec rc_core drm_ttm_helper ahci ttm nvme libahci drm_kms_helper nvme_core r8169 xhci_pci libata t10_pi xhci_hcd realtek crc32_pclmul crc64_rocksoft mdio_devres crc64 drm crc32c_intel scsi_mod usbcore thunderbolt crc_t10dif i2c_piix4 libphy crct10dif_generic crct10dif_pclmul crct10dif_common scsi_common usb_common video wmi gpio_amdpt gpio_generic button
> [    6.036793] CPU: 3 PID: 370 Comm: (udev-worker) Not tainted 6.8.7-dirty #1
> [    6.036795] Hardware name: ASRock X670E Taichi/X670E Taichi, BIOS 2.10 03/26/2024
> [    6.036796] RIP: 0010:amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.036891] Code: 0b e9 af fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 7f 2f 7a d8 eb 98 e8 18 28 7a d8 eb b2 0f 0b e9 58 fe ff ff <0f> 0b eb a7 be 03 00 00 00 e8 e1 89 4e d8 eb 9b e8 aa 4d ad d8 66
> [    6.036892] RSP: 0018:ffffbbe140d1f638 EFLAGS: 00010282
> [    6.036894] RAX: 00000000ffffffea RBX: ffff90cba9e4e858 RCX: ffff90dabde38c28
> [    6.036895] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 0000000000000001
> [    6.036896] RBP: ffff90cba980ef40 R08: 0000000000000000 R09: ffffbbe140d1f3c0
> [    6.036896] R10: ffffbbe140d1f3b8 R11: 0000000000000003 R12: ffff90cba9e4e800
> [    6.036897] R13: ffff90cba9e4e958 R14: ffff90cba980ef40 R15: 0000000000000258
> [    6.036898] FS:  00007f2bd1679d00(0000) GS:ffff90da7e2c0000(0000) knlGS:0000000000000000
> [    6.036899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.036900] CR2: 000055a9b0f7299d CR3: 000000011bb6e000 CR4: 0000000000750ef0
> [    6.036901] PKRU: 55555554
> [    6.036901] Call Trace:
> [    6.036903]  <TASK>
> [    6.036904]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.036998]  ? __warn+0x81/0x130
> [    6.037002]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.037095]  ? report_bug+0x171/0x1a0
> [    6.037099]  ? handle_bug+0x3c/0x80
> [    6.037101]  ? exc_invalid_op+0x17/0x70
> [    6.037103]  ? asm_exc_invalid_op+0x1a/0x20
> [    6.037107]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.037199]  ? amdgpu_bo_release_notify+0x14a/0x220 [amdgpu]
> [    6.037292]  ttm_bo_release+0xff/0x2e0 [ttm]
> [    6.037297]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.037299]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.037301]  ? ttm_resource_move_to_lru_tail+0x140/0x1e0 [ttm]
> [    6.037306]  amdgpu_bo_free_kernel+0xcb/0x120 [amdgpu]
> [    6.037399]  dm_helpers_free_gpu_mem+0x41/0x80 [amdgpu]
> [    6.037544]  dcn315_clk_mgr_construct+0x198/0x7e0 [amdgpu]
> [    6.037692]  dc_clk_mgr_create+0x16e/0x5f0 [amdgpu]
> [    6.037826]  dc_create+0x28a/0x650 [amdgpu]
> [    6.037958]  amdgpu_dm_init.isra.0+0x2d5/0x1ec0 [amdgpu]
> [    6.038085]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038087]  ? prb_read_valid+0x1b/0x30
> [    6.038089]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038090]  ? console_unlock+0x78/0x120
> [    6.038092]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038094]  ? vprintk_emit+0x175/0x2c0
> [    6.038095]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038097]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038098]  ? dev_printk_emit+0xa5/0xd0
> [    6.038104]  dm_hw_init+0x12/0x30 [amdgpu]
> [    6.038209]  amdgpu_device_init+0x1e50/0x2500 [amdgpu]
> [    6.038308]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038310]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038313]  amdgpu_driver_load_kms+0x19/0x190 [amdgpu]
> [    6.038409]  amdgpu_pci_probe+0x18b/0x510 [amdgpu]
> [    6.038505]  local_pci_probe+0x42/0xa0
> [    6.038508]  pci_device_probe+0xc7/0x240
> [    6.038510]  really_probe+0x19b/0x3e0
> [    6.038513]  ? __pfx___driver_attach+0x10/0x10
> [    6.038514]  __driver_probe_device+0x78/0x160
> [    6.038516]  driver_probe_device+0x1f/0x90
> [    6.038517]  __driver_attach+0xd2/0x1c0
> [    6.038519]  bus_for_each_dev+0x85/0xd0
> [    6.038521]  bus_add_driver+0x116/0x220
> [    6.038523]  driver_register+0x59/0x100
> [    6.038525]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [    6.038618]  do_one_initcall+0x58/0x320
> [    6.038621]  do_init_module+0x60/0x230
> [    6.038624]  init_module_from_file+0x89/0xe0
> [    6.038628]  idempotent_init_module+0x120/0x2b0
> [    6.038630]  __x64_sys_finit_module+0x5e/0xb0
> [    6.038632]  do_syscall_64+0x84/0x1a0
> [    6.038634]  ? do_syscall_64+0x90/0x1a0
> [    6.038635]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038637]  ? do_syscall_64+0x90/0x1a0
> [    6.038638]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038639]  ? do_syscall_64+0x90/0x1a0
> [    6.038640]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038642]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038644]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> [    6.038645] RIP: 0033:0x7f2bd1e9d059
> [    6.038647] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
> [    6.038648] RSP: 002b:00007fffaf804878 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [    6.038650] RAX: ffffffffffffffda RBX: 000055a9b2328d60 RCX: 00007f2bd1e9d059
> [    6.038650] RDX: 0000000000000000 RSI: 00007f2bd1fd0509 RDI: 0000000000000024
> [    6.038651] RBP: 0000000000000000 R08: 0000000000000040 R09: 000055a9b23000a0
> [    6.038652] R10: 0000000000000038 R11: 0000000000000246 R12: 00007f2bd1fd0509
> [    6.038652] R13: 0000000000020000 R14: 000055a9b2326f90 R15: 0000000000000000
> [    6.038655]  </TASK>
> [    6.038656] ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Mhm I'm not sure if that is a good idea.

We should probably not always set the flag to clear the BO instead. And 
warn here when clearing the BO is not an option.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index b2a83c802bbd..ecd0cf6cdd2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1371,6 +1371,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
>   		return;
>   
> +	if (!adev->mman.buffer_funcs_enabled)
> +		return;
> +
>   	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
>   		return;
>   

