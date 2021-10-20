Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB44C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB633611C6
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB633611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728C66E301;
	Wed, 20 Oct 2021 13:56:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE326E2DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 13:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSY0ME/WbDLNRuB8Wm7hcESlRo3Z3k5pQS8uUmASLCqH3oQcM+ktFv/3x4+EXY3n1SsDjTAZDEs+qwuxyMvNf2K2MKY0dbNhE8fJkr7l97c+MyJZVXgD5z5Y4/3vV9DClO6KxOq46x2zUpWNLl9PV7afK82U6ozBAkC4G83QO11svFj99f+g3AgRdRDySy0VJUdpT3UAOTsh29DfZqeF5VfZjpTENn6F0u6RVWUHCMTmv9kzuQUASnpRwOTuBMu07WMD+XF3b9OYarWBbF2si6e0sKwt8Zf9m5+/mSJyWi8si/lou6UJDsBuqDVEl16bnh8lZ4odSthKNwpXYYlejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azoXEwU3JaTdbp2nMtPP+/8uomIcq5ioAaP11WNDCo0=;
 b=awnwWbWytc0AX7+eGZt5qPTMo+w37VX1u4nEvy7I+rkuymauemOqRZkjYIvEx2WG/o0NLAbAD4CpZh4fuCJT7+M7iuNEr3pYVGTxqGpl4a7DDRdz0HfXOE9VJQSg22zvDMvmId9J/+JL+PysLof90tNQN8t3gi3oPq3tvQKizxdgfJsU1H5DfM/WysOJ3VhmRnBQOnImXCqQvpeMHS+YtvzG4/fmdGneqplrfnOQsGMcBq187MLYRwsoiUDcPihxMDQakZmzR0BGwmxJAZO6uaNYBLsm8Wf0/FbHWVQBZpRnvv+26r5yrEoVxs+gzZPnSICBywd4M9OQ1mNsC0JA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azoXEwU3JaTdbp2nMtPP+/8uomIcq5ioAaP11WNDCo0=;
 b=BlUUfz/1EKltzkxrjiKeM+4Ooaz318+/bjK1hgZKb8MFZ10XD336D2aoF+/lCFl/H8+Qs90zmBKYlSh+hY4yu/JpxZVSFJJ3oCUd8zl/jytX/fLfGC99QUtnKBUpoZwwKoyVVy1baBIjFrtPyg4w6bMhNsnb4TNjoczLK0elLBU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 13:56:44 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%9]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 13:56:44 +0000
Message-ID: <16ed0e65-fbb9-6487-89f0-9d0d4e74e226@amd.com>
Date: Wed, 20 Oct 2021 09:56:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu/display: add yellow carp B0 with rest of driver
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211020135321.1011977-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <20211020135321.1011977-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::16) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 LO2P265CA0244.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 13:56:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c46304f-d823-42ac-38ce-08d993d17356
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5296A121EA0E227F7BA00B85ECBE9@DM4PR12MB5296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkMbKYTha3PF+2tcsrhW/h9i13cm+a+sIp+MpdawomHTP4YsQrh/6K+wYCguJAWtiwCAE53P/Y5sEiG09tJyh46OTJU+8Lo/vVze7oob0DFnpyeMWD6B9d0boKgjwC7GCCPaH2TmgsYlOT7nNj3Uk/YkTa+F5rfXRYor1to20b74Np7h0aFZ6grUgEEEUOvmw5P7xWeARqNnCgrqw3vVVPcHgWYjCWI9Zqb1a6V6mtRHhO3VRYgnQyMJ0KPt0QVGqdy6Nt3KJ9imB31bhOUf9HRxtP+fNb9Bn5YQFP0M5ZHEjS9adY5iHeewrONheV2nPtTj95CJ+S1mmJE1ci9wQij6vW7JcH29K3spfqnaH1ltzhScU8hT3bAMn6MRWovWVbjBp8S9eJkdk+uV+Pqw6/EKkRfLfvJrkWWW2wp7fl2uJdQPu6u2+wxet/Wm9kLyeN1i40NodKMk8o9qHGkwh7MzRauFh951kZnbrJvwK4c3rtKmGqNCPMS+YrHX/egKnFGf5ahmOX2ZR8T5aytgII38LOylKonS4tWtmaH1ucecrTcdXJi3lXCbs5SpJ82JIvSfnNCCxH3f+wVqKHpf5lFeSv9LhiyvhDR6JfIrzNTM+Vdujk0mHiJ5OhtiU7uDHVuW++Kyad+zp8WR9quAyaci4gzH4UrI/uSJ8zpP/3L63WHT9AeFh1SbaDzrWk1NRWejSmdjsJTH3cTZYTxJcg/ApWrBOcr63hzK/aAkvf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4744005)(316002)(6666004)(2906002)(31686004)(83380400001)(956004)(2616005)(66946007)(66476007)(66556008)(6486002)(4001150100001)(508600001)(16576012)(5660300002)(38100700002)(86362001)(8676002)(53546011)(26005)(31696002)(8936002)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxmZ01UWTVoMjFXalRqVlcrTVRvbWZtMEtyeTEwdkd4VFA3UGFxaGdCSTg4?=
 =?utf-8?B?SkpQMGQwS0prVU82ZnY3a052VmxmT0hsY2RkdTkzNEo5N3JtSmNZUkFoeDJ5?=
 =?utf-8?B?c2F5bTNWVFE4UXBhcmRiK29kcUFyemZ0YzRiS0NIUU1Va2NEcGpUVUw5c1Zj?=
 =?utf-8?B?VVRodXpRQWlvUVhVOVQrcUVSOXVMdmlmTDJHN29IM1hoVkovMjkreHM5NW5W?=
 =?utf-8?B?dHEvbmFDN0R5K2RYRjNmZlpKd3krUXNVY0czWkQyRE12MlhLaW5Fc1hRZ015?=
 =?utf-8?B?VmNlREpuVThDUVFsY2tINFBUL0VwNGczOGs3ck1Pd1JSRU9vZ3FLUTg1cTBr?=
 =?utf-8?B?S1R5SUx4OWpSSFFPSTducHFCRjJYQUlnTG16aUowdklIQTVoK3F6T204RXIv?=
 =?utf-8?B?UVVmL2FPVUNxQ0I2bklZbEFnZXpSYjM3czhZZjVVUmFWOGhzMjlGZTBpSjNt?=
 =?utf-8?B?Q1hZanQ1eFVCQkg4Q3lzc01ncEJRQy93NDVWVFdsUEVvdmpxMDBjSEZpUHMx?=
 =?utf-8?B?OUEvWGdDZExza1EvN0x4RVp1TmMvWnFxYzhEME5mTjRwTFBuOXE5dXk0OURQ?=
 =?utf-8?B?RU4rVzJIUEViVW5nM1hkbDRDSDFzTzlFdVo4OTduZjdkUzVzZFdQMlFkWGts?=
 =?utf-8?B?aTg2RkRISWQ1cndrMVhaUnNTOS9EdGhZaVExTlFuMFQ4VWt5Uk5JMXE4dWox?=
 =?utf-8?B?NXNjNnFocjE2RXhjNFFsMTBiTTdxSXBCaGU3TzM0ZEpPTzhJUVdzaEdldXpG?=
 =?utf-8?B?YWZ3eDRhYVBIYmJvNmZWK0pQNExRMjc4U0I2VndHd1FMSStXYnZTYnJ2Undr?=
 =?utf-8?B?YXoxSThrVWFUcGtrMUVyU0o4U2plN0FvV2U4MHRkbHpweU9RVFEvTENlbHlX?=
 =?utf-8?B?Sm1ibFAwSnNEekxPR3RuT252NzRtL2p4dTM4b04vT2ozUlNhRmZhcnVHa0tZ?=
 =?utf-8?B?WVhjT1pySXNtVzRTL1NpM0JrT1VuNDZnTHNvOHdjY3lva0ZDSDA4T0pZM05M?=
 =?utf-8?B?R3NQL2ZVd2Zzd2ZsNzZEK0ZjSmxtMkZwZ2ZNeVFaSno0b0lnaDFVRlZrMzRU?=
 =?utf-8?B?ZkI1RnFKNW5MZURzaE80RDZLUVlLNWNndnMyVVliTTFwYU5RNS8zd0pDdmN2?=
 =?utf-8?B?L2k5ZzZiOUdvaUI4Mzl5OGlUUk9STE5CUzBzb0NtTXpjNXRUWW9TVEw3UERH?=
 =?utf-8?B?aDk0UDlPMHN1dWRpcS9vbEFyeTE4RDlBYVBMbGJZb3daak9pL2lKWENGbzBM?=
 =?utf-8?B?Y1BadkExMkE3SjloUnlnVkZFaTI5M3lEMnllallUYitsTXF0TlNmdVQvek9s?=
 =?utf-8?B?WDRyUXJIVU1BRG9rMmg5R0hIMFArNmxuMVkyTjliWkVlYThRT2MzS2prNk5i?=
 =?utf-8?B?WnduSHBnbmpKQncyT2FUemVMNkZIaS92S2poNmE2MVE5d0NxYVl5VVJXMjRr?=
 =?utf-8?B?TEs2VElYOUQ5Y2JxUGdsS1hQc0U3STFBZ2NOMnRjZitSTGhkYXJ2MWlGdUtx?=
 =?utf-8?B?Mm00ZkZHS2tlQXNBaTc4dVE0UmZUT25WK3NTYVY1R25OcERWM09DUFBDY3dT?=
 =?utf-8?B?VzVMaU5qcUN4VENNajY2S28rVWU1czdQeURld21zcXArbDhIWkRYOUVZTkhH?=
 =?utf-8?B?NkZnc3VZSE0waFVLSUx1bDBENk91Vi91SXVaTFl3UXhpclpFK2FxbVBwV0da?=
 =?utf-8?B?aFQvUSt6NnVaQm9NU1NNL0NtY1dhR3paOHlqdG9mSm9HZzErcVJNdFNZUG1l?=
 =?utf-8?Q?gAQ5uRwHhJ3EnragZzvgu7joTMYQ7xTxgua88Ep?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c46304f-d823-42ac-38ce-08d993d17356
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 13:56:44.4274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzcDpGd+1UW1srRNri7qgdhmYggnig31doHv1fGkDT7jx4AZtqhUjEKnNV3kIsRz01EItXGfU4LbuVtDuFzLeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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

On 2021-10-20 9:53 a.m., Alex Deucher wrote:
> Fix revision id.
> 
> Fixes: 626cbb641f1052 ("drm/amdgpu: support B0&B1 external revision id for yellow carp")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index a9974f12f7fb..e4a2dfacab4c 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -228,7 +228,7 @@ enum {
>   #define FAMILY_YELLOW_CARP                     146
>   
>   #define YELLOW_CARP_A0 0x01
> -#define YELLOW_CARP_B0 0x1A
> +#define YELLOW_CARP_B0 0x20
>   #define YELLOW_CARP_UNKNOWN 0xFF
>   
>   #ifndef ASICREV_IS_YELLOW_CARP
> 

