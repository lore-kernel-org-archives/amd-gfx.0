Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008E9C25B5F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 11:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6665D1135D4;
	Wed,  8 May 2024 11:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pxujkdNV";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE8EA1135D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 11:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwZNgIuHzIfmT6QzhLcqSqNznMW9qcURqyqujthJ/jX52ajcVgSrFDb851WH6G68jOg1pukmQM6pJSKgJ+XRpv/5ePc6LZJFef/vNN/zBVIlr3wMMpvEwB2VFXHm8aYyBQPPIMzmKAmV1P8rn0zBFs7kAeOwrz/V61D+iqhG2oR6qIU4R9DYyLyEamVQK8pvOY9qgW+hj6yXVhZmoVaBzBZvwX7Tr/7uMuqDhhaXMchABe/44Pw9RVQBOcaHN7PqOuODawsbll/8cSoruJU8O/K3/qHFkBSt5y9Q6OfdPdXlc/cFVwriPSF1TJBsKDHTlExNpQV3kDbejFnfzj1iDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFYci4gvfwvnMrJGGQnn7oMFrBIakbsctzyYkOR778c=;
 b=iQEu3JyaANp2b00uIyHBdpXBNSMkwWhyrqIiqlQk+PLRXprFLRFsJJnvLd/9T1p+NpyzlFBMt6tUGubKGeKpW5o/ezwF+gMLiZ6Z4d6meCAyY6W5NMI4nGOX1P+s5LE9LBXHJjiclpx+lLMaxFEmGziSoFJ3t2pzvV7WTtRUkejTJ+nlhSeOlJNNLTsAdO5VjUXekHSeO6Wi+zRt821QlJpG4Fr1oTvIULdfy3oDVASYm9WgcpxtnhEEILVHXAXOsEiYHA0q8/UOJIw0YQ9IUai9oRAiw/aOvfZshegOGC7F0sn2d1Gp05Ev6IS+ziW2f0ycSbMxcpkpQd3o8VgEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFYci4gvfwvnMrJGGQnn7oMFrBIakbsctzyYkOR778c=;
 b=pxujkdNVVt/F0KWsSazmAZnL9Yxr4AVWrEBQYAx2zyFS6YR6pnh6nkhj/4HJPtyj+MPswMD/k+OmiVg4qo4rEdB31RQsDN5TtC4dPtMnLF2AqKPWEQ/unv9flUPASgicaEerGiXT7fxtf8G4oayATq4/lU2pXoKQCxLko4maCw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 11:38:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 11:38:24 +0000
Message-ID: <65723643-77a1-473f-908e-611916026513@amd.com>
Date: Wed, 8 May 2024 17:08:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix buffer size to prevent truncation in
 gfx_v12_0_init_microcode
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240507164446.318263-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240507164446.318263-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: be217a17-e992-4960-1242-08dc6f535eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXZFaWNnZVgwdmNJWFhwT1o1RG9zNVBDYTgreUV1KzJXRnFqUWp3N0laekFD?=
 =?utf-8?B?TDZNOFRwaXoxdDA1ZGJBOFFXeUN4VitDajhQMTByK0tMOFRuV1BLOFZCZ0ti?=
 =?utf-8?B?YkhYVUM3WE1mQk84SmFnUmh6MkxqdEViNmJUQ1pIR2o5c3V5aHJvTGpzOWhQ?=
 =?utf-8?B?T2c2U1RDQWczcW5ydjBQYnNpbnc5Ty9zTnNXQUNIb0JrSVZ3MWlvY1g5T1RS?=
 =?utf-8?B?RGZVaW9DVGV3RGxaYlFBWVNNZ3RvRVRtRDM4MXllUTV6eGNid0lDdmFDeG5a?=
 =?utf-8?B?ZnFVenFHbC9SdjIzRG5JVk1CbFFjcVh5bUlhcW9RT1lIQlo5cXhJUGE1N2Zz?=
 =?utf-8?B?WndDVDRYdk95MXhZcjZROGl2TkVJTnM0dWxsRHEzQWR4R0ZxRDZkbVNyOU5W?=
 =?utf-8?B?UXpPUW8rVGZhN2tIeWMzclk3Z251KzEyUndzaytqNG9jam5OL3ZEVFdQOUlj?=
 =?utf-8?B?dWw5U1pSRmhZRUFzSDArQTVFdThiMGxyT25kN0oxU3BwVVZNNjFwVE5KQjhp?=
 =?utf-8?B?M3JTbW9XcDZqU0xPak91NHRZRG5KNEVhK1IrUjlEbjNsWDVnaDh5YzdleVVw?=
 =?utf-8?B?WlFUNjRZcWdxOER4dUk3WTMyUVpmcDc2WEJkTXM1VGR5MU5HS0JzdWg5WnJn?=
 =?utf-8?B?OXdCSFB6VWx3V2ZlV3llZkZ1dTRjWHdSSllkcFZ4RE9ONzZublRpTlR4WkJW?=
 =?utf-8?B?ZGVOMDhVeHRiT2lMWjlQSHRNSXR2aUhYNTVJRmNIK1VNaFFvZ25VbUpSQ2VE?=
 =?utf-8?B?dFNlcGRSd0Y2T1hwei8raEFaVWpNWDBBcjFnUStzbHhOa1BIMjZMclZzWEVS?=
 =?utf-8?B?TWppMDkzUCtyY1NWWGpXZUsrWGp5WmhPN2ZFcjdIT0czbHhOSmt1ZHpwNlow?=
 =?utf-8?B?TkFLcEFoa2FGT3JNWmJJaU56cnNnQUZZNlowUmUzdnRicHZJeHBrSDU3MERu?=
 =?utf-8?B?MnFnR1Q1cXY0VTVZMW1VVkRkNDdJajBYZ2hrT3ZwL1dQQjNETHlVRmI4MzVZ?=
 =?utf-8?B?Wm1IUFJ6dXJEaWg3R2svb25zOGJIMXFqMUFXanFpODVQV1c0bjJlb0g3Y0lP?=
 =?utf-8?B?ZmNkNXhleVBWUGY4UCsxVldxcGs4K3lvT3paa3Z1M0NwcnY1V0g3R3pZMlkv?=
 =?utf-8?B?Y0xRdGZBMXIxSTBYRUdsZ1N5NUkwbGMyemdEbmtQbDhnTGdYU2s1T2xSUkk1?=
 =?utf-8?B?OTZTRjhjSTNCUFpXYnVTR0FWb2JBNFRMc1ZpZU5RbEcvTy9JRWhXZ005T0RX?=
 =?utf-8?B?T3p3ZzJlUWNjdU9WRWV6MFNOY3l3SFB1RzF1ZlEyNHRsc1Q3ZjZOWlQ3MjJp?=
 =?utf-8?B?c29PUy85ang0Wkh4L2xLVEJRc1VBMTdJWW1MZXJ3Zi83WU5ic1NRUjBlQzcx?=
 =?utf-8?B?dzJuS2tLazRDelFoVkt6Y3c3MlRIa2wvR0tZblZ4Q2kvY0p0YUNQRmo5c3JD?=
 =?utf-8?B?RnhUb3k2ek9ubVI4RXVIY2xqRHh6MjFXVURTUm9yQW5VaVZ5S1JYeHAwU1Uy?=
 =?utf-8?B?MGxwOXdSQ3ZNREJhaVp2R0oraG53ZE1YRlZIWFFGbWU5Z1Rhd2dpQXozQmVV?=
 =?utf-8?B?ZVNjTmlkSHpxbGVES3JXaTlENllGNkhvQW9nQVFOM1B6SHBpSmgrbFErekFy?=
 =?utf-8?B?VTdnbnBPYXg4UEUwejdPSml3NDdBeC9rMkRwbG40ZW9IbllOWEd3VkJ0Qlls?=
 =?utf-8?B?Ung1RUM1cTl0VXN3VFVFbUNiSTVKNFFOcXV6cWdQVStJbVZhL01wRWR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGhMRFdwZ2doNkM5b2h3SDVPR25XckxEMzBDc1BNNDJpWG5ramk5NUkvRDh4?=
 =?utf-8?B?ODh6bnVzR3YyaDlGM1dLT1FDWXVVb0szR3Q1dFczczlpTFlqM0h0SllDU3Vm?=
 =?utf-8?B?eE4zUmR5bnJELzZSSHhHelF3SVF5MFFsb0tHeGRUcklhN3hIVVlUTTBnSWZm?=
 =?utf-8?B?SFFYaXZucVlSWVk3K1B6SFMvOHJlRjRrdFEzYmh5VmVBMUd0TEZ1U2pyd3JW?=
 =?utf-8?B?NDZMbmIvU01DWEFEamg1ZVRISXBJNEcvZHpJcDVVbU0rSHVLTEhLZGwxOW5C?=
 =?utf-8?B?TFdmRmNhcE1tbFdiNnRKMEVsSUwyYnQ4UzYrdmZiMzMzWHhIYzlJa2p6TkYv?=
 =?utf-8?B?Kytva0J0aXNJZU1PSExYME9TK0hXbUxURzhmdHEwVlZ2Z2ZhclloNXdRUnFr?=
 =?utf-8?B?QWVvUzJiQVNSd0s2UFg4c2M1aXhjcThYaTVBNEJJS0xFTzF2ODJlV1BsWmhT?=
 =?utf-8?B?MStLenV0UDkzN2l1TThwcWJYUmRMc1pIdElxMDU2b3grbjlPbTJnMHE3QVMz?=
 =?utf-8?B?ZUNsTVEveUM4R0FIakVaV21nQTFvYXZWQnRpV2Z3OTk0bHdnaTM2MktYaloz?=
 =?utf-8?B?KzZrMlozYkNYbmFjTGpVZTlZbjNzUHlocERWRE1rUWM0Z0lqbFJFQkE1eEQ0?=
 =?utf-8?B?UTJHQndlVEtWbnNqeXJCVFptTXdpNCtWZHgrN0RQUFpLNGg2V2RPRG5VTW5w?=
 =?utf-8?B?aXAwVi9PaDVBWkVvU0dmZlhoZzVIc2RBeWNUREJuSWdwdkE0R2hXczZ4WnZC?=
 =?utf-8?B?d2h4ZlRLTy9DUHJRVlRIUG9Pa2JpazZPWXpDa2dTMUZ4MnNrK0pCVDRVM3ho?=
 =?utf-8?B?MGppTTFiWnMwb2Q3V3RxWllpNTN6NTZVZHJLNDBBbVJUbHc2Z3B0RURiWE9l?=
 =?utf-8?B?Q2M3UHhwNlFXVWVtNy93TmZTMTYvOFdwenVSOU5Ca09NRWZsellYODlLcm1p?=
 =?utf-8?B?UUdjbGE0WWU0WDZCYTVNa0tzSjNLMW5ZT21ucjR3L1hBUW9OTUxtZitsWkhp?=
 =?utf-8?B?RWk4eldBdGtkRzFMWkM2UzlpSjQ4dHRmdU1CSGJxdG5rdGxBSmVXd09FSDVY?=
 =?utf-8?B?Tm9wSlBFckZoVWwwMWtValJ4QkF3TU56aGYydmEvWlZXcnZuWnFtSmg5VHdP?=
 =?utf-8?B?Sm9uVDJ3N0Nld0wzcUdNWGlqdXhCVlErM3pQZVc5MGE2ekZWK0tLTTFKdWZ1?=
 =?utf-8?B?Z1lEYzhaMjV2SHBmeWRUb0FRbk1BaVBCdU9kSmZnbHN3ZlBRRkhCUEpmajJx?=
 =?utf-8?B?VDRZNEZ1OWg2cllXK2kxWXMySzZ2WEJ3aU9TZDZ4RGVON1Q1SlEyVUUxRGtF?=
 =?utf-8?B?eFJNQm13Tkh4bmExZUNwZW5na3RPRmp6ZzdWQmdtOWtZbmZwSHlCUDFOdWZ2?=
 =?utf-8?B?TXI0eGExNkpNNWVCMXRKVU5yaGRjNlNkUkswM0NBZ3J1WkwveURuY3BWb3pk?=
 =?utf-8?B?T3dIVE9NTFBmWDNtR1J0WU5nQi9QNTRSQW00QzdUanp3U3YrMzVYOEp3VnlT?=
 =?utf-8?B?WkFGa2VuQXNLNzVUWFkwSWU4L3ZOV0JmZ0kwUVdZK29lSXlIRU96U1dEVkZu?=
 =?utf-8?B?NXhMMzZ6NXhHUC92eHpQQjB4Y0lhc0d5bm5qSTJJYVZDMVdDdVh0L1gzN01h?=
 =?utf-8?B?aVEzVU5ZaWtnVXFBdVI0RWJidzlYb1l2WHpLS3d5a0RHRkwxOGlSQkY1MDk1?=
 =?utf-8?B?Y1gvM1NpKzNmcktnaFcrM0JiellKWTdxSkNHMklkUGV1MkNlOTEvNHZXZlNR?=
 =?utf-8?B?VEVaNDJocjBkZ3U3Ui9iMDRsMGcvakFINU9KbVpHZ3NPM05HNHNjUDNRamZF?=
 =?utf-8?B?aWZwV014VUZrNk0xVmg5alFOWW92dVh0bmppcmNxSERqN1ZzSi80V1U3ZVdw?=
 =?utf-8?B?MlFZYUtSd0NGV2FQRndTS3d4STJheENXQUdUWFo2c2dpZUNvYTFKaVUzSGxw?=
 =?utf-8?B?TGZmYjhsem5tU00rMTBjcHpzeWNWSGJ0YThpd1hlUVZjcjVBUlNOQWo1cGZE?=
 =?utf-8?B?UldsOEpOT2pSZTA0bEV0dTQwMkFXRXpCYllydUZiUW4rUy96NGNGQkxOaGl3?=
 =?utf-8?B?Und6K1N0WW9zc3RJK0x1RUtYeTFhaTZFdlZQWGdsU3BXUGRienB4aFFGelZw?=
 =?utf-8?Q?ZG3HhHCapDJTJLE490iGHjSdx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be217a17-e992-4960-1242-08dc6f535eae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 11:38:24.5973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWRxXAJvPxgiYUStt9o8OWTI/AkvPIj2I1S2meyV2s8aNT8x74ewg0vpneE3H3iZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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



On 5/7/2024 10:14 PM, Srinivasan Shanmugam wrote:
> This commit addresses multiple warnings in the gfx_v12_0_init_microcode
> function in the gfx_v12_0.c file. The warnings were related to potential
> truncation when writing the strings _pfp.bin, _me.bin, _rlc.bin, and
> _mec.bin into the fw_name buffer.
> 
> This commit fixes multiple potential truncations when writing the
> strings _pfp.bin, _me.bin, _rlc.bin, and _mec.bin into the fw_name
> buffer in the gfx_v12_0_init_microcode function in the gfx_v12_0.c file
> 
> The ucode_prefix size was reduced from 30 to 15 to ensure the snprintf
> function does not exceed the size of the fw_name buffer.
> 
> Thus fixing the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c: In function ‘gfx_v12_0_early_init’:
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:421:54: warning: ‘_pfp.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>   421 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
>       |                                                      ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:421:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
>   421 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:428:54: warning: ‘_me.bin’ directive output may be truncated writing 7 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>   428 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
>       |                                                      ^~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:428:9: note: ‘snprintf’ output between 15 and 44 bytes into a destination of size 40
>   428 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:436:62: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>   436 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
>       |                                                              ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:436:17: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
>   436 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:448:54: warning: ‘_mec.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>   448 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
>       |                                                      ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c:448:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
>   448 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index b53ca25012e6..b6e5a2230622 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -408,7 +408,7 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *adev, const char *
>  static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
>  {
>  	char fw_name[40];
> -	char ucode_prefix[30];
> +	char ucode_prefix[15];
>  	int err;
>  	const struct rlc_firmware_header_v2_0 *rlc_hdr;
>  	uint16_t version_major;
