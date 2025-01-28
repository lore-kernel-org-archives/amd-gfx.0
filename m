Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67504C0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1202B10E619;
	Tue, 28 Jan 2025 09:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0EL4ynWd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB6510E619
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu6hsmPMEEH2Vq7joNSZHAgTTxLJmb6Afz3U82P7VVHuwXE2ax9pygGavgS3IoVdDlluiWMn5FblzacpGQaHgTRXQ+4ox3po7FFoAhGLuHck4jfiyNtT3PyhldwVHe6aSNpeKew5ZA0jwwFX2DSuYPKU548YGRAMRoqUHPpp2fNgljVwyP5vpWtqoT66WQwh/VTJzGImgUU46FNNiTFmbTR4CjPU7876s0w9mMFe2KIPbMR8JkxPmWQzpZTbpRtHbnsoK2k2B2b5ithXU5NjMWJo7l0Z6pp5HiAVLu0V8aMl59tlFFsYc+mzLFr4CYxchYVaXBe30e8bgAnL7TwLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn5kOcgXRa4prLvSPipMhMP3umCzHYLozXWz70DudFk=;
 b=ei825Grly6LXO/bENsQB0mnN+vdpCcsDUYX/8l4BPy3YHYiTQIFDMSnGLC81f/rRV6jXXBuyAzePEoEuePvaEpfhfT9nfsLBhO/4AnhVXm8WaaC2BAGpZ3Y4KavYCzi42iLUgMOVevNo7nvS/0QFE9sebuGz22K+xTu//XRIAsr3ACUbm3cmaeW6hL7VRGwI7zQ4AeWx0oH/i1jCXWG4RjMTnSkphxU1wMS2yNeR1yC45+/Bzb0FAsrKUZ9UufeURChzE1zfKaoYyHBKauElqzgRf5GPhB6C9mqk3ac6I2yybNsoj3Y/oqH01ALiV7DHN3kbWgCNv77cEzPVrwr4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn5kOcgXRa4prLvSPipMhMP3umCzHYLozXWz70DudFk=;
 b=0EL4ynWdzSGM2TSVITLEK17KXwSk9us2z0PW22/kZ+i3URkXxO1vmXSzRrNjRKfeLHVT/2xdYz0gTk/VAd2WV8IDgHksbXE6fuM2NwmefU+Y1po9KSdKpq2s5aw2L5HEzP9VaT2UjE2hPomxIWHDNLs4ORr9G4/tOrJBo32whXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 09:47:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 09:47:03 +0000
Message-ID: <a4060452-f20f-4ca8-b0a2-cf64f06da597@amd.com>
Date: Tue, 28 Jan 2025 15:16:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdgpu: Enable devcoredump for JPEG4_0_3
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
 <20250128090950.461291-4-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250128090950.461291-4-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e248a6-fb20-46df-46f6-08dd3f80b81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDJCdVFTY2xiTnZ2UHNobkRsVk5CcENuV2tOMHpkSnI4c1Axd24zZW9LM1ox?=
 =?utf-8?B?c1dUQzN2QmZscW1NTythbmVwbmEwS3QyZmMwOUpraVRsUFRpVnBibDIrNEl5?=
 =?utf-8?B?OUQrdGZ0b1BvNWFFSFZYcGRidm5WalFaQ0lpTlplVzRHNjI4NUpuNVZiZWhj?=
 =?utf-8?B?eFNycnpLU0NuZnc3K3cvSnoveGNHTWh5b2lIYjNDNVczMVBxMjZCemRTNEpE?=
 =?utf-8?B?dDJXR3Q4ZG03SXRxaU83WVNYd01YdWpKUkN6NTF0dC9CY3FHbDZaT3pFanpS?=
 =?utf-8?B?RnRUMmFBWGlqc2s2ME9LVVd6amtCOGRYYS9EWGtDWVVDUEtXYi9WZTh2K1BQ?=
 =?utf-8?B?SzdkWVR6cHZJSnp2eDY0azRCTnZteVBEUlh3bWRlRGZzUGY2Q1NuWFhUNWhG?=
 =?utf-8?B?WHNnU0pKVjMxWkQrU0pjRmNuYVgwSFBrdDZQdnlGQnNhOCtmdEp5OVdZeWh5?=
 =?utf-8?B?U3QwS01rdWc5RHE2VmR0K0o3S0ZRT2hTOUw0RFkveWR4RTJIQTVIS1gwVldW?=
 =?utf-8?B?cDZzQ2s5QWI5VDUrZVdNdlduZHluckJJLzVjeXFXaWNZQXIxN3FDVTk5Uk5r?=
 =?utf-8?B?L0FVV0JSdTg2Y2tXUk1GcnVVNnJTYnRiU3VFWmc1SzZtRHhPNzFHTHFqVFR0?=
 =?utf-8?B?RkdoQmJ4MzY5aDdkRkQxLzFPYWZlSU96SG9MOFMzbnYzbHcxWHV3VDhuYzVS?=
 =?utf-8?B?Qm5xT21vc0pkbzZwUjJFbVljRU5KSW1MYzQ2dUxGbXBaQ1REUFVQcWlFMGxn?=
 =?utf-8?B?KzR4OWk4YTJweVhzbmQ4ZGpTand6YmZZRGFnUS9sSnlGNTlmUXJsMHpxcTg5?=
 =?utf-8?B?ZEc1Tm1pUnZ6VTRtTTJhRURMcVVqN2EwaWs4S3JFYlR0TUMyUWtRblNXK2o0?=
 =?utf-8?B?UUQ1SzhJT3NESUNJYnhPS1hzTnhjMnZVOCtEcVQwbi9ISnhVVjU5TWRGN2ds?=
 =?utf-8?B?WTUvRDJ2WldpMjVEWXk0WDN1elVIT1dOb2phUkIwSlFXOXNQcVJlMWg5MVZj?=
 =?utf-8?B?d0R5QzhMQWlQcjNickQ5SHJEcEM0b0JOWjNVTE14ejlCcXVyMUtKVzBBNEdw?=
 =?utf-8?B?L2pJVkNwSkFkWk1ZekRuYlJ4TkpUYmpTcnlqbmdBbS9wRThZYWRSY0xPS21O?=
 =?utf-8?B?VTl1akJmRjlOV0hGY2RIcHExS3kzcHZyRWhDQTZQcHJCNGY0YnZJcnB3M0Yv?=
 =?utf-8?B?dWNxOTVvN0JMMjZBWFZLaURqK3gxd0NLa2ZScTJuNk5TYjVhV2RnR21kekpL?=
 =?utf-8?B?d084YWhNbFpoRnIrbEZ6Y2NVZmVEOExvbUoxWTBtU0FhMTdpZzhtRjJhOUdV?=
 =?utf-8?B?am0rRmRrbmFwVkxjZlF4QU11Z2FOcWdaU255elB3b2p2YTZaSWNES0l2Umsy?=
 =?utf-8?B?aWl2T1YwMExVTGRCQklpbUx3dC8zS2tqd2tzbHdHelVnaUNCY2JXb1JvTGtG?=
 =?utf-8?B?L0RXUHdwQTZ4ZktKVitGbDNpLzJZbERaeUZ6V2RKUTMwdG1hY0VPaTFWOC9i?=
 =?utf-8?B?ckhzSzg0Y0lkYU03L1BYVXlqb0REMFVXVDNiblZ5bDA4M1Z0VlhqejI3WnU3?=
 =?utf-8?B?citEcmlWZ1FKRzh0WDRmY3dCQlRhTEs0UmFpa1hpc2JRRGRNOFI0N3VxLzZo?=
 =?utf-8?B?VFZ1c052RWxpSkhIQW1nWnhLVzB0Sm5xdE1RR0QvUmNNblozOC9PWlBRWWRj?=
 =?utf-8?B?dy8xcU04SHYxK3krQmRpWDNLVmNJN0FtL0hpVjlJeU1pNmNienFOWDhxUkl1?=
 =?utf-8?B?Sy9KWi82emJFZzFnODlCbm5raG5lRlJFNXBmOEZ5US9IWDJ2dGZOelVUUlB1?=
 =?utf-8?B?bnNER3BtWCtoZTA0QzJUVUEyN0NsUWxoT21DMzQ5Si9aT2N1eEJJa1lJdmQ4?=
 =?utf-8?Q?oF3jGnqHb6S7G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdpcnNxbDVVU2JsbDBxcTgySHVDekl2QUY0bDlYYXBoTW9mdHhkanJJNTRz?=
 =?utf-8?B?S2t4VFY2L2hvdUVhMXpscEQrR1RjaFIySnB1QWh6QUVvS1RDZmFaN29oN1RZ?=
 =?utf-8?B?SEYvamFYdVBWUkpVTWIwVGo0T1oxMHVCK1JGWkRFR292RVJHRW1TRmtWQXIx?=
 =?utf-8?B?NlVBR3MwWG0vTnNsNE4wblNiUXdMNXBXazVQdzNmZHZUbUN4MERSSmRFME1k?=
 =?utf-8?B?Rnk2ZVJzb0FOY3R0YUxoeHh0MldJL1o2Skl4SHZzNW9VL0M5aUpBYVFVck1n?=
 =?utf-8?B?bE1NWjJJVmpHc0pKZXdpclVMaGo4blpOVUg4aEowVkVPSkdLZFd4N2lwY3Z2?=
 =?utf-8?B?MDhTMjVNeUZseTJ6Szg5bDg3TXRDVjdRa1VMSTV0dUVWRXcvKzBCRkxIWFVt?=
 =?utf-8?B?bEhrOGIra0lTdHI1dzBLYjc2VHhib0c0elQwOHF3RVhlczgwelNTTTY5QVJO?=
 =?utf-8?B?bWs5M0RyV0I0U3pKY3JFVkJ2cFdCNjJNQTNzQWVoZzNhZ0xBLzArMEloS05O?=
 =?utf-8?B?VEkxRm9BR2N2cjA5RzRSQk9XdDBmbFNVRzJYYzRqRXdMcUViLzFVZEZlRUFr?=
 =?utf-8?B?dnlvWTFWNDFQY05tekxZMjVlOXRrTGhXYVZ0RFJhcG9qODFWVTYyWVdpeHZK?=
 =?utf-8?B?YnVQcHJGU3ZGdWRlOGF2bXJGVDZhU0pBMnBTS0hmQ2c1eUxmaGw2d0kyc1BD?=
 =?utf-8?B?VElyNExxQ2luMnlzUVR1NUttRnhlM0JpVlpCdzRheUl2SVBEeCs1aC9aWXgv?=
 =?utf-8?B?NHYyaDhvZ05helVNYWJhODBqQjJ4dW5BUllWMEs1aFR4OVdlVjJKMkswY0pO?=
 =?utf-8?B?ejNHbi9pUW1kclNEZVVxMURFc3JxZnRsYTAzanNZZkd1SXo5WGFLdTJpZzhk?=
 =?utf-8?B?NlhFR0lTK3gvMS9zamZDU25Md21mYi9vUldzOStVSnZXUmorWXg4RGhOVmV6?=
 =?utf-8?B?MjRUclhIZXVBQ3crY1J0ZnVUeTdkLzZXdllQWnZnUnE0WWExQ1dJdzZDQ2Y2?=
 =?utf-8?B?bFdON0toSUZaVFdEZlJzVmprbjJmeHN4TzFoaEh3NEU1VENUR3RaRGRGWnpG?=
 =?utf-8?B?c1N0QnplTE03ZjJ5dm9nYjRCV2RrN3JPKzQ5Y1dGdjNUZncxYUlMcE9EOExQ?=
 =?utf-8?B?SXRpdkxLR3JkeTFFQ0huQUdTbzFWSFRsaWZzVk5JWjY1bmVsSGtKSndzU2Fv?=
 =?utf-8?B?ZEVQaWltWEVvMHlKTHljc252OHE3cms2eC9KaGZ0N1o0cVMxL21hSkZnWW1Q?=
 =?utf-8?B?TDBxcWxLU0pmYjJpK3daWXRubHBWRzBzenpkU1dOcXlGVXJCaU0zLzQ1bUpa?=
 =?utf-8?B?amlVVkpBTFhRY3FBZHIzV21JRmpMNkhUNTZiSEkwM2xtTXA4VkFHOHVhY3pz?=
 =?utf-8?B?cUIvdmduTkxyMzUzWmZhbzNYZVNLSjNtSEpHRE1DRnhDRTdLVlEvYnBYWHp0?=
 =?utf-8?B?SGJtWEh3VDZOdjZSR2ZRY2VxeUR4OTVZOWt4S1AyRmd1aURGMEZSVXlIOUNE?=
 =?utf-8?B?R3BEZDBTVjQ0ZUVadzY0c2FtS0hiOWt0Z2pkSmgrRFNNL3NxeWxNRHBtWUpP?=
 =?utf-8?B?S1BtTll2VURWc3N5TEZ0ZWgyUmx2UHhTYzFGSyt3ekhYenpQRFlyRWVMems1?=
 =?utf-8?B?QytjS2Z1NjZFZ2syelRiSHp1RTJ1eXBrdytMQSsxOTBKa0JOZWRXZ3h5a2J2?=
 =?utf-8?B?UWxYT0dzenR6QlR4eE1vY21zaWtYcEdEVGJXZUR1K3M1azJvOVBFZXFkZG1n?=
 =?utf-8?B?dm9mY3J0TWZrU20wbG80YWNDVUxTZXNNVkVPcDlnRjdObGkxUEF5dXM1c2NM?=
 =?utf-8?B?MWs2LytJVVJDRkJNbUM2Qi9lWFQ4bnNmTUlZMStzOHFIYUc0c1hKbnMyakgz?=
 =?utf-8?B?Zjk1OWNha0huMFpnYkJrdHJjbFdTTGgzQVlMdkkwZkdXU1Q4djRwbm1FMTh5?=
 =?utf-8?B?SnlwbHA3RTdGMi8xUVVJUHBzUHh3Q3NLMnVsZTM0MnZvazFzL05VTXdVeHlJ?=
 =?utf-8?B?eTFyemljVitKOWViWkFEMm9UR2tHYzFoYjZHWXJCSFdqT2xDWVJrRkM2dnBS?=
 =?utf-8?B?WkRZaElQMkk2TzRLRC9LajRtSk8zcis3YWtOVktISldVeW5Ea0I4UHVZMWVX?=
 =?utf-8?Q?QAOWDxqAdslTDpIgAP2f/2IlV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e248a6-fb20-46df-46f6-08dd3f80b81b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:47:03.6861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kvxFlJH3HWMmrtuexQtI1mRSRD/JQMuXrsg7AJEIpj0guC9W1XmMrL/BULuLvTt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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



On 1/28/2025 2:39 PM, Sathishkumar S wrote:
> Add register list and enable devcoredump for JPEG4_0_3
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 58 ++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index bc21f12daea8..39fd678dd874 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -47,6 +47,8 @@ static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  				enum amd_powergating_state state);
>  static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
>  static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring);
> +static void jpeg_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block);
> +static void jpeg_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
>  
>  static int amdgpu_ih_srcid_jpeg[] = {
>  	VCN_4_0__SRCID__JPEG_DECODE,
> @@ -59,6 +61,42 @@ static int amdgpu_ih_srcid_jpeg[] = {
>  	VCN_4_0__SRCID__JPEG7_DECODE
>  };
>  
> +static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0_3[] = {
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_POWER_STATUS),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_INT_STAT),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_SYS_INT_STATUS),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_STATUS),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_ADDR_MODE),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_PITCH),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_UV_PITCH),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_STATUS),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_STATUS),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_STATUS),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_STATUS),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_STATUS),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_STATUS),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_STATUS),
> +};
> +
>  static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
>  {
>  	return (adev->jpeg.caps & AMDGPU_JPEG_CAPS(RRMT_ENABLED)) == 0;
> @@ -164,6 +202,11 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> +	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * ARRAY_SIZE(jpeg_reg_list_4_0_3),
> +				     sizeof(uint32_t), GFP_KERNEL);

Probably, this can be simplified and kept under common logic

amdgpu_jpeg_reg_dump {

struct amdgpu_hwip_reg_entry *reg_list;
int num_regs;

};

amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_4_0_3,
ARRAY_SIZE(jpeg_reg_list_4_0_3));

amdgpu_jpeg_reg_dump_fini(adev);


In that case, amdgpu_jpeg_dump_ip_state/amdgpu_jpeg_print_ip_state will
be good enough instead of keeping jpeg_<ver>_dump/print_ip_state

Thanks,
Lijo


> +	if (!adev->jpeg.ip_dump)
> +		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
> +
>  	/* TODO: Add queue reset mask when FW fully supports it */
>  	adev->jpeg.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
> @@ -193,6 +236,8 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>  	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>  	r = amdgpu_jpeg_sw_fini(adev);
>  
> +	kfree(adev->jpeg.ip_dump);
> +
>  	return r;
>  }
>  
> @@ -1053,6 +1098,17 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +static void jpeg_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
> +{
> +	amdgpu_jpeg_dump_ip_state(ip_block, jpeg_reg_list_4_0_3, ARRAY_SIZE(jpeg_reg_list_4_0_3));
> +}
> +
> +static void jpeg_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
> +{
> +	amdgpu_jpeg_print_ip_state(ip_block, p, jpeg_reg_list_4_0_3,
> +				   ARRAY_SIZE(jpeg_reg_list_4_0_3));
> +}
> +
>  static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>  	.name = "jpeg_v4_0_3",
>  	.early_init = jpeg_v4_0_3_early_init,
> @@ -1066,6 +1122,8 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>  	.wait_for_idle = jpeg_v4_0_3_wait_for_idle,
>  	.set_clockgating_state = jpeg_v4_0_3_set_clockgating_state,
>  	.set_powergating_state = jpeg_v4_0_3_set_powergating_state,
> +	.dump_ip_state = jpeg_v4_0_3_dump_ip_state,
> +	.print_ip_state = jpeg_v4_0_3_print_ip_state,
>  };
>  
>  static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {

