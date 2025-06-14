Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787BEC71135
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Jun 2025 03:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF4110E9C5;
	Sat, 14 Jun 2025 03:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DU70ONlA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009B210E55C
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Jun 2025 03:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFU4E4Tk1wblVbQinfV9Mtm/cMCpAphypUuzh/eoJXbk28R/4CLsvXzuCOOxB7jbs0jpn1dqNtwGbi5IlDpOh91wTSETwtv3/IoFp5LwBbZCanw0iEkiqIn9lkK15hnw0Z2Bp+3h08LmWA42NjC2qdcs8iVcwUnnkqLJp02OBz2DV5YSEc0w95dh8dPygBlbHZeWwNmR3U/pugjR7P8Ur/2ZLrwqImNCEPYuyEcrV6Ajz/b1qGk9dVmUHOHsQjVu6+6Yw2TSHg0EmDl1Baej+qDTkQl5kLkzQ2MQ/UtXek10mKBlDieSHdKIRp/XTFsMCUUH9LgccFtgPkNfKmeZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exLFDW+u8ELdW+pjpDzvBPtb8GqbY90EKJmWR2EfaCA=;
 b=mKe9/zqPs1CYku8q01XQsCmFL6r7AlAPyt/yiXxj9vDHmZ8xsf8r+1BLSOgoT42a+A8OjMmsjNPfsYNEmJZ/0k30uaK2pwxdORfL7fTcZiclkUdxNSF/M1n6Ca5dZTIVOJHBHiF8HC+K4UYpBesCLVPILip8dYj4LfFPyDDZNhezpOiS1cQTE9pm4Zcq/Hce1BvX1clGeiMdcI0EB3nBtpr7EacgTEWX+c6cvIEPfqjVu505xB+0XFjcF6HKxzY4Pv8E2QmtG9UBF8nxnaGRekqlvSe7PY+7c9DOxHSGAmKJpFPODUaZMYWTWDe+7gB1pMtnXvj+Gr1i1luf6r2slA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exLFDW+u8ELdW+pjpDzvBPtb8GqbY90EKJmWR2EfaCA=;
 b=DU70ONlARVEbWzT0D7zUsml4Nro/wKFjtXN+2tMONICjDLNIZUholBXEDEFID9TANCIVxFuTGGzWSv6pUIypxQkjHB3HoDSrQtXFMPPpukMqA2BibokRFUSa9c28UKx/L6xZ873YUnr9jex3oJBPdcNcBUe3nWJJR7Wm4HnDGtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Sat, 14 Jun
 2025 03:27:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Sat, 14 Jun 2025
 03:27:18 +0000
Message-ID: <f1525ee7-9f1d-48ae-81af-f97fb3a00351@amd.com>
Date: Sat, 14 Jun 2025 08:57:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Adjust output for discovery error handling
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20250613214101.4117000-1-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250613214101.4117000-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS7PR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:604:256::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d5439c-ee12-41b9-5187-08ddaaf35d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXkwZXN4TDJZTlVTcjg3dU9COUNiL3k5ckRiQzJoa0hYV09vMS9xZllqcFk1?=
 =?utf-8?B?bFcwTWsrcVZWNys4Wk1rVVlTdS95UjFEQU1RRGxXSFo2STExZXdyYkN0U0JV?=
 =?utf-8?B?VVYrZkdpN2NWVVNyQnVySVBtS05TNmJ2QWkrbTVOWjFub3BwaXNUWU5UakFi?=
 =?utf-8?B?cGNCSFpVQk9wdnNRZ2NSVmpzV3dJRlZyNnh3VWNiY1BOeTlHaHNDQ0I2ZjZ5?=
 =?utf-8?B?MnlvLzZUT3dvcUJYK1FLTjJOczBNNW5yaVdGY0xOdVRIYmxqUElqWUt3MVA1?=
 =?utf-8?B?dnh1TFdybW9CTEhIQUsveDBibVhPNmF0dFV4MkFCSERQWU4zRVhvd1pCVUt2?=
 =?utf-8?B?TzI4SU9ydjBjcnJtZ0FXanliVk1ad3Y3RXo3bm5ia1VkV0dJZmFETkFZN0Zw?=
 =?utf-8?B?RU5IYy9XK1VzTEovMWJGeS9CSDIxVmlMNndXYm5CY2RFdFZQbWtpOUhiRkYw?=
 =?utf-8?B?WENyeDdyelhKaG90WGpiYTI2ZllnMHlzK1pPbkk4bXc5MkF0SnYwb2RybFRH?=
 =?utf-8?B?VmFJWElDZnpyOWRQYy9LbXBUVUxCNFZIdW8vdmtUYWt5S0pmcDF6Z2pZbGVp?=
 =?utf-8?B?Z3lGRFhrSzJZVUxJY1cvNlRjYk94R243ZlNBamU2SExJUGtMTjBib1UyNDln?=
 =?utf-8?B?bUdzOFJaTnNLanZZazA2NWhldjdqK2dLTVZsRmtwOVpjeHhmYkZNYnAyano1?=
 =?utf-8?B?a1BQTGNZSEY3Qm9PWlZNNE9ocW5ROERWR0ZXMXl5TFdHRFVEYXFEVGpueSts?=
 =?utf-8?B?bHF1ZTlzVnhKQjlHQWpCSytDUXQ0T0hpS3N1WkdJUFBZQWQ3WnJ0bXRwbi9O?=
 =?utf-8?B?VTBhMEZHdHM5TnJENlRQMkNjaTdNWXpFQlFweFAyOXdWdjhnb3ZVdEsveFo1?=
 =?utf-8?B?T3Nzc1kvRGZiZFgyTzc1UFBmaE1zSmhlQURBVVV6OGlMMmF4dG50NGNsd0gw?=
 =?utf-8?B?ajVQbzdQN0RPRTZjTnBuNit1TFVPQnEwN0QyYStvbm5oYUhKMGYxMUF1b0tm?=
 =?utf-8?B?RWRidVFldlFrcW5oREk2bVhiTE15WTI3TElkVUFlaCsvOVRhVU9qZk5Xb3NJ?=
 =?utf-8?B?Tktsc0QwMFNUUHBMN2ZjNEtRTUZwbUs2UnI2MUYvSGZXYzV5MUtERGpvWkh4?=
 =?utf-8?B?Z1Y5VldIUWhpK082cmI5dmwvYTFhYWIrZTJHNm1JM0pITytlVGdUUmIwVnAx?=
 =?utf-8?B?bm5ZaUMrVGRqL3BKZHNOb1lXWFlPaThEUmRsSHFxNGxvSzY5cXdWUVJ3cjlS?=
 =?utf-8?B?SGhaYUJDclZJZDJTaUdZUVRPcmFOY2pqSERsYUtkMDk1M0NaVnRwT1JCakwy?=
 =?utf-8?B?eVhhTW1ER1R5MXhmOGNRU0dsaHBSNGI5d0I1M3pmUE5WRVM3OU9BZHZXTFVm?=
 =?utf-8?B?bEYxZ2VjMWZUdFFaYVdSTmtJcE15SjBHVzZRRkl3K1ZOcWRId2VxWkkvSkJ4?=
 =?utf-8?B?Z1RnUE44bkE1ZkVXREZYUkM4M2xEVUFUc3ZuVjhvY21QS200ODZGdldIN0Jt?=
 =?utf-8?B?elA1eWkvY0VGQzRWKy9MTGRBVjNIV0NSQlk1WU5VTC8rMklwbFdnaUlKRDVX?=
 =?utf-8?B?VkZkQXlNWlhPS0RaUzh5eHVrMzdLSVFsVjZEUVBtWVlzNHdzV0tvVldpZlVW?=
 =?utf-8?B?OGp2dHhTRjJKZ2JkQytjYXpPQTM3ekJFS2EyaFJpYzFJay9GNFB6cGNYQnhh?=
 =?utf-8?B?aDF4cUEwQklOK1N4RFI4dWFDVk1IcXhzbWhYaEhrakU1Ykh0ZnVncHpWZHI2?=
 =?utf-8?B?a0RlUW0wNTB3MzBObXhGVUVSeUNhM3lMRGVXY3AzbjFhd0VVRnRjZEtoK0pU?=
 =?utf-8?Q?fXLDvVE0tPxJHbjJO03R5il/2+deUC57pZe7E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFFaS3l6U0t0SHFIZWg2OERSdm9uNFhSa2lZYWpqeXF6L1hoclJNcXp3b0RY?=
 =?utf-8?B?Skl3d2g1OTJGcU5qWWZmVEVsVVJBK1VxVVRHVXJ6R0JrTDUybXd4VjIvemk0?=
 =?utf-8?B?clFibHBBWS9UblFYUjhCUGV3Ykk1L0s4OFdxTXdmTkpad010ZndjeTVrdHlE?=
 =?utf-8?B?UVA5eHF6VnBtQWJIS2d1dXR4dG80ZVlqSEpLKzBPWmhJT0ZEa3lacm9NK0k2?=
 =?utf-8?B?bWFFSkZ5dUZkSWlId2VxYVNXN1BpWkVuMVh0QmU2anpBRGhudlZFZlNUQnFP?=
 =?utf-8?B?TnMrMnBtTDdFVGVpTW1DdElSSEpNNkR1S1IxOTczNzJIbUlYb0VMRTRDcDZn?=
 =?utf-8?B?TkZxOWZVdzd6bXdEdTZDT0h3WUtVWUJRVXp6VUQxUXJMNlV1Nk45ZFZ5U2lU?=
 =?utf-8?B?RTR3Q05aaXd4cEh2bmNDMVp0Qm94dlB2N1pCK3BHdmxnTTlaWHBqMjQrZ1lK?=
 =?utf-8?B?VWlwRWg3UFVSdlRuQU94UGsvcVpXTCs4MzlENXQ3SUtYRzhRcnQrWmpoSHFv?=
 =?utf-8?B?ZXhnVi84VlhEYmdpU3g4UlRNaE84NngrbXJjcGY1cjJPcUZ6K3pTcTFHLzU4?=
 =?utf-8?B?bWw4bE5YU0pEUFpzWk5CUGlOVFh0dWppTzU0dGhNdU5vbFBTdG12TDd2OXdR?=
 =?utf-8?B?UGx5dHBMcGU1ZUoxdi9SYTJLa1YrVUt3aGQ3WllaTFhJOElqWEZibDhCOEgr?=
 =?utf-8?B?eTVSV01vU0VWV2pjYW1DOUdxVmVYRnBLM0EycmhzR2lhN05KbW1QbUdBVkNE?=
 =?utf-8?B?NVhEcEo2aE5GWTQwZWREMERNV3VvU2NFZWtsMUFHWURsNW5PWVJjdTJUamRm?=
 =?utf-8?B?dmYrRUxMRS9rT01ocUg4MHkyUTlBeE16amVGYnA4bjBlQ0c5aVVpVTc1U05V?=
 =?utf-8?B?YjNUN3d3QjEvY2dsMUw1RG11YW5lV3RxSERvOEZOYXZaWFB6RFBnYnY1My9s?=
 =?utf-8?B?YjU3N3FnbVcwQVU0ZEU0MldHalBpY3l0ZW9aN2xaQjYwWnVmWFhGRFczYVNU?=
 =?utf-8?B?a0t0NkZnRC84MnU4UDlMUWlMT2VLdnNVZ0k2bGVTV0N1OGt0b0NRYzdVSXpQ?=
 =?utf-8?B?WmZjR3JhOEF2N0FlZU9GYTRWUk9UMkhuSnFvaTR3M1BzcnpHdk44aU9sd1JQ?=
 =?utf-8?B?SW1iOVFjdCtERUFtSkhZSlIxeUZUTHFnSW5oT21admNPalJlb2x3cFUvMnR4?=
 =?utf-8?B?VFJ2NDJ3Y0VKbGpYa1NEMUoySEQwVVRKaVhjWWpQRm5ma0E4UlhPSXRrK2VO?=
 =?utf-8?B?c3cvU3h1am5XRXZCNDJPNTBsWmk3VXdiU21TbEJPT0kzcFN3cGlLSWJ2VEVD?=
 =?utf-8?B?Nzd2TjFSRU1ETUozNEQ5S1pXazNpYlVNSXpUVW9RaWg5djN2YStRMXlsdFFK?=
 =?utf-8?B?dUxRRU9xUjdJN0kxY0ZNOC9Fb2w2TVhEcnBsV2JVT1k0ZEtVWDZCY3JUNTRC?=
 =?utf-8?B?MXlMejVHTTBETjEzY1ZUa28rUkR3VnQ2UWVrLzJabEJTSU5xWXBPN29xOEhS?=
 =?utf-8?B?SGFQV3JCS0FUY0RFamtuRnZUK2FpSVZnNFo5SnVoL0ZUYUNpbnVpdlQ5Snpx?=
 =?utf-8?B?b25QbHZvM0V1RSsxeGFrd3JtSFFRRCtTYVlLZlZQbEp1L2VHKzZmSHUyLzVZ?=
 =?utf-8?B?M3ViaVBwZVBBanNySmdhRkhwTEpVcUNSVmxDK1cvK0dwK2RscXJGWmM2UHNE?=
 =?utf-8?B?K2xNanhPaUVqU3Q0b3ZQMmlKbldXSTU3ZnVxUE9reUc5MmRzYW15K0w0VWdD?=
 =?utf-8?B?ajNmbnhYN3ZJbVRPQ3FhMmJMUmlCVUJEaEo4VERyaDNNVDJhZ3BBZ1pFYzBi?=
 =?utf-8?B?M1dpZTdHZWhJaXRBR3lEU1lwT3ZnS2NKcGJOUXBMaGdHVCt2Nnc4WFZMYWFv?=
 =?utf-8?B?Z3dOMG9GenhNV29nTm40WjBiUFJYeWpxNUtHMFhBazIrMXNqSTBQdzVVMlYw?=
 =?utf-8?B?Q2JicUJnZUtkMHJXbTV3VldwK21jTi9TYkkrZVdkZ0lNeTBSR3I4S3l0Y0Ju?=
 =?utf-8?B?UnFycU5sVEU4djlJR0lxdEl3eGUvclRQMlNjZFFjWXczR1Y3ODJvSVVyVngx?=
 =?utf-8?B?N1F4M0NTUFI2c1ptSFlKRUZUZVlSMWpJNHlmQ3JJL1VhaVFuNVNlNGkwUHZ5?=
 =?utf-8?Q?8ow7sLGQ3KsuoneSggK6RT+cZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d5439c-ee12-41b9-5187-08ddaaf35d15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 03:27:18.0769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWQXb07QyaOeaYOUA6FpgtvyXfOquskzyprLzWkBsw+EKECfVz3PmDvpZSE0a+pV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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



On 6/14/2025 3:11 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file
> available") added support for reading an amdgpu IP discovery bin file
> for some specific products. If it's not found then it will fallback to
> hardcoded values. However if it's not found there is also a lot of noise
> about missing files and errors.
> 
> Adjust the error handling to decrease most messages to DEBUG and to show
> at most one message to a user about the missing file at INFO level.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4312
> Fixes: 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file available")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index a0e9bf9b27108..8e4526a8c2600 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -321,10 +321,9 @@ static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
>  	const struct firmware *fw;
>  	int r;
>  
> -	r = request_firmware(&fw, fw_name, adev->dev);
> +	r = firmware_request_nowarn(&fw, fw_name, adev->dev);
>  	if (r) {
> -		dev_err(adev->dev, "can't load firmware \"%s\"\n",
> -			fw_name);
> +		drm_info(&adev->ddev, "Optional firmware \"%s\" was not found\n", fw_name);
>  		return r;
>  	}
>  
> @@ -459,16 +458,12 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  	/* Read from file if it is the preferred option */
>  	fw_name = amdgpu_discovery_get_fw_name(adev);
>  	if (fw_name != NULL) {
> -		dev_info(adev->dev, "use ip discovery information from file");
> +		drm_dbg(&adev->ddev, "use ip discovery information from file");
>  		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
> -
> -		if (r) {
> -			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
> -			r = -EINVAL;
> +		if (r)
>  			goto out;
> -		}
> -
>  	} else {
> +		drm_dbg(&adev->ddev, "use ip discovery information from memory");
>  		r = amdgpu_discovery_read_binary_from_mem(
>  			adev, adev->mman.discovery_bin);
>  		if (r)
> @@ -1339,7 +1334,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  
>  	r = amdgpu_discovery_init(adev);
>  	if (r) {
> -		DRM_ERROR("amdgpu_discovery_init failed\n");
> +		drm_warn(&adev->ddev, "%s failed: %d\n", __func__, r);

This indeed is an error. Rest of the changes are fine.

Thanks,
Lijo

>  		return r;
>  	}
>  

