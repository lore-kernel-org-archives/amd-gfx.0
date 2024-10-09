Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143CACF043F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 04:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF31310E288;
	Wed,  9 Oct 2024 04:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U2SuYxAO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDE810E288
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 04:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XghTQglcHwkIiwDfp+F+qf6d9j0/+4SHNxFZoAy88smvdE5Yx/AYUTm6JoqaDMb4852xyUppfbnXWcjtiKggDv4ftYbbGSWmu6RQjCIqEt7x0zq1WMdQiuHD19gf1HT211u8cdqQhUe1bVv+clwSEVyJ4Zqa0sDqHLrjxmsECCcMIDQkTZwclOAah+kcqR1yXHuaLsh4Fojy7lG3k3yXxqwgvwyyL23kwwraaFXwiR7zCkBoKKejLo0XjBpVrqh2H4DDd6PVP7Toi2jgyk3pa06/tLUGzjYQ15WOb7QH46KxwIZG7VbfawrGh/Rh2laTjSbUVFek70y4FfEqA5WGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msWDEZqYaB8TDyuMMk+LMuPVdnHF4ZqzIShvHU+CQsk=;
 b=STiijoNdsbYxTWl2HzgPkNUlCbDRmJRdKXavWnNCjxRRg6BbUUwPhnvwMuBhleqEGvFEDcUrxWOu9O6hKtXttg0bbCcpJXDp1WetHoasvj44Mbe8wdZHMuQwndLg1Sr9qOhHwsmp1TmbMb0ICQlaKa79nss1DmTa0FMUepA2KsJleOHYgSc9XoCG4qsyY+PMhKDtw32BbX83ZKxKIXla/4H76S0W/29IFHfNbctNMBAHRxVUWLGmnhu7Cz/MUw2ttrMhWYo5xMEV5VZy0/DHjOTsSEwpl10Xcywhfu2+eUFp9Vqk7I4pj505GmUcF6HRQwl9l48gWSlNc4NqmN/bEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msWDEZqYaB8TDyuMMk+LMuPVdnHF4ZqzIShvHU+CQsk=;
 b=U2SuYxAOz9y/U5M6DLvGBATe1GMh3ReMBVLGqDIxIGFiAdVloH4YBAR9tycFNrXiQFtKBsXmV9/M+nYm02I8beb8YiCle+vJMGc14JrqywKQVp2VGZYWZeQhRZEVShmw0b46JRKUM16MYT8fiwvzGL09Eek4K6coqdft4zk6ljo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 9 Oct 2024 04:40:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 04:40:03 +0000
Message-ID: <ab612970-3e26-4ffe-a23f-06be48a21aa9@amd.com>
Date: Wed, 9 Oct 2024 10:09:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: Fill pcie recov cntr to metrics 1.6
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: le.ma@amd.com, hawking.zhang@amd.com, shiwu.zhang@amd.com,
 charis.poag@amd.com, donald.cheung@amd.com, sepehr.khatir@amd.com,
 daniel.oliveira@amd.com
References: <20241004150102.327639-1-asad.kamal@amd.com>
 <20241004150102.327639-2-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241004150102.327639-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8faf75-6df5-4690-bcff-08dce81c70ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjlJSzZDYkV2MlJJWld6ZmV5ek1ldlRINGsrWlR5RTFQOTcxNjAreFNvYzBw?=
 =?utf-8?B?MEUwdG1XQm1XcEgwTXNzTENCbnJiVjV6YitzZjlUMzI5ZVF2WGtwNEszSk5q?=
 =?utf-8?B?alBCVXRjcDNyMUdIODBjb0xRSG9uNkwvdThYYkw5RjczdFp2RkdOM1dWQ1V4?=
 =?utf-8?B?ZklsSmJFSzV5SjJoR2YzcnkvengvUzVMdG5peWs2QVBXaTEyVTRkNktsd01u?=
 =?utf-8?B?d0ZuWWFaR3pDdHZnQkZ4U0xXK0FlMTVMYnFNdTdRNDlTbkxEaTRjaHRmUE5Q?=
 =?utf-8?B?L01wdDFIc1RKRWhNYzhQaHpuRnRpa2lvTW14YnVjSmtPcndscUZXTmp1ZzFr?=
 =?utf-8?B?OW9mMXc4eVdKV0p3R3BaaEJxcU5BcUdGdjRiMm9vb2hZaHppTE8wZ2RsRzRE?=
 =?utf-8?B?c0k1djdDREdhU1NzSEpjcTAxVkxUZDBDZWc1RFArdFJ6eGNCVTV0eEVJZUtM?=
 =?utf-8?B?T2dRTUNpY1ZXYnlqL2Q5UE92Z2ljdjJyd0dtN24wTU5kbVRWMVluNjk0RzVp?=
 =?utf-8?B?YnRqNkR5WjNjVFFyZEJycHBjU3ZtQW5CUytlVGF0Ui9QaW5sa3lqczJ1U29t?=
 =?utf-8?B?Zlc1cDZWSzZ5KzQ5bUx5bzdQUEVmVUszQnRIcnprTG1lZURuVEEvMjBpcjBh?=
 =?utf-8?B?NjBPeUhWRGsxN3hJTmRtQnM3T0NzY1UwbkJrelZOV1dvYjdKNWFrM1RKVlo1?=
 =?utf-8?B?Yzd5Vk8zVGt4M1gxK1hkSit6TjZyRDVkcWlZWFFINUpnREx3N1R4UHBMWGky?=
 =?utf-8?B?aGJ0MXNkNUhMeHRIQzdDdmh4MmMxOFcrWlQ1dHZKTzFHQnpJWmhxd2FGb2tL?=
 =?utf-8?B?YzlIcml5ZVVoT3VocU5ZVHZYaEZKc2dmSlY0T2RTdnY3eDdhRnA5R1lGSFlu?=
 =?utf-8?B?RENQQTJlR2NYMVRvSXY0QTBiVnRoYVltQzFwQ1AzZVpYak4yRGFFSnpjdTE4?=
 =?utf-8?B?R1B5VC9RT2NPRmVOS0M3SVMrL0tLdXhXQTMyeWtyTWtVQnZNTHpaeVR3clJT?=
 =?utf-8?B?YVNNU3JudWVOZnk1R05nNzBvck1aWXZXRmZmQk9WN1loaFJHNTZpcHBBQm1m?=
 =?utf-8?B?ZWwwT0Y0azh5dlI5T2RtdklyR3B0eDFNOFNHWCtJdloyKzY5U1lVL0JnTEwz?=
 =?utf-8?B?a0hTclNaUG9GN0QyWGphbmYyWnhEMUhzaDJPeStuak1FRGxmZWxOSHlBR3o1?=
 =?utf-8?B?LzB2bnUxbHk0OG1JeU1BOU5ueEU2R0ZlWWxWMGRDVjVFUW1jYVBQeXNGY28r?=
 =?utf-8?B?UVF6SVlVOFdLdW56NE9mU2JiSmtiMXJvcjZTOS9oQnZxVnM0T3FSSG04S3Jk?=
 =?utf-8?B?Sm0yQXIzNDcwUFNyQjFrWTNrLzZmOVY2TWRWY1M0MmljdW9lVDZqREF3RHB1?=
 =?utf-8?B?ZHlkejl4bDVKVWtWYzNTZStraFp6c0Z3V2VFOHNpdTBWNU4vYmJYNGhDOWdT?=
 =?utf-8?B?Y0QvQ0NSTHlObnJpVHh2bTJrQ0o0QTl0eVhmTGhpVGorcU9zaVlEM25WUTBn?=
 =?utf-8?B?eW1wNzFvdjhGdjRhbHF6K29OR2FRVUFOdzhEZjRBaFZoNWFHWTZITnlBV2g1?=
 =?utf-8?B?L0NIZ1hkRDI3N080Y2RYZmx5VTZISFovY1FnbndSUGpEUDRidVFPWHhVOEZW?=
 =?utf-8?B?V25QaXI1L3k3SU1Yb1VUMGlyZTFHb0U3WTZVVzBDTjFhQW80UlpleGpOcHdi?=
 =?utf-8?B?MUJ3Q1hZWkNkeS9QeGk3YkVIYkVnZUlRbmptVHhkdmVaekp1bXZCV3F3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTBnWGtuRS9mZlB6MHR1enBZcU1RSWlKVm1IOW9hMFpnaElBMnZaS3RrT1Nk?=
 =?utf-8?B?QTZLM2F4cGMvZ29NcnJpN3hUZTB6d01kWnNKYmpDWmhtdGZkcGFHRXV5eVRR?=
 =?utf-8?B?cHhiSDhNaHIrclBEQVhWbS92cDBJckUzVEVlQ0owZ2JaUDJDOHBFdVdVTnZo?=
 =?utf-8?B?ZDh0RkFRUTNpU29MSTMrTVcraG04SXVwaTZSYlduV0JyZ2t0c2pPR0Y4NVU1?=
 =?utf-8?B?L1NkalpacGlaTHo3Ukhqa3JTWkRUeElXSDJwRkZPT0NOeHkvTTNXbTVFMFd6?=
 =?utf-8?B?b1l6NTFBQnFyL05pYmVaWmM5RnpncDZBVWhGR21pY0trUjdyTTg0cUJvVWo4?=
 =?utf-8?B?dGlCNVpLLzJTNjhDM2t2K2w5dU9TTExxUkJBQVoyQ1Y5R24rUVplTmlFN2h0?=
 =?utf-8?B?R05OenMvUzFSa242L2ZXNnV4UTdHdE9kVk5ET1l1TENuTTc3aG80SjZSSC83?=
 =?utf-8?B?Yit3VUJxaGQvZUd5aVIyZzAwTEpaV1F1UWZpaGdPNURYdFBlajB6ZXU2TkNL?=
 =?utf-8?B?T0taYkdpRTVKcG4xTGhTOEdFMHdCMXZrNXpOa2Z5TmYrWi9oTWZNV3MwdG04?=
 =?utf-8?B?am0rSDN6bEdQTC9mMEg4QjNsMmVoSnZtVnc5bi9MMGNUTUViRnB6VVJ0QjJp?=
 =?utf-8?B?dG02S1I2R0J6VkwwaU5TbWtNLzhQVmw1QjJkTnFncmRuVW9rTWU1WTF2OUFs?=
 =?utf-8?B?cG8wMmNwV0crN3FwbDdVRjJSVGpOMWV3d0VmT3BJbjB2dmVIblM4L2FIc0li?=
 =?utf-8?B?dGw1NHM2eXZSMnN0bWlWbDQybEtuZE1weGNnTSttczluWjRtTDdSSmU0NnM2?=
 =?utf-8?B?dE55SUZqR0RKL2FYZnhqOWZDZXJCSjh0a2ZkQkg1eTEvSjJybU9jUmFxVjlU?=
 =?utf-8?B?SUtpWmdQYXJsVG90b2s0NUZ5QXErQTh3N2l5SXMrYWZvTlZyV3A4YWRnS29K?=
 =?utf-8?B?SDVjV1QrS29YMnc2WTRtUHJya3JkZDhHRDN4T3pWbFE1cmNnN2RYREg4VWtQ?=
 =?utf-8?B?MnQ5WU5sNTRibHcwdzVmY1hnZTJ2Um5laWlmemxxY1crQTMzUXBqOE5VWUl6?=
 =?utf-8?B?TUJ5bXNiR2pibVp3TS83VXdFdzZyR3ZLdWRIK1FPd09TOFIxTWZCTEZ1NmZq?=
 =?utf-8?B?bnRTUlhCT0FKNEJ2NkNmZ05DZ1ZIQXVGd2dFTE5mYlRpekJhYTh1OTVoRitM?=
 =?utf-8?B?TkxqMjFIZEloL2lFTGxqSGRSemNWbTRhUXNHendCWno5SlRjaHlOU2ZFd3ZJ?=
 =?utf-8?B?M256NFN6U0NYL1AveXlva01iOU1MUjRwS2RiM2hNcHVaZDJmN1NROFk2Y3E0?=
 =?utf-8?B?akgwTnZ2K1V3QjdzMUpybHcwekFCVzRuQUlzdUxCM3lzVUo4OERIQzFQaVdx?=
 =?utf-8?B?bFEzNGlncUdvNkRFcXBUaXdVUVYweU50bWNVRUovTHRGb2FkT2FYUGM0M0Rq?=
 =?utf-8?B?NE42NTVXdjJwOFNJYnpKZW9NcHBaU3NNb2xqTlVzM3VYSjdqbmx1K0FobThZ?=
 =?utf-8?B?dFBVeGRqZmxmM1Zpb1BOYVpJeUNDN2VDc2lLaGtJamdMNnNFaVpuWGhVWU1p?=
 =?utf-8?B?VVRNR2x4ZzZtSVp2NVlZN3lmeTF3byt0RnFWZlFuZXlYZW53VUtHbEE0M0V1?=
 =?utf-8?B?R2VKOWlzTHQycUgwMFhncUgzbVY1VHdmZmgwQVZIY0RDNWRhWWZYR2VSTmpw?=
 =?utf-8?B?VjgwWWdZU1VGd1RuSzBXU0l2TCs0WlJhZXliaXJubkl6T2xtUzNmZmZvVWd2?=
 =?utf-8?B?T2JGRVB1dkwyaWVFUElrUHI4d0tWNFhCK21iNjVZTlgyc0VLend5amhiRnBa?=
 =?utf-8?B?cDlQelNlNkRxb2ozWFVNRWMwbGVoRmFYSGVXQVFNU0NydGovV3VkNDcvcGRI?=
 =?utf-8?B?VmRFMlNNeVNaeEdNL0JybWlubW1YTDdwNVdxYnU5S3RhRWlsRC8zRmR4em9V?=
 =?utf-8?B?Mk53bTJ6eEJ5Q1p5cS82YU84U0JzdEJDbFpsMkwrR3ZmemhNbHRlRTZGS2tZ?=
 =?utf-8?B?azA1bUF4THNHWVpPWHhhVk5HUjVubjcyNFBjdkNVQUpUazhnM0lXTUxXaThP?=
 =?utf-8?B?VVl2RDRkNXJySSt1NkVMYmFFcmY0ZTZleUZ2dFNBblhvaXcwYkxwTXY3d2dW?=
 =?utf-8?Q?7iXYv7u4d2Tq8KiVTkOAyo8lc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8faf75-6df5-4690-bcff-08dce81c70ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 04:40:03.4551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5euWWJWZp/Ocxi65Lk1VFtqUyVExjcC+oA1DXhDRC3sbaYSCjLAeHEZ1yg4l0ewW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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



On 10/4/2024 8:31 PM, Asad Kamal wrote:
> Fill pcie other end recovery counter to metrics 1.6
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 52f3c537bb3f..a85574a46769 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2306,7 +2306,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>  
>  static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
>  {
> -	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst;
> +	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst,
> +	     smu_13_0_6_rec_cnt, smu_13_0_14_rec_cnt;
>  	struct smu_table_context *smu_table = &smu->smu_table;
>  	struct gpu_metrics_v1_6 *gpu_metrics =
>  		(struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
> @@ -2417,6 +2418,16 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  				metrics_x->PCIeNAKSentCountAcc;
>  		gpu_metrics->pcie_nak_rcvd_count_acc =
>  				metrics_x->PCIeNAKReceivedCountAcc;
> +		smu_13_0_6_rec_cnt = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
> +				== IP_VERSION(13, 0, 6)) &&
> +			(smu->smc_fw_version >= 0x557600);
> +		smu_13_0_14_rec_cnt = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
> +				== IP_VERSION(13, 0, 14)) &&
> +			(smu->smc_fw_version >= 0x05550E00);

Better move this to an inline function which checks IP version.

bool smu_v13_0_6_is_other_end_count_available(smu)
{
switch (ip_version)
	case a:
		return fw_version > xyz;
		
}

That may be easier to read and manage for any future updates/IP version
derivatives.

Thanks,
Lijo

> +		if (smu_13_0_6_rec_cnt || smu_13_0_14_rec_cnt)
> +			gpu_metrics->pcie_lc_perf_other_end_recovery =
> +				metrics_x->PCIeOtherEndRecoveryAcc;
> +
>  	}
>  
>  	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
