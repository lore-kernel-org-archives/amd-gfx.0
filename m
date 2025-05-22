Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D4CC54E90
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 17:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1228610E2D5;
	Thu, 22 May 2025 17:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uaKieRvA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A4110E2D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 17:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVucCg5I8FWbd7Q9jjhMG01wBmdS8dJ8hWl4PmYRpEzlUNkaPsxHG0bSNvdyJfasm9Kpqkg7hUt4RqZdVwlJuu48CngQWZzmYUnpuGyg1zTO7xng23NzrlNhMOOA2e/c3IDmfpQS7toSLTCAmZ20nFxBOQNwsydP9muWAMb1sSMGYPR35+wiexdJ4XHCjp9WC3VLKQt98QoYhUroIeuRXt/yBUk/1b1qn8xCs9qYNSRBLopGpLKgx+unrVJ+dpcvSfeie1jJNuToHzZi0edx7wXhIEx5OG4aHHUjB80ISuXjjZmLe4aHLArh1AgosL795Y0TyGaB1HzWt2bPGrwYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA2vtYHARaQqLrcEdmTc/mFHj2VawKI/7d/mYAcu8iE=;
 b=JomCKk5C9lClAkcjsMWnMeiAdFM7vceb4MiZz35M0is5c+UxDfeyyDybfCuv3uBuqeM/+VW6x4uov8k7foIdUTCkO774BdowNd2JtOCTCJnmMSBXvnwp4nBIDw1UG+Wm4e8KkmVgYVffe06u65fFoCxeDs0ErUPNn0H2FwvzakBOX2KT+EQ5mZ5QxxfebjUw671GjFO1D4SI9zZSiUgWyHr86NhF1Jb6Ro8s1iQG87XiOx3ToSAKfWIh3pmmyD6Au96y/1nDqYipi3zddoSy4hYaHsxdcI0K88XK1ytMI1St3J4V/gJiHX95+/3PzBWPuonzFElYsn4zwNGQutZVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA2vtYHARaQqLrcEdmTc/mFHj2VawKI/7d/mYAcu8iE=;
 b=uaKieRvAuEuNIfDe0mkhOLcu9xvjRJ34Bbt04mZRydz7V/vmBzp51OVkMbR+bv7n1eOw2gk5ymgGEt3qhSi2zzVF2aawXVvQpgQM7l+M29bSZzAkpd6bDgkAW9lElcFeaUgkNLRRCt5OkhtjisG6BZ0gGE9g+VDvbKpGb+m6uuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) by
 CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Thu, 22 May 2025 17:12:56 +0000
Received: from DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620]) by DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620%5]) with mapi id 15.20.8722.031; Thu, 22 May 2025
 17:12:56 +0000
Message-ID: <b204e3a7-ec18-4250-a72e-01e4d55690ee@amd.com>
Date: Thu, 22 May 2025 13:12:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250521205906.639718-1-pratap.nirujogi@amd.com>
 <381923a0-7ce6-461c-9dea-fe6710bb52b3@amd.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <381923a0-7ce6-461c-9dea-fe6710bb52b3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::24) To DS0PR12MB6440.namprd12.prod.outlook.com
 (2603:10b6:8:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6440:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 3556ef8a-aa8b-496f-d3cb-08dd9953e4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXNXUFZsVVdYVzdiekJScGl4YXZyZm1Ua1IxRXJneG10by9ZNXVpSmNoZWk2?=
 =?utf-8?B?WjRmQ3JxckQ1ZUVNVm9LaGEvdko0NlI1YnZpUnY3MTJBT29wUER4VUNWMzdW?=
 =?utf-8?B?bWVSU1VHRm5yUTJ2N1Bqdndxbjl6Q3J0eVhGa3p5bTZOM1F3NU42Z01kb3Nv?=
 =?utf-8?B?Nlg3TUZzV1J4QzA0N1MxS2ZHc2dOOTF5VkYwY1k4ZmxPN3NzUVlyQytCdFEw?=
 =?utf-8?B?RGxBOTdLalpVL05sc2ZHOCtYTTBqQUlhekVFTmR5S0QyWkNLTlcxTlRHQ3hV?=
 =?utf-8?B?aHBqcUMwVjZtYVJxYTZDcUZCWFU2RmlvR1dMQnRFNHdUYnpLdUk2MUtWbFNw?=
 =?utf-8?B?bjNBM2xtZXpZT2xMeXZaVHVlZnRBbW5JYUpxNnVUTzN3MHVmRTFsV1BKMFRx?=
 =?utf-8?B?MmVBSTdWbnFTVkNQVjhaYlVpa0N5Z3R4dGlqdUVxa2pVaGhFVXRKVkVYRnlV?=
 =?utf-8?B?cnRETzlBdGJKTjNrUVRNcWtzMThyNGkrQTFrVHdpaSszQzRhT3M3VVF2UHVy?=
 =?utf-8?B?WFdHN2JCWnVSOW0zR09uUDNEOEpjWWkxNGFJeUI1S21tRUJiT0hTdmFnV05W?=
 =?utf-8?B?ZkdFUDNiQk1UM05Ea045Y1RrbDE2V1VyU05CNkV2ZGtGNHV5b0ZKakNzUGE5?=
 =?utf-8?B?TGF1VWhxMnlSM3d6dHZ3dG9BbEt3RCtNM3lSSFgxOElCUjN1V05ZcHR3WnVB?=
 =?utf-8?B?WkcrdklkbUduZzNmUkp5ZWQ5WERBakNVbWZwTlk2OHhyb3hraWVSMmpHbkR4?=
 =?utf-8?B?MHh4SFlmTE1SdUhpUlVSTkdGcmt6ZzRvWCt2dGtVMG9kMjMzMlVnRmxuVFBr?=
 =?utf-8?B?ZVVzRG83Q1Jhc3JJM0tqM1htVUVFWE9hYzg0OUJQK2syeVRodmRFODlEOVNv?=
 =?utf-8?B?ck1BK2F6N1Z3aDFvNU04eTY3ZUhvbVhLNnIvSEZFM1ZzWEVkcEFJK3NMcGlY?=
 =?utf-8?B?eDdwalA2eVNsWGxqR0NGaFI5bVpyR0NhWnJIM1BUVHVyRjdMaWZtcHgwb29i?=
 =?utf-8?B?bmc0Z2p3ZjhLckwxeWI1RU4vdzcybTFtOU5kZlJiNWs3MU5FRHA1a1h4Z2ZY?=
 =?utf-8?B?N1FzT24xUCs2UWlpQlZadk93ODRXREJydG1TQ1BaQTd1SE1OQzlNSDBQTkVI?=
 =?utf-8?B?OXFuYTZ6eWxIVFhkTVJ5ZGpzUXEyN0xXYis2cUp6YS91elFpeVBwNDhpMWsz?=
 =?utf-8?B?bjUvbmtpU0Jmb0dDZTZaRmdnejk2b3B6NkllYU5uNjlGUGR5d2xxWE45bUU3?=
 =?utf-8?B?UlBRY1BtSDBtRjAraFRZcUhyY3FyZjRCUTF5VHFXd056MHFFRGxKS3h0cjFs?=
 =?utf-8?B?UDY2ekhwbVFSN3MrZ3BPU1QzdFp3cTFreE5GWlNhbWJGZ1ZaazEvSjRnbnQ1?=
 =?utf-8?B?UWJ6dGN5QUFGWS9SWkw5T0xNakZHZ1VxdWhVS0V4S0FZdEJ5SkRmZHN0SXBD?=
 =?utf-8?B?Y3FQVEF3Y0wzMG9ZOEJtQzNkSTNud0RZOHMwVStxTFhaUzV0NFVzRVpQMFo3?=
 =?utf-8?B?eWg5TnVIZXc4T2dzRDFOcHdzNG1XWmVoSG1aREZBM3dwZGFURnlkTWF5Z0Rw?=
 =?utf-8?B?M2R4N0ZZYXVCRVM0cmVSQzltZHR1bXNIWERKd1puaEsxbStnSTlHRklURWZw?=
 =?utf-8?B?WXJzdTR2dkRBZHVtNXZXSGQ4c3BXM25weEI1RlpULzQ1UUx6MWdVWFJEQVNX?=
 =?utf-8?B?RUgzR21Pb1ZndkJtd28vaVI0UitqSG5MeHZEUXhBNFBLYXZPYkVFeVcva2Uy?=
 =?utf-8?B?UnA3aUR5WTdJeTdNY0Z5WWVpK2hPeDdUaFNQMEJrUC9oM1JWSENBUWxkQWFV?=
 =?utf-8?B?SFdpcUlrK1l1TW4xa1RodmtQVlpxcENGcnBSRnVBeDRJNEl2TkRlZDNoUzQ3?=
 =?utf-8?B?YjNzelVxZVM0b1lIVkNYa2paWDliMi82ejZTazRmWHV0czNicnBZZkRKb0p4?=
 =?utf-8?Q?iVC4FmweGTg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFQ1TFYwWVpuYk41VjJYQ3FETDQwaExRKzUyeHN6M1dLWUJSbGJhNEk4Z1Fk?=
 =?utf-8?B?aVg3emhZZnArTEhsbm43SndsZjZDU2pKN0gwZUlHNXAyb0Z4SWRvTHh3Qm84?=
 =?utf-8?B?QUpUczFiQ205UjRDanhuVXR5ODlJVUJNcjZOSkhhNHd2cEFVdmVnc1Z3K3NI?=
 =?utf-8?B?dElMNEtCL1NpQWZCS1AxTGZnMUx5RXUrQnRYYWo0am5BVjE2a2RvM2c3MVdv?=
 =?utf-8?B?SEFNdTZSbld0dWlKZDkydGZ4TmVPYkwzMVVyelZSdmJCK2IxbUVZb09SZmlY?=
 =?utf-8?B?dm9HSE9Nc2Q2UGxaaWY1aG9zTGh3dTM4M3FoU0ZXMGtmMmx0ZFhsZ09UZDE0?=
 =?utf-8?B?T2VCNUNOWlhwQ2gweURaSHFnTW5YTW5kalU0ZkxBbjBzelZiTEVaWkhzYnFW?=
 =?utf-8?B?ckNLTDk0YzFuQ0NnNjRZcEsrS0ZsVmt5K0VyOHdHRTI0eFJxcy9EMHpNa09Y?=
 =?utf-8?B?Q0p0aEdjeWNiY3p2cDNjaS9jNkN6VklSbXRwOXpYbEJWb0pCRTk1My9vRFYz?=
 =?utf-8?B?NUVFamUrQldjR1dtcnhtNGdCbEN4Z29scVlFVkl6a0VodkI4ZjQ3c2JiRjlk?=
 =?utf-8?B?RXhvMDBPWjZ0Mmw3WG5iSUpmQTA1VGFnWnFPSGVZME1KKzZCTWRKN3oyZUVI?=
 =?utf-8?B?Y0grOWtlTjcwVEtSS0hiSUw3OTRiOTNGWE8zZTVXYXo2eS9WakNwNXhVMWJN?=
 =?utf-8?B?YTNNVS9EcmtvUUtHdC9EdXhtL3NWUWtGeXdzMGowUS91NnBZY2REY0YxcVBG?=
 =?utf-8?B?WUc4MHZMdHIzUEtxSXRVMzV5YjJBRjJFTE8rYXBmakpHZ202bnRjNUFLejdu?=
 =?utf-8?B?TTlPTWdPaVNlSWI2Q3RhUUNGUHFYUEV3OC8yQ1QxeEI2TEpMZmNmS3NtWHFh?=
 =?utf-8?B?YkpRYmpKT3kwaVhWaWlDRDlLMGxVeWNYVkd6TVhDV0tNM1ViV1ZoUUovZzFs?=
 =?utf-8?B?cFhVUDVteFg0azdBeHVya0FyZmpLcU91QnJPSC9xQnZqK2NGeGdOZmg1QXE3?=
 =?utf-8?B?a0ZONnpNZ1FpME9jYXIwUTNpUURqV1dneGcrNS95N2g3N3RtM1l4M3hrNUd1?=
 =?utf-8?B?ZTZuei90aUV3TElxMlZuT1kxK3I5b3FjOVdMdnNka0JhVnFvblpDOVVRVXBM?=
 =?utf-8?B?WnhhNW12K0pOMVdkU1NVdFJFY1BFTXhvUUpadVpHdlNIdDA0ejMxN0dyM3Jj?=
 =?utf-8?B?OEsxZFlaMWRsTXdPTzR1ZmE4SHc2MnRPTHBzck13V0lBVGlDRDRRejJTYTdy?=
 =?utf-8?B?WllWMDlOa2pHOWt4R1FlTzJ1dEJRc0JlSDZRVjBLYlRqZnpPaEZ4cFJxL1du?=
 =?utf-8?B?clUwMGo3Q29UVEVxa0IxOFVwMFlKdWM1NDdkUkgzcG9wNlZSbFBTZytwYVhl?=
 =?utf-8?B?RXFPNG5kazVRTFBTaHBEWVNDRU1UeWF3UHQ2djlTS2x0dkVvam9GVHVOdE1z?=
 =?utf-8?B?RS9oWmYzdUxTMHZjbnZWUGRjYjdPR2l1OTkzazRvb0dGU0xkeGU2RnZ2TDYw?=
 =?utf-8?B?a3hTQnFkdDBQUzhZNUlWRm9OSWZZeUd6TXExRm5zclpKOXdaUGwvaTFMMjdh?=
 =?utf-8?B?dkNlUTRrelhsZXlaS3BKbStyZUhIdkE4ZytFUlpneG02RmZJQWZ1NDM0TWxs?=
 =?utf-8?B?ZGhGRi85dnRCVkF2aUxsUXR3S0k1LzI4ZnU3SkhGNlhQYXh4VHdKc3N2QzVF?=
 =?utf-8?B?eFFIL2t3ZXljaDljT0p4MkROK0VxcFd6RkFKUkFWR005Qmt5Y044WDE1VE1Y?=
 =?utf-8?B?b1N0Z09KbWhjdmo2QlVrNHJ2TE5LMENQY1E5WUhIZndITHAvb3ZheXBJYnhi?=
 =?utf-8?B?aG1CUkQwYmdLVFhTeGJxVnNCRmlWLzhIS3MyTnhZZkppTE1SOVlDaWg1Zjhy?=
 =?utf-8?B?dmVqRTN1NEdHMzZCZlMwdU5RSGRJRkErdlRGUzJxYXZoQmx4RjN0ZFVwcktG?=
 =?utf-8?B?aFlReEsyK1ZJZElFMzRYRkwreGsyT3hpSEZyRGZMQkJoYk16QjZlY2F5OVRH?=
 =?utf-8?B?bEFlcUdGMGMvdXdZTVhoWjBzamdZWXVmU05XeVFBeUR4U1JOdGR0ajBJcjAr?=
 =?utf-8?B?NHptTkhyMmV0MmgvODdEUVBFRkRYNnlpRTFWTFhFUC8vY3NyT092eXZEY2hW?=
 =?utf-8?Q?KrIQphm8qEer3likMC9d2W1ne?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3556ef8a-aa8b-496f-d3cb-08dd9953e4d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6440.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 17:12:56.0432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLibm/P6a0w5mXEH1uJmNivkmQhuz7FUWMcL7yhQVxL+9ywwEDgVwye/SUlOBJFO3Yd3Niukx0GTLc4QHOU5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749
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


On 5/21/2025 10:05 PM, Mario Limonciello wrote:
> On 5/21/2025 3:49 PM, Pratap Nirujogi wrote:
>> ISP is a child device to GFX, and its device specific information
>> is not available in ACPI. Adding the 2 GPIO resources required for
>> ISP_v4_1_1 in amdgpu_isp driver.
>>
>> - GPIO 0 to allow sensor driver to enable and disable sensor module.
>> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming 
>> mode.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Still LGTM, thanks.

Thanks Mario!
>> ---
>> Changes v4 -> v5:
>>
>> * Build errors reported on the platform that doesn't enable CONFIG_ACPI
>> or CONFIG_SUSPEND. Include amdgpu_acpi_get_isp4_dev_hid() only when both
>> CONFIG_DRM_AMD_ISP and ACPI are enabled to fix the build errors.
>>
>>
>>   drivers/gpu/drm/amd/amdgpu/Kconfig       |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 32 +++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 +++++++++++++++++++++++
>>   4 files changed, 67 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/ 
>> amdgpu/Kconfig
>> index 1a11cab741ac..6bd9aa5dbef7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> @@ -77,7 +77,7 @@ config DRM_AMDGPU_USERPTR
>>   config DRM_AMD_ISP
>>       bool "Enable AMD Image Signal Processor IP support"
>> -    depends on DRM_AMDGPU
>> +    depends on DRM_AMDGPU && ACPI
>>       select MFD_CORE
>>       select PM_GENERIC_DOMAINS if PM
>>       help
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu.h
>> index 836ea081088a..a5ccd0ada16a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1713,6 +1713,10 @@ static inline bool 
>> amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { retu
>>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device 
>> *adev) { return false; }
>>   #endif
>> +#if defined(CONFIG_DRM_AMD_ISP)
>> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
>> +#endif
>> +
>>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_acpi.c
>> index 707e131f89d2..f5466c592d94 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1532,5 +1532,35 @@ bool amdgpu_acpi_is_s0ix_active(struct 
>> amdgpu_device *adev)
>>       return true;
>>   #endif /* CONFIG_AMD_PMC */
>>   }
>> -
>>   #endif /* CONFIG_SUSPEND */
>> +
>> +#if IS_ENABLED(CONFIG_DRM_AMD_ISP)
>> +static const struct acpi_device_id isp_sensor_ids[] = {
>> +    { "OMNI5C10" },
>> +    { }
>> +};
>> +
>> +static int isp_match_acpi_device_ids(struct device *dev, const void 
>> *data)
>> +{
>> +    return acpi_match_device(data, dev) ? 1 : 0;
>> +}
>> +
>> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
>> +{
>> +    struct device *pdev __free(put_device) = NULL;
>> +    struct acpi_device *acpi_pdev;
>> +
>> +    pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
>> +                   isp_match_acpi_device_ids);
>> +    if (!pdev)
>> +        return -EINVAL;
>> +
>> +    acpi_pdev = ACPI_COMPANION(pdev);
>> +    if (!acpi_pdev)
>> +        return -ENODEV;
>> +
>> +    strscpy(*hid, acpi_device_hid(acpi_pdev));
>> +
>> +    return 0;
>> +}
>> +#endif /* CONFIG_DRM_AMD_ISP */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index 69dd92f6e86d..574880d67009 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -25,6 +25,7 @@
>>    *
>>    */
>> +#include <linux/gpio/machine.h>
>>   #include "amdgpu.h"
>>   #include "isp_v4_1_1.h"
>> @@ -39,15 +40,45 @@ static const unsigned int 
>> isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>>       ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>>   };
>> +static struct gpiod_lookup_table isp_gpio_table = {
>> +    .dev_id = "amd_isp_capture",
>> +    .table = {
>> +        GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
>> +    .dev_id = "i2c-ov05c10",
>> +    .table = {
>> +        GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
>> +        { }
>> +    },
>> +};
>> +
>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>   {
>>       struct amdgpu_device *adev = isp->adev;
>>       int idx, int_idx, num_res, r;
>> +    u8 isp_dev_hid[ACPI_ID_LEN];
>>       u64 isp_base;
>>       if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>>           return -EINVAL;
>> +    r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
>> +    if (r) {
>> +        drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
>> +        /* allow GPU init to progress */
>> +        return 0;
>> +    }
>> +
>> +    /* add GPIO resources required for OMNI5C10 sensor */
>> +    if (!strcmp("OMNI5C10", isp_dev_hid)) {
>> +        gpiod_add_lookup_table(&isp_gpio_table);
>> +        gpiod_add_lookup_table(&isp_sensor_gpio_table);
>> +    }
>> +
>>       isp_base = adev->rmmio_base;
>>       isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
> 

