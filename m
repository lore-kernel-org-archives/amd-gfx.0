Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF12CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A9F10E291;
	Thu, 30 Oct 2025 15:54:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XSalzFTU";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C3110E291
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMQfzYPl3ZSZJnH+BVUxuBrDr4EnQWlFUtqFfQgWfGz0sxxwYMDHKBIa/kpdjcHXiCAQa/MnrCV4w83AENIlyWA2KPM4n5BMHvt1ry6ZEUwbbPzgMlcsSFDGNF16tv2up+RjM3LbIXwhau8LlOfRfWnCjDOjOzPj+EPAZ80OQaVxrZ3SU3exbRpKkUgF1/1tw0PVKCJXekTfxh617sge4etSxruo0waoSpjL/ro0Rv6xQccRS/kUVDB3cS56lTmrDOg6RBC2vXaIm8DRCUhks0S/upNSQpqVzZq/QGJx2eCD8LyThHQCRgcDvaZkOfKjLbySM2yZauxVrJUhCKBYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eulN8AOcmtEuhsMe8c3e6J53iV1kOMcf5q2JJQ7b/Vc=;
 b=remHZ9E3gplaSEYsSbj7O1G9KIwd9XNw25VJNmMgrmZi7Af5fFxsZCPjTvCfWgEEQ8hjzvIdsKKNN9JKN4FwIl6vk0joZp2MN9Jorulzsa9GchgUsxlNFFdWNys1urU0J92CUnNWNXix96j1ZFXbQ9CHvQGipdfvo/a1cP1uw1m8QKfyIv6Gb8gqh/Y/G9b3d26HHVOgskopd/jazMNBnba93pAeyii5Hy6Lt3kppyRwmrJMc01kV3UJCR3mZInWjbAhAEFxSPdz+qFYenR0nAwpiqo19vht0kQuGDEdFsWakGZQTCjGB5562u+l8i4O9V6fWYrHmLfSpmm58Ls5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eulN8AOcmtEuhsMe8c3e6J53iV1kOMcf5q2JJQ7b/Vc=;
 b=XSalzFTUrbz6RKXNORqLuiS7r2YVPYj7suaDcv/UZELIA2CDOy47e/goYBtMWSnpX5o4swXzLoT5/a0dhZWdFg5ZJ+WznSR65UZyNqSf1nFtjalcmlSuhf41GOckoT28B+18P8QMV5dDl23BmKDIsotwftmJxrhcYbpN1gt8x2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:53:57 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:53:56 +0000
Message-ID: <050ba477-c7d5-4420-8f06-6fce0db48726@amd.com>
Date: Thu, 30 Oct 2025 10:53:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: implement per process/device pasid in sysfs
To: Zhu Lingshan <lingshan.zhu@amd.com>, felix.kuehling@amd.com,
 alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251030034536.11356-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251030034536.11356-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:21::30) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 945f2fc1-bcf2-41b2-b5c9-08de17cc889c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tjh5QlkwcEU4Mm5od0h4eDJZZmJ0aGlUeCt3Z1R6aXpGa2ZwRS9pUGFwNnFa?=
 =?utf-8?B?YncvRTdBYlQvYzM0K0UzNWlpa0pUUDhEY3lHOE9FM1JkcmU1Ymgza2QvSEww?=
 =?utf-8?B?NC9DOVB1UmNpLzhGWUV5RnFEckFpVDFmbW1TU3RYTFk4REpEeWxqT1RRY0lX?=
 =?utf-8?B?WUtPUW93bVhwaGU0b3RORUQrU1NrTFVvMjBtZWlySmJwcGp0L1JSSmZLK21j?=
 =?utf-8?B?dlM2bUNyelQ2eDZsTmtlNHJnSVh1MFB4QjEySng2SVpqdHVPZ1hOWnNWVG1H?=
 =?utf-8?B?dnE1Z3pzUWhUcEwxajIwclgrdVlEeC9NQkJhcjNsbXFTK3MvcjJ0SmM2eU9P?=
 =?utf-8?B?Y0ZYV1plODZNSUY5SXM5eXc2MU9QRml5U3ZPZVJMQkZYbXNRRndoNkpuRmlS?=
 =?utf-8?B?cWUwOHNucUpZU0p4ZklmVm5haGFNa2orTmxWSWtocXB0T0FKUStnOU5VZlNV?=
 =?utf-8?B?cFVFODFCTnkyTmsxZ09SeDlZWVk2dWlZQm5LOXhkVTBKSlNwZzBSeHZ4dHRZ?=
 =?utf-8?B?NEkwTUNhZjBHTEJZWXV6ZC9LdUZMVFVHdGkzVmNIUk9nRWRzaGZZSVRVSDVB?=
 =?utf-8?B?S0N1OGJvQjVNY0xnZEZEMStmcEdOWFRYWkJFQmNzRnZ6aVY1RUFhT3AxbkJK?=
 =?utf-8?B?d1FDbUNvZUhEWU5DM0Q5QUUzUWVnemkwQ1ZNUlRCSGVqRllWOTNaemVVOXNo?=
 =?utf-8?B?OXlYcnkwcTVMeWNMOVVFVTBSY29GM1U0L1dCL3BBZnYyNGdnRnFSdDFuREZI?=
 =?utf-8?B?T1R4aU5RZTRQZEYrWEhubDBzRXE2a2xSd2pXT3g5d3RWaDg1WmMrMXUwbUxF?=
 =?utf-8?B?aFhaeCtFcURNdTRmZkFPbFJ6QkFGNkRTMDNwVTdpNVUrTG05OWh6cXhJODlw?=
 =?utf-8?B?UUFNYjBkNjlwQmNmZUhYYnhGOHpXS29WNFY0RXpsT1lLVmxhZWxWZzFuSytw?=
 =?utf-8?B?NnZXOTVKMnNEWFNxaTRrTUlJTUZPazczZHBhWlhqdkwySDJqbUdaNHg5RXkw?=
 =?utf-8?B?dzlnUS9NMndQdDVYRXA5SUlYK2VLOXRtNk0vN2M1MEcvTlVlMk5rNS9kc1lx?=
 =?utf-8?B?VkVqMGhrQUxKWkUyTHZ5bnVXTTVudThBSVp0enhBOC9rbExEQXhDdFBqWjFi?=
 =?utf-8?B?UitlT3ZTcUppdHFRM0trcjhYejAzanVFT0hqdGtKSUkrWUl0Rnd2NDFqZzN1?=
 =?utf-8?B?bFkreUpNMXlET2FBN0VwS2ZtQnFIVG4zTlZUdlFQQUhRWFlwaG8yQ1RhS085?=
 =?utf-8?B?STBJbFdQd1QrbUlUS204OXRlMUdzRGtjYnpENjloWFgwTmh4aC9LMlZmMFlY?=
 =?utf-8?B?cHNkWXlwZlFhUWdDNHdxMWpKeWhZNGpWOE9sa3NaT3J2MmxreDUvVWJ4VGZz?=
 =?utf-8?B?R2NiS1BDaXVSQUUwc2QyUEdKY1N4bGQxWlM3TnhuUGlNclFVN1hySEZWVE1E?=
 =?utf-8?B?dlpxQWlMN2FkdnY1SElDQjFuNkFQZDB1ck54NmFrajg1MkwySWtlQmRIcDhj?=
 =?utf-8?B?Z2gvenZQZjFPMXUrN3dhNWpqU3Q5RmJicm1tKzN2djVWd2QrejJ3MXJxOTc0?=
 =?utf-8?B?ME1yMEo5REdydFNPL09LSXBndG5Jck9YRFhRT1ZVLytYK2tOVVZNMWlTWEVR?=
 =?utf-8?B?SDAwQnNCZ3JsYTVpM1hFMkR4dkk0Q0tIYkRmZkR1NFRCZWk2Mkh2ZU9pYTVp?=
 =?utf-8?B?MW95bjFkSlJ5Q25aNkhjaHZsMlQ5dXlWMDZZOGtKa1RIc1ZiMnpBRG1xTXUx?=
 =?utf-8?B?NFZUYTU2MHd1NjQ0V08yUG1zSkt5Vlc5RXlsQVFQaG82RHlETzBoWEdJaWFr?=
 =?utf-8?B?THMzNVBpK1pVTjVlNUFHNldxdm1RS01WN3pKeVcvU05MUTdIdSttWlE2MFFR?=
 =?utf-8?B?M0o5cCsxamh2SGJpNXdXcXIvVWpaczl5Q2l1elBWYUY5aWxnNFpPSERWdURL?=
 =?utf-8?Q?GPn+TcnseUqV5PUm2U+1S95qd2pXq8FE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdwL1JQU0IrNmdTM1cvWjlhaTVsWmdSc1JJdUVuRDQ5T2FQdndkWnQ3U1dv?=
 =?utf-8?B?Y0xkaWllQVZ1ZGRXMVgzSGRBU2tVcEp3c1BUWTFha2RSWTVuSU84M2ViSjhr?=
 =?utf-8?B?T1hON2RVVG4zZkZkU1FHeHNDNHp5VVg0OEZvLzBTbU9aQk9nRkQ5UnZMUU5Z?=
 =?utf-8?B?azNINzI5eitkOTQ3NmVuYWRSeG9RZFJmSTJjbFY5REVKTGZPWDRGeTBBWmh6?=
 =?utf-8?B?QitLOHBqSEtWZitiUmQzSGcrOCtJbDVtNzJsUzVwNXlGRmNUUitzb0xVdmtY?=
 =?utf-8?B?a0pCM1lEYTVPSGdlYVBzSU40SjN3RThEVHRRbnZ4Mmd6VVJ4OEVGWGl3WEU0?=
 =?utf-8?B?Si9ZVkFOMEUwbkFCSlBLZ0xpcndaUTJLMGJuMWNRYVJ2aXltSUJUdlNFc1RD?=
 =?utf-8?B?MTJpV2JiRS9iaGdrTjBBNWxaOXdIc2RYS2lzMzJJaGF5WGlNUmJFcVFHdDhx?=
 =?utf-8?B?WG5CQTdkZ0xkRzZRZm50U0ZYdzJjQjhVbmdiOGNjZFVCMjJ4RG1vOTl0WVBJ?=
 =?utf-8?B?ZUJuU3AzNzdvaTN5NndVTmc4NVRrWjEwTjlvNmNJQXdHQzY1NlduT3hIMENT?=
 =?utf-8?B?QlpYRml6c0FFQjBtMDVkeUZpdm9jK2diUkFzYnlEYTlIRW5SZEhOZlovK1px?=
 =?utf-8?B?ZURieVFQZHo2UmtMSzNwalNlZzFmaHlaekNVZW1ITVRMSnZ5NzVrN2R6NkRP?=
 =?utf-8?B?RitCU3BBZUVGcjlRWVl0UWp0WXI4SFdRaXVhU01FRVYwWEZYQ21SVHp3Yks2?=
 =?utf-8?B?VlVLS21SUnNsWFdQeXV4cnhDeDJNL1VsbVZmM2c5YStjK0xJR0J0WndJOC9m?=
 =?utf-8?B?SmY4ZG1CMHZMTXFjTWlhZm5kMnlpY1hoOHdpcmVMRTBxbS9Hc2NTNWRGTm9W?=
 =?utf-8?B?MHU0TlpWcnp0NTFJMUpBdTZYVDZPVVJPZUhJZFJpQ05ZMDVITVgvVkxuVXFJ?=
 =?utf-8?B?a3hzbTFYTFczcUdyK0FsSC9ZbDdVVUpGVzJTZEZNYXNEcjJRMktzdXRHcFM4?=
 =?utf-8?B?R1pOUmVxZHVXeDlhQkFoRjNTeUxIV0lLL0M2VzFQTWE3Q1hvRjk4dEd5aXAw?=
 =?utf-8?B?UFRTM1NZK1IraG1BNE9RajBQSWxndi9VQlpEcm9xZGpJTENncFFoTVV2V3Ba?=
 =?utf-8?B?andvR0l5OUhpdmFWWVlxRDl5VU9vWVUvc1BhOXR4TlNNSXZ6eUNVeEh4ZDdC?=
 =?utf-8?B?Qmh6NVRmNnZpWXNuMHdxellWQlVQRC8xSzZCYkY2b2U5R1BLbjNITDFDVE9i?=
 =?utf-8?B?eTVLeW43YXpYVEhzLzhuS2hGSk5RTy9ObGpWWE9VU3BQY2dRVkgzb1pUMUg2?=
 =?utf-8?B?SENTTys1R2ZoNW1Na1oxUFg5alNMdE5hUGpsL1pseHVvb2VZVlhYN2pKRVhE?=
 =?utf-8?B?bkd0S3hXT3pSbFFxQ3d1aDdQQlJjNGcwVFhuTEtmWmVZeHZhbEREQkFvcDZm?=
 =?utf-8?B?Z3hNMW5MbmNzUXhmanVUSytzM3JudUZrcDBRWVpBNkJleUxMZ0pTSEpQZmNj?=
 =?utf-8?B?c0FvWm0vN3lkSGpPakFHVnpiMXZsWlEwNmFKVzVyZUlxb2w1THUxNENBRGQy?=
 =?utf-8?B?Tk81YSt1SExVZFJPN2NSMm5sYjFhbUN1cnFPbU9abmhLaWtFb05GZ0JqaFlD?=
 =?utf-8?B?YkdPVzN0NUlSWktSYUNNT2ZlQThsVnV3MkdXTGp3UnRMOUFtZXdhQXp6N2Fo?=
 =?utf-8?B?RlRPU09oa0YvUjdwRG5WTlZYT1ZxWWhYaEhnbHIrZVpvZlRJajlJbjh2T0JL?=
 =?utf-8?B?RnViaFlPVm5hS25TU0drM294US9NaTFYWW81ck44NkllcVd5V0VxeTE1Um5O?=
 =?utf-8?B?STFoSENuSzlCM0t6MFRRTU9ZZllnbjlZWlZDQXhKcHREMlBtT2R5Y25jOE40?=
 =?utf-8?B?cG5FcjF1T1VJbnVBbVphNFhVQm5sVHMvSmFtaUdDZWZIc3YzSUNIZGJ4Nnox?=
 =?utf-8?B?aCtvSnpyRWZSRkNLRjZXNzdpNFFWNzNYbW5nd3RQWmZySGlsRXVPc0JnZ1JQ?=
 =?utf-8?B?b0ozcmlIMGE0RUNaVFZTeUR5cUwvS0dWMlpiREcveXpid3k1ZkRDYXRMeld2?=
 =?utf-8?B?TEVrRzd6UUxNZ3ZDYmdtcUV1YkVodVRBTENzdGpxSmZEeHNCMXJVeVIwTTMz?=
 =?utf-8?Q?lzHI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945f2fc1-bcf2-41b2-b5c9-08de17cc889c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:53:56.7842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is5kh2Ik7wPcm5JLnT6vAr/fd2MPjCO2FlvjqslwBlHzcrR/BFXyGOjJ+NyqMDiv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757
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


On 10/29/2025 10:45 PM, Zhu Lingshan wrote:
> The pasid is a per-process-per-device attribute,
> therefore this commit implements per
> struct kfd_process_device->pasid in sysfs
This per device pasid is used internally in kfd, not used at user space. 
So no need to exposing it.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
>   2 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 70ef051511bb..6a3cfeccacd8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -864,6 +864,8 @@ struct kfd_process_device {
>   	bool has_reset_queue;
>   
>   	u32 pasid;
> +	char pasid_filename[MAX_SYSFS_FILENAME_LEN];
> +	struct attribute attr_pasid;
>   };
>   
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> @@ -983,7 +985,6 @@ struct kfd_process {
>   	/* Kobj for our procfs */
>   	struct kobject *kobj;
>   	struct kobject *kobj_queues;
> -	struct attribute attr_pasid;
We keep it to have use space tools(ex rocm-smi) work as the tools still 
read it before they change.
>   
>   	/* Keep track cwsr init */
>   	bool has_cwsr;
> @@ -1100,12 +1101,6 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>   					int handle);
>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>   
> -/* PASIDs */
> -int kfd_pasid_init(void);
> -void kfd_pasid_exit(void);
> -u32 kfd_pasid_alloc(void);
> -void kfd_pasid_free(u32 pasid);
This part is right, these declarations were forgotten to remove.
> -
>   /* Doorbells */
>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>   int kfd_doorbell_init(struct kfd_dev *kfd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ddfe30c13e9d..24cf3b250b37 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>   			       char *buffer)
>   {
> -	if (strcmp(attr->name, "pasid") == 0)
> -		return snprintf(buffer, PAGE_SIZE, "%d\n", 0);

Same as above we keep it to have compatibility with current tools.

  Regards

Xiaogang

> -	else if (strncmp(attr->name, "vram_", 5) == 0) {
> +	if (strncmp(attr->name, "pasid_", 6) == 0) {
> +		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
> +							      attr_pasid);
> +		return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
> +	} else if (strncmp(attr->name, "vram_", 5) == 0) {
>   		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>   							      attr_vram);
>   		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
> @@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>   	 * Create sysfs files for each GPU:
>   	 * - proc/<pid>/vram_<gpuid>
>   	 * - proc/<pid>/sdma_<gpuid>
> +	 * - proc/<pid>/pasid_<gpuid>
>   	 */
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
> @@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>   			 pdd->dev->id);
>   		kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
>   					    pdd->sdma_filename);
> +
> +		snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN, "pasid_%u",
> +			 pdd->dev->id);
> +		kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid, pdd->pasid_filename);
>   	}
>   }
>   
> @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   			goto out;
>   		}
>   
> -		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
> -				      "pasid");
> -
>   		process->kobj_queues = kobject_create_and_add("queues",
>   							process->kobj);
>   		if (!process->kobj_queues)
> @@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   	if (!p->kobj)
>   		return;
>   
> -	sysfs_remove_file(p->kobj, &p->attr_pasid);
>   	kobject_del(p->kobj_queues);
>   	kobject_put(p->kobj_queues);
>   	p->kobj_queues = NULL;
> @@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   
>   		sysfs_remove_file(p->kobj, &pdd->attr_vram);
>   		sysfs_remove_file(p->kobj, &pdd->attr_sdma);
> +		sysfs_remove_file(p->kobj, &pdd->attr_pasid);
>   
>   		sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
>   		if (pdd->dev->kfd2kgd->get_cu_occupancy)
