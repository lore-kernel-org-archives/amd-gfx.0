Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281EAC4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 15:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DC710E62B;
	Wed, 10 Jan 2024 15:57:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3D810E62B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 15:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CppOE9DZIBkiWOzFLqGCbT1Ti0FTMIWAtvokhIBK441EzreBqPnecYkfHNUkhP/KlZrm51rIq0SZKS496pmCu65DR8PM5oxcu5pzm5mfophxqCjC5QXckU5YOHVhBQ2nxEusltfR19r9F7hn8/ltwgc9Arx3ojooPpToZ83X/jHs7GGCESCE67gpr2XCVtVTEVQkUppkyBlIqHytsbj3GzVcO+lqByEoUcOUgdp9hYCjTo1VMjaSfPBVIbGYn+ESVXwBvwsYqCa3nj7hdK6xNjY4acCOMUDsKqMFNd/2y5TABYsnfM636iJA9GqKH9M6Kk5UMUL1ew6Hcm7B+8qHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1MU0ERjW5W6LnXxP6tBoWJ5tLzJQud3CXhps9Yl+oY=;
 b=dn9gBiimxpwVQMEUMqcu5j2DexPhilv74uoV8W3cotWtzRxnzfBfIJULjImDskDkrl4WDyUdKyQdVkvr7MlNTU9cSxP77UCdhgOULkmkXLqSVm2+PQLp4Il6yPBr+QRtysO9mN1t7MgEw7DleJfOx5Nqe5rGK2mUkTMABRh5oI9mnQpDaSNnApnXpRgSHthe9EeiigJqceOr+EADChLBsnLaqTVeoK2E2L+yHCxxnMbCdHDPPi7sp7kIx9qb0P4lmreRoVwzKI3uQXRokRWjOmwnhqxkGA8FT4iBVdf/Ukz1sudLHg/qrW9DuzDsMbs7quhcoyC3BsYhunbARObyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1MU0ERjW5W6LnXxP6tBoWJ5tLzJQud3CXhps9Yl+oY=;
 b=I66LNiRXwIEC3/uVwD37Ru/NHqlHAGi98INYR9WyvamTjZNY+ojb9JbqHVEBYy1/aGh5gluN8ITjesij4gF7ScxPZzxWQkoQIhPmo56tK7TcC37cfIk3e/j1lxPwPj0EFW8SQclcja3ihdLEfYkp7ABS42t9B2VIeeXG1Lpcpgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 15:57:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 15:57:36 +0000
Message-ID: <7fde053e-b120-4d80-82cf-0a104ed5653f@amd.com>
Date: Wed, 10 Jan 2024 10:57:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix the shift-out-of-bounds warning
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240110093938.684930-1-Jun.Ma2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240110093938.684930-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f4c5cc-7411-4a95-4138-08dc11f4dbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPqXQklmmp/A/VMtCtRtWbzANlgJ9FRBwIbTT+lNjzemMdkcl24aAP+s++wBleP4iVQMNISymWhnvN9kJ+L+gxvKinTAxtV84Wfasctn/jmtJdT0Y2Rm4KYd8pEGyp2EWcftu5Sy/XKf7cTEucPPpssACF3HKp7PasDVSFC3+mIxWTzfkWxzvTVICjC6nIWm+HhIumMhQAxY4+sLVLxT8MGHheRizPi8kbREFp5O7T4vhjZPEULOMCaodivuhD+CLN+/ec0bHgvCu8F6/tmVAoBXdpFKX3NlAfxYgHaY0tMMRzT9NL550TLOr8BLvs9hDmTpe6P/SaSsJvryRptghVg1eFBEi7dYIjW48/e9wo52PqAfMK5GaZhVWn4PgYYxO42TE0kYkrmq41wMzEfEKKIX1Ebn7KxxYbwmJd0/IO/ymZY8Y8aGy1y4g5tjBVgSEibaNYkDpia0JIBqXtd+h5iRmlNoFGGO4mPeHN7reesMwAhSVyTreTiezsbvpJvT/Sexu+zcj2JFigLeEufo1lwkKpl+VlF8RoZJ8UGWV6KxGvsckbJzijJ9fLxBLumn0D8ofUuoemTe3wnbuEQmPLZO3z5VFNwPPZWtu9I+Ug/Os7aZciv60PCm4HHEskyGiyhtDo1pPRh6fhCtoEtyFNWjTxcsgKurw+/EzlNp/t7b8dauZ90/WMz9JUC9vmm6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(5660300002)(6666004)(478600001)(44832011)(38100700002)(66946007)(316002)(66476007)(66556008)(36756003)(41300700001)(6512007)(31696002)(6486002)(8676002)(36916002)(6506007)(53546011)(2616005)(86362001)(26005)(8936002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlHTU9iZm5ZSW1Ua21CdW1rRjUyTE5BOXRqT2hrQ09mOURWQ2VzT0xHTlBj?=
 =?utf-8?B?ekVzUnlTbDZ3dDZZVmJ6SVRQWnI3OER0NXhVNnllU0d5NzNmOHlPdlpOVTA4?=
 =?utf-8?B?RE0xai9HUSswUzZBa3VwaFo2MUlXckFGUk5meklMZzB5dWlPZmtRU0pHZ0Zm?=
 =?utf-8?B?WU8rNys0K25McUVPeld6V1VxZkNXRUhvWWpqT3hwenRmYTJwejI1MXJDRDB2?=
 =?utf-8?B?bVl3aGlxY2xJSjQ5azZQM2dYTmxKbk0zK0VKSEczRkRkdE50ai9lNkp2OE40?=
 =?utf-8?B?aCtBeWtUZERaSEhsVkxEUnNvNVI3Yks3QTZtcEd4Q1FheVE2bHI5MXcrSFlu?=
 =?utf-8?B?OGk3RFNPSWNIbkdOc2ZGVnB1cmZtakI0TGZmRTllbnJyWk9FMDdKQlMrRmVa?=
 =?utf-8?B?bXViY1NSeVJoTWhETlVkNmxxb0ZtSVVONVAvL25aZCtTYjNDZ3pzY2lGUGsv?=
 =?utf-8?B?VS9MczBDSHRNYmdPL0FMREZNWDYvMUhhb1BsVGZaUm1RREs0M2VJcnpyZnpF?=
 =?utf-8?B?Mjlyak5GTk5TWVZvbDgyYUxlaktsaXRRT0w4cmpEeDFnekFGZHpnUk5ObGNE?=
 =?utf-8?B?WFZVbXpxNjFHNWNkRlRpTjdPaHZUbWQxR2hsZy9QNWs3a0RKNy9hT1VvYllT?=
 =?utf-8?B?Q2tlRUdURjU5bE9IakYwMHMwRjh6SjBsNVZtaDhzWTB1ZUVoSllhL3RQV2F5?=
 =?utf-8?B?Z1RIcHNXK3VaS0NGWGphakN0Q0k2Tm9rWTRESllWNW1kaCtQT0FqWGJkbGtQ?=
 =?utf-8?B?MzhvOVloMm55M3pXY1h2TmRsZ0lVR29pUlQyR1RvTTdLSFNYbFVlOWl4Wmxs?=
 =?utf-8?B?M1RrLzRqM0xrTlZrR01vNWNobGRRcU5ZbGU3N2RZK0E3OHk1RUZjeE9teWpW?=
 =?utf-8?B?U2RWY1dlUFVCOTNCblhJdmk3TFYyaWpiblB5NjUvMHBPcS9Kczg3RnFpWHQ4?=
 =?utf-8?B?NTBzbGhlcUs2OGhJbW1jTEh4RklUQmJySVBiNUNCVTZlYlRWOUdvQzJjS3Np?=
 =?utf-8?B?Q0ZlSW9obmR3L2hCNFU0VUNhM3dIRU1VRlhkRjlleHJRb2xvamdEU2Q4Nk9W?=
 =?utf-8?B?aFJQQ2IwUWtycitYZ3RxSy83WFAxVFdyT3hFVEFOMmRlWStrU0laTzBLa2hJ?=
 =?utf-8?B?REtnTmxYc2JZeDl1b2pBM09KdjRMYnlJL01Lb1I4SUFGQVQyaHVrUzlCeXNr?=
 =?utf-8?B?VFd3RCtIa2ZxVEtIMWdGTFh0WlBteHVHWUFZdzAzc01yamthVENVRkZJTFdX?=
 =?utf-8?B?M0VBRDBpZGNXSE9ySmx4MnAwaDh5czJMd1hyNEdtcHFnbHdPMW1HMC9sWVRF?=
 =?utf-8?B?S2J2NUNDUVJYZ0tiazB4MElJaXdtaXh6bWYzbVJWekFsU2Qyb0xORTNQeHI3?=
 =?utf-8?B?QU5EZ1dxVGZvaUFCc1d4N3prYWc5YlJEdTlyZWlJUGtjM1daZlBaYXlGUm9D?=
 =?utf-8?B?QURZcm1LelY0SURxa3c3UW14dDl0WGJ6cUFYaXFGTGZzY1pzSGsxb3E2RGVv?=
 =?utf-8?B?NDI3Z1grc0pqUmlNODBjUkFXMXUzMGxjSGJDNk5ZaE1uM1U4OWVFRlF0UFE1?=
 =?utf-8?B?SnpIdUhCTCt0dldGZ0NNSVNuZUQ1YUpTRVJ6NzJuMVdhR0lndXQzOFZEUWZX?=
 =?utf-8?B?cGx4Mk1LeUpYVnhsY0UyTmJpNi9SV3l4K2Flc3l3ZFJPMjBUSmFDemROWGxD?=
 =?utf-8?B?bzlLSDJ0d0RZb3ErYWZsVCtxYWJnTHBvN0NxbzFHTTA0S2IzSGhqdTgxU2lY?=
 =?utf-8?B?TnBmaFU5NXo1bkVrZisyNVYvcUZhOWNsUjF4REdGZjBuOW0zN2kyQkIvdmt4?=
 =?utf-8?B?VUFaYjVZd1UrQ1hyQnZCU0RLeUFLU0ZSZEUwbVhjYkFFTjVkb2ZUaUpRSWts?=
 =?utf-8?B?QXBubnZmVVlVaFFIVjI3VEJrRWZHOExiSFhLZElKZHMwYUVQajVGSGc5RnMr?=
 =?utf-8?B?ZjNxN0JremJ6eDZ6Y1Uvd1czMW9XbE00aWl6QmJ6VjdKY3pWWXJCN0JWcDRF?=
 =?utf-8?B?NVh1d1htK3VhanRobEpSMmIrNWoyRnNidnFtcTkzSnhZNkovbXpOVnZVRTlh?=
 =?utf-8?B?RmNER0J3NVA1a1BhelRIbUpYYUFSamErUTd1dnl5T1lteEhkOUpUOU5rSW9s?=
 =?utf-8?Q?SsECKWe0ZZJy98jNyosRYqnIe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f4c5cc-7411-4a95-4138-08dc11f4dbb4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:57:35.9752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJOt+bG0evFr0TS0Ot6IkybDDTs7jKoyPMZO1ca3ahYrS1M69zejlgEULiu8As94VAidDS9OogpBafv51GmcoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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

On 2024-01-10 04:39, Ma Jun wrote:
> There is following shift-out-of-bounds warning if ecode=0.
> "shift exponent 4294967295 is too large for 64-bit type 'long long unsigned int'"
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   include/uapi/linux/kfd_ioctl.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 2aa88afe305b..129325b02a91 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1004,7 +1004,7 @@ enum kfd_dbg_trap_exception_code {
>   };
>   
>   /* Mask generated by ecode in kfd_dbg_trap_exception_code */
> -#define KFD_EC_MASK(ecode)	(1ULL << (ecode - 1))
> +#define KFD_EC_MASK(ecode)	(BIT(ecode) - 1)

This is not the same thing. We want a bit mask with one bit set. And 
ecode=1 should set bit 0. ecode=0 is not a valid code and doesn't have a 
valid mask. You could use BIT((ecode) - 1), but I think that would give 
you the same warning for ecode=0. I also don't see BIT defined anywhere 
under include/uapi, so I think using this in the API header would break 
the build in user mode.

Where are you seeing the warning about the bad shift exponent? Looks 
like someone is using the KFD_EC_MASK macro incorrectly. Or if there is 
a legitimate use of it with ecode=0, then the correct fix would be

#define KFD_EC_MASK(ecode)	((ecode) ? 1ULL << (ecode - 1) : 0ULL)

Regards,
   Felix


>   
>   /* Masks for exception code type checks below */
>   #define KFD_EC_MASK_QUEUE	(KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |	\
