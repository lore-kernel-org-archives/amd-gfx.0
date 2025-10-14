Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D95CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 11:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF1610E212;
	Tue, 14 Oct 2025 11:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VBwn/H15";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5A810E212
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 11:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDdSIjzEEsNnJX5WYZvVMeokjkvBp+d2MPLwHcGBr5T4WRD7mzVFtYTDKtpzPhBRL3efxbOmTgKu0owOTxOBXMQ1Y8peHTsdf4FdIeZxCNQHv20nA6JiMs5CGDjXN44O15G+XjHeNimJc2Q7tZ6tK5REKLCwKjzKOlGXqp3EwTm3OOxPq79OsrMzJuLKXDvLoPWn1TLUE2+FE/pjzEILy7UOXttE2oOOGseLndwoSVP+OfdjkNWX5qYFF4+8bgdI8brpzIKNmmJzUg691sgwupkgxP+1MT1Enc0KvvPvPVHKwI2HX9+dByntE5U90vOu/atGAGCUR1MHtH47yRI2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw/1BGd2sG8LlqIkNoKxDa85cQFjfeLGprdmNhNKIF0=;
 b=YIgWThrG/Li8hclrprwTIbt4elG5flY1iLV7G5h5L/CMryX8XhCF4rujVmzUb4ry7vBHPb/zIsElCwVBKyC/3pP9zu6QUfTYyNNRiFKDhUhyySfXtFrPBt/6xwV0Ny+HZNY7O9DA+0GmrgnLGpaLVKaUMQ/CUpSjleJUO1e1Kjq7IzinqlXpmciF2fojhEw3tBGZoZNYReR+BXywsfT8S3/xZqVVqDUzh0GCQ0xg0o01Jh525Nzox82sthrJolIX5C/Y1NBrRHnJd6SPnw40QHyQWaSqzEagmMmsYZ20GJtd4m+j72jxO7wrfXEm8PBNAwx9FRdhw3JuJIp9VFql1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw/1BGd2sG8LlqIkNoKxDa85cQFjfeLGprdmNhNKIF0=;
 b=VBwn/H15xSS9TFc7FdAaOOOT+GAipZVsxTBddrlFQiHc2/IrG9bLGLZ20Uc3iXoKHd1bebsYWERInYF3lQjarIfrXI3SEfEm8URAAQPolcte+qco1okf765mU4B9TCyTwsOPyWUNU8U541CoraQ/HQvAAr5phbaRnPWJ61KqrOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 11:47:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 11:47:02 +0000
Message-ID: <f19b26b3-b419-469d-9c54-c7e9ff5fc424@amd.com>
Date: Tue, 14 Oct 2025 13:46:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: add the kernel docs for alloc/free/valid
 range
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251014074337.421304-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251014074337.421304-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0496.namprd03.prod.outlook.com
 (2603:10b6:408:130::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: e919a840-3ee8-4ae4-c72c-08de0b176417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzlLLzVDUW1VRHFVdFMwb2pWdU5MbTlPQk9sd01LeS9sOU1Kb2MxWGkvblI1?=
 =?utf-8?B?UmJwSUV0UVVrVnFqRlAzSjk5K0NVSklVaUNDS1ZxWWtHNDFnYTFRWGtWT256?=
 =?utf-8?B?U1gvMmZLYTRpRnBrOVIyeTBHTnZqQUZpYWdjb2U1N0EwRTlJTFN5UXdxeW5E?=
 =?utf-8?B?dFFUV3hUUmdnQmorZk91bmltMTg3cU1tRmZPc1QrbEJYMTBEZU0rSmc0WEJa?=
 =?utf-8?B?TGVFMmNFNE9TQXBwSEdGWHM3Q2xPRGd6RHo0UFB1SWQ4TkR1bkxvNzkrVzE2?=
 =?utf-8?B?cWVOdHR1bmRYY0dlcXVXNUpFRWJiQkVUbVY0ZGozUmY3ZnlSL0YxYnBkZ3dF?=
 =?utf-8?B?ZVlPRncrZE9KRVVnOU45aW9rTk5WY2czR2F1bmVkTXdJUmxaZE16MW9HbkxU?=
 =?utf-8?B?QjVCbXJuTUN6UTNVRFJDL0Q1UjNHSTYzWm90Rmk4bFE3UXFzN1ZuZThGUG5v?=
 =?utf-8?B?dHYvUHhUWm1BSDE5LzlSM1ZNMFRTYTQ3cUpyb1pBejNmSDhQejV5bWxIVlQr?=
 =?utf-8?B?RDFua0lzc1A2a1c5Y2ZrdTE1bkZEQTdHcHJSWXBpWjQ3aUJjTmlOODhWKzVL?=
 =?utf-8?B?MHBxdkNJSC9ia01vVVFXOGdEK00vOE5CRDZ2bEpWVHpzeFdPTFdscE82VjZX?=
 =?utf-8?B?K2RyWmdhY1JuS1VVNzdlQXlCb0Rmbk1GOHV4blRBMFk2Vk4xOG1qNXFjK2dS?=
 =?utf-8?B?MHJ6TjIvUnNVTjNXYW9wdkZkVk5aZzZXMEJWQWdMLzhGc0h5Ny9PVXZDd2hN?=
 =?utf-8?B?aDQ2OUYrLzhaWlgxSTFZTk9Kb0llRGM4aU8xUmNiV3ZzWEt0Q0pCcnc3eFBi?=
 =?utf-8?B?a3BiU202WkJCT2lVWTRSSndYVllCSUlRb09DRUtSMWRnS2phbmFhWCt1dlhD?=
 =?utf-8?B?L3BUTE5kQ2R1VDhvQ1phejBpbE9USjdMMm0zU2k5eUcweVp3ejIwWlRlVEcr?=
 =?utf-8?B?VWp1d1hTbEZEMzVvN2ZXNUZWQUxzaG0ycWdWNENCVm42QWIzcnVYZE85eWlI?=
 =?utf-8?B?Q2pUYlNvVEZ4NlhDRVI3NWI4cHpBZkg0TXFvUDZXbWZmZHAyTzVnQmtJNVJq?=
 =?utf-8?B?Wk5IMjJYMnlGU0lqUWw3UDJLSFpYSlV1UytjeElyU3RKeEthaDZxNDhJa28v?=
 =?utf-8?B?bG9yRGtvYVNtckN4b2tpVlV6SnRibXRKTlB1OHpYTFo0ekJUTjZVR2k4ZmYx?=
 =?utf-8?B?ckNmWFhQT0Y3eWZGME4rYzR3c1NWZEx6alg0MWVTQ1loU0JNNm1nQjdqRFE2?=
 =?utf-8?B?SWJtZ0xGYXVpYzRLcEd2NnloUWZSemlLMVAwZXgzeTIvalJoWGJQUHdIblVm?=
 =?utf-8?B?clVvZVpvV1UxQk0vYnRXZXErcmRiTVAvUTFOWjlQMkYwb1FDbDdXS2dFU2xt?=
 =?utf-8?B?dVNNQ1VBQzZhNytWc1FKbXh2enNvTEgxVHNtalg2NERGcGREQWZuTVQ3aGVv?=
 =?utf-8?B?dUcwbnFZblBIMDBSWmROZnpqTXAzbFp0RE9JcThFKyttaFhFWnY3dUNOdE1S?=
 =?utf-8?B?ZHEyWXBnc2RvY3pBemhSbmFBN1NMemppSGRVU1pyTHNQLzI1enNyV3RSMjNM?=
 =?utf-8?B?NXhDNzdtUllsWjZFWGxCMWpKOGZsSk9nclFqT2JEWis5UnFhZTVkcDRoYklS?=
 =?utf-8?B?alFPQkxlVzRYNEFDODJLMnkxRzhnUk43ajBzWjhsRVhCNTlJejNOWldHWmFR?=
 =?utf-8?B?QXhBcUROeFhQbytvYk1jOW9uanpHSjFaeTBjK2EyNUVOZWp4Mktlank0VG9w?=
 =?utf-8?B?M3U1MXJyT0xjZk1SeXBLbDJXQk5lbnJJVlZFZk9FYy9aMXMwTmJkOThBOWpJ?=
 =?utf-8?B?SU0wbjkwc0dQNlUwbXFKVzQyQTQ4Wm5PZWdTTlM1Yk11dzI4SGtkVUd2a3VH?=
 =?utf-8?B?WnE2OVJ6S3dQTU9KcG9lL25JZXpYcnptSkQzZXdrV2JoU0NjNE1BTVJRYmRM?=
 =?utf-8?Q?SQHpXyrjZilZSBQOnWZ/fM3lX6WriQFA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVQM0t4aTdkSFF0ck5ZTHNZMUlNdGoraWJkZ1BpWnAwWGpyaG9CRWsra3pz?=
 =?utf-8?B?anR3SnpVcWNJRzZNN2NreUZySnpQeHlva05HSndlVlFFd08rOHNoTXdpY2Q4?=
 =?utf-8?B?bGE4cDFpalNUY1Vvb3htZmNhK0VIRU5zbjJJY0lGeSttTGIxdnUyWVYvemhH?=
 =?utf-8?B?b0dVRnd4OUw2amxEWFBTVldSTTFsalJjSmdUSFM5T3FuN1ZNSU1yNVhlN2lq?=
 =?utf-8?B?VGxUS0xXOWVMUTI0eXd2a25BWkdCamd6V1V5SHFpOG5FRkl5UVB5R0c3Y1dy?=
 =?utf-8?B?R2FyTVlvM2IxVXhGNE5qYk9scy8rZ3JMam42aEtPUElmRE00enNQT2RDWUtF?=
 =?utf-8?B?N25nZSt1UStINEl1M0w5Q3M1cFZaVFE1dldTNytqN2NZbkZHZ0NMOG0wVWJx?=
 =?utf-8?B?a3RTWE9WaVpvaUhoUFdzOU5jWWF6bmkwS2U2Q0UybXlYTlVia2RxQ2FPdzNt?=
 =?utf-8?B?SGRVMjZwc0hneEV0cGF4NDZBRlN0Y2hVKzdrZ2ltUmJ5K01WbjBpYkVIdU9O?=
 =?utf-8?B?b1NCUGhyS1hBdDQ5MWtmMVUreDJqNHczU1Z3YTd1YjJQKzJIbXRRVHlLWHRq?=
 =?utf-8?B?SVp6aUVmYmNrTlh6ZHZLL0FxbWtpSng2bEVjNVBsaXlHQ3hmYzZobHRUSlRI?=
 =?utf-8?B?M0VEb3dHVHpldVNHdnhHWW13K1M4WTNaNUM1MU93QS9EdDVHeDFFcDB2SG5C?=
 =?utf-8?B?TFplaHJ0aTNHejFlNDdmSWFFWUFWSHhVeGphVUNmalgxamNrZ0hRMXgwSUJa?=
 =?utf-8?B?Uk5xdk5rdUJITk42QmxSM3hFREFESGFDLzJ4bHMydXRrVFJ1eE1pTDNraFpB?=
 =?utf-8?B?N3NOdkRCUmJLaFBvSGRlQjN4ZGpXYWR3QmgyTDJIZXN5SzZ6RnFzOTY4b1FF?=
 =?utf-8?B?cDRIWjdzR3JtNU16VnAxSERRSlRqTURlOU9Db1lVYVFIeVljRXFMOG5pRUtC?=
 =?utf-8?B?S01SMWtXaUtZMW9JT0VYY3VseDYzZURuR3MxOHpJblBKYUJPVmZZKzZlUkdx?=
 =?utf-8?B?VWF0UjdSWGh0U3R3aWNMSWVIZmc5TCtleU03ZzhwZzJzYmlEb1piZEVvMWFF?=
 =?utf-8?B?YzVHdFVnWVBJUkUxdm01NE91OXRMS1p6eWlpK2F1cEdCNUtqK1hGTWc5aGhl?=
 =?utf-8?B?MzBqRUpvSkVCUzc0S3hvU083V0JSMkN1VCtXWFV5STdWYkRMaWhDa25ISEVR?=
 =?utf-8?B?RU1WazZuSzVXbGdOVUVSRGZkcXJRb2NNVjhyWjBwN0FUL2gzbHRZZWZCb25O?=
 =?utf-8?B?STJPR2FtTGp1YnhBcExBdGhnMFE5ZTFNdUw5elFxMW9ZNkFCc25xK0htdU5R?=
 =?utf-8?B?d1dTd1JWS3FQajcxanB4cHNzRkllUld5YWd3NUhRL2VJbjNtR0RWQ1h1NG9B?=
 =?utf-8?B?Tk84MFRsK0I0aHJSNWoxRE50SDdxaU1aTjlKNy9jNWg3YXZNeFYwcjZDWEN6?=
 =?utf-8?B?RGZUSm93c1cwUmpDOCtDV0trQm5CaytVNm4wbWZxZkFMNXBtUERxRW1xTXlu?=
 =?utf-8?B?eUEraDE4NGF6ckdrNTVlb1RpWHQ0SlkrTGhCVENYdVVrQ0FYWm5OY0RRMEJB?=
 =?utf-8?B?dmFzSDVZZzBRbVArK25pcTA1Q2Vidkk5YktaSXVwenlTTHVoUW1LdGx6Q3Qy?=
 =?utf-8?B?SVNqRkZJNXgrcm55Qm1reW9YWDlFcDZUQU9tUXJhSXpWeVdtbUJYZ01adkJ5?=
 =?utf-8?B?VytEcWNkTkJ4R0Zadk03YXhEV2ZzMU91S3k0Z29EemFHUVUrMmY3NTNhMDBn?=
 =?utf-8?B?akJEekZZSkFNVmNtbUJ6TUtSK0ZObnVJOEhOTVNvbEdQOVNPVXRaRkRaMm5x?=
 =?utf-8?B?TmQwUFB1R3ppUm1aNHBDSm1xV3E0c0p3VGNHbXM0WjRIdTNhc2NEOVBIcDhJ?=
 =?utf-8?B?eDFtb1lDdlNJdmdTQTNzclR2RW1OYWNpYXdLTWE3NjNLTU1JMDVUR2MyVG85?=
 =?utf-8?B?MnNkckhIdEZHL25iY2RvOThxYWU0Vm05cE9pZGt2b0djYjlkaXVGNjZwU21a?=
 =?utf-8?B?UkRvUzJKMG90VE11WVA2QjRBaXdlcS9jajIxMVdMN01hdjV3bXY2K2xPakJz?=
 =?utf-8?B?YTZuK1lPekx3a1A0R3d5L0tIQ1dHVE1UNzFZWUhVelZ6Q3pGUW1lc1VXd2Fa?=
 =?utf-8?Q?+i5wqM0A45Jm/7sHH+XP2EZcs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e919a840-3ee8-4ae4-c72c-08de0b176417
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 11:47:02.8186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nZl+xZroXriKUIDk5S+Z4wv+PXsENWzo7EiTxy+DzSfOqJ52VbHXNcPVzSLMcaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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

On 14.10.25 09:43, Sunil Khatri wrote:
> add kernel docs for the functions related to hmm_range.
> 
> functions:
> amdgpu_hmm_range_valid
> amdgpu_hmm_range_alloc
> amdgpu_hmm_range_free
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 35 +++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 04f02e0c8bb3..419f0dbb38ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -227,6 +227,19 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	return r;
>  }
>  
> +/**
> + * amdgpu_hmm_range_valid - check if an HMM range is still valid
> + * @range: pointer to the &struct amdgpu_hmm_range to validate
> + *
> + * Determines whether the given HMM range @range is still valid by
> + * checking for invalidations via the MMU notifier sequence. This is
> + * typically used to verify that the range has not been invalidated
> + * by concurrent address space updates before it is accessed.
> + *
> + * Return:
> + * * true if @range is valid and can be used safely
> + * * false if @range is NULL or has been invalidated
> + */
>  bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>  {
>  	if (!range)
> @@ -236,6 +249,19 @@ bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>  					range->hmm_range.notifier_seq);
>  }
>  
> +/**
> + * amdgpu_hmm_range_alloc - allocate and initialize an AMDGPU HMM range
> + * @bo: buffer object to associate with this HMM range

"optional buffer object to ass.."

> + *
> + * Allocates memory for amdgpu_hmm_range and associates it with the @bo passed.
> + * The reference count of the @bo is incremented.

> + * In case the @bo is passed as NULL, caller is responsible of taking care of
> + * the reference of associated bo.

I would drop that sentence, when NULL is passed in there is most likely no BO to reference.

Thanks,
Christian.

> + *
> + * Return:
> + * Pointer to a newly allocated struct amdgpu_hmm_range on success,
> + * or NULL if memory allocation fails.
> + */
>  struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>  {
>  	struct amdgpu_hmm_range *range;
> @@ -248,6 +274,15 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>  	return range;
>  }
>  
> +/**
> + * amdgpu_hmm_range_free - release an AMDGPU HMM range
> + * @range: pointer to the range object to free
> + *
> + * Releases all resources held by @range, including the associated
> + * hmm_pfns and the dropping reference of associated bo.
> + *
> + * Return: void
> + */
>  void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>  {
>  	if (!range)

