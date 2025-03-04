Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BBBC021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 18:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F247510E0CE;
	Tue,  4 Mar 2025 18:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ibNTZKSy";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D555B10E0CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 18:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToSqENtuzNCmIklHaMVnXIiPuwU0JEvO4xIe6jNcmCXxFmXSpkYnIC/bThtJjskKBHsqTTL3BWCYtS4cRzD00G+Tgf/V2+c2DfJMz/lWAlrB0La6ZE51bhYjl8kkIGyVBMTlfLJ4NLJPKk29sSbkE1bCCG+BQAs0ew2cQEZ5ajfIgpAWu7K1bfKP6FH2bHJ6zhxTTkoxXTEoJUuPIABTnKJolGZnJdcE1GF7jnZPx7MZ4pM5ZCdvtG0w9iVAkGnghFDRyJBCIzgukfXMpbn+1hFOdVxUxzwpuoK5wyzyoaV4PB9GLgxuL7Uimf2rlNP7UhyUtf+nPNA7nFWVTMaj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFh7hI5GRAhsV0NVLGhj2mawgtzscoClduTuqUcrgj8=;
 b=Ga2JMK4u3AuVFx7orm9t/bRWWr7QMlA5a6Kbv6An195hZfogaOqZgOrC3Q7KXDtPgmIYHtDr+VEkOHwi7AbGES2Y0QWMZjETA3WLmwgWEJo8H8DmqGlvceBsDdxCbXZE0THqkoTpDtYcBY8sVnWpVNWW7fkjarIMABjpnKlRBiGiP/W5JMdgyuRhRngBrVfmrbSXWKmlCgjv/UNgubSwRApcXPDWF7XQSWxZbwX4/o3HiD/lXadZv2USZckjvkASsfDQ+kbzkdbrgcC8bcYysvWX/aNOzkpbABa1nYrCtyblEibsTLZCk1GKF5yRU4T5WJKXHe2Sltq5YnjIkfOItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFh7hI5GRAhsV0NVLGhj2mawgtzscoClduTuqUcrgj8=;
 b=ibNTZKSy9iHJcW/Va4L7h6KuP1YYGmoFqaZLs+j9Jea6TzaakNpCXzs6bog+u4bZYqoHd/wvS69ZdGceejkgTMO+d27l0nts+QYuvDn+ekUVeBPNKTpTAxMVCoIVfxRmL/m9OgBA7tuhYN3Gax9wP39pLVu4uBdpo14GlcQ27ZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 18:32:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8511.017; Tue, 4 Mar 2025
 18:32:52 +0000
Message-ID: <ab954442-5bf6-4d2b-8d08-a6078b0dd6fc@amd.com>
Date: Tue, 4 Mar 2025 13:32:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Change error handling at prange update in
 svm_range_set_attr
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165839.8433-1-xiaogang.chen@amd.com>
 <af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com>
 <da6aa7ea-bf95-4e5d-8c37-5a2c43c4fc2f@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <da6aa7ea-bf95-4e5d-8c37-5a2c43c4fc2f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0439.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d60a763-199d-4597-b072-08dd5b4af96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RktzVEJQVWVYR2ttd2ZGM3JoWFIvVWN5M3U3c05WQUswNldESU5ORzMvd1hk?=
 =?utf-8?B?bERtNXpINzRVT0tBVDl5ZFh2QXZzYjBSVy9TbjNCS1FOMm1rWTlKZTZ2a3NT?=
 =?utf-8?B?UzZsb2g5bVJ4NDdWMnh1RWJhVjZGejlueFJONlJ3TTFrb3QzMFZqMWtmSjVz?=
 =?utf-8?B?SnBaRzdkU1d3MkV2VDYxTzZSNyt6WXoweTVZYXVETFErS2Rld1VtZXExUlVQ?=
 =?utf-8?B?TjNrd3VJZHB6dmIvNU0zS1htYXpMSzdNSlU3RGVrRXB1MHk1L2oxN1VmZHps?=
 =?utf-8?B?NmNhdXAvZi9qcm5mS0NLbWVBTnlSRlp5MHUwd2lENy9NMlVnTVhBb3VXcEhY?=
 =?utf-8?B?MFNnazkyT2UrOS9TYWhzRldEbmJTMm1WU2lhVTN4VVdmcUtnZzhhdFcrdkw3?=
 =?utf-8?B?YTBTRmFYTEFUK2RHOVAwVDhmN2ZSb0owdTNZL2hmVXZjQy8yOXNQd3hKRlQ2?=
 =?utf-8?B?SUdSK2lGTkQ5MTdvVDZkeVpIZ3pVMElSdEhtem5UWU55c2ZXb1FpT3BqRUJS?=
 =?utf-8?B?SlZwVGc5dE9MdHVHYUhkWDBBOW94ZnBoWGEvTGxwKzhCVzJadklabFFjdm9y?=
 =?utf-8?B?c1pCald2dzF4b0pQZTF1WUg4by9ITGo0cDcrWFExcVFlSm83QjJaU0Mrbzdk?=
 =?utf-8?B?aXZhdEJOWkFKelFYQkhGZ3d2MU9tYy9RVlZ6UHVGM3BpZEx4VDhTdWdHQUY4?=
 =?utf-8?B?QXNZOVh2N0JURmNHQmZLWXVmb2JnWnFrTWZNRG45Z2pOa0NuVTZMV1Z4dHFq?=
 =?utf-8?B?T0J6ZmtwcFlXTHZHTDNMQlJydXllWWFhWXdXL2ZzZ0lOZCt3Z0FWYTBnbnIw?=
 =?utf-8?B?ZUViSVAvWlQwRXRYNzBoSG42U1JqR2ZiUlQwU1E5Z0NQdE85L3BVSENXV0xy?=
 =?utf-8?B?R3YwcWY3cVcyK1ZoYXh5OHBSVnFsaHBTb3hiTFFYRlJ5UjlUM2NkTk9Nb1hx?=
 =?utf-8?B?OUNacHEzRnpHMmx4NnUvYmN5Nk1rUUhBVndqOUxVekViazQwUzlKNWF2NnF0?=
 =?utf-8?B?N05zdk40RzMydVJlZXZRU0UwanNrNjhIUC9UWURDc1hyS0oxYjY3V0l1VW5o?=
 =?utf-8?B?WnowOTBXc3NPQ3R3Yll3dHBlcjBoOE9RckxGVWxpbSs3TVNjZmsrZ0V2bDR1?=
 =?utf-8?B?eS9oVkpqSEZjQkY2RnVuWDR4YjNqSkw5Q2R4eHBtYTZmS0t5aVA2TG9JaXg4?=
 =?utf-8?B?M1prM3pWcXIyRXFqNlpMS3hiazNtTUthQ3RYV2lkSXBnMFlaSkNwR1pMS3hi?=
 =?utf-8?B?L0xjK1FLSDl4TSswNklmQkw4OERmYUphd0hOeGdiNHNPczdmQTZwdmZQK2Va?=
 =?utf-8?B?akRBNTVsMUw3d3JoVXNTTWJIK0kzQXdEblE5V0dqdE1XdTAzUGtQTDI1dTBn?=
 =?utf-8?B?dzFvYlFwY3hLUHhrdllHcFA5ajFFOU10UWFvQUdndlN6Q0pseEsxTGQ5TFdE?=
 =?utf-8?B?MDZpSVV5dCtJK0diekxSMUYyYlEyTDhlQWV5NEpmWGVLck9qSDBLQnFkR25G?=
 =?utf-8?B?L3I0cVdxNHV0UHV4NmJVaDhJUWxLc2ptdXpLd3RIWTM5VHpFL1pWM0ViL2d0?=
 =?utf-8?B?Z3piS1JhYi9aamg0RVlSbndpWDN2cTM5L2VuQ3FiSzZ6NVhwb1RVZ01kSW50?=
 =?utf-8?B?VDErMzdlSE0zb3dZclF6UHRrMjNRck5NdTdvTFBVOGtodkxCNjFOYmNLY1BN?=
 =?utf-8?B?c2k3cUxUYnBlKy9MblZ0U1MzbW90ZXppRzhSOGpMV01jdGlJK20rVjdGUEFX?=
 =?utf-8?B?MlBkKzFUSG9Ucnh4OFMrbWZVd0JLN0dFZXpEaXZ2dnFKV1RtYzRsYjE3Z05J?=
 =?utf-8?B?T0pqUFhWeXh5akVlaXVLS1hYTVdFNUU0b2QwRmxZVHkwd0FJbmFoWkFtRWQ3?=
 =?utf-8?Q?lX4bfbwa4QFdN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzlyNXRibVY4Yy9ma2szZTlCUUJDWjFNTUpOakNzdGN0dzY5bUxlM3lVN2Ny?=
 =?utf-8?B?dVkyZnlvakZlM2lhRU5JWkFheUl0ZHdWRmVwdWVFbXV0dlYra1ZaRW1ReFoy?=
 =?utf-8?B?SDVDMWNHUFRRUUZKOHhELzJRdEg2NTJmTkFVOVVMQmdPL3JVNGFiOCtDckRS?=
 =?utf-8?B?VUllNkRIY1k3QnFYZmVPY3U2Qnl3bUE5aU9veUZUQXBPd1owMHlpZXdKcVhY?=
 =?utf-8?B?Qko5bXdBaGpod2RPblhtbFR6SHRzVU0vSC9KdTErbHJoL2hUbHdlVXhwOVBw?=
 =?utf-8?B?OVFka3FnVFpLMFZjRDl6S0plSkRoQUFHUVhRMHd0bDl6a1B1VlpnVitWSFdL?=
 =?utf-8?B?Z3kwckZBRnNEbHlWczd0Y3hzY2ErbTNvNUpVMytQV3dFV09Fb2o0OWhweWNS?=
 =?utf-8?B?aE9uRkFELys1cU9COW9uS3Rtb25lWmpTY01Vc1BHNkRrd2xxSEpVTnBkdWFh?=
 =?utf-8?B?VFk1aWcyY0JqVkxlOWRaTXVrcGlvR1pEVVlDK01aSktyRkg5OGh5R1NiaWNF?=
 =?utf-8?B?ZVZ1bVBJdCtkTkgyb1d5S3R3V2o1aFFVQVEyWis3UGlYRVl4Sk1xYVpsSWVs?=
 =?utf-8?B?bUQxbkxWUmtjbys2dERtUUtWLzk4SEUxcWViUE5wVVUvRG9UdDF0UHQ0OFVP?=
 =?utf-8?B?dHM4dk1MVFRnKzRMQUtqb0tBdWRlbUZpWGFYWW0yaHdGM1pEQmxSOXhpcW9n?=
 =?utf-8?B?T3RsVWZtbWlJOXNsV2U3RkoxelExZm1HL3hTK1dLOU1CYnplVFpPaVJLWTAx?=
 =?utf-8?B?VWJkdDBCLzB5WXdCTUdNV3FLK3dGTUZiRlRjMXlYc0psT1hMWFd0eWJpRnRo?=
 =?utf-8?B?NFVocDRwaXhvSmZYUkZZVXBxWVpKSlhodXVoTzliSDRBWWpWcTQ5SCtjeEMy?=
 =?utf-8?B?UTBMNFlPcnBia0VTQnhoTkM4VGZkc3l3T3ppWFIyZ1pkY1dvZVJtTVBINHlM?=
 =?utf-8?B?di9mSDMxRlRwMGR4U1BETGpnWEcvMURnb3BqNWk0UkM2T1RmWURiWk9SM2th?=
 =?utf-8?B?SnFscGJ5Zk1HNlFiTDRlQjZteXVXYUlQbnF5NDVWRUpWeVdXUE1kT0F2RUFz?=
 =?utf-8?B?bUgwQ281NFgydVFkaFZsMHF0YkJmSzNhdkR2R2RjS1B1L1NsYjdWbjNWenIx?=
 =?utf-8?B?Q0ZJWDJTYS94dnR3NkdaZDVjNGhtc2dlYWw3UnNIeGsyOXQ5RnNxKzVzVGVG?=
 =?utf-8?B?MmFnZVNlMXZwUFJjVVdmV1ZpM2V3bE1NZklYNU0zY01JbVU0a0ZJN2NmNVg1?=
 =?utf-8?B?b0VUZnk3SGlLdXlFOW1xbktXNjIxSFlGK1l6SUw2S0RFdEcvKzlMeG5xMTdw?=
 =?utf-8?B?a3VJRGp2RGN6TXc4Umc3VU9RN0dMc3BpTTVybXFRRFVnc1UyUStJc0U4Slc0?=
 =?utf-8?B?WmhmRnNJZnhqMXQ4WndUNFFZZEViKzhOeitSeWlybkN1dW9XMlpUcyt5SjZn?=
 =?utf-8?B?K3RnK1AxRzBPdkphSzVySVB3MjZsUkgvZnYwdG0vYmZQdEtsSDU2V2EwRWxq?=
 =?utf-8?B?TG5KQzF3N0k0NWdINTdwMDNTU0pua2NvRDFSTzRwWnZqK2lSYm1acVNJUzI1?=
 =?utf-8?B?TGNEK1FHdlBCRDRyMVNBYkVObjF2NUxSSnRmS1I3cDZuazZCWWhOZFdCclp5?=
 =?utf-8?B?dzFxYjNPME5JREV5QnBNYU9icGJTclkzTStKL0E4SmNBdUZqYW5qblRYQzJ1?=
 =?utf-8?B?RWVuaVhyS1JjLzRHVSs4QTBSNFR4bG9EM2VLQnU1M1U3aGtKeGhsQVV4YmlT?=
 =?utf-8?B?bHVGNXMzYTBUR1ZPaDRlTUx4cWhWS3M3VnpoaWNSQlNsUnQ5VGp6R3kzVjRy?=
 =?utf-8?B?ME1PbFBxOGlCajM5L2NkbmZaYUpTQVhRb0xuMlFRRzByZitlMlpXTlhyWFl0?=
 =?utf-8?B?eVVCRTd4YW5nSEZiVTE0OGFIWExmVjByaXNoeHlRd1h6UHRWdnhWSzljalNo?=
 =?utf-8?B?SjV1dWYzei9YS1EwclB1R0pqcW85OC9ybjN2N2hVaEFOUlJIRUZnSE8wMi9G?=
 =?utf-8?B?NFBVd25rTFp2SW1FemVmUjBKS2tYUktmcW4wT1MyZXdZdFRwUThuQ1dHb2Jr?=
 =?utf-8?B?U3VGYkFaazBaRXRKUWV1S1JnR29RaUJ1R2NNMGtzNlBPYUJvWHBwMnlyT2Vx?=
 =?utf-8?Q?1w0uayHMYSu7z6m6TJPZKbIiC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d60a763-199d-4597-b072-08dd5b4af96e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 18:32:52.8675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KOaEtpBZb71DLqTwkVpUq+cBi3oXFFcgsqbFgBwVZMNtmkhayjDDhODrSZi7VF2g4TRmFxZCqKJ/ul4kqmWnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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


On 2025-03-04 13:23, Chen, Xiaogang wrote:
>
>
> On 3/3/2025 11:21 PM, Felix Kuehling wrote:
>> On 2025-01-31 11:58, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> When register a vm range at svm the added vm range may be split into multiple
>>> subranges and/or existing pranges got spitted. The new pranges need validated
>>> and mapped. This patch changes error handling for pranges that fail updating:
>> It may help if you clearly state the problem you're trying to solve to justify the changes in error handling. See more comments inline.
>>
> Current way is returning the last sub range error code if it got issue during migration, validation or map. If the last error is -EAGAIN, but there are other error codes at middle for other sub ranges we still return -EAGAIN. That causes same procedure repeated until the sub ranges that have other error code becomes the last one.
>
> I noticed it when looked at large range(more than 100GB) registration which split into multiple sub ranges. There were multiple unnecessary repeats until hit return code that is no -EAGAIN.
>
> As you said we may return immediately if hit no -EAGAIN, and hope app terminates. But if app does not terminate kfd drive will hold unused pranges until app stops.
>
>>> 1: free prange resources and remove it from svms if its updating fails as it
>>> will not be used.
>>> 2: return -EAGAIN when all pranges at update_list need redo valid/map,
>>> otherwise return no -EAGAIN error to user space to indicate failure. That
>>> removes unnecessary retries.
>>>
>>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++++++----
>>>  1 file changed, 23 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index e32e19196f6b..455cb98bf16a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -3716,8 +3716,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>  
>>>  out_unlock_range:
>>>  		mutex_unlock(&prange->migrate_mutex);
>>> -		if (r)
>>> -			ret = r;
>>> +		/* this prange cannot be migraed, valid or map */
>>> +		if (r) {
>>> +			/* free this prange resources, remove it from svms */
>>> +			svm_range_unlink(prange);
>>> +			svm_range_remove_notifier(prange);
>>> +			svm_range_free(prange, false);
>> Freeing the prange removes SVM mappings from the process. This will break the subsequent execution of the application. In case you were going to return -EAGAIN that's definitely wrong because the application would expect the SVM range to work after a successful retry.
> When return -EAGAIN app will do whole range registration again including rebuild sub ranges. And at this stage we do not know if subsequent sub ranges will be success or fail. So I release current sub range resource if it got error(including -EAGAIN). After processing all sub ranges if decide to have app do it again, the redo procedure will rebuild the released sub ranges.
>> I'm not sure the resource waste is a valid argument in case of a fatal error. I would expect the application to terminate anyways in this case, which would result in freeing the resources. Do you see a scenario where an application wants to continue running after this function returned a fatal error?
> I made a test app to check the behavior of registration of large range for debugging a real issue. I do not know if real app will continue to run when hit no -EAGAIN error code. The purpose here is making driver handle this case more general.
>>> +
>>> +			/* ret got update when any r != -EAGAIN;
>>> +			 * return -EAGAIN when all pranges at update_list
>>> +			 * need redo valid/map */
>>> +			if (r != -EAGAIN || !ret)
>>> +				ret = r;
>> This is a good point. But the explanation is a bit misleading: "all pranges ... need redo" is not really true. There may also be ranges that were validated successfully. I think the point you're trying to make is this: Don't return -EAGAIN if there was any previous fatal error found.
> ok
>> I could potentially see a different optimization. If you encounter a fatal error, you can skip the rest of the ranges and return the error immediately.
>>
> As said above it is a another way to return immediately if hit no -EAGAIN.  but should kfd driver release unused pragne resources any way?
>
No. Freeing the prange doesn't free any big resources, like VRAM. If VRAM is used by the range, the page mappings in the CPU virtual address space hold reference counts on the underlying BO. And that doesn't go away until the address range is munmapped. If anything, you may end up using more VRAM resources because the next time you validate, you may create a new VRAM BO, but the old one may not be released yet. You may also create problems for later callbacks (MMU notifiers and migrate-to-RAM) for those virtual addresses because you're destroying the SVM range structures that would be needed by those callbacks.

Regards,
  Felix


> Regards
>
> Xiaogang
>
>>> +		}
>>>  	}
>>>  
>>>  	list_for_each_entry(prange, &remap_list, update_list) {
>>> @@ -3729,8 +3740,16 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>  		if (r)
>>>  			pr_debug("failed %d on remap svm range\n", r);
>>>  		mutex_unlock(&prange->migrate_mutex);
>>> -		if (r)
>>> -			ret = r;
>>> +
>>> +		if (r) {
>>> +			/* remove this prange */
>>> +			svm_range_unlink(prange);
>>> +			svm_range_remove_notifier(prange);
>>> +			svm_range_free(prange, false);
>> Same as above.
>>
>> Regards,
>>   Felix
>>
>>
>>> +
>>> +			if (r != -EAGAIN || !ret)
>>> +				ret = r;
>>> +		}
>>>  	}
>>>  
>>>  	dynamic_svm_range_dump(svms);
