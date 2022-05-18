Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDC1C43219
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 13:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0199210E113;
	Wed, 18 May 2022 13:46:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4184F10E113
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 13:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj2oHyhQ479fpcvea9lvgr70p2gl1D5M4GxKuTzncEYMVcgxbmSjLTFQFYBGN6yOj5fGjVOoZ7DNwiDYt4bOjTEo49SyCrOihxxR/NTEvtFzBp5EjkImsLmLoHCPAfpvkSNF2y4v6pKMBIaGwcp81yrEeB6rJVTUZ2andP5FE+qiIE4fDN4plzfFGOGjt2sGn/CpwcqIXMoMWNBO7vPddzpb0+Uy713wR0L/mJZtKEjIstxZwTbEUrlwqMeUURmyKazsrUnAoGRRnt8V2XfXZNXdc66CpxlaurEqdfL5pep/UxjqurSYxcBSR4dsIHfktjI9K4CxdYcGTC3XMUX7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJbRrJGtdrPYccv3u0BHS6HZBAgk7ArAq6/uVKJjPxQ=;
 b=kBnf2lxqaOmC0WC8t+CC7NOitBsNpcSALyMieHivSmtw0yVu3x9Ebj8C6a/OnjZiWFJcMIl3phntBIUGJvrrbp+z6SgyVr2i2zFZ8BdHs6ePmRbHU/VrJdvwiP9nt4yK2huGjIoCdq9SY4zYIgwH8ZOzUQDjBDOzSi/wfnchFgjnsu3Ph+8MLuf16jvhN4oUbvazAieRx5Y9YII16Q6SxCvyzFlvLHQG6tpshE5IGkfws1PAHshgHInzc4cdhWZkiNcjRKiXUX+gbTikzxMWsTXJGEWKX2qyy2WGVRn8HXFXh6WEyfYygaMRdQJz6qBpueLvvBTw/9S1R1Xv1MbmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJbRrJGtdrPYccv3u0BHS6HZBAgk7ArAq6/uVKJjPxQ=;
 b=AaAXG8c0n6+oPy82kX8YQQjBgOh3daEeng8JHErFcIixpUXG21gU6gSV2sAk7BMr7k7xXBecLHQ2lvoHOrXr+EuZMr1AAgOh4r5Y6Fs1zH79H67V/KFov0AFMGCJSPvz3ou1Xs+xJCG8D+zUHKfj/Xwv5mYK8zOmrMWH9gdq5nE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4829.namprd12.prod.outlook.com (2603:10b6:208:1b6::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 13:46:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.013; Wed, 18 May 2022
 13:46:27 +0000
Message-ID: <0e8e9f79-1089-f2a4-7966-3ac50d77c771@amd.com>
Date: Wed, 18 May 2022 09:46:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [QUESTION] sh_mem_bases: amdkfd vs amdgpu
Content-Language: en-US
To: "robert.dazi@yahoo.com" <robert.dazi@yahoo.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <919822485.7462667.1652833945250.ref@mail.yahoo.com>
 <919822485.7462667.1652833945250@mail.yahoo.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <919822485.7462667.1652833945250@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff43ae4-7728-4bb9-c795-08da38d4ce24
X-MS-TrafficTypeDiagnostic: MN2PR12MB4829:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4829C24EBAC13B4F9467882392D19@MN2PR12MB4829.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFprgHVWizWHcZr+bWAfXkQMbOW7bb1/6brkPIttlkDE/IO+w/OHqeDhk7pWMs/me+g2LPRNoqMs2Uhicy8x8GRvdVyIcidTRmautZmswFHqvJ2TG6dmUBaYaTvH+IlIsAFziee8xTSAo1b8nMvi6P5WhhpWht3gTKI+WO919Y7rjO1TogqGKoEEM86TID4cJimVhkknUDfUm9uTVRUF8KkusWg6g6Ocj0Wl8e9C8oiA0JQGSae3u+LJKoHdrYl4HaNASliC7YyGHl4rtVrXmeYCPaKljlVV82npyVprk3C180+SCEuull6MfTJzylkbSyrQjwWcBonYMCA2iW/qKJ4cA98oH2ubbZpjgn2oEbe4n9+7M+Xu5z74/gKFYykKVeFzEVd0ih6bLLkhjHiunwH7HKP4VOLMjwLjLYQReGLMqZ1eujG8rEKktgoDnUl35n+Mp7CjnHI2y2Z0J/ck4kJRhE3Jf1W6VdEMbrGXgin3EXYyHLE6kJilRj6buU09DmRPd61Rhy4nHN5W5YNCIbP64EirPKMInATAyoZRgY2PpCflOu9HOlNTevL/myKLOM31oQTr1GCHKT48cC1knrgIMDnoJVHAgdepmb2u0uil0TpZncQUQVzWV/qKyWuXwdDiuCDjItZhCF5b5axUw9NYrN5b0nnt1umIIGwHAnI5S+iLS3X78Eeazt4BdZf7GH6xUNbdQ2UZDHIs/h51s6fR8RTp6qHFwbni63TlePkTrrVEUa/rmdUOCtsz8HD/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(8676002)(5660300002)(26005)(6506007)(316002)(6512007)(44832011)(186003)(31696002)(508600001)(2906002)(2616005)(86362001)(8936002)(31686004)(36756003)(110136005)(38100700002)(66556008)(66476007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxRV3ExS1FFeHpyb3NVblNpK3lYV3Q0V0FCbGtoWFRFVUZtR0lDTzNKVXNY?=
 =?utf-8?B?VlJqWjB0bTBZNldjRzc1aVgrTUpka0dTVU82Sy9nQVBVZGV4UUxQcUVmNngv?=
 =?utf-8?B?QmZJbi9pVENPUkl4aWtjWEoyay81cmtSZis5aWpHMTNCemJwRWQvVHg0L2ly?=
 =?utf-8?B?NTQ2eitWb0d5a3hhM2syYjQ0OTFwZFQ1L0k2WW9PakhjVWdjUWFYT1lmVkcv?=
 =?utf-8?B?VEVjQlVBVmRzTmlQbkl1TjIzVXNDMzFTa2kxZ05QMDd1clBMMGtLUWIyWXR6?=
 =?utf-8?B?NWJKOEx6SkJONTFmbmFoSm04cTc3QWUyTEpIYk5rbHhmRDV5WlpDSTdyME1x?=
 =?utf-8?B?ZDk4bmhNTUhJd1ozS2ZMWG5KVElBVEJMMWh5dS94dHBLSmQ5V2kwRUcvZktu?=
 =?utf-8?B?MTFCWDBuVlROSjMzZkE4dmxXNEd5dGgyWS9GR0kvb0RrUHlUSDhUaG5PZ3pY?=
 =?utf-8?B?cElvanl2bU9BQWo1WUtmd1hSdTM1NFpsb0s4bktCYWxkcGd5NFc1aUQxYVdX?=
 =?utf-8?B?YjNMV1I5MzNZbSt4aktDZXV3b0Vqb1FXYlBlMytXSS82Wkg1M1Zib1F2NFRY?=
 =?utf-8?B?aXQ4TzF4cVpaZ3BwZkkxaGhzTkhPMUFHQVBpUlQwZ0lMNmNQUzFhQjBzbGVD?=
 =?utf-8?B?bnJOQmRKWHRJTWdUVnhlZG9yWVI1WHdEYllSNXFVdExYaVhYVENMK3B4bUU3?=
 =?utf-8?B?eUVoODFMSFZNMkg3Vko3YzlQSmpwME9obHArcU55YllYYmNFbVNTdGFvUWVR?=
 =?utf-8?B?QitWOGswVGtoV3Z6cWcrYm9XQTViL0ZiWnh0eTJ0ZGZRcHUybk42SUR0NWVM?=
 =?utf-8?B?WU9xK3lpbGQva1h3cDMrK0g3K3lDcjZzMy9XSXBaQUlwVExaWmlrekYrZ3lu?=
 =?utf-8?B?M1RnQ0llSzlwYWN0UWZzdVBRd2hqZnpoNjVDa3hQWUVRUEt0aGxRNkZRZjVT?=
 =?utf-8?B?aWFwWHpMdFJuVncvVGlMc282eGRIRVVPQmoyUmQyem14cDV5aDBiaEFsS3Fq?=
 =?utf-8?B?SlY0dVBINTBDRXNER1hNUEIrTlRzc1JyempUQWZ0Wkl2ZXpuWWMzc0dLMWtu?=
 =?utf-8?B?RE5yeUl1Mzl4Qm93eEl1Y1BGbVJDMjdPRGhYbjhJWUs5Zll0TzhQdEJqT29v?=
 =?utf-8?B?cEJ5STZ2L3ZQTUNTUnJEVGZSWEQ3Z1l4RGMyY25UNzFhZnlaSnhCS0s3d2pp?=
 =?utf-8?B?YU0zWnpGdE5aVW84Z0FJT1owVE96eWc2eEUzSjc4S1NpbHBzOVpIMXBpUmFs?=
 =?utf-8?B?SGV4N3R5c1M1SjVMbW5hbXNvU3hqVEhrelkwYmEvdC9iWTFaa2IvMkdQaVVp?=
 =?utf-8?B?YVB3YjkwU2wxdmh1dkxpRk1SaWRiQzlkaDd2cHVoaEEyWU1SSnN3a0VOd2E4?=
 =?utf-8?B?dFpnYzNlY1JyNXlYTE5wUTF5MTJPZVo2NzNQR0ZXRFdHa3RKdnFhbk5PaDI4?=
 =?utf-8?B?azFoUzQ2cnpSZWZBMFEyTUpZeis5V0FGYVN6eXBkbzNRSHRoVDR3cWNLNzZp?=
 =?utf-8?B?VnQyMkNmZmNjSHVEK0xZV3RzbU9MV0YyWFh5UFpJcFRMbmhZWDBOWFZyZ3Er?=
 =?utf-8?B?OHVQMEVWRzhLbWdMVFU5OVpuRkFCek40aUxsakNyaHdrNTdXSVpzWmhza1Ra?=
 =?utf-8?B?SndlSlJRSDFvemJwNXlrYWpZcGtPcW1Ib05BQWZCNGdjcEFReGhVMG8zMk1D?=
 =?utf-8?B?RmlsTXJkMnJ5eHNGdGRxR1dqWGd3eCtBZkdSby9tTkR3UjZMTEZiRDVEbkla?=
 =?utf-8?B?R0oxWTVHSkNDSmtuNUhLdXZtRW0rYUdQZnNISlo5aUJDeTc1VmMzdlQvNDRk?=
 =?utf-8?B?bWdzRkUwNkY4bWhTQU43aHB4dCtnNXdRQXV0aXkvaHI2YUFsNmhEMHI0WVk2?=
 =?utf-8?B?VDVlN29ZOEhFd0UyU1d3WGVta25rZWpWS1VOdER0d3U3R1UyY0FHVzJpbDc1?=
 =?utf-8?B?VUx1bHJ0TFZkQU1tSlY3a09nZVNFNnBKV2d4blJVMC9FdzF3UkpMZUlzeVp5?=
 =?utf-8?B?dDZnMWZwQnpXTVBJK042V1czdUFWLzA3NWFXV2tYcEpveWpZSVB1TXhFVXo0?=
 =?utf-8?B?OVJhblBsRmk0ZWVUUkVnZklnek1uRm1Db3FuVzNGMEhMbGErQkJZRVVVeGIz?=
 =?utf-8?B?SURRZXdjMXN4T3lZdUt3U3RpQVo0ZTJZVGx6TlRwbVZiM204SmdNYXRwZTB0?=
 =?utf-8?B?cXJ5UUZwSE9mejRNcTNIdDhoWXMrcUl6clJJUGJ0K1BITmI4akEzYkk4WFg4?=
 =?utf-8?B?MC9VVUFtNnFNVVFkdUVDbG9GbG1QRXUyZDQrdFFmRmErWERvMCtSb2FYRWZ2?=
 =?utf-8?B?K09sUHBsUzJuN01XQy9ydkpkV2NRR2c1Q3UxZDFZNHJ1UDF6ekp2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff43ae4-7728-4bb9-c795-08da38d4ce24
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:46:27.2366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHvooXSIMnqTk/6ls05lzM5lz0ooaoLcluQbr/EB8Bb+xMKT69QVoJjdmoLYWBE85RwLgtI+fRc42kBXD8ZWsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4829
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

Am 2022-05-17 um 20:32 schrieb robert.dazi@yahoo.com:
> Hi,
>
> There is an interesting feature divergence between amdgpu and amdkfd concerning the shared/private apertures. I restricted my analysis to gfx9, it may differ with other gfx.
>
> In amdgpu, the pair of aperture start addresses is defined the following way (in gmc_v9_0.c):
>
> * shared_aperture_start = 0x2000000000000000ULL
> * private_aperture_start = 0x1000000000000000ULL
>
> In amdkfd, the pair is reversed (cf kfd_flat_memory.c and kfd_device_queue_manager_v9.c):
>
> * lds_base (ie shared_aperture_start) = (0x1UL) << 48
> * scratch_base (ie private_aperture_start) = (0x2UL) << 48

It's more than just reversed. If I counted 0s correctly, the aperture 
start addresses in gmc_v9_0.c expressed the same way would be

shared_aperture_start = 0x2ULL << 60;
private_aperture_start = 0x1ULL << 60;


>
> Is there any reason why those two definitions diverge ?

I don't think there is any deliberate reason for them to diverge. But 
there is also no reason for them to be the same. The sh_mem_bases 
register is per-VMID, which means these settings can be different for 
every address space. The address spaces for graphics and compute are 
defined independently of each other, and there was no reason to 
coordinate these settings.

Regards,
   Felix


>
> Thanks,
>
> RD
