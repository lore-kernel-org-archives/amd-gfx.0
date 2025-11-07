Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF15CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 09:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE6110E05D;
	Fri,  7 Nov 2025 09:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1z94YOaP";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8389010E05D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 09:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAU6Hp2XAV3q2X8aq3wDJJ/OM34k2oXye0E1HdCwJaHM1aMLg/q1x5hJHySBi/AB2yA1mFCHQzAY5ju9s7DQ/93rlkOrOV6k1Gu8sZ9D9Di9fuD/HUGAkqyrbojjNt2gM1gWRBAN8eGuv1C75qbcRQ8e7hBKtI2jpNRRAEZ0kwY6UPAFJ6ipLA+qDyW0XGRsPQe3vmxdjebOi9gRIh7CGzWCgNYfLLUDce2JXPKlJVP7BZ5nEdAdGV72s6CgwjEko18HJxK/U53MbVHOKfu2q5MH8/AFjLgBCc3xnc8/RXKANXTRoPFYxrreYrTyVbgqMwr6AkkclvYpOTZVQt5yQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRHQWOcv0ed4hm2GkvUl6LA/NA+VqI6ws3BOt8D2d+I=;
 b=D8fmILdTV7LsdaebqgvvSQ0LYk3iPqd8kMRp9P5XrVpGtVkGMzJI9wzl+7dueZZyA/rmBl7L5vC24/D99rzw8UZ5c3zr2hetOx6m3HNQpfu6wRLz33c/of8dUTMC+JHAJ1lX45FjDEXhVvYeUNa8OqnXUBacvpLGMdXRC4fmI7wTwKIeIYWbJrNezih1+90TvN1iOnhCEMrP+2SU+v5jP5PBka3mEBTo6k3PzUg2XD8nGFZ8UpGPfNDpWnDOPt1hejLVf8kNTXpU3dgTRxYSUyFDOTaHeumiX/owuVglkeXjV5PJZ73b0z4nDmeLVdnPRf99XjxFUrUdaOiDuaI1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRHQWOcv0ed4hm2GkvUl6LA/NA+VqI6ws3BOt8D2d+I=;
 b=1z94YOaPS5Xc47SQbP+1mwn/AmjuhtS+AZvxL9bfN2lRnWnppKv31F7Am/GJaqQmAp29JPyUNOtoCPWNYJU0nlPa43/LidWsxdUHlxYSkmcq7oYjHydYIyXM4Nih7IyS4FDy9xsqlhyfuvdTIhvqHwUhzIsWmrUDXOae5cC3RCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Fri, 7 Nov
 2025 09:49:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:49:57 +0000
Message-ID: <991f6d36-81e4-42d2-b301-0755fa00ffde@amd.com>
Date: Fri, 7 Nov 2025 10:49:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/amdgpu/vce: Save/restore and pin VCPU BO for
 all VCE (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>,
 "Dong, Ruijing" <Ruijing.Dong@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-7-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251106184448.8099-7-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e56daaf-92d4-45c0-ff37-08de1de30239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDZsclA2dTJVQ2NJOCswdUdkUmNWYVE0Vk9odWpNWDFzdGwybjRJL1JOblJI?=
 =?utf-8?B?blprM25VcDVSTDI3SjRSWVY3ZWEzZnFKVnFZVi85OUY2MUhDZ055eVNuTWR2?=
 =?utf-8?B?MmVPM3FZY3pNOTZOcUtMbDlndG93K3pNOGk2WE5UbVE0UU1yYW04ck05eDdS?=
 =?utf-8?B?cm1TSUZaeUVjVnFzcWRRYXJscXQvaEFXNDZYemZUbkhhaEFRM1FQNFFta0hE?=
 =?utf-8?B?ZnNiR0Q4bnI1OWhheklnQ3ptUFNEL1pTMkUvSjFNQzlPVU9DdHplczZYMGhs?=
 =?utf-8?B?MDBydXJkaG4zclpQK24ycHY1MDZGNlFERFllNnIwL05jeEtGeEtSdWxEakJy?=
 =?utf-8?B?K2dDRkhGZDZTQ1o5bm50ZEJGSmxzd0hnd3JZS295akIxeElmUnFpVlJXNmZy?=
 =?utf-8?B?SGlUU1VTSVJ3ejVEU05vTU8rNU9rTUUxc1NBaitBdjNTRXVEbVUrSVJpei83?=
 =?utf-8?B?TXc1VUUyZ0R0aWpFd1psYk1ueisxYS9WQ2V0R2t3dnQ5eE5GUFZsRHZYUlJO?=
 =?utf-8?B?OS9oTEtzUlJDeEQybTYrSjhpSEQ5SkFQTE4rNitYWVpVM1k5STNFd2pNdm9i?=
 =?utf-8?B?ek5SUDEyU3Q1cWs1UDdyUVJhaUxkczg4bXMrUEUyTVBMRERHcGpUM3RmZ0Vl?=
 =?utf-8?B?M1d5TWF5cjV5QzRnRWwvSHpLZkFjMjVlUzBRYmJ6VThyVFRFeGMrYzE4M1Bw?=
 =?utf-8?B?UkhjM2FCOTRBK0N6VEtmTS92Q3J5amgvRHpFM1RHeE9KUURDeGtSa2w2TitH?=
 =?utf-8?B?SEVIeHVLREJCbE5Fd21yQmhFb3dnVXU2M1F3V3Y2N0o2ZGdmcmpDdk05SEJu?=
 =?utf-8?B?SDRqY2dBeG1EdFc5eGdaRDcrOGhaLzRxZ3owNndzaFZtNTY3MUtNSXVJdnpD?=
 =?utf-8?B?QlVrejJ1STY0K0s1ZEpJSWRjcmQreXpkYXIwRU0rK3pCT1RnK2JFR3ZoSzJB?=
 =?utf-8?B?Yk9sckU4VzhOdGxnTzBMRUw2SFM3amlHTFNHWXJvWFpnQTlzY0FHa003VDUw?=
 =?utf-8?B?TTdsUWUvV0ZPdTJkcy9oYzlHQ1plTVVlbUlzTnoxZURlZ2swWklvVndkMm1m?=
 =?utf-8?B?WURrUjZPM2I0cDRCMFh3cDloYU1aeTJjbmxuZmNsd3V2aHhFbUw0aWdxcktJ?=
 =?utf-8?B?WGFkZUlPMXVyOWVWb25BK2lMbWM2VzZBeDQ5YzdDL21qWXdrZy80Ymh4SU1K?=
 =?utf-8?B?Zmw2NnpIbllzb0k0d3NJUG9rZVlVbkdmZWQ1dGxOVnpjTC8rdHB6anNVeldo?=
 =?utf-8?B?ZXhjOVdGNlBrdGtia0pBMFJUSnJSRXlZMURKY1U4RXltdUhNNm52MWNWZStV?=
 =?utf-8?B?NnBRS0NzdjhLU0tXWFEyK1ZXSGFXbzJtNUFCakpoVWlPMnk5L1NKNitSWkhz?=
 =?utf-8?B?SHpVbFZlWkVTMWVYSmVrTVZIRGtUcEN1NE13TUtDRUNzeUNDT2dVblZ0K1cr?=
 =?utf-8?B?M1lpaU04cmFOY1lqSUUrSTF5QURhUEwyMDZ2UEI2UmtIZUN4MHpmT0hqU1Mv?=
 =?utf-8?B?RU1yV0dOZ3dvTDg4S2NtQWRUNHJtWldPbXBtNTc1cTlrQWpGTHhSc3NkTElk?=
 =?utf-8?B?QUxzQVFCVlgyUWw1TUJKNUlIVGxvaFJ6M1R4UDkza2V0ZXh6TDlIUXVWcWZV?=
 =?utf-8?B?REQ1eElTMDcydUhRWWZDZTZCblFvNkRFZW9hWEZKek9ucjIyNkt0QURjNUlR?=
 =?utf-8?B?SCtuTFdLazVKUUxZazBtb0Z0alR5S05mZjVVZ0kxYzR6MHU3c2Z3bWwwTGMv?=
 =?utf-8?B?YnhtWFF5OGdaYWZiUzh0cGhtLy8vcEdiQWFvSlNwMFZBeURqZUxiTWNiUFBs?=
 =?utf-8?B?VTV4ZklVMWZaQmppSFQvWVhNU2RaV0czUE85c2pRT3loclZYSFIzaWpYNC9V?=
 =?utf-8?B?WWpMNlZmamplWS8wbEpLamk2akt1cjRiQ0plcUlzb2t4enAyMTZiSWtkZGxX?=
 =?utf-8?Q?1tpJdZzWJlEN0kNs9h4MbVD+qaWo+Bxk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZ3eWsrQ0RrOFdHb29DdlI2YSswRDRXK1BCVmZaUXZ1OUZlZjRYVWZWMEJw?=
 =?utf-8?B?YnUwdHhBS0dGODdDOFVnbUdjN1B1c1BZNGo4blFpVU5PSjZZODJJQTRuSXV2?=
 =?utf-8?B?SGVnM2N1dXRMYU1NS0o4cGFaRUFNZ3ZOa01aMlpySVRuUmg5eFZpY3YrR1lL?=
 =?utf-8?B?R3hHbHM1UEdYYWdxcXpucnAvd3A0bHRSR0t1Y0xkVzdEMXoyS2NURXNaemVH?=
 =?utf-8?B?MmNxaWo5MmxDOFBCWkxZcEZOc1d6b1Q4RU1TTC9zSFJqOGlBUUFYVEtpaGxN?=
 =?utf-8?B?SnFHUlFyL1l4WGhuOFFkVVhFYjlIcThvbWhtdWY2bkIwZ256Y2FDUDJZWm94?=
 =?utf-8?B?RkhaMDd6eEl6b0NGNkhXbDdzdGc2aTk4NFBmQzk1eXgrQkxlTllCOHdBZGs5?=
 =?utf-8?B?cFpzamZIR3JkMmNGS0NBOHpOVGZyTkFnVXpDSEpQdkFJVUU1RENsN25EWU9r?=
 =?utf-8?B?VkRaS3FCVUtKNERWejJUbEpSNTl6N1JmVDhmMmFWU1BrNlNuOGNYUldiOGNI?=
 =?utf-8?B?aS96R2xMVUFGR0xSSFBZNXBJUENIaEd5a0dxazNQQUlaenFTUW1HK1RwVnBL?=
 =?utf-8?B?d2VaaXYzYjh4NlBtM1R4WC9BcmFGM0pXWE82dWVyc3d6RDlmVE9oMXdxQU9I?=
 =?utf-8?B?aGdwUXpMdUpMKzIzS05RSzhvTzZ3S0Y2Z0hjeEFiTGtwbTBPQlR4T2tMRWRk?=
 =?utf-8?B?NlNLWFVxVUlaWDBvQWdYNUFmUnBKOUxmVVpDcG5lak42U2c2TnlnR0pZczJh?=
 =?utf-8?B?azdHSW54L1N2WWpYd0JuSG50dkxNVTN1V1JDT3RtekdhNWNiM0xOdEFrcm5r?=
 =?utf-8?B?U2VsOTlsQ3JBWXUzaFZobHRwcENNWnlIaU1rRGxiYmhBbEtzTzFOSW91RkNj?=
 =?utf-8?B?SHpKQmxNbmU2OStiV0ZYLytGQXBBNzcvbnlubXA5K05tOVhxeXM5SkUyMzRZ?=
 =?utf-8?B?SFNxM1l6SnpBbEhQd3BNb2U4N3BkWkU2SUxabS9OWitWWENkbWV3SlhiaVNB?=
 =?utf-8?B?ZzFoNXc1bkdnZ0REWWM2dXpsOGlhVUNhM1VNa0lzYS80aTBYM1YyT0xZdDhD?=
 =?utf-8?B?czJKejd4MkdIenpzN094THVhNGVtbWpDbFNOZC9UVG03YTdyVTBqS2hDZU9v?=
 =?utf-8?B?dU1LdDdPM3BoQVZNMVdnVytGUm50TGRNalNGOWlRa1Z2YjZ1SWNKR054VUhl?=
 =?utf-8?B?b0k1Z3Q1ZDJrblg2R1BVRGk2NW5IbVduQUdFSWVvanJ2dnhyRUdGWHBJM0Ju?=
 =?utf-8?B?ei90R1lvSnRjNnlOWjJQVFdBU2ZybitGVFJJRTlFbytIc21UUTlPMk5yMk5R?=
 =?utf-8?B?VlZmMUNwYUNuUkVEazhtYXQ2a2tkclVTOGd5WHVEMk9kOUlnbVRpMTdMS2ty?=
 =?utf-8?B?SFlEODF2ekpJSkpWamNUemdoV0xMMWFYMHFvOG41SEtqbEpWc3lBL3pBYU9k?=
 =?utf-8?B?UGRWaHpSWFpBVGFPQkpXZ2d4YXhEM2x1V05zSDlmMWtOd3BjbTRCeFJKeGRO?=
 =?utf-8?B?UmhGVnkxdExSbGlFYUdFWlhtSC9PSmI5MXBTcStTemtkeDV2NVNZL1hpTS9s?=
 =?utf-8?B?VVl4YXhqd1NXTXU1WFhDU1BFY2RpWXREb2hrbHpvNHZ5N0FLNVZzT2d5QTA2?=
 =?utf-8?B?ZVFFQmxvVEVVMXg5OExjL2tLZXRDdk5mbDFPd2JSVTRucnN5cXZsOXBEZUZr?=
 =?utf-8?B?eWFZSWh5TVlFVWN0LzVwaHFqN0s3VVgzRTBxVVJXK3Q0T3gzelEzd3hjOTRS?=
 =?utf-8?B?bkZuamJRM3cvSFNNK3k4S3JiUEg5RWgwWEhRN2VKeGdoZEhwdHNEUG1YY2tV?=
 =?utf-8?B?b1BycXlKMCs5NFNuTFh0clUxa3p6TExKUm11VU1VWVJ0N28xMUlaMWlOOWxV?=
 =?utf-8?B?WjBrQWFLRm1jeHFLL25sVUcyM2tuK0Q5UER4bFQ4cFdKYXpKVWoxbTdRNm1C?=
 =?utf-8?B?Uld1N3ZpOFBCQnNBT0dOYkdIRUlHaWx0U2d2akRDNkhLaHNpazFWNlVsZEtL?=
 =?utf-8?B?bWtzdjBtck96MzdRVllFaERXejBCRXpUczJrQk5YTkw0LzZUeE1HR3ROVjVy?=
 =?utf-8?B?K0R6am9KMXdkVnQ0V1c1dTVVUnJkN1lLY3dLalR6SUloaVZORzhhaFM4ZEdP?=
 =?utf-8?Q?HQiB4kHPdbGLF/0FOKGY01fwK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e56daaf-92d4-45c0-ff37-08de1de30239
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:49:57.4534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4D4d6rzT8duVZGPk7P+h1JTUagXcoCJ+a2uB9SJZROd2c/U3nb2iN7ZnGzxHpCn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756
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

On 11/6/25 19:44, Timur Kristóf wrote:
> VCE uses the VCPU BO to keep track of currently active
> encoding sessions. To make sure the VCE functions correctly
> after suspend/resume, save the VCPU BO to system RAM on
> suspend and restore it on resume.
> 
> Additionally, make sure to keep the VCPU BO pinned.
> The VCPU BO needs to stay at the same location before and after
> sleep/resume because the FW code is not relocatable once it's
> started.
> 
> Unfortunately this is not enough to make VCE suspend work when
> there are encoding sessions active, so don't allow that yet.

The question if this is the right approach or not can only Leo and Ruijing answer.

If we can get VCE1-3 to keep session working after suspend/resume we should make this change otherwise we should rather make all old sessions invalid after suspend/resume and only re-load the FW.

Anyway I think you should make the removal of "amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);" a separate patch, cause that seems to be a good cleanup no matter what.

Regards,
Christian.

> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 44 ++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 52 ++++---------------------
>  2 files changed, 24 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 2297608c5191..4beec5b56c4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -206,6 +206,10 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>  	if (!adev->vce.fw)
>  		return -ENOENT;
>  
> +	adev->vce.saved_bo = kvmalloc(size, GFP_KERNEL);
> +	if (!adev->vce.saved_bo)
> +		return -ENOMEM;
> +
>  	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>  				    AMDGPU_GEM_DOMAIN_VRAM |
>  				    AMDGPU_GEM_DOMAIN_GTT,
> @@ -254,6 +258,9 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>  	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
>  		(void **)&adev->vce.cpu_addr);
>  
> +	kvfree(adev->vce.saved_bo);
> +	adev->vce.saved_bo = NULL;
> +
>  	return 0;
>  }
>  
> @@ -290,13 +297,19 @@ int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
>   */
>  int amdgpu_vce_suspend(struct amdgpu_device *adev)
>  {
> -	int i;
> +	int i, idx;
>  
>  	cancel_delayed_work_sync(&adev->vce.idle_work);
>  
>  	if (adev->vce.vcpu_bo == NULL)
>  		return 0;
>  
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		memcpy_fromio(adev->vce.saved_bo, adev->vce.cpu_addr,
> +			      amdgpu_bo_size(adev->vce.vcpu_bo));
> +		drm_dev_exit(idx);
> +	}
> +
>  	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
>  		if (atomic_read(&adev->vce.handles[i]))
>  			break;
> @@ -316,40 +329,17 @@ int amdgpu_vce_suspend(struct amdgpu_device *adev)
>   */
>  int amdgpu_vce_resume(struct amdgpu_device *adev)
>  {
> -	void *cpu_addr;
> -	const struct common_firmware_header *hdr;
> -	unsigned int offset;
> -	int r, idx;
> +	int idx;
>  
>  	if (adev->vce.vcpu_bo == NULL)
>  		return -EINVAL;
>  
> -	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
> -	if (r) {
> -		dev_err(adev->dev, "(%d) failed to reserve VCE bo\n", r);
> -		return r;
> -	}
> -
> -	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
> -	if (r) {
> -		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> -		dev_err(adev->dev, "(%d) VCE map failed\n", r);
> -		return r;
> -	}
> -
> -	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
> -	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -
>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
> -			    adev->vce.fw->size - offset);
> +		memcpy_toio(adev->vce.cpu_addr, adev->vce.saved_bo,
> +			    amdgpu_bo_size(adev->vce.vcpu_bo));
>  		drm_dev_exit(idx);
>  	}
>  
> -	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
> -
> -	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 2d64002bed61..21b6656b2f41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -448,14 +448,8 @@ static int vce_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -		const struct common_firmware_header *hdr;
> -		unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> -
> -		adev->vce.saved_bo = kvmalloc(size, GFP_KERNEL);
> -		if (!adev->vce.saved_bo)
> -			return -ENOMEM;
> -
> -		hdr = (const struct common_firmware_header *)adev->vce.fw->data;
> +		const struct common_firmware_header *hdr =
> +			(const struct common_firmware_header *)adev->vce.fw->data;
>  		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].ucode_id = AMDGPU_UCODE_ID_VCE;
>  		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].fw = adev->vce.fw;
>  		adev->firmware.fw_size +=
> @@ -506,11 +500,6 @@ static int vce_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	/* free MM table */
>  	amdgpu_virt_free_mm_table(adev);
>  
> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -		kvfree(adev->vce.saved_bo);
> -		adev->vce.saved_bo = NULL;
> -	}
> -
>  	r = amdgpu_vce_suspend(adev);
>  	if (r)
>  		return r;
> @@ -561,20 +550,7 @@ static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int r, idx;
> -
> -	if (adev->vce.vcpu_bo == NULL)
> -		return 0;
> -
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> -			void *ptr = adev->vce.cpu_addr;
> -
> -			memcpy_fromio(adev->vce.saved_bo, ptr, size);
> -		}
> -		drm_dev_exit(idx);
> -	}
> +	int r;
>  
>  	/*
>  	 * Proper cleanups before halting the HW engine:
> @@ -609,25 +585,11 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>  static int vce_v4_0_resume(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int r, idx;
> -
> -	if (adev->vce.vcpu_bo == NULL)
> -		return -EINVAL;
> -
> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> -			void *ptr = adev->vce.cpu_addr;
> +	int r;
>  
> -			memcpy_toio(ptr, adev->vce.saved_bo, size);
> -			drm_dev_exit(idx);
> -		}
> -	} else {
> -		r = amdgpu_vce_resume(adev);
> -		if (r)
> -			return r;
> -	}
> +	r = amdgpu_vce_resume(adev);
> +	if (r)
> +		return r;
>  
>  	return vce_v4_0_hw_init(ip_block);
>  }

