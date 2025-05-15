Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E282C3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 14:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B278510E8C8;
	Thu, 15 May 2025 14:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nqqSh9B/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394E710E8C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 14:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9eV2S9vN6zB1Kmv2mH9Qg3JT8PF3QO0Gn206PHKndVEsQxwUwBedJ46gtsqAfytlf8EP+c77dnai/E19Fu/yps54PI1Ux3xGgmHnPE32EY0jMB9JsVM1Tos8uatU0L3Mi7pXh16PtDzNav+w96E7G+Ffm7IfjFFKDGwsoLtRhrpUP53IhpfdCAwfB/pnNbn0C7o9AMAWrMjWnS3b+BBe53H0eGr740O5zGrryYQ2tSfZtLqL9JFU8ZmiI1wCdNNFp4q3C8l+z7be+pBjm96pcoU92MAqlBsDcd+7Cb06frx9dZXkvWATl5fdDlkQG5rXRA8gzEuduxGsJv7wPKhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALBpXyJFoJX8eyNTonAvyaMFSnho/rH2eQk2bRkgaHQ=;
 b=clHNxIlGzzJKd35zdRSTJuGn39wAE4NdNcbRyJ1BbX/MN0Fqbo1GmAEGqcsOzR3OApSyvWFzoLA9j87+BrHW1ADfUwLr8F1YB6aAsgrPB3fBH8Mzw+/KDAAGASJDN148MWW9BhMYtUP11/6bWC5xO+AchCnGUysDakgQ4bKK6OUhSRZojWGvLL2Y+DDr6gr7ni1iqorXJEzBPI3vhr03wYCwUvGKJ2XLpyLdMzCY8X16R3bp7Hyp3wTnhSnbodto/hobExk5OWZWwFxbEFhVaE/kba1yRP3oFkPOGZn0LUrLBtgkyUB2Ew715b73OirkHqCNAYvF9k/CcEb2IRyIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALBpXyJFoJX8eyNTonAvyaMFSnho/rH2eQk2bRkgaHQ=;
 b=nqqSh9B/LTSpScTqe9ZBjHirQ7ptZtgjS7UYydq6fLMSKUilFv0nPNFOsnK4GVI6f7YT0YOM9udTojZKdlWwJHAPkOZ3h8wTISMlvA9a2Z1Zb0ytrV4bOeuQOVs+yugzjRKs6qV1toSbCMyMNnZ65K1rdiAcsdy0RyfJT6ldRmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 14:29:33 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 14:29:32 +0000
Content-Type: multipart/alternative;
 boundary="------------a0A1wtx2w7WD5JDKCHHmiFNz"
Message-ID: <4a02537f-1ea3-471f-ae10-c85471a65402@amd.com>
Date: Thu, 15 May 2025 09:29:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: destroy_pdds release pdd->drm_file at end
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20250514171004.4259-1-Philip.Yang@amd.com>
 <20250514171004.4259-4-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250514171004.4259-4-Philip.Yang@amd.com>
X-ClientProxiedBy: DM6PR02CA0089.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::30) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 727bc696-5437-4d1b-6c7d-08dd93bce8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUpyb1QxL3J6ZC9pY1VrUHlaRTNNcXRSTDFuRmVBS3U0R3EvRlhzdU44cWVC?=
 =?utf-8?B?S1RTWk1EZlBTNStnd3JDN0JKbDhEVGpMVzZHekdvaCs4eGpCVWpjSWRyMTZ2?=
 =?utf-8?B?T3N2QVMzVTdHcktSQms2c1JvYUFQQkJ4Ukt2M0c3WVozSGJrSE5NV3BnQ01a?=
 =?utf-8?B?ODVsSnZPM3l3aFh6anM1d1dYM2JOa2owWXFRZlZYVFRLa2pCa0tpYkFCMFoz?=
 =?utf-8?B?NldHS3E4ZFVHbzJkRmJxTW5YTE5iY1htdjNFOGZNb2dUYnZHQ2JKdHNodGhZ?=
 =?utf-8?B?WldUN2IweVhhNnhTRlNjNHlGYXRkMlQvMFJvTCtScXAyR1F6RHJGWVE1Q2d0?=
 =?utf-8?B?bGZRNk15aGZvbUlVKzJFWTIvcWpqN3ZkYVVUeUVSVzlsSklSK2xFR3hQSnYx?=
 =?utf-8?B?WFNUZmJOWlJEemF3VVkySmtZbWRzTEJISC9EUDhzUDluU1FGRUJPNVN1bW9B?=
 =?utf-8?B?dFB3RE1WZExIdGdrWXgzdkZWWnZoM3V3K0NzMWJOZmgwQW44OEhQdUxYVms3?=
 =?utf-8?B?T0lXZW5Ra0JLR3d6NnhvQ3F5R1VyN0VqZmJJekFRMGdmaW00UzRid29ySWsy?=
 =?utf-8?B?T0RIT2lLZnJKVjNTc3dhaE5CRjJCcE1yN052bFJndURiL05QeVkzSm9rbVV5?=
 =?utf-8?B?QnQvRFFQakIyM25IMlFZQ0ZpSnNBS2FnT1U3d1F5L05EeGQzWElBZUtHcmFp?=
 =?utf-8?B?ZW9LeVg4S2t6WXFCSWtiS1lPdHhTY2hCbFhvQThzZmtEbjg5MFRqTHpzajNG?=
 =?utf-8?B?bnpxaFVWRlJnbEZyNnRkN2xuMjhXcG0vQjRDcFRsQXZqVncvS3ZqRjE3QXBl?=
 =?utf-8?B?Nzd5b1crVmwrRnl5V0xaVWRUKytGSDF1VGpzZ2lvWWlvcjNsaWpHcWo2VHZO?=
 =?utf-8?B?alNwK1hFc1VKbnVSdUN6aVlPc0VQSU5ScmNyMTlmR2g4V0R5UDNMbzJxMHFU?=
 =?utf-8?B?V2plSXhUUzFJTDhuMDNWV0x3Z01NT3phNFBRRCszSWV0TitVSkRXd0NJRWcx?=
 =?utf-8?B?NVp6Q01VdElnMitoaXUraHVvMnA4YkJmM1pMcXFaYzdEWlpKTXEwcjBhZ3J3?=
 =?utf-8?B?TytvY1lPeDRpM0xOQ2NUUEJreXlzK0xRMk5vMUhSN2tENGsxTi9xd2ZmcGg2?=
 =?utf-8?B?NkxQOW1HYW9yL0NDMm82WUt1UnpLVmMxWVUwblVOMTFiYU9PcmVOclhIU21h?=
 =?utf-8?B?MklrNU14V3VRUnUyUTlOcTRFSXJGMUR0eUdVL2lRbkFnYVliMzA4RDRiNXpx?=
 =?utf-8?B?dnlWaEFKTGpEK2RMd2FSUi9hdUJZUmoyWkpobDhPYSt3ZGM2QjUrQ3ZlUEZu?=
 =?utf-8?B?Z3pubkJzMWJxMjJSb1NkK3E5MnZvNDhWMTFlaG9LR1BMOVA0d3RBUzJlY0dx?=
 =?utf-8?B?bDI1SjFLcm90ZFZVMjZpV0JnV0tzM3hzVjJaVUFPeENSbUJRVDBlanRkZ1ht?=
 =?utf-8?B?NmxPd28yK1Z6S1VhbFBSV2M1a3V0bndtYWNxRXdDcVBhSmh5TTUxT1FKZTZ1?=
 =?utf-8?B?UlNvRXh6ZjkzUmhrb2RMbWk4cTlvVnNWaldnMDYxb2hEcGhPa3l5bUE2VkM4?=
 =?utf-8?B?L3hiM3pMSm1OQ3gyTGw1dEJhWUZsNnpEVlVzV0hySHJzNW1hV3hISG9waDQ5?=
 =?utf-8?B?NkMvVk1DSDRTd05GTFE2dEJjV3h2YlF0ZGt3VUdKY0FUZEh4TGtvYm5KMEMr?=
 =?utf-8?B?Um8xa3NwWkdSKzVud0x1MnVYK0N5eXZtMFRVUFdJbmFXM0kyZG4xQXJsTGEy?=
 =?utf-8?B?YjBoNXRoeS9xNnQvaStWQzYrWFVCa2J1R2kwUk4zcUxwK1ZmcHFLNTZYQ2J2?=
 =?utf-8?B?Y1FjUko2L3dLMkFydWpQUVh2czBiN0RHZlVpK3h2NUlXTTBmbWpMWVdwWk5y?=
 =?utf-8?B?UEc1MUt6dzh1SEJGdlRORzVuU1hQcjFzWHlOVWdLOEJsWU10VS9xNTA4VEVD?=
 =?utf-8?Q?MDiPQRFMZyI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHdvUkp0VTJVZE1uZ1NFbXRaT0pBYlZranlyQVNlUmR6RWgydkRUQW9VeFVs?=
 =?utf-8?B?cGpBRkdsOGRyVC9lM1BVVHBKanlmeGtBcGdZcENxeXRqcUJjTWhYRU91bEJX?=
 =?utf-8?B?NHBZSGkwZFBPaUtsNTEwNDVtT3ZXdTE4NVpxUkRoTHJyVnNzYWJrK0FhY3dD?=
 =?utf-8?B?UTg4aExPMUtSUzJmelVCMzJEYnZqNkRIa3VQV25WV3ZpWXh4dkhucFJkS3R2?=
 =?utf-8?B?ek82elhZSjVQbUpZL0JwdTVyUGRiM3hNaUpTWU5JOCtnZXFHRGo5b01JdERw?=
 =?utf-8?B?R3NxZVJQR0VjeUJZc3NScEg1dEdpaDdQbmJRODBVdXBiWHJKNEVqZVFUdk1L?=
 =?utf-8?B?OWZ5RlRSbXNXQkRGRHdFSEpodEZocGpHQitRRDNEM0pKZEl6cjBCZk5TK0NL?=
 =?utf-8?B?d1E1NlowWlY4TkdOMU9wWHNkdjA1RWZtbTJkdHpsY2hackxQUWZsR2VDMHpN?=
 =?utf-8?B?dkJ6bHVRazVObmE3MGlnMVFxOWlia2laWkp1QTFxSUp2YjVwMVlTdUhCNlli?=
 =?utf-8?B?bnJMNS9pZGJvcmwvTDI3bzE3KzlZYzJJWHJYbERLS1VndGM1cDNaNklsVllQ?=
 =?utf-8?B?VDl6cjUvNXBidDBGNlNZVHl4b2dDTWVBemdFTEJWTzJpbk0wY3FCVFNEd3du?=
 =?utf-8?B?NHdzUlNXOFZnbGNsaHV0czJTc3JaR21oSlAzRzc2KzhsR2pKOVVvS1JiSUdB?=
 =?utf-8?B?SjVDVW5heEtObGhqeXFsOUhaMVllQlZYS0VZcVg4MjFpc0lRZStPUmVaSTNm?=
 =?utf-8?B?dytvWE1FNTVZSG9OVU1Td3BsVjlXMzVtU0dUNllwUm1sck9CU0pqdlhTUU9i?=
 =?utf-8?B?UkJ4VkdMS3M2b1lpT3dqWk54aGM2QU9weHBTVjF5NkRmMTRET3NnUFdGUmdS?=
 =?utf-8?B?dGxJdWY2OG1pdUZOM1JTNzE5V1B2NnNJNVBTeFZ0N3ZqM2RENU02WWdPUFdM?=
 =?utf-8?B?ZXZ1Z0lXeWY2WW4wdXp0Sk41bkM4RXl0SEplZ0JPSXA0L0FwQ0NVd1kvTFps?=
 =?utf-8?B?cHZYOGw5VXZTdGJNVmxER25wNGE3SGk1MWkxMHVhSFdCNzltbDFoQmFyWmZL?=
 =?utf-8?B?Z3JZalpMcEhQaDhRTmRBcVhyZDRyamFVRExtdTkrNWlLSjhyT0FuUnZlVDhP?=
 =?utf-8?B?QVBJNkNMSkRpTXJsRXlsZ0o2OURUT1NMSlpYcnBzUmJ5SkpHWk40V1dHblBB?=
 =?utf-8?B?UzJRUnNlUzRjYzlqMXh0TjB6aVdCdUcveHZrc3NZVUpiTXlidVZ0Ri9pZ1hs?=
 =?utf-8?B?Y3lhUnB0bmttbUs1RUp6ZjZJVGl6UmRlQUdJcWVXazY0eDhtZmxsQzhBYXpi?=
 =?utf-8?B?dFVsa2VSVTdFOWxLSWlNSG9jVUdDb2pzQUYrS2QxRTk5cDdSZTBGZjBpSXZD?=
 =?utf-8?B?WW5TNTBUK1NOa2VzTVZJTFNLakJIZ1NOUDZGZEx2bUFNM0hwc1NLTmJaMm1Y?=
 =?utf-8?B?UUcxczlnRExudSs2dUJ3d0xHZzBObkNmYytkUXhHSWtrTUJ3MVlOY1I0bDNa?=
 =?utf-8?B?ZFJuQ1pvY3dJeFJtNUFqWGRVTEV2UVNSdW8wMmx6QTIyaDlhOUJzclJEaTgr?=
 =?utf-8?B?ZHE3M2R5cmw3cjdyQTE0dmZRWW9zMG9HSHZSa0U4NUtYeXB4MFBKYkF5ZUp4?=
 =?utf-8?B?OGt1QWZwVWx3RWFIc25UNHMrZXVPRUV0bEtsc0ltV1JmS1RhaElSNzNrY1ZZ?=
 =?utf-8?B?WTN6MHZGK05xdnVTMU5kTmpFbXp5TU1kbGU5dmQ5K0pTdldXbU1pL01Xdzhz?=
 =?utf-8?B?STFtUWEzTmR5dEFDRmlTVCtheXEzdmJNWGdpVkw2am1pcktaVWpJUzNUOVBr?=
 =?utf-8?B?UWIzenloUnVhdlhTd1hQQTlqSmJBc3RsRU5rTjk3VXhROC91RGQyd2FOSmNR?=
 =?utf-8?B?UHIrMVB3STZYRGgrdyt4ZXBJYjNoS1orbVkwbkQwNDQ1NGxuVm14RWt5a0ls?=
 =?utf-8?B?UWM2SktSMFBsQzBQNzEvT2tta05GWW52WUtqUjZObXdSbERnejd2WGhrSEtW?=
 =?utf-8?B?ak44MElyTzFmc3JLa0djYXhmMGNuSmdVVnZMT3pMM2czajhBSFVFQ1Zhc29S?=
 =?utf-8?B?Q0FnTkxmeWdMOENob3dqektJWlB1SzIwd0VwMmJDTjVKdlYxS3FrVk9kbTFq?=
 =?utf-8?Q?f8LA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727bc696-5437-4d1b-6c7d-08dd93bce8d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:29:32.8083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBaXraUfVu91NQ+fIU/8X0VN93m0PdRYfHfBkJZoSDINLIMWtvaMXvUM9hqjZ6dv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
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

--------------a0A1wtx2w7WD5JDKCHHmiFNz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Does this patch fix a bug or just make code look more reasonable? 
kfd_process_destroy_pdds releases pdd related buffers, not related to 
operations on vm. So vm tear down dose not affect this function.

Regards

Xiaogang

On 5/14/2025 12:10 PM, Philip Yang wrote:
> Release pdd->drm_file may free the vm if this is the last reference,
> move it to the last step after memory is unmapped.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index e868cc8da46f..b009c852180d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1063,9 +1063,6 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   		kfd_process_device_destroy_cwsr_dgpu(pdd);
>   		kfd_process_device_destroy_ib_mem(pdd);
>   
> -		if (pdd->drm_file)
> -			fput(pdd->drm_file);
> -
>   		if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
>   			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>   				get_order(KFD_CWSR_TBA_TMA_SIZE));
> @@ -1088,6 +1085,13 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   			pdd->runtime_inuse = false;
>   		}
>   
> +		/*
> +		 * This may release the vm if application already close the drm node,
> +		 * do it as last step after memory unmapped.
> +		 */
> +		if (pdd->drm_file)
> +			fput(pdd->drm_file);
> +
>   		kfree(pdd);
>   		p->pdds[i] = NULL;
>   	}
--------------a0A1wtx2w7WD5JDKCHHmiFNz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Does this patch fix a bug or just make code look more
      reasonable?&nbsp; <span style="white-space: pre-wrap">kfd_process_destroy_pdds releases pdd related buffers, not related to operations on vm. So vm tear down dose not affect this function.  </span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang
</span></p>
    <div class="moz-cite-prefix">On 5/14/2025 12:10 PM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250514171004.4259-4-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">Release pdd-&gt;drm_file may free the vm if this is the last reference,
move it to the last step after memory is unmapped.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e868cc8da46f..b009c852180d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1063,9 +1063,6 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
-		if (pdd-&gt;drm_file)
-			fput(pdd-&gt;drm_file);
-
 		if (pdd-&gt;qpd.cwsr_kaddr &amp;&amp; !pdd-&gt;qpd.cwsr_base)
 			free_pages((unsigned long)pdd-&gt;qpd.cwsr_kaddr,
 				get_order(KFD_CWSR_TBA_TMA_SIZE));
@@ -1088,6 +1085,13 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 			pdd-&gt;runtime_inuse = false;
 		}
 
+		/*
+		 * This may release the vm if application already close the drm node,
+		 * do it as last step after memory unmapped.
+		 */
+		if (pdd-&gt;drm_file)
+			fput(pdd-&gt;drm_file);
+
 		kfree(pdd);
 		p-&gt;pdds[i] = NULL;
 	}
</pre>
    </blockquote>
  </body>
</html>

--------------a0A1wtx2w7WD5JDKCHHmiFNz--
