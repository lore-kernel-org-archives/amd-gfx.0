Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE44D3B7DD
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 07:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE00610E3B6;
	Mon,  8 Dec 2025 07:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CD+FPzXC";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CBF10E3B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 07:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/8MLDbfjHP/rT+reKgTSgA2/WGO+RBPxACHCnNK3+TL8jvknETh86tc6v8/w9pOQEcq1w+xG/r+/QqKJEfcxJxtg6wb3sPJeIs1Zqc2E63fdBTp+8+YHJmVoFS8D/ox8GIqOQWzucFdS7sfiaMgfRxI5n2flFtMECmwfZ1vjQC14tJvb1kVRZ8m8kKXnaveDQP0SEkgE4HkR/e3MPaxnk6Hz0ZTeCLf8y/8EDWNcJeMCObR+fob6e+cBnqGdPpGtyBcm8RsUvUVSVo617hfNL94JHukkDvFCCjp8KFbVMLopzKIARd/ti5xN/CigndDCU998TK4d92eWhjy8elMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pTFMyqpWK1hDwnR66AjSJEDvr64Pxr+jmUbHcN/qVA=;
 b=usDwSgaOxA6QqnEWZ4EwrTOB/fipi33FpRVZuiGCjRCgp/3J0AwuO3e6oN4xksE+ISS+1/FP9wEuiRnRSNU4h+1PD5gxq9/lI2W1li6vMr1+4WogSYeM/oS7tYO5BTXSdCC4Z8jxW2MjrZfoxGI+RjeWrPznvsOoey6u7NCA5LSGtC5vAvO9DGQLHWkqu1HCMZFAgL007G3wG1m1XmwSo8wVHobbAO25Vp2rufAZuxTb8rnSNuAaO+9TzPbIrXvQD5+LId0k0Q7jbIRgYDIR0vW53p9NTlcMenyLt8ibfNXr0szFPMAzPq8y1nMNFz1rj/tSaeTkz3emYntG2UoJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pTFMyqpWK1hDwnR66AjSJEDvr64Pxr+jmUbHcN/qVA=;
 b=CD+FPzXCSA4BYrz0LPSGuwNLTO5QtkMLfczxNVYQSeWts/RCWzegvEnESOKBlmt8PejwomTbxENIJbND59bkudyWFKSNZmfdFsLiYgo//DpS4FBzofhbO6s0x6ZuepNbSH0zJrnNHZUSOQVYO8qU86F1yDmvgj8rg1BKgwmDhQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Mon, 8 Dec
 2025 07:52:53 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 07:52:52 +0000
Message-ID: <2a84408e-48c5-4632-a194-fb6397280b5f@amd.com>
Date: Mon, 8 Dec 2025 13:22:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add cache interval to driver tables
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20251202114358.512048-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20251202114358.512048-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bdaaf9-028b-4bb8-f84b-08de362eca0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmZiU1ZFZnlWMmNtT05yaXlPakY0QjUwNVg5Z3NrWmR2UTJ4Ni9UQnQ4RkYv?=
 =?utf-8?B?QnkrSGxOL0cyQjBVdHFSR2kxcy9udTBFTVBpOTF5NzEwYUZMUEFtaXV6Y3V1?=
 =?utf-8?B?OGk2b0s1SG40N2Y0eGdqQ3AyS2NCdGhnSFBrQmJ0dW5xTDVqT0JWdmo0VDRm?=
 =?utf-8?B?bVVpRm04V2tkdm9WR1cwNzNpcXdKQ0RQRzBhOHl3eXlaYTZXRzRTTDNld2lt?=
 =?utf-8?B?K1N0UzZSRGw0QitnRGxGUW5pekQwQnk2ak9hdTJVczIwazZ0SW5EZDJTZ3Qx?=
 =?utf-8?B?SzF6czBIbUJBamZCU2FNVGVrbXNRelhOTlkxRXYwc3lWZWZLQmFHRzZ1MzRC?=
 =?utf-8?B?ZzBzazA1aE90VGxkT0dPMTdIWjY5VGtNREFIMDl3cndxWlFTa0NmZzBuTXpB?=
 =?utf-8?B?Q3diR1JBUkRwREVKdFdZTGhoemUzWW5tMVNqN1Bock4vU2J0NFFsTEJkVWtC?=
 =?utf-8?B?Tjc1VU8zc3hZK01iQndvditrWDREdUpvWDVTcUFXVDNYWGlUcHpXVmo2VzVQ?=
 =?utf-8?B?alo1TWlydThpeGJDbFJjbnFpVnlkeVIrSmM2MlhBTlVuMnpYVmlpcTNURGVY?=
 =?utf-8?B?OUJNTEMvUXQ4WEFEdTdtakhadjlKRDZSM0ZvOXVVMUltd2ExUjdsVG9ScjNl?=
 =?utf-8?B?M1FpbjdsMGZicXIya2ZFTG5VaHZUVnpUOFFHdjJtYkw5bXNpVUEzVHN4TEgx?=
 =?utf-8?B?NzYrd0dBVWFmVVRVZ3dlNHVFTEhEbndFYWs2NHhmTUV5MjlVb0kvL2MxQS9N?=
 =?utf-8?B?RWdiaHJ5d0R5dmh4T1ZGRXpXaXVuQ0VhNWwxM3JrYm05eUFzakwvVGFGMndT?=
 =?utf-8?B?V1Z4RUtFS0dpWGJhbzVWTDM3bnRHMUNIOGh4VWRvVVFnY2NXWUY1bEhuRTJP?=
 =?utf-8?B?NTFYTWlUTUhKc1J3NWlmR3BpUzExbi9BWGJrSTAzZGlMUzhFdDJ1RE5YN25l?=
 =?utf-8?B?SVRseWtlT2NzVWhWRTFma1RaSWNhZkdSR1FHT3lPMXVYaWt6bkptOXpFcUc4?=
 =?utf-8?B?NU82MHJKVS9QWjhIQnhnZXIzS1N6c3B2WGc0eWlXVi9ObGFTV1d5bmYvN0JL?=
 =?utf-8?B?WS9sc3hxUzY3b1pnRTQxT1dwVUo5dGkrcEVoRFJySXBXL2lKSjk0QjRLUlh2?=
 =?utf-8?B?VkpBNU1VbVJJNmpGQmhvai9zd3ZJYTRRaUZpVHJHSTJuKzJnSkZ6M3RENmJz?=
 =?utf-8?B?ZlFjdXdzTktyZ20xbk5MWnlBdmJQTjNRb2FMd1phUXl6cjRtVm1ybzU3VXpF?=
 =?utf-8?B?dUJxYy82QVM5OWdKWVR6L282ektJUjBxc2pOMkg5Z3AzT0lpMUExTW9lckZS?=
 =?utf-8?B?dGFUc2hJZWpQQWs2MldDS0xHc0dlOXZaWGtiWVUrZm5KbXFjY1c2U1hFd245?=
 =?utf-8?B?RUtUSzBrWVd1V3ZmTjFGQUs3QTJJa3kwWThKdGpROVJZL29ZNjFVa25qRkFV?=
 =?utf-8?B?SG1SMGpEcEgzQi9kaC96bkc4L2NzYmJJRVM1TEVoL1krZjZvbk5mc1hvV0U1?=
 =?utf-8?B?YVFlcGcvalFpQiswU0lJYlMwQ3czd3hJMlc4L3ppQzcwelQzRUNwUjIxMzlU?=
 =?utf-8?B?akFwQ2lhQlMyZG5MVkhKaEQ5UVNnMlRZUXNBUlVQZzF2UTk2RlhhVlRnSWo2?=
 =?utf-8?B?Ty8zRE1wTWhFSXRNZTE1YmZlNnJYNnc2SU5rN0dLN2xMeUh6cG8wQnJuYzhm?=
 =?utf-8?B?Z0xTM0ljM0E0MEFyS2YxTjZmTUIzWm9tbDdhUUZpYUhmbUhmMFpPVGhZYnFl?=
 =?utf-8?B?VTlVKzl6U3N1ZzNIam1vOTBsNUhtY1dEVFZwc0xzSmJld1NpbmxoU3pzMFRw?=
 =?utf-8?B?YzJqdEc2UFFUV2VXamt2dG1PSFZYV0g4MlZRY1RFNlZiaHBxVnduNjE0aXhh?=
 =?utf-8?B?cUhxbkpEVmVtY0JuM1QrcVo2NFR2NGpPV09LUmVuc3kvQXFPZDFEd2YvNDdl?=
 =?utf-8?Q?SZSC6Y466wEevfpl3AuGyxtW3cCaOSLE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3V5c1B2WDgrbG9BTlVxbCtBNVpmZU9ZNUlCZUwrSEtPb1RFeUdPZTFJbHdO?=
 =?utf-8?B?WDJiSjNka1VaY1JuYmVaVjZhNWpjN3Y3NFVWWlJ0SFVRUGw5bVZPZXVWNEFj?=
 =?utf-8?B?RWRNS0pYNFNDbGlHdXB6SGtTRWZjUTAwWlJCZGg4c3RqZVVuWDA2K1U3dnhB?=
 =?utf-8?B?cjFOUzBoT0NVWVNxOWkzZGVNaGw3TVZ3Q0pvUFRxc1pTWHpwQXQ0eTlpaW4r?=
 =?utf-8?B?MVFxYXQvbmFXVGd3TEprczVLU0hmZmRNRWExcTgzR0hIOGpIR002bTZMdVFM?=
 =?utf-8?B?Y1dBK1gvbXE3VCtBTEpjQTQyNjE5T1ozeU5JVm9uRXBLcHQ5OWlVMzhzb1ZO?=
 =?utf-8?B?bmJRYmkwU3Z6NGU0THVlbmFyaVF2cnQ3aXB0S24vWlRNUFlGZFJydjRLeEhN?=
 =?utf-8?B?V09iQmFxb3l1Rm5UN2ErSG9mL3dvbUI3V21lNHVWSUwzemV5VmNqazRNcVJN?=
 =?utf-8?B?eGxDcExPSm1Fa0FPQ21PYXpWQm53T3JCVG9mbGZNazRFejZJcW5OVjFmbFBi?=
 =?utf-8?B?OFJnZ2s4RUZ3alRUdlYzeWoxcXVDTEoxZzY3TzJhTytUZ2pHd3kvSFUwMk42?=
 =?utf-8?B?dTM0aHJWRWo3WFMzZWlISTNOSU8yQml3aVRmQ3NmN2R5SXE3MUlHTVlKZ0VY?=
 =?utf-8?B?eEtGWEFrOE5GODRmdDh1UEtxbm9SdVhjRSt3SFNyWEFTKzl5S3h0QWl0NkIw?=
 =?utf-8?B?VzdERHY4SWpEOVBmeVRBY21BSEJYeTZ6TWN6Mm1kaFI3RHR4bGFzMkQwVVJn?=
 =?utf-8?B?N3k5Q0t4ZmE0bmpPNjZYN05VV0xFLzFxZTRjamlTNXR3TUVTZDJmMDNZNTE0?=
 =?utf-8?B?MnVaN3E5RVROL0ppVG1kNkNpTkV4SE44UGM1WWQ0ZkVTbmVDTU9KSGlGaWp5?=
 =?utf-8?B?VENYZWxvelQzYnBrTGVyV0c0NktNeWIyaURpYm04OEZXOEltcnNpbDR2YXVw?=
 =?utf-8?B?bjNodTYrS21yamxoeVhkdU9EeXRvU090ZjR3SVNKWlgvOGpmWWZKZjZFc0NO?=
 =?utf-8?B?V1h0MTRKb3BzeE14R3pTR2tFQlJMWXFOSGlLRzdGd3lGZjJqTzFrdUVFUjNN?=
 =?utf-8?B?b3RxUXBVNzQyVkY4TWZkTzNPd29MSXgwcUVCWjVGNERLYWFnVEdnRTV2Mmlz?=
 =?utf-8?B?VGhUTUpnYVYzQ251eVUvaXVFdkFHMStMcXNtMnRkN1JsU3I0UHNhbjJCQWNi?=
 =?utf-8?B?dGJkWEY3Y2k2K1RWdTBSZXplUE9JOHMrSUVXS2ROTVYyV1czZXZEcFFvc1Ja?=
 =?utf-8?B?V0ZuMlZBM2s4VDc2MU5MVVZyemFWVk1vRlpKV2p6c0RaQjhSbVVhNTZ1SXM2?=
 =?utf-8?B?R3lHQUx6c1Yzd2JVRHgxcGR0Qjdzblkzb25uYThVQXFvUlVXcWVEUW9YdlFr?=
 =?utf-8?B?OXpUeVlJazUrNUExTHdQV2IveHAzd25pYkZuM0MrVlplTEwvWXAydk9raHB2?=
 =?utf-8?B?YUNwQ3dBRnRqQ3dvTlhFdlpSMkFCN25VelJCeXBwaG0xeU43WWtZNXVPVDdU?=
 =?utf-8?B?RXRYK29idjJyOEhHeFhIVjNjTXh1YmZZa0FsaGR3RkIwaEZySWdYYXpRYTFz?=
 =?utf-8?B?cmU3OGkxb3RKaGhtRWhBdWRvZlZmQkEvNzh6UWdsTUh5M28wa29hUnpsK2dS?=
 =?utf-8?B?Y0J2akF0aXNkZHdhNUdieWFSdVRJc2k3QmNLMEttRU45dzRVaFBlbHErMk5K?=
 =?utf-8?B?cTBnanArbmREdDQyK0xHSkpDTnZrQTUyNnZPclpvRGlzbkdtVDJTUXdJRlFN?=
 =?utf-8?B?Qkk3elI4NmNCNWJKNVZMQ2o3Y3Q5QnBIK2tYaHN4QjI0c1A1endnZ3pYdUZp?=
 =?utf-8?B?V081RnZ0dStjc2tkR1NNOEpwZ0txZ290VTRERjBVb0RXcE5yWFdSSWJrSDdS?=
 =?utf-8?B?UUl0ckRxSzJzWXlvdExET2NndTM3TUNsWVlqb3RtSDB6dnFnWkRjWWYwdDV6?=
 =?utf-8?B?YU9DY0hzTVM4cW1JMHZPSmZMWTQxeEFRSUQ5emEydU1NZyt6K0JVODFEb29F?=
 =?utf-8?B?TEZHcUxSQTdQWWxUS0FxSEU4aFE4ZHd0SllhUm1vaEUzcFgzMXhMZ1k2ZE5p?=
 =?utf-8?B?bWRtaXgrY0ZFSUhGT2xOZUlLTUtKaTE5WVhkNTNyOUNVVjhZM0FUNTRNT1Yr?=
 =?utf-8?Q?SQeyMe28Qtryk3rgXtleT66k8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bdaaf9-028b-4bb8-f84b-08de362eca0e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:52:52.2974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rHZmUkzEnOi/h+fM+JBRkVZkNs/I//tIWOP6tLVKJ9g3hq2ElOdVuF0SBCEbcxk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
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

<ping>

On 12/2/2025 5:09 PM, Lijo Lazar wrote:
> There are different metrics tables provided by driver, and they are all sourced from firmware.
> However, even with the same firmware table source, different classes of data could have different
> polling intervals. Hence driver shouldn't apply the same cache policy for all data coming from a
> single data source. This series adds driver tables with cache interval so that different tables
> could keep their own caching policy even if the data source is the same.
> 
> Lijo Lazar (7):
>    drm/amd/pm: Add smu driver table structure
>    drm/amd/pm: Use driver table structure in smuv11
>    drm/amd/pm: Use driver table structure in smuv12
>    drm/amd/pm: Use driver table structure in smuv13
>    drm/amd/pm: Use driver table structure in smuv14
>    drm/amd/pm: Use cached gpu metrics table
>    drm/amd/pm: Use driver table for board temperature
> 
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  31 ++++--
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 105 ++++++++++++++++--
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  16 ++-
>   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  15 ++-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  33 ++++--
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  16 ++-
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   3 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  44 +++++---
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  14 ++-
>   .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |   3 +-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  18 +--
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   3 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  16 ++-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  49 ++++----
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  17 +--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  19 ++--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  23 ++--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  16 ++-
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  19 ++--
>   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   3 +-
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  19 ++--
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  16 ++-
>   22 files changed, 332 insertions(+), 166 deletions(-)
> 

