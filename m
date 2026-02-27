Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB4FFD7F91
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 10:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1068D10EAF3;
	Fri, 27 Feb 2026 10:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L48OTEuw";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013049.outbound.protection.outlook.com
 [40.93.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446E610EAF3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 10:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwoY3ggylLbK5SzaAeCG+R9KLz6qMEx99hVHQFK/gdhqiHezNM1r2X5KLMW37bJOfwB9hus3Ucy+nN0gt92us0N2JpCY7saYZnqGtB0dHzFQ5OtLqQOQhfJyWA/D0QvdYGQvwLStOG71kT90F5Ijpfasz6cSrXhDcICV4Sm5nHjqlDy+vfKzobHVzay7YDqGoYIdQX8UmolT+/sqkwx5qYp0O+4UrKBQJFemkPC4krZjdZhPrJ61t7tnqo17TMEstr6zXH+lv42PiJOmgMmZtJT2h2BFIlya1gMI+d36vgZlLPqhlF5+/PEWcwJT3+VafiJvGTVb3uEQ8NEWwob7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ti+rPlYfoGhQ1Qes5PRQBho3CvLdtCsjJyj9HClZL4=;
 b=p+sopjJcnjaRiXqahL/uUKZJq7LO0ii3f5MojdXeBunk3BxOf8K9s6zS8Ce+nn20+C2TnJ6K/FhmxMzHdt63G5hRGSacevfD//QtcZEec3GFpV9awI5Wd/Mvj0tCqrRmo5MaQdUhk8gXD4yKBjl78/+SJ5Kh04UR9IJuQ9aWK7j9+uKInDA5o6GdAIVRdDB9BJ2chXfi8BrvkslzoJfAfXcF7ZgoDvhW/KSQSpg7G7MokFYu1toYcjVYhSP/R1Me6C0RpD14cYgi/FnKmFgkXpfetaTkh0f9KC4JJkisvEPXgVPgthVUE2EcsI0bqxzslDckW1xf7upM4SovsiqjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ti+rPlYfoGhQ1Qes5PRQBho3CvLdtCsjJyj9HClZL4=;
 b=L48OTEuwLNhij3Dh+DmrHJRKoyKHFcPpQz9uMQ7NTxIR/uBLApE6RKAscpSkFFYULTIoeIGkdV6WCK60UC7/rNoV5D3LQI0c2kjU2/9FdOJZeSPYo1oWUmh8cGCaBDLDKN8hkAr0Q4X+1OL0swCw1OMZrl+j3bXPvuLnoTcInVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 10:32:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 10:32:43 +0000
Message-ID: <41773dd1-0929-4c5e-9c67-07262ee299b2@amd.com>
Date: Fri, 27 Feb 2026 11:32:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update type for num_syncobj_handles in
 drm_amdgpu_userq_signal
To: "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260226155146.3727191-1-sunil.khatri@amd.com>
 <e93f64b2-8157-4cc8-b4b9-16572a8cd022@igalia.com>
 <490f80ef-6614-4ba3-8183-fbca7698f8da@mailbox.org>
 <6e1ec357-6858-48ae-9447-e915fc946417@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6e1ec357-6858-48ae-9447-e915fc946417@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0064.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: af1abdb9-42a7-4790-376c-08de75eb8a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: CopQE+QD4D2ilZG3nBY9CbBgjrUH/M11/wVvVmPd55g4QEjOWRq5C90Tj9kFigQ1LcwbYdEHt0J62aOOCswNBVzNyYFFSqy8F4G0Hpikw6lHEwdn04rakEep+GabCKYsbij02yj+pse42J7CtHu/GHulVO5ePDqWGcIST7km/7Hcr3w9zmyNEWYcyZRC+jrgX3ba2hL+aXpANbLslbm74uiDELz/zf6nU37z2LL5fBOdfCd3yaTpfu6XKyJ7lHpwiU21ji6LGPQdGFYdUn1dlCeMHQmRnzCXoqTDlkr71rNr2FsiXLWQuQvx7+mDpG3p66hb9HkJa35DYhEsQ+ol7/LiPS0yKvFZk0xpYDDQty+lb/FF2B1wW/wv8T/kX2D2MZW6Byh9Q4ksR3lXWC2vdCJpteRVOfZiFVQp7/iWY4t0GRlhl+yOeAOGQViX8/J9km+7uYwcmjei/WBcuhSnPDnKXd8PxTz4w1Kc+uQHcPOc3JKVeB+PJUgnYbaEuPLFSPfqapzMAoQCp7agNvLw36HZmRT+JnxB8Z+yQVpdlIENmQRQuo5muAIZx82kzmE9RwLwRwEQcipfQoE2rTrIluMoMq0qxhdSJBV9vstsAoxa6cQoCf64Cwrhu1Z2ZMVsWehMjQb35CdbgPnR3pS+MmYh9wep8VRQClXQiVTjwhv5R/KoAnnNfyE9XrYurDOvwLVaQ3KuCTRNQYU4QkJx+YKFzibL6XxkdA8dUmWLSQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9WU0VaWUJiVWl0SEZUQXQxcFhCeDFFdSt5SFZQdSsyKzN0ZmpqVlRXK1pZ?=
 =?utf-8?B?YUJ0RnZXVVVSTmRJZGtaVmRKdlpJd29uSDFONXl0SkhwcytvTSt1eWhuTmNJ?=
 =?utf-8?B?TnFJbmFEbjRWMGo0bGNQeVZadU9yaTM3T2tnTmFXYXI4TjJMQXNjbmNDU29I?=
 =?utf-8?B?VW5NcW1rWEpsRHhSbTdvQ3FLWHhKM2QvWEdXVndvbHZOOTV5dHYweFRhZzFl?=
 =?utf-8?B?ZFJSZUlibXQyT0pESTltZDc2L0xETHZ0bkRPWUJDbG0rV0xIbldQMUNrekVP?=
 =?utf-8?B?YzZGV1gxUnh0dWxFbGJ0WWMwN1J3YjZEU2FLVW85cm5KNlFjL3F2ZHVqL01O?=
 =?utf-8?B?c2VwNmsrZHRORkpvUVhmbUxHeVdYUDJaZzVZL0pBRWloclpHZlNJMmIwUUxN?=
 =?utf-8?B?YmNtSWxFaXJ1c3NqL1N4V1owSTNZanlSZTV6NFQzTVRRbFMvVVpLTFBpVW9L?=
 =?utf-8?B?N3JkRDJ4NGk2SWdINVIwK2wxSVZrUXlJYjkvWDVKU1g4RnBHMC9RQWZyOXI0?=
 =?utf-8?B?TnRiWHpuY0lpQ2xtTGx3Q2lJZXc4UXZiVmJwZlVVdC9GVVFueXplREI2Sm03?=
 =?utf-8?B?S3BJaStkL0t5NTlhTzJBQXZadVBwV3habnBsa1NTZDJkY09wMlM3c0tJeVJU?=
 =?utf-8?B?WTMwVEcwRE45VkJGcENSTTg3L0tENU84L1VIUzdzeFk4dk42NWJXbElLbnVU?=
 =?utf-8?B?cVlTbk4yTnExS0dYMk9DNnRRSnJXbHh4dzRVSFNjS0NjdjVlbldDS0szODJZ?=
 =?utf-8?B?VWh3ZTdha1ZIYWJHajZIMVZUMlpKUFRSWTRKdWo5VmJQTXBGd0cwbVJWY0RR?=
 =?utf-8?B?WHp0VFFpWEh4UlhHTFRjS3ZSMXNRWGNMZXFldUQzSHpacFVvczMrZE1va0Ny?=
 =?utf-8?B?a1R5bDM1U3FMZStCMERyZWltN3p4TmdzL3BCcVc2d2Vya2VTR01HVEV0Ry9j?=
 =?utf-8?B?R0pOL0djQlNSRFFDVE1wZ3Z3bElsTFc2YVBBZ0lXM1g1NWpIMW4vbStCbDVF?=
 =?utf-8?B?bDg1NElpa1Nnc2pSekFzclh4alM1S2tPVUJOeHN0ME4wMTZhdUd6ak1Fd2Fs?=
 =?utf-8?B?U2ptdjVoQUdOS0ZvWGk4UDd6SkdwN1BlRzNaZXpwK1IzQzVzRURyOWVUOVBq?=
 =?utf-8?B?T2lnUUYwL0x1aXNJb04vM0pVQ1JyZGIzbk5JMG82RHpiZzFTc2hKVEp3UzhK?=
 =?utf-8?B?RHpGaDkvSHN2UVBFMjFmV1dUaE1JNXp5c1BNb0hnUGtnY1Q4QXlvbXRWTTcv?=
 =?utf-8?B?TzdsOEV0ZlNaRFNrYVlldlVqY0UyMXBaNjBveDVlNURKcE4rUEJoenZ3cmtP?=
 =?utf-8?B?bTBSRGtGM09mcld4azZZZFpwZ2JGbnpqbWthWkVTWkFBQkJNZ1M2WThlN3Zt?=
 =?utf-8?B?VE1XOFpqdXY4ZEhxQzB5ZTJPTXF1UVh4SzJsa0V3QUdWL2tXNFVlZnlCbkVC?=
 =?utf-8?B?SnZVc3ZPbmZkVi9Ic2ZYL2ZZZG93YUJMRjJ6UzZHaFJ4akdTUmFPa2tXbWpX?=
 =?utf-8?B?QU53Y1dWb3YyZlY4clc5NDhzcmw3MDh1OGJxb1pHSDJHaHAxVWtPeVdseEZn?=
 =?utf-8?B?NCtMeUlXOTlySE93MWNJZHBUd2VMZkdNbTdNbFJsZ1o1Rm4xREJKYUtGam1m?=
 =?utf-8?B?eG5OZlQrUXNyYjJtdjBBWWlGZW5LcDBORVFCOEd4V01NYUJmUHpkM25iVDFm?=
 =?utf-8?B?NFkxZVhEZWFLY0dzNDk4MnlkaHhjUE5zM2h1SWt0WVErOEJOMllKK2FCZ1g0?=
 =?utf-8?B?TDQwNUtQbXBmVkpIWnFTcVpGaEZUcjRqOXJKYitreGdEaEpQRS9IaGtHb01j?=
 =?utf-8?B?ZER2QmdkZXBPczR2ZUlmbUJ3NVlDL1NMNFdqeVpMeEN6U2pyK0ExWGJXeU5V?=
 =?utf-8?B?NHdJOTFkVWl0UE5GYUhGcjUwK2FNQWRDRFNRd1VtUk1iL1JESFRSNWlOWDFz?=
 =?utf-8?B?VmFIWWRPU3hLNE1hamhpYS9tUmdkQ1loM3UxNjQ0VG91OGpLVmlZZUtBb3By?=
 =?utf-8?B?bDRKQTEvMndMYVh1Wm1RQ0JhVUJ6d3lEWjY2azE5VkdubGtMQW9sN25xbyth?=
 =?utf-8?B?eGNXdERtbitpTEIwMjBldFhYd2RKV0c1R3orNSt3K01zTzNWRXZSZ3drbTZL?=
 =?utf-8?B?VGYzTTkyTGdwajY0bUNubFhwZ2pBUlBET2MvelZZeDlidi81K2wrdVV0YzIr?=
 =?utf-8?B?dEZuSDRKL21uU2tqdU9UYjVKdXFHZllyTDBMY2N2c2l1cG1Ia2tINENEU2pC?=
 =?utf-8?B?MGRIbnlKajhtdEM4S1dUTTRidUI5V2xsZnRySjg4dDFIM05ab2IzTHovY2N5?=
 =?utf-8?B?NERhYzVWS2x0VEtyQ0hheUp3bStKUUlhLzZiMlpNZkI0ZG5lTTdZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1abdb9-42a7-4790-376c-08de75eb8a55
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:32:43.3118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvsiKRbWdnDr4oH6sIgH65PExZ0crJ+zAtWvodYX+h5pIl1YL+gEZfW78zHMQ9rE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466
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

On 2/27/26 10:22, Khatri, Sunil wrote:
> 
> On 27-02-2026 02:43 pm, Michel Dänzer wrote:
>> On 2/26/26 17:05, Tvrtko Ursulin wrote:
>>> On 26/02/2026 15:51, Sunil Khatri wrote:
>>>> update the type for num_syncobj_handles from __u64 to _u16 with
>>>> required padding.
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>    include/uapi/drm/amdgpu_drm.h | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>> index 33e8738ce91f..42b4c0f6746b 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -479,7 +479,9 @@ struct drm_amdgpu_userq_signal {
>>>>         * @num_syncobj_handles: A count that represents the number of syncobj handles in
>>>>         * @syncobj_handles.
>>>>         */
>>>> -    __u64    num_syncobj_handles;
>>>> +    __u16    num_syncobj_handles;
>>> Could probably cause build warnings/errors for something which builds fine today. Hm on big endian it actually breaks completely.
>> Yeah this is a clear UAPI break, no go.
> 
> Yeah i am holding on this change for a cleaner solution. I acknowledge the UAPI breaking here.

This uAPI break was intentional. The functionality is used only as experimental feature behind module parameter and new FW anyway.

But we didn't wanted to break existing Mesa binaries for easier testing and so kept the ABI for x86 intact with the padding.

Regards,
Christian.

> 
> Regards
> 
> Sunil khatri
> 
>>
>>
>>>> +    __u16    pad0;
>>>> +    __u32    pad1;
>>>>        /**
>>>>         * @bo_read_handles: The list of BO handles that the submitted user queue job
>>>>         * is using for read only. This will update BO fences in the kernel.
>>

