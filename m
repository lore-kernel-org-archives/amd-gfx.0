Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EEEC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 23:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC9C10E1B6;
	Thu,  6 Feb 2025 23:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ewZp23vV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A9610E1B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 23:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+3VJUY8WrqM3LLKYYJfhe2GMDb6KJU7Pr39W8875NiLhHVMw7BBMuWgx0XigDo3RTUzEHapCvVtqVeIEmcO3naN9jXKqRSYwUwJ6AYpDuYJTcQqDyViW8BzYWJeqeJ9GYvYAfSCLKXIngUGuGo5q/ur1Wk2DihL3qkM6IUYj5zsw1TSL9pa47mP6pcC4z/qglQjvt/LZnCR7be15lRv7QUFnKFV1kT90IGnBKk9odxdhumHJyGR9FbALl5DNwG2nSTfmmJdsmzvcsu6LfzPjufC3Wb41pCSfdzZ8cekrivfP7o7ecz1/2YpHqBCOQrUMjkJ5XAzFLICiE2pdexKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3N61efzrVY3Lqhx2Ry1582gOZrOIAY4qJRzP2o7dN8=;
 b=ib+bZLcw+EbknIpvd8n3nfPclhh0YxqRuDppTzz1okS01SM58KpPzXHF3Bshclf3zKNfE/UnMxqYgwsngsbcC3949PwVBJOAF9WCZ6+DVlesSl5tuuWnaIsHPecjCpJcuHYfBUOsznTu2X2FkplIbPG+JAS9teBuSJrAqJ9tpoqzXXkY2/m91Ku2lKHoxd+svS9yrAhvbYBVQkQ0gES/Q1/QUcSG2z1d/ZL1JhDl9ESgBQlcTmBLJ25A8Akcih8imuNAxJNI3nIrXIuTSL9kRr+0FhlaILmUEhchaN8OYtOwEH70rpQj8k5lzZA1c2cHOQby0aXqjefNrdACMbEuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3N61efzrVY3Lqhx2Ry1582gOZrOIAY4qJRzP2o7dN8=;
 b=ewZp23vVri3Pf/QynNSTpVS3V9j57yhjMRC4BuY0Ttdm/IwJzk64seYsIB1asqb23AKlLXWDGf0izOFIW/QSeOV76m8gSCcxnRyALkyxYffSrAY1oCpOF7MnrX+Xg07mSUz29vQHfon9llmdSNwrZ/s0BI8rqcTlyp02jkI/3g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.13; Thu, 6 Feb 2025 23:09:19 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 23:09:18 +0000
Message-ID: <6098fe3a-d193-46f0-880f-1ad8b56444b1@amd.com>
Date: Thu, 6 Feb 2025 17:09:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Set lower queue retry timeout for gfx9
 family
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Sakhnovitch, Elena (Elen)" <Elena.Sakhnovitch@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
 <20250114195251.42661-3-Elena.Sakhnovitch@amd.com>
 <PH7PR12MB5902C5C4122EDEA9EF11ADBA85F62@PH7PR12MB5902.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <PH7PR12MB5902C5C4122EDEA9EF11ADBA85F62@PH7PR12MB5902.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:806:125::29) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b616806-5893-4f08-db3c-08dd47034876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDRVZ1JHR1R2aHBWUTdhdkFObDJ5b1F1MXZJQVBDNjBvSktZT3RyK2NHMkZK?=
 =?utf-8?B?cjNZdjJjWDR4NEFOd2Njc0w2T3R3ZnluNkF4SUZyRUZGV1ZORk5RemRmaWZq?=
 =?utf-8?B?bkRlN1g5T0xyUGc3WjZIY1NLOExzMHdpN3dsTXM1NlVLSVZ6Z2RNU016WnY1?=
 =?utf-8?B?UmZ0UGtjNTRCNlBYM0ErcllrT0ZCMnF0T1pieVdmNXV4NDkrbE90V3J5SzZa?=
 =?utf-8?B?Z0Z0UEdFTVRhN2l2VHprWGd3NzZ2R0xIam1zTmFHTkJ2d0c2SjcvdlRNVnli?=
 =?utf-8?B?MklNT1BxaE9laHBZRkMyQkZJNEdNdnB2RTM1SG5LMWd4VXBoaDlwUHhtL1Rz?=
 =?utf-8?B?cS9jcDVpalJ5T05YMHdPZTRzVjZMKzkvUUdZWEdmbCtuSzhIamRodWtnaDd1?=
 =?utf-8?B?MnB4cTFOVlNhQ3RsdUxOM1ZUV3ZnYWdZbzZLaGw3Z0lCQm0wZHVMRmlFSlFT?=
 =?utf-8?B?THNFbWhKaHpvVEk0ZjhzL3RQeHkzN2t0S0hXa1lHUWorbUJHMjR1b21DWkxD?=
 =?utf-8?B?d2prZDlXMHhNaVYraWNuTlQ1NzhHbkxsT1J5NzdXM28rNXBRb0c2bFFoZEFE?=
 =?utf-8?B?cmhCVUZJMUtWcXRzYXZ0NTU3Zkk5aWZQZ2NRT3ZmaWVHc0UrZ0ZHY1hHSUZp?=
 =?utf-8?B?UGNvZjM3RWJCckhlenNnb2JadzVjOUpqUXJ3d1lsdGdvT3hhd1I0cmlOTm1T?=
 =?utf-8?B?QyswVnRwdFVsNnEyR1hlRFZkcTFBdTRXdFluWmtUOHdhNXZITzZBV1cyMGpC?=
 =?utf-8?B?bzhzdUFWcTE3OEQ2VUU5VUJLTDU5S3RIdG9wd1drVExIUDgrWUdsMXZhWloz?=
 =?utf-8?B?WXY4Uk9ka0ZXRnVzbGtRNGRoSUZTQk5LUDF5cXBDZWJGNlB1Uk5yazJTVVNZ?=
 =?utf-8?B?UGN3bitKNmdaM0o3YktuZTltWVBHdnBDaW4xSWdRS01QUUgxNllZOThwZVky?=
 =?utf-8?B?dll1c25kb2xGL3hGZHRia0grM0N3aHNDa28zZ1J6UktUbk5Bak1hWGNGdlo5?=
 =?utf-8?B?bGxseFNkZy9PTXZLOFA4TnY3c1RUUWtIN1ZqRk9SdDdaUTdmZ2VXcHBlaUJh?=
 =?utf-8?B?ZlQvRmwvdVoxZFZTNjk2ckJaUmVncTdaaVUycmFhNTRob0RCdHlBdTRoaE5n?=
 =?utf-8?B?c2huQjNmeWVKM1dOd2NUd2ZlN1lBU1FGMnNHL09aWFNyblhwZkFiWm54TTVy?=
 =?utf-8?B?TGlqczk0WW9xVTZEODJ5L1piUlF3Ui9mMzZvM3Faa2FENEE2NGhCb1JlaVlX?=
 =?utf-8?B?dEE3dGxLMjFFVHUxcEJpa3dPNWpXTVpwNmd5REg1UXVkc3JYZGdLSzltSjNa?=
 =?utf-8?B?andPWCtpZGxsQkNSZUlyMi9rcWF3L0tINitmdTBva1lsV2NVbTFaLzJGWEdt?=
 =?utf-8?B?dDVnT1hNeGtFMnh5T2JOYkhXMjlMMGlSczZQVUFUQ1F4ZXJaTUd1dzZaZXpZ?=
 =?utf-8?B?enB2bWt1dE5ETXA1eWUrQkpJcGVMUExYTjFHMGR6dlJnQW5PVkcvRGxoOTR5?=
 =?utf-8?B?aUN4RFJaQWpmY0F3Q2w0NUhGcHBsVG9mWE8xQllaREQ2Zk1wd0RRMlp2TlZ0?=
 =?utf-8?B?VGdseVNEb04wTUlnVXVYZGdaODczaXp3VjBsaGdUaHJUekx4cVNrRzJ5ZFJm?=
 =?utf-8?B?KzB3ZFlXNXJvRmJQR1IxMnZBQVdDZmRobnRUNkIrTld0RHNQRFlBWWo0ODB2?=
 =?utf-8?B?SmNQQ05BVTluNy9JMFAzako2aFFSbHIwT0hQdmZ4ejdQV0V1bERuR3hDYzRy?=
 =?utf-8?B?K1hzRlAzWVB2d2NPaUlIS05HU2tkK2JzWSsvVVVLSTdRSWw0MDRVLzBsWjZO?=
 =?utf-8?B?cmMvZFJjUndFdi9TME5UbDlJY0ZZdVRDMTZCazJaSGVaTXBPcU1FK28xeG1Q?=
 =?utf-8?Q?4pqaVzzvWrnir?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmM3TUlKalRwa1ZhVVhSQ1N2V0t2R2pTbjdWdnRkeTNHa240dVNoNEVmSlVt?=
 =?utf-8?B?dEhYMjFzWFFhWkk2T0lxbE1tb29PSHhKa3l6M3BDTW5mNXFjei9EYUdGM3RG?=
 =?utf-8?B?QVM0eXlnNm9Nckh0cUVha01DelFpQkpMN1dHY0JIWFF0MjB6SUZTV3R6bXN5?=
 =?utf-8?B?VjdWR3ZPcjlhOUNuUEZzanRBekFFYk5xeXZ5b2prSFFqQ29OWnZVNG1XcHow?=
 =?utf-8?B?QnFDejdsc3ZFaUJoc1pXRC90ZEpUUVRXS0hneXA3RjlTeWhpT2Z3Q2MxcEcv?=
 =?utf-8?B?Z0cvK2Vzd1JDN0hUVTZuK3lhKy81NmFTWnNMVWU1UlFGd2Y4WmpJMnRwTXdE?=
 =?utf-8?B?RUVaeHUweExVREFwNXNjMURGbHV2Umx1MFpnOVBmdlBYbTQ5STZadGYyanZa?=
 =?utf-8?B?OTRmMnJCRTdaZVltYnA0eUlEZlQzQ2hjbGF2VmJkUVBXc0RZVXVkYkF5WHo0?=
 =?utf-8?B?MWltdFpuS0c2d0I1a2hjMEttZzdmWkRYS3EzaDVzVzU0ZFo0dDExajNwc25D?=
 =?utf-8?B?cjdGSUgxTnZUTUw3T2tzYURnYThkUXYrSVMxTnZ3NkI2bG5NeFRoOHlMWFBF?=
 =?utf-8?B?azNMWW1yaUcyVUVCdTc5SHZtTTRzWWxHNVpSWG9uUEttTnlvQ2xBbDhyUHNW?=
 =?utf-8?B?RVRsQW9TTkZMSm9WL2ZNMmpZc0xsd295Tk9WK2JlcGc5TEZOd1dsOHNYb2dB?=
 =?utf-8?B?cHJhWTQ3TCtvRksxU1dVSkNpYWpoTUJIenBJT2EwT2pBYU9Wek8yclVWN3pu?=
 =?utf-8?B?R2huaWlmM2owclVsZkp4aTNlQmZXa0ZYZFNzMmVZQ09VNmxTbVY3US8wQ01v?=
 =?utf-8?B?dGpmaFN5Y294WmxCTUVkeHRIOTRvQ0hsQmFQdGFHMFhWTGJLYXVpaS8yZFZs?=
 =?utf-8?B?QnpBRVY2OEs4MjBGeE5JQUI2YlNRZUxESHhFc1hoSHZ4YkFqL2hSYW0xZ2dj?=
 =?utf-8?B?a0RUYjk3SUVybGcvOUlUd2M0Zm11ZzlpRmRpbzRDOEwwT3BFNGpmN0lKL1Z3?=
 =?utf-8?B?QUIvMStxVjYrRU1UaC9aU0wzMUo5ZXpVRngvZ2dZTFZRZzJ6RXlEZEhFY1RZ?=
 =?utf-8?B?VGEwaGxKSHZISlJVSHdKN2VNMHFLY0NocTN1UzVxMjFWeDk5VE1PdGdiZmhC?=
 =?utf-8?B?VEVEUk9yUDhLaExXWXVrSC93VDVJQUxhc1ZyZjJwTWhwNTczQlVRNjBmTThR?=
 =?utf-8?B?bkF1dHlZYUxMRmx5bmplNDRTQTU3Sll2VG15ZWdSdW5XZ2R6eU41Q0pUK0hV?=
 =?utf-8?B?Ni94Nm9NWUdSZHp3bnU5MHJTYlIwK1dsZU1zVHhpNHZjWEs1bGVMeXhDemFU?=
 =?utf-8?B?akV1V2l4c3NUTUgxRGF5dHJBMStCL1h0SlZRVEU0cWdzUGk5dXhQTFZOZTZL?=
 =?utf-8?B?Z1B6OHY0VUxHUTBmTHlybGxleWxBL0dWcUtmQkV0aDRocUVrYVZhS2pZTTlF?=
 =?utf-8?B?VEZUbXR5Si9HcytxT2VqVmo5U3Z2dU1Cd3VoWUpIRXkxMjhtQUlMN0RHQWg0?=
 =?utf-8?B?NjhsT2JKQ291YmtWdTRETnFTY1VMQ2YzcmFtYWFkTUpQRHg3VFk5SUVHZy84?=
 =?utf-8?B?Q1Nhc0VaTWkraFVTS3JYaDRudHlqNUUyMGlPdS9LVG54anhVK1BUKzNLd2tX?=
 =?utf-8?B?dkkrOFlzckU2SGxqQUMvM1ZPa2IvMFB0UnFwUVM5NWY3T29FdW9uYXYrUEJj?=
 =?utf-8?B?RzRQclkvbG9jSG9JVGl0MVI1Nm1pRy9vcmk3MTZaZW9VM2t2OFNBcHd3cUFO?=
 =?utf-8?B?Z0pNeFJMZTI3UXNBTGZBczZqRFQ3VTVER2VVN21MSXVUdW9XMXlVU0Y1YlMy?=
 =?utf-8?B?bE84TTNWRlAzTGZKUXR6WVUrcU9FVlI5andLQU5NU085VmlFWDJwbHNqV00w?=
 =?utf-8?B?dXh1ODlocHdEWUtDTUJyVUVLeGZrbFJkaFlNSTlEYTdaNDlqcmRGSUpRS3ZV?=
 =?utf-8?B?ZjJuL2dONVRsYkxDMjY0RHdHRXZ6U0thdjlUTjRnSFU0Y1F4Ym9URHNJUUt5?=
 =?utf-8?B?bkxtMkNubURCcTJ2Y1RwZFFBaVZhcmtxSlJjeVAwSW1ZU29kNHpEcmtNZXVw?=
 =?utf-8?B?MmQxWW1HM2NZM25KQ0U2N2tIcmRoTkZtZHZ1YkRjelN5bVZWOU9HSDE0L0xL?=
 =?utf-8?Q?XDLMLnq6/xiQkpW1+CNLhbY0R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b616806-5893-4f08-db3c-08dd47034876
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 23:09:18.5827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu4gZyOUQYQXyKVvPFgFG/0q83NE7oFo0RCWYBEYqBpF5Sqxxu+Bq1fAulQO30RgvKUuo8/DWKltXp1eA0hcQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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

On 2/6/2025 16:27, Russell, Kent wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Ping (plus Jay)

Sorry, I'd need the whole patch chain to review.

As a general comment CP_IQ_WAIT_TIME2.QUE_SLEEP is tangential to 
SCH_WAVE. I'm not sure it's useful to tie these together.

SCH_WAVE is lowered when a debugger attaches to reduce context switching 
latency, which it triggers at a high frequency. Higher latency (the 
default) is desirable in normal use to allow short-running wavefronts to 
complete rather than taking the slow save path.

QUE_SLEEP controls the interval between checks for unmet conditions 
(e.g. WAIT_REG_MEM or CUs fully occupied). On contemporary ASICs it's 
best to minimize this by default. The cost is additional bandwidth 
consumed by CP when polling memory, but it's not substantial.
