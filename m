Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F16EC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186E510E726;
	Tue, 22 Jul 2025 22:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ni2jSqdD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3DA10E726
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL5F3zpirszKo9vs3zxsTrEK5ZyetI2FHfRJ5RcWzFu2JK67+volKdRBCCmVR+5dmecoHBtxVtHchlUwY/h4E2N4gyHSnhZV+3qHHZC3V4apUs9JbOslK8A4xcn+7NuVxoPOJ/twB4qUCDcO5DtZuOLd2+Z8wA+xlEO5KLWk+3JqdHNPdES3VpSna72Jl3+9SsOCqrVwh3rKx2WZ+Ug2KR051UmjajqvWD7RnjCYBERIRWjcFCuL+NNbKZHO1nM3QGTGv8bEJFOEsoRSdoRQA6hotjw5X2nlaYm6MHvm4hut3KA/KDBVS1gkuFn/X8bnIA5AwB33LUGybFkexM4wMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEXe4bv50E3hBWUwkXnrrejYLVRoHIV2ws/7XY2IvF0=;
 b=buuetrqwKNSuiNDXfRPDs+axv4JFBzlf9pZoHCVR1AuzQOn5t3TLE9fzLDjBB9OWUPa2x82ccSPPCn1hevBOZliOZTqrcB3Dxdub5Z6SKdgNOkkAQfMQWG1S4F9xzNrqdwm8ieTUC5MEayHOgtt7nBhzurA4KbL85mKT/jiJAmgzjTH9uQfzDzmADh4ojF14haxE9sBE+KkbVhvsgap4Ob7cfms6JboYK+rk+/OUe6D2H2+c07B9oH/LQtaKfJfQeTdfbQ7XXWYN4kWRCgufH/WK43vcnfvZtUgZfbIxJfPldVoMGeY7KSRFGib2/yZp7x+lHHPEyy9L4UWjpH5ilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEXe4bv50E3hBWUwkXnrrejYLVRoHIV2ws/7XY2IvF0=;
 b=ni2jSqdDRsV96AZcHLNRyxoAWpwM0YXDFLNfs4gOKTXDbpgwMCjirnNOoCFUPKmjglfGfnYiyLvaIg9LNWxrWIf6nLRZBGg80gv6vo+q/eNd08I7cwj26p+o+sfKtu6ysfT69WzZ9FQyR/egInQGAVMX/eMJczoOA44OTBqlMNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 22:46:08 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 22:46:07 +0000
Content-Type: multipart/alternative;
 boundary="------------18ZKMwiLfqe0icKeTx5b0EsE"
Message-ID: <f81030dd-198e-4d7b-8467-7e7b3f199f32@amd.com>
Date: Tue, 22 Jul 2025 17:46:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com
References: <20250722162450.79502-1-kent.russell@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250722162450.79502-1-kent.russell@amd.com>
X-ClientProxiedBy: SN7PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:806:126::9) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: b70b18cc-ac33-488b-8798-08ddc9718c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azBibVZaYUY0azl1a2lacHRpSk5JengxeHp2UFlabDUybjhzMXlmZjlPRUgy?=
 =?utf-8?B?Zk84bDlFWFZWQXJDdzRwU3pIR2FMSWtzRFpneVgvZXpFQTJ1SVVVbCttNGFE?=
 =?utf-8?B?Vjdac3FWaTE1TDN2TVkrTFZ6Yy9teFpLcE54YUdTdmFGLzh2eHBkV2o4T0hs?=
 =?utf-8?B?emNqSVNjQzRlKy9aRjBNNGZzSEJnaEVPQWtGakFCa2w5OEpLVkM4a0Y4cGJB?=
 =?utf-8?B?Q21NM092bmxmbzN3bnB6VUN2c3prWEM3MHR0SStVdTNyb2IzeEVYWTJlZFM0?=
 =?utf-8?B?WjBrZ05Manlic1VHM0ZQM1AzbnJkbW00MHZnUHE1Tm1ZZTEwRDFaNDlwWXcr?=
 =?utf-8?B?UG5kTjRjejgvd2R4Q2hTVlYwcU5PRVl0NzRBV0hTa2xuTWVPcmNxRG9HNjVR?=
 =?utf-8?B?aDVpTFl3dzI0eDFCcFEwZk1wOURIVlNWU3NZQ1hxeFRuS0prcWFtNWNmTGx4?=
 =?utf-8?B?TmpqdXpSWHdFdmhjaCt2cm5VTGtQckdxWEl2ME5lL2lGelluV3lpTnJWcjBX?=
 =?utf-8?B?ZDNYSk8wM21SVS9xK2hCL0RYdFhtL09xMVM1TVJIbUNnNTN4Rkw2QzRxbVpK?=
 =?utf-8?B?ZW1mQkhJNGZGY0FGT0tQV0p4ajdDT2xwSi9yaDQ3TlVSbWJzNit1SGFFWUwy?=
 =?utf-8?B?ODQyWWtBbTlxelpkaXptK3d4cklYMkVrRG5UVjFXQit6bjFrOHVhZnZBcHlB?=
 =?utf-8?B?N2tPU1RlWEQyb2VNUlVwL2thaHExQmZIOUsxMDl2bW9vS2ljZ2owalhDTDBW?=
 =?utf-8?B?cTdESU11TTBHdXk2dFVuTVNpTng3VFlJeGpGUGU3S0FLVU9BcksycVhrcTdN?=
 =?utf-8?B?NEhuUEMxZ3d1TkFZWWJhdFcxRXJiaWhOd0phMDZzS1k0SlpNU3piNDc0Mm9j?=
 =?utf-8?B?SFI0N0p0WTRQQ1JScG9XY1htOURGcW5mVm5tT2RSa2pKOVNWME96WWR4ZThX?=
 =?utf-8?B?cWNMTGR5NzAxNDF2b1B6R2taOVRXdm91cGJHSmxEbmFXN2tYS2lBU0pxRE5p?=
 =?utf-8?B?bG04NFFneld0NGtWeHpKUmJNVDlYczFoKy9rMHdUVG1GcDJTM0JaU1Y3N0Y0?=
 =?utf-8?B?eTRRMzdCYi9kcnRadWovbTlNRyszZHA3d2V2cWE0WGZXTmUwdmwvV1czTVNy?=
 =?utf-8?B?Rm1haUhuaDBKaUVuelZJUS95ZGJ6UEVNTWRibCtnM1JCNnNzMmhDVWJEMFU3?=
 =?utf-8?B?S0dVaHNtdjJNM3kzbzRlQ2dwK1V6THNOWTFuMmI2dTZ5YmhSaWl6STI4SC9Y?=
 =?utf-8?B?bG1PNVdKZWdaanhzRVN1czNiMmYzQmI5S0x2REUzRFNTdGsrU1crWG14R0Rx?=
 =?utf-8?B?anRJZWlaVzFkTWMzWkFEcmZiUCtyZjQvME1KVjREcThhbjRqc2l2aUluUWVs?=
 =?utf-8?B?Q2FMUkhkMDZ1cERHdlprZ0JKcmVGcm85b0t2MFY0Q1ZSdW4rLzVHdWJPc3ZD?=
 =?utf-8?B?czFjU2JNblVIRUU4UGxwc3QrUU5IRFlSR2JOQzdVc2NMQ3IrVk9hd2NGa2Iy?=
 =?utf-8?B?N21JbDF5YzQ4S3pZSzNDYUc5QXVDUEsvS1o1a3NUK0duMlltT2V2emg4c0lO?=
 =?utf-8?B?YXVZNDdCcHczMmxKdk90aXNYdkFzWGFVelp3dmhkZGtCN0g2RURZNzIxekNF?=
 =?utf-8?B?VThtcmV5UHpmU2ozU0hOZDQ3YnMzWmRtRnJjQ0hEaXRXcGVkb21ZRG1uS0lI?=
 =?utf-8?B?Q0d3OWdsVFlibW12UHNreU1vOEhrcklBZmYwY2FlTlA3M0tQcXFjZFUrZnA2?=
 =?utf-8?B?K0ZIdW5lQjRlL1pLZUtWTHZ0dkhRelM4YWQ2M3BVSkRneUFySitzdWZJTUQz?=
 =?utf-8?B?TWloRm5GeHAwc0RsUmJQcWxSalpxdWh0SU5ndkFKMzBxV0dmMjJIOW5oanNw?=
 =?utf-8?B?SkhrbERtUjN3cDJlVm5SeW5lU3pYYjBFbkNjT0JvUk4xZ2JsMlcyUGJkVjhN?=
 =?utf-8?Q?yQcEE5YqKPs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxUMkY3VG1nZ3lRanV3U29XMjJGTjlGNUJBc1FvM3cvUG1Qd0w4SUhFdVgw?=
 =?utf-8?B?Ymk0T0lPdFFSUmE5QUlibFc5WkprNnVEbXNFUTV2VW54VktCT2kvZUtwblV3?=
 =?utf-8?B?bmlldnpBb01ObHpFTlowdzJtcHYycmpZaHNLU0F4QmpsZ2pMVVk5dHhNUTVs?=
 =?utf-8?B?VEdTb1ZYRk1FK1NlQkNTS1Jvd3NrYzJZR2xpL3J0empFclFpMC9kZGVkWWdU?=
 =?utf-8?B?TWFRRU5sN3VkbjZMb2xYd1RYYVlhRmIyUnMvV2duVElNVVZKM21WbTc0M0hn?=
 =?utf-8?B?YmFIdjkzZnJHcWJ4TXV3QWoyaFpzRGZJUGt1WFgrbkR1VWZBOGhMV1ZiZ3hv?=
 =?utf-8?B?VjZsbXkwNFVUaEJQaEMxcGJ2MWFEOVJMOVhMZ2tCc0h5WTFOY0JlblpFKzRt?=
 =?utf-8?B?RGtwK0NqV0luSVBhL3Zla2o4VUVjWXA1WHVXL2ROUlpha2tBZ2I1WUpOSmdq?=
 =?utf-8?B?aE5qNnBZV05SSW1yektES29UcVp6cFVRYzAzZXQ5cFZRRlFyS1U4RW9LZHJB?=
 =?utf-8?B?bThhejVSZzZTWk45MEdQd25rbVJJYWJDTG9XVnBYTUVUWmFEeElWd1lGbG5D?=
 =?utf-8?B?MlU5OWdNM0tDeUZRUnlKMDJFVjVjOVcrQXkra0tMcmNmOHZVVGUxTzgvZFRw?=
 =?utf-8?B?b3dGM0RnWTZxNzJ1TE9ZeS9ldUhlL0xKcURNM1U1QjhibWVENlFkbGRnODBR?=
 =?utf-8?B?VU5ac0NHM1pHK1AvOEk1bWNHYVQzTUFCUlQ5QzlnSS9SK3pWWG42dGlrdkRW?=
 =?utf-8?B?ay9kNTMwM29TS2crTWlEQ0dyZlQxSzBoUnJpSGZNWkxZbStmRFkxUkxvR1JI?=
 =?utf-8?B?T0ZCUzU3Sm9Wd0dRQlZ2a0RrSVlsK0t6OVRlSmFLajVTakpmN2dvR1NRVGhN?=
 =?utf-8?B?Y1VYYXJMa05SbW0yK3Q0WU45cFN5VkpLWmFQUU1LQjJ0RklGUytjZFNtYUo4?=
 =?utf-8?B?NDc1NmtZcnNwZ2I5Q0JrTk1lT1JpeUhOVHEzelhDSyt3L0ZjMW16by9PT0JZ?=
 =?utf-8?B?NHNwWks2c2lSMVBvay9uaWUzTzJTQlR5Z29rZEt6YWRRYU1Tcm5ITTVCUUcx?=
 =?utf-8?B?ZTBpcUF6OFJaRmVHT3hHWVFNUGJ6SFNGbHRmZEYvRzZOd0NYUXNVdmNJd2RB?=
 =?utf-8?B?VVRJRGNidU1ZTG5lclJTMGwrNDh4V3lYVUFsRUVMVHpqSEhYUXBZT05LM2wy?=
 =?utf-8?B?UXg3aU51YlRkbytHbXRXUURVNzJDZXNVTnlYREpNVFVMUFlmcm5YRHRRQkx5?=
 =?utf-8?B?NzJUdXpWaHBZMXQ3V0ZyVWtiSU5HQStDMlhqN3ZvSEhHUDk4VmV2a25XVXdN?=
 =?utf-8?B?MXl4djVmSmNPTlRtTXg0UHZrLzdVMlZCTUlUdEJJdXUwM01ZM2lHVXhoNHFU?=
 =?utf-8?B?K2o4dTdyTkk1K2tCSkRod1huVm5pU1g3RllOK1FmUmRYUGNEM3prektGQUNH?=
 =?utf-8?B?MDRjbTVVaENSdC9CTHlUb2c4YnpUUVJzRk5XYk1KcE5nNTZYWVBjTXdaT3Z5?=
 =?utf-8?B?SUxDYVUwTFNmYkd0a25OWkVaZGJpQytoOGJsckpJTG5qQ1Rqc2d6WjNlMFNv?=
 =?utf-8?B?cld1YlI2L0tmaGhKc09kQlh6OWhOSi92eDV3dHQ3dEdLNTlZc2tyVlBQY0JG?=
 =?utf-8?B?TGVPRExKTUNqUENuWThMZERPOFZZUko1bHpFTTFvcmNMS0xkdkloVVZqalF6?=
 =?utf-8?B?dEZSZWhEakZXeG9CK05UNTZqTlhFTEYrbVh4OVIxZnRJOUdWRWx0M0NncUhj?=
 =?utf-8?B?emFXSkZYK2JGc2hsM0xVVkxHNGFmVzRPa01YZm9qYyt5aUlRcjlqaWFYUXY2?=
 =?utf-8?B?dTBrSHhDTGhBUHpNV2pxZXQ0YnpFRjZSTCsvUzhpaXFYRnZVbWVyQzJWRFZC?=
 =?utf-8?B?R3pMVFBBd2dla0dDODVrcWFnbFNOYW55WkJ6dXY4bnhhSkZhNjd6MWxqam5W?=
 =?utf-8?B?MDZJaytYOG1oUFd6YlNZQkxkWFIrVTVUSTl3NHlhd0gwWFh1eUJKdTRsazNQ?=
 =?utf-8?B?Q25ZMktqeHhZeFpFb1M1ZDgvTU9QU0JlQXZDbis3N2tiU2dLcVN1N1FNanlF?=
 =?utf-8?B?dEQ1T1lDSk9HM0RNcFl1SFhoa0JKc0NrZjVwcHl3VlhLNUJiQ2h3SjgzUHU4?=
 =?utf-8?Q?2MGk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70b18cc-ac33-488b-8798-08ddc9718c11
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:46:07.6792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqKtZMCUBnN/CciSiHeD+BZsvK5gcRloa4Kkt6eKP8ug/yyGu12XBR69ZZ4tRS2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433
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

--------------18ZKMwiLfqe0icKeTx5b0EsE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/22/2025 11:24 AM, Kent Russell wrote:
> HMM assumes that pages have READ permissions by default. Inside
> svm_range_validate_and_map, we add READ permissions then add WRITE
> permissions if the VMA isn't read-only. This will conflict with regions
> that only have PROT_WRITE or have PROT_NONE. When that happens,
Why read-only conflict with PROT_WRITE or have PROT_NONE? They are 
vma->vm_flags that specifies the vma protection. User can change its 
value at runtime. Is user not allowed to change it from read-only to 
PROT_NONE?
> svm_range_validate_and_map will continue to retry, silently, giving the
> impression of a hang.
>
> If pages don't have READ permissions, simply unmap them and continue. If
> they weren't mapped in the first place, this would be a no-op. Since x86
> doesn't support write-only, and PROT_NONE doesn't allow reads or writes
> anyways, this will allow the svm range validation to continue without
> getting stuck in a loop forever on mappings we can't use with HMM.
>
> Signed-off-by: Kent Russell<kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e23b5a0f31f2..10b70b941b11 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1713,6 +1713,24 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   			next = min(vma->vm_end, end);
>   			npages = (next - addr) >> PAGE_SHIFT;
> +			/* HMM requires at least READ permissions. If provided with PROT_NONE,
> +			 * unmap the memory. If it's not already mapped, this is a no-op
> +			 * If PROT_WRITE is provided without READ, warn first then unmap
> +			 */
> +			if (!(vma->vm_flags & VM_READ)) {
> +				unsigned long e, s;
> +
> +				if (vma->vm_flags & VM_WRITE)
> +					pr_warn("VM_WRITE without VM_READ is not supported");
> +				s = max(start, prange->start);
> +				e = min(end, prange->last);
> +				if (e >= s)
> +					svm_range_unmap_from_gpus(prange, s, e,
> +						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
> +				addr = next;
> +				continue;
> +			}
> +
>   			WRITE_ONCE(p->svms.faulting_task, current);
>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>   						       readonly, owner, NULL,

It seems the real problem is at amdgpu_hmm_range_get_pages. It always 
set HMM_PFN_REQ_FAULT to hmm_range->default_flags. HMM_PFN_REQ_FAULT 
means the page is faultable and a future call with HMM_PFN_REQ_FAULT 
could succeed. When vma->vm_flags is PROT_NONE the vma is not faultable, 
so hmm_range->default_flags should be not set to HMM_PFN_REQ_FAULT to 
avoid hmm_range_fault fault this vma.

Regards

Xiaogang




--------------18ZKMwiLfqe0icKeTx5b0EsE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/22/2025 11:24 AM, Kent Russell
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250722162450.79502-1-kent.russell@amd.com">
      <pre wrap="" class="moz-quote-pre">HMM assumes that pages have READ permissions by default. Inside
svm_range_validate_and_map, we add READ permissions then add WRITE
permissions if the VMA isn't read-only. This will conflict with regions
that only have PROT_WRITE or have PROT_NONE. When that happens,</pre>
    </blockquote>
    Why read-only conflict with <span style="white-space: pre-wrap">PROT_WRITE or have PROT_NONE? </span>They
    are vma-&gt;vm_flags that specifies the vma protection. User can
    change its value at runtime. Is user not allowed to change it from
    read-only to <span style="white-space: pre-wrap">PROT_NONE?</span>
    <blockquote type="cite" cite="mid:20250722162450.79502-1-kent.russell@amd.com">
      <pre wrap="" class="moz-quote-pre">
svm_range_validate_and_map will continue to retry, silently, giving the
impression of a hang.

If pages don't have READ permissions, simply unmap them and continue. If
they weren't mapped in the first place, this would be a no-op. Since x86
doesn't support write-only, and PROT_NONE doesn't allow reads or writes
anyways, this will allow the svm range validation to continue without
getting stuck in a loop forever on mappings we can't use with HMM.

Signed-off-by: Kent Russell <a class="moz-txt-link-rfc2396E" href="mailto:kent.russell@amd.com">&lt;kent.russell@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e23b5a0f31f2..10b70b941b11 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1713,6 +1713,24 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 			next = min(vma-&gt;vm_end, end);
 			npages = (next - addr) &gt;&gt; PAGE_SHIFT;
+			/* HMM requires at least READ permissions. If provided with PROT_NONE,
+			 * unmap the memory. If it's not already mapped, this is a no-op
+			 * If PROT_WRITE is provided without READ, warn first then unmap
+			 */
+			if (!(vma-&gt;vm_flags &amp; VM_READ)) {
+				unsigned long e, s;
+
+				if (vma-&gt;vm_flags &amp; VM_WRITE)
+					pr_warn(&quot;VM_WRITE without VM_READ is not supported&quot;);
+				s = max(start, prange-&gt;start);
+				e = min(end, prange-&gt;last);
+				if (e &gt;= s)
+					svm_range_unmap_from_gpus(prange, s, e,
+						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
+				addr = next;
+				continue;
+			}
+
 			WRITE_ONCE(p-&gt;svms.faulting_task, current);
 			r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr, npages,
 						       readonly, owner, NULL,</pre>
    </blockquote>
    <p>It seems the real problem is at amdgpu_hmm_range_get_pages. It
      always set HMM_PFN_REQ_FAULT to hmm_range-&gt;default_flags.
      HMM_PFN_REQ_FAULT means the page is faultable and a future call
      with HMM_PFN_REQ_FAULT could succeed. When vma-&gt;vm_flags is <span style="white-space: pre-wrap">PROT_NONE</span> the vma is not
      faultable, so hmm_range-&gt;default_flags should be not set to
      HMM_PFN_REQ_FAULT to avoid hmm_range_fault fault this vma. <br>
    </p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
  </body>
</html>

--------------18ZKMwiLfqe0icKeTx5b0EsE--
