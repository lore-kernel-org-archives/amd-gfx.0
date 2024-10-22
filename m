Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C606D2C547
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 12:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936B910E677;
	Tue, 22 Oct 2024 12:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mf0VV9q/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF6210E677
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 12:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+j7cFqBhJBqFFrIes8gIlowxCSN9QCoZFd8RhAfdkhviFbaFIRKh/2lMAPXSTKO88SaeoE+RdhzMh/G5ejbrlJH4iU4HQuVwhQShFd/po/5lPJ/S5IGOdqO1IzmYPT4aMdmIeRl3X3Vcy3+qPAPv3yM1QZvFuJduaH7wYdmuHuWbn6cdbzUHXLArclBIpzVKQxXgrPuPk4MTDynImbyHfGuEkL6REOZxslcsy7N/x+Ih/KKWkHynhic2CZEiKMPv+fIAVLclDcZlR4SFYXGmNTCz3PyYNrYqpHbuKn5YrDTALmqCeHsGz/KoVSZzggegOlUulYjcxkyjH2qB4ENFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNhBUgINhmDofzV1oF4mrmRGVgQo20hmQL6spX1L0MU=;
 b=x6QC8BFwQWDPsHuJtMqW3D3FPjiFmt5m4/zVWGEDIWAkDxz3zVn0gChvJ0ZNe85ScyLuOOjzv5RysdWx/6f1pFPcDhVDWFBdCC4jBAvo8U2p/QwnHfisG6MbaPrPJqM78bjo+vuOAQZi0j8n4rgVD2cMMLSykf8ZOsNk5ZW9N63XGISAImEuFOIizVdoPG4EQ9RQ+oJlEibQ7bYtwL5nbuuZAtL/ptE2uD7RaPI416f22QGbkezEIB85FUT/sIdupEB6ZTeDQhBO0p5pIM1qAXzpMmf0Baedg6K2ldOEETOEjXOZLAgCZ8PbYw275vsCRqyJDpuAKJmntV9DPda3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNhBUgINhmDofzV1oF4mrmRGVgQo20hmQL6spX1L0MU=;
 b=mf0VV9q/407V5xXEbbQejwxgT3CH7FHZOFZGigmuRTjCkPhJiwEGLGizIbNhHopbNCtarOc6++Zjh/PrGB1+mWpAslTrXgr0SXmHJZe2ToOEAxOLxGTcyUM90J08OqVsSaFGQrdMSm2Wk+BnHLA0FXkk6gbNHkp6CC/6KJbf2Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 12:37:22 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 12:37:22 +0000
Subject: Re: [PATCH 29/32] drm/amdgpu: dump_ip_state for each vcn instance
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, Leo" <Leo.Liu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
 <20241017132053.53214-30-boyuan.zhang@amd.com>
 <13fb4b4c-7a32-a336-8e37-8d95c72552b7@amd.com>
 <BL1PR12MB5753DC49036662D60E1234CE934C2@BL1PR12MB5753.namprd12.prod.outlook.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <aa56a910-f3dc-8c3a-b824-a0bbfad4f428@amd.com>
Date: Tue, 22 Oct 2024 18:07:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <BL1PR12MB5753DC49036662D60E1234CE934C2@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------0A16B0142DA998E2AC752C31"
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 472ed800-4419-4881-1da9-08dcf2964674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVBGaE9DRUZjYUlaaUFDV21ERFZKNVBaMXVMVFFsWTN5K1pqN2lkWkJqeGxD?=
 =?utf-8?B?SnZ3azZHbWVnd29VQmFsUC9JbHl6R0FBQVRZMDJCVUpNaXBOWVFoSnMzUkVY?=
 =?utf-8?B?RVB4bEZQWTNxZC9FWnhBcmNMUENvUTduS1pKVkFLbmpuZnpjcGd4UXk1alZo?=
 =?utf-8?B?NGh5WGpDVktIVkhGcmw0bDhmQkJ0Q0hYRm04U1ZsbktWUytBS21kRGJOTWRH?=
 =?utf-8?B?LzhOUFZycXVrb3lHanNHbnRUZXhOc2lEa0FkaVdldFJJRDhFZHI1blJTVlh0?=
 =?utf-8?B?eVdGRU5EdGQzMGlKSDF4NzBSaHIyOURGUEQ0MEhhR3JyRXhVYUh6dExlOFg1?=
 =?utf-8?B?VTJXRVRWaEZQUE5Va0ZqaVptOUcxaEdoeWRnKys2MnRwM2lTRTdwZm5HWmxI?=
 =?utf-8?B?K1o4MzR6a3pXYkdqcnl6a2VyWksxMWI5a0F4NE9MV1VIZzF0aWtIUXZlV0dw?=
 =?utf-8?B?cTJBaWdXRWoyWGtaTElpLzVTWVY2U2tYcFp5NFoza1VZM2M1RmQ2UzBCb1U2?=
 =?utf-8?B?VFdpUVFHWFBhQS9SaU94SFRUTWpOTFhhSkhvNmQ5RjBwYlRQT0lIMVFKVmNx?=
 =?utf-8?B?V2lkS2IreFRuUkpRV2xQNUViSVQvZFpZWUpZOUx6eUxPbmJGbzFiUEd1R3dq?=
 =?utf-8?B?NnlxK0dhSGJhZlFsWExyTnRaMmlpNkxhMUpLTndObDZRZE5MV1doV2J0ejJM?=
 =?utf-8?B?aVhCaEtjcXpXWlpLR3A2dFpGeWlHUnI3azdzNXdjMGMzN3JOb1NtY201Y3R5?=
 =?utf-8?B?RFgrMWkvTVlPMVJhZU9tdzVlMnNFTmo2clpYOXkwa2Z2aFhKRWttV1NweHV1?=
 =?utf-8?B?SlBSTkxRemVWNUZ6dEFwQWQ2WC9mUlk3UHU1ckd2Nk9PODRQQmlkRi92dmxz?=
 =?utf-8?B?Yi94UmNNcCtMcFFoTzlFS3ZsS0NSbE9iTW1UMEp2ZlU4QlU0QVdLemgwZFdm?=
 =?utf-8?B?Q09zUmphMHBkeUU3aFRDU0FKdWVlT0h2bHJLR0hqQjUyd1g0bWw2a0dHMFhl?=
 =?utf-8?B?WW9yRTR5S05xYlFaR01IcXpsazB4NHFiTHpFc2p1dWRTM01mR0VaSkluRDZW?=
 =?utf-8?B?bTV6c2QxTVJ6MExadGhnekluSnd2OG93bEIzZjlvMUtYUVAwMkhWU1FLb0dN?=
 =?utf-8?B?eXJOQ1RPV2JCMHdBc1F5NUxWalkwZVFkQ0lJajVTRTQzSHNNVDJUcFZXaVcw?=
 =?utf-8?B?b1ZMWDB5cVhYQlJqaG1VMURMNFcxYUxtblgyM0ZscTdPNVBrNkNjWlBIa29P?=
 =?utf-8?B?eGlVYXZTcnhFcmYyWHU5V3JJZ2xpbHpHR2Y4K3IyWC9kRldJeEo1cVE4WndG?=
 =?utf-8?B?Yk5OTXFlbGZnY3RMTE5KQnR1NGQyR1MvV0xpQzRXWFJKbDloYjVFdGFXQ2xJ?=
 =?utf-8?B?dzNIZWxNbG1iK0RkME9NZ3NHUVEvTVlxUGRyaW1kTVFYWWxWRUJrOVY5RHRI?=
 =?utf-8?B?RnBCVVZ5MGlGQktobjFGd2VaT3NzYmx6cWxXT0w1L1BkL2JXUlBXWmp6OTVK?=
 =?utf-8?B?NmpZbjBPaXA2QjRFMnA2QTBrK3FSQXlOZE1ldDBrSURNZ29SbTIxMFlyQm1x?=
 =?utf-8?B?b3BQT1grYjlqa2t1UXI0K2k4aDBQV0JWdXNLMlFUU09rR3FGTFZmenAzb1d4?=
 =?utf-8?B?aXB3bEgrSG8yNHFBK1dVYlpzdjJqYm50TlVZdXlaWHYvSkl1c2FtUUVPMU53?=
 =?utf-8?B?T3JaWlduRzFvTDVrYU1YeE9yRGpoemE4QWFhdGx4dFVDdUw0QkcvdTYrRjhz?=
 =?utf-8?Q?g8KT4wW52Xg0hnRJ6o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzdXN0pNQjhvTnRUYnZXc1R1ZVFpTFkwbzhDcXgyOU42U1RaMWoxT0ZSaVRI?=
 =?utf-8?B?STB2U2lscjdHeFhzQkY5SnB4UmRMVDFUQWMrRmlGZFFmei82U25YcGhlRVIx?=
 =?utf-8?B?Qm00SkxTdWVpQlRqck84djZXUTd6MFpveUZWUE1JcURLNm9DTEZ4M2lvQzlj?=
 =?utf-8?B?cEEwWVFtWkdjYjlMem9EVUhxN2JPSXZjNmNSMFkyc0VpL0tpVUkxbk1SeWtX?=
 =?utf-8?B?TU11RFFtRi9xVXNkaHpZOWY5OXVRZlBwNEtTUFNyNFBVNWlxT1J3TEx3NFk1?=
 =?utf-8?B?OXRPdW5UdWQvTkQrOTg2MG9SQ1JEYlJnaXRiaU1ndUU1TThaRnBFN2xBdm1a?=
 =?utf-8?B?bmlkaVp5V0JRS2lDdzlqNkRBWTg5ZzJ0UUNsK1prbEN6eEVOTkg5WHVhN0Fj?=
 =?utf-8?B?U3RseWdZYmdxY3FRaFc1R0wwOWFKVk50QmFhaTJFNzMwU2VtK2t5NFhJclR6?=
 =?utf-8?B?emNpeXRZMnFWeXFDSHZ3RlpZZTlQYjZvV2lpaWN6Z3FOSmw1SWNLOU9UdjNo?=
 =?utf-8?B?ZFVRRkFNT2ZqYVlCdUJmenVzc25UWkdoQUExKzA0UytlS0swNkxhKzVhTWVH?=
 =?utf-8?B?S29md2R3ZTJTeldZTjFRSGduOUxnZFpJNm92Q2hKNzRXNHE0VkNRNkJUcVYw?=
 =?utf-8?B?WkJSREdBWVBvRnhsOFhvYisrclpRb2hKaTRGRHQxTHFPWDVqMkx5OFhEaVhk?=
 =?utf-8?B?b3VHSU5kam9VS0FBdlhySVF4RStiQ2N0MnJJbEFFdmxqbTVJSlJvMnAxdzRV?=
 =?utf-8?B?M2Y0YXl1RzZ1NjRKZkppeWkzQ2NiSFhNZUhHaDJyR2tLT2lsL0pWQnpNNTY1?=
 =?utf-8?B?UmNmS2lsVk51QUZBcDhlL2RQb1JFb1l5bGFyUmZnYi9kL1BUaDdvUTZ4NjBS?=
 =?utf-8?B?SGpOSUJVcVkwT2E1QldvRVo0MTBtTUc2N2gvR01zMWs0RGlBVHVDNmdsa0dr?=
 =?utf-8?B?em1HSkZtNUhlZWl6aUwwUGoyTCtLWXUwZkNoT2lsSTZ1ZURnSDlSK3hreUZo?=
 =?utf-8?B?bUREUzY2bTdERlVNcmZDVlZ6RUtWeGQxSFE2ai9LMjVnMzZkNW5FejEzU1Zs?=
 =?utf-8?B?UmdnUUdsd0gxalRYYWkzZ3Q5YmNkODJzamVETUd0UjU4eHJiWDVZMXVsZEFo?=
 =?utf-8?B?aEJPc3BnSmNCSHNlbW1ZRVp4T2RBK0h5Rk5xOVkxQTJOdkZwN1FtRWNYNk9s?=
 =?utf-8?B?UFhCSU0ybXZaK2M0VmwxVUFpdXNRSy9hM1ROY0xXUW1hT1dnbGxFeXRPcHdM?=
 =?utf-8?B?VWFuVGtIbEZySDF5YkJvcGhKVDNubFBaQ0NkZ2pjR2hreXNYMWJtZUV4eFla?=
 =?utf-8?B?dkFnUTRUY0NOcmVtaDZxWlZuamluWGJnMStRT09OdngzTGErZUcvMHRCSmt1?=
 =?utf-8?B?M1pZSHZDSXQ0N0lwNGNQR1NRbno5YkpabnFJMCtjSHErbkF6YUJxN3JDeXpB?=
 =?utf-8?B?QVM3Qk0yQkQvRmMxNnYrck41RFJYNXpoY0c1TXYzTDhwWHJsdW9odkZkc0c2?=
 =?utf-8?B?WUk4SmUzZWlIM2ZJUmV1UjdqdzdOZ1lrRXQyUFNpYk1raWpnTVB0QWpKODFu?=
 =?utf-8?B?aHJraDdPTzJzeE9GcWFKdHRaSnp3eVZudWZKTW5zTlpkZFUxUWFMUXMwSU5Z?=
 =?utf-8?B?aHBrM3hMckpZd2RJbU5lUXA1M1JldlNkanJucWdPNU5mVVRWRTJieGE2RW5X?=
 =?utf-8?B?aVhsaVBqanBBSEpvV0Vpd1hoSUNoZVNlUG5HNy9kN1dqZDZoMGkwYjlVSWFo?=
 =?utf-8?B?M044NXdOQU94VC9IZGUrR1BXSTJnUzVqVUI4TDNZTkM3SlR5dFZCU3Avdk8v?=
 =?utf-8?B?MXRhYzYzUDNnclh3dHdXbFZLendQRTdLNVJ3M055T3QvZmtwb1c2WVRPTmpE?=
 =?utf-8?B?MVJNYmRSdVBMT25QY0dtaGJiZUhEVDEwZlZvQXNrYXFjTGpwa1JsMTNFTk9B?=
 =?utf-8?B?NWpCS3pEUWxqRGNxb2p3Rm4xUWpoeGt0YURJbFdUcG5zTFcwamV2SWhHQ3l3?=
 =?utf-8?B?MUdBSlJ3V25HalRNZ2ZkQlQ2dzJPVGJESU83dVdRNFhaeStORWxsb0lhYWpH?=
 =?utf-8?B?M21XYS8wcURSVmJxaFVwVnQ4SmVCU1pqNHgrSHRhUWlGRmhnbW1ORlRKMFR6?=
 =?utf-8?Q?T4Vyl/CiRRcrKJrx2r5c4vmJr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472ed800-4419-4881-1da9-08dcf2964674
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:37:22.6326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isY8aEv1BeMSDm2jj1reRgccb0GViAfYy+i1m2NDXsgoJ4aJi7+0Fn5ONrsHeJJoxBeKu/0VyhCbpOpUw18Asg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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

--------------0A16B0142DA998E2AC752C31
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Boyuan

It probably wont work fine as memory allocated for core dump also needs 
to change based on ip design where not we have an ip_block for each 
instance too.

So here is what i think and let me know if that sounds fine with you. 
Once you get the review complete for patches #1 - #27 get them merged 
and on that code base i will rework the changes needs for core dump for 
vcn and then you could get rest of your changes reviewed and merged.

Also i am assuming there is no dependency of patches if they are in 
order and build independently so you can leave the ipdump patches #28 
and #29 and let the review process complete. I need to change them 
according to new design and validate too.

Ignore the review on these two patches till then :)

Regards
Sunil Khatri

On 10/22/2024 2:29 PM, Khatri, Sunil wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Validate the ip dump date first for vcn before committing. I reviewed 
> based on the code changes as it looks fine.
>
> *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
> *Khatri, Sunil
> *Sent:* Tuesday, October 22, 2024 2:27 PM
> *To:* Zhang, Boyuan <Boyuan.Zhang@amd.com>; 
> amd-gfx@lists.freedesktop.org; Liu, Leo <Leo.Liu@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH 29/32] drm/amdgpu: dump_ip_state for each vcn 
> instance
>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com 
> <mailto:christian.koenig@amd.com>>
>
> On 10/17/2024 6:50 PM, boyuan.zhang@amd.com 
> <mailto:boyuan.zhang@amd.com> wrote:
>
>     From: Boyuan Zhang<boyuan.zhang@amd.com>  <mailto:boyuan.zhang@amd.com>
>
>     Perform dump_ip_state only for the instance of the current vcn IP block,
>
>     instead of perform it for all vcn instances.
>
>     Signed-off-by: Boyuan Zhang<boyuan.zhang@amd.com>  <mailto:boyuan.zhang@amd.com>
>
>     ---
>
>       drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 27 +++++++++----------
>
>       drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 27 +++++++++----------
>
>       drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 27 +++++++++----------
>
>       drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 27 +++++++++----------
>
>       drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 31 +++++++++++-----------
>
>       drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 35 ++++++++++++-------------
>
>       drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 31 +++++++++++-----------
>
>       drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 27 +++++++++----------
>
>       8 files changed, 112 insertions(+), 120 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
>     index 9255bcfc6c3d..27e0f206c9dd 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
>     @@ -1964,7 +1964,8 @@ static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>
>       static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>       {
>
>        struct amdgpu_device *adev = ip_block->adev;
>
>     - int i, j;
>
>     + int inst = ip_block->instance;
>
>     + int j;
>
>        bool is_powered;
>
>        uint32_t inst_off;
>
>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
>
>     @@ -1972,21 +1973,19 @@ static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>        if (!adev->vcn.ip_dump)
>
>               return;
>
>       
>
>     - for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>
>     -        if (adev->vcn.harvest_config & (1 << i))
>
>     -                continue;
>
>     + if (adev->vcn.harvest_config & (1 << inst))
>
>     +        return;
>
>       
>
>     -        inst_off = i * reg_count;
>
>     -        /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     -        adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
>
>     -        is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     -                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     + inst_off = inst * reg_count;
>
>     + /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     + adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
>
>     + is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     +                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>       
>
>     -        if (is_powered)
>
>     -                for (j = 1; j < reg_count; j++)
>
>     -                        adev->vcn.ip_dump[inst_off + j] =
>
>     -                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], i));
>
>     - }
>
>     + if (is_powered)
>
>     +        for (j = 1; j < reg_count; j++)
>
>     +                adev->vcn.ip_dump[inst_off + j] =
>
>     +                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], inst));
>
>       }
>
>       
>
>       static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>
>     index 94f000ed4895..665b749c5ac0 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>
>     @@ -2072,7 +2072,8 @@ static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>
>       static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>       {
>
>        struct amdgpu_device *adev = ip_block->adev;
>
>     - int i, j;
>
>     + int inst = ip_block->instance;
>
>     + int j;
>
>        bool is_powered;
>
>        uint32_t inst_off;
>
>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
>
>     @@ -2080,21 +2081,19 @@ static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>        if (!adev->vcn.ip_dump)
>
>               return;
>
>       
>
>     - for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>
>     -        if (adev->vcn.harvest_config & (1 << i))
>
>     -                continue;
>
>     + if (adev->vcn.harvest_config & (1 << inst))
>
>     +        return;
>
>       
>
>     -        inst_off = i * reg_count;
>
>     -        /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     -        adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
>
>     -        is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     -                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     + inst_off = inst * reg_count;
>
>     + /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     + adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
>
>     + is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     +                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>       
>
>     -        if (is_powered)
>
>     -                for (j = 1; j < reg_count; j++)
>
>     -                        adev->vcn.ip_dump[inst_off + j] =
>
>     -                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], i));
>
>     - }
>
>     + if (is_powered)
>
>     +        for (j = 1; j < reg_count; j++)
>
>     +                adev->vcn.ip_dump[inst_off + j] =
>
>     +                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], inst));
>
>       }
>
>       
>
>       static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>
>     index 7c9a0169215e..5332b2903ce1 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>
>     @@ -1946,7 +1946,8 @@ static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>
>       static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>       {
>
>        struct amdgpu_device *adev = ip_block->adev;
>
>     - int i, j;
>
>     + int inst = ip_block->instance;
>
>     + int j;
>
>        bool is_powered;
>
>        uint32_t inst_off;
>
>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>
>     @@ -1954,21 +1955,19 @@ static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>        if (!adev->vcn.ip_dump)
>
>               return;
>
>       
>
>     - for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>
>     -        if (adev->vcn.harvest_config & (1 << i))
>
>     -                continue;
>
> Since this for loop is removed which dump for each instances,clear my 
> understanding here, there are multiple ip_blocks for vcn now and 
> ip_block->instance is 0, 1, 2, 3 etc representing one instance ?
> Assuming the use case of 2 instances so first time when 
> vcn_v2_5_dump_ip_state is called it will comes with ip_block->instance 
> = 0 and then 1 and 2 in sequence as we are dumping that information in 
> loop and storing in coredump in that sequence only.
>
>     + if (adev->vcn.harvest_config & (1 << inst))
>
>     +        return;
>
>       
>
>     -        inst_off = i * reg_count;
>
>     -        /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     -        adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
>
>     -        is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     -                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     + inst_off = inst * reg_count;
>
>     + /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     + adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
>
>     + is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     +                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>       
>
>     -        if (is_powered)
>
>     -                for (j = 1; j < reg_count; j++)
>
>     -                        adev->vcn.ip_dump[inst_off + j] =
>
>     -                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], i));
>
>     - }
>
>     + if (is_powered)
>
>     +        for (j = 1; j < reg_count; j++)
>
>     +                adev->vcn.ip_dump[inst_off + j] =
>
>     +                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], inst));
>
>        Storage we have linear to accomodate each vcn instance. So we need to make sure that when dump is called for instance sequentially we are adding values in vcn.ip_dump in same order so print should give right value else there could be a mismatch based on existing logic. Please try to cause a dump and hack around the code so is_powered is bypassed and we dump the values for each instance thats the only way to see if its working fine.
>
> By looking at the code it seems it should work but there are some vcn 
> variable which i am not so sure in new design.  Also patch for dump 
> should come first and then print to reverse the order of 28 and 29 patch.
> But testing is needed to make sure its working fine.
> Regards
> Sunil khatri
>
>       }
>
>       
>
>       static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>
>     index 061c958700d8..40a3d29d4e71 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>
>     @@ -2269,7 +2269,8 @@ static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>
>       static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>       {
>
>        struct amdgpu_device *adev = ip_block->adev;
>
>     - int i, j;
>
>     + int inst = ip_block->instance;
>
>     + int j;
>
>        bool is_powered;
>
>        uint32_t inst_off;
>
>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
>
>     @@ -2277,21 +2278,19 @@ static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>        if (!adev->vcn.ip_dump)
>
>               return;
>
>       
>
>     - for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>
>     -        if (adev->vcn.harvest_config & (1 << i))
>
>     -                continue;
>
>     + if (adev->vcn.harvest_config & (1 << inst))
>
>     +        return;
>
>       
>
>     -        inst_off = i * reg_count;
>
>     -        /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     -        adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
>
>     -        is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     -                      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     + inst_off = inst * reg_count;
>
>     + /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     + adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
>
>     + is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     +                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>       
>
>     -        if (is_powered)
>
>     -                for (j = 1; j < reg_count; j++)
>
>     -                        adev->vcn.ip_dump[inst_off + j] =
>
>     -                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], i));
>
>     - }
>
>     + if (is_powered)
>
>     +        for (j = 1; j < reg_count; j++)
>
>     +                adev->vcn.ip_dump[inst_off + j] =
>
>     +                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], inst));
>
>       }
>
>       
>
>       static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>
>     index fdf346bf3e34..3b2f4f1e0939 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>
>     @@ -2177,7 +2177,8 @@ static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>
>       static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>       {
>
>        struct amdgpu_device *adev = ip_block->adev;
>
>     - int i, j;
>
>     + int inst = ip_block->instance;
>
>     + int j;
>
>        bool is_powered;
>
>        uint32_t inst_off;
>
>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
>
>     @@ -2185,22 +2186,20 @@ static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>        if (!adev->vcn.ip_dump)
>
>               return;
>
>       
>
>     - for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>
>     -        if (adev->vcn.harvest_config & (1 << i))
>
>     -                continue;
>
>     + if (adev->vcn.harvest_config & (1 << inst))
>
>     +        return;
>
>       
>
>     -        inst_off = i * reg_count;
>
>     -        /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     -        adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
>
>     -        is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     -                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     -
>
>     -        if (is_powered)
>
>     -                for (j = 1; j < reg_count; j++)
>
>     -                        adev->vcn.ip_dump[inst_off + j] =
>
>     -                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
>
>     -                                                                 i));
>
>     - }
>
>     + inst_off = inst * reg_count;
>
>     + /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     + adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
>
>     + is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     +                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     +
>
>     + if (is_powered)
>
>     +        for (j = 1; j < reg_count; j++)
>
>     +                adev->vcn.ip_dump[inst_off + j] =
>
>     +                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
>
>     +                                                         inst));
>
>       }
>
>       
>
>       static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>
>     index daaf2fb6b3e5..be03d31cb206 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>
>     @@ -1757,7 +1757,8 @@ static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
>
>       static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>       {
>
>        struct amdgpu_device *adev = ip_block->adev;
>
>     - int i, j;
>
>     + int inst = ip_block->instance;
>
>     + int j;
>
>        bool is_powered;
>
>        uint32_t inst_off, inst_id;
>
>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>
>     @@ -1765,23 +1766,21 @@ static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>        if (!adev->vcn.ip_dump)
>
>               return;
>
>       
>
>     - for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>
>     -        if (adev->vcn.harvest_config & (1 << i))
>
>     -                continue;
>
>     -
>
>     -        inst_id = GET_INST(VCN, i);
>
>     -        inst_off = i * reg_count;
>
>     -        /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     -        adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
>
>     -        is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     -                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     -
>
>     -        if (is_powered)
>
>     -                for (j = 1; j < reg_count; j++)
>
>     -                        adev->vcn.ip_dump[inst_off + j] =
>
>     -                         RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
>
>     -                                                                 inst_id));
>
>     - }
>
>     + if (adev->vcn.harvest_config & (1 << inst))
>
>     +        return;
>
>     +
>
>     + inst_id = GET_INST(VCN, inst);
>
>     + inst_off = inst * reg_count;
>
>     + /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     + adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
>
>     + is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     +                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     +
>
>     + if (is_powered)
>
>     +        for (j = 1; j < reg_count; j++)
>
>     +                adev->vcn.ip_dump[inst_off + j] =
>
>     +                 RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
>
>     +                                                         inst_id));
>
>       }
>
>       
>
>       static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>
>     index ff8db22b9614..43b1f3d06157 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>
>     @@ -1638,7 +1638,8 @@ static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
>
>       static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>       {
>
>        struct amdgpu_device *adev = ip_block->adev;
>
>     - int i, j;
>
>     + int inst = ip_block->instance;
>
>     + int j;
>
>        bool is_powered;
>
>        uint32_t inst_off;
>
>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
>
>     @@ -1646,22 +1647,20 @@ static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>        if (!adev->vcn.ip_dump)
>
>               return;
>
>       
>
>     - for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>
>     -        if (adev->vcn.harvest_config & (1 << i))
>
>     -                continue;
>
>     + if (adev->vcn.harvest_config & (1 << inst))
>
>     +        return;
>
>       
>
>     -        inst_off = i * reg_count;
>
>     -        /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     -        adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
>
>     -        is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     -                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     -
>
>     -        if (is_powered)
>
>     -                for (j = 1; j < reg_count; j++)
>
>     -                        adev->vcn.ip_dump[inst_off + j] =
>
>     -                         RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
>
>     -                                                                 i));
>
>     - }
>
>     + inst_off = inst * reg_count;
>
>     + /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     + adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
>
>     + is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     +                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     +
>
>     + if (is_powered)
>
>     +        for (j = 1; j < reg_count; j++)
>
>     +                adev->vcn.ip_dump[inst_off + j] =
>
>     +                 RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
>
>     +                                                         inst));
>
>       }
>
>       
>
>       static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>
>     index c83a5c09f410..65554c4e86cd 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>
>     @@ -1365,7 +1365,8 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>
>       static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>       {
>
>        struct amdgpu_device *adev = ip_block->adev;
>
>     - int i, j;
>
>     + int inst = ip_block->instance;
>
>     + int j;
>
>        bool is_powered;
>
>        uint32_t inst_off;
>
>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
>
>     @@ -1373,21 +1374,19 @@ static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>
>        if (!adev->vcn.ip_dump)
>
>               return;
>
>       
>
>     - for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>
>     -        if (adev->vcn.harvest_config & (1 << i))
>
>     -                continue;
>
>     + if (adev->vcn.harvest_config & (1 << inst))
>
>     +        return;
>
>       
>
>     -        inst_off = i * reg_count;
>
>     -        /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     -        adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
>
>     -        is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     -                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>     + inst_off = inst * reg_count;
>
>     + /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>
>     + adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
>
>     + is_powered = (adev->vcn.ip_dump[inst_off] &
>
>     +                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>
>       
>
>     -        if (is_powered)
>
>     -                for (j = 1; j < reg_count; j++)
>
>     -                        adev->vcn.ip_dump[inst_off + j] =
>
>     -                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], i));
>
>     - }
>
>     + if (is_powered)
>
>     +        for (j = 1; j < reg_count; j++)
>
>     +                adev->vcn.ip_dump[inst_off + j] =
>
>     +                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], inst));
>
>       }
>
>       
>
>       static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
>

--------------0A16B0142DA998E2AC752C31
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p>Hello Boyuan</p>
    <p>It probably wont work fine as memory allocated for core dump also
      needs to change based on ip design where not we have an ip_block
      for each instance too. <br>
      <br>
      So here is what i think and let me know if that sounds fine with
      you. Once you get the review complete for patches #1 - #27 get
      them merged and on that code base i will rework the changes needs
      for core dump for vcn and then you could get rest of your changes
      reviewed and merged.<br>
      <br>
      Also i am assuming there is no dependency of patches if they are
      in order and build independently so you can leave the ipdump
      patches #28 and #29 and let the review process complete. I need to
      change them according to new design and validate too.<br>
      <br>
      Ignore the review on these two patches till then :)<br>
    </p>
    <p>Regards<br>
      Sunil Khatri <br>
    </p>
    <div class="moz-cite-prefix">On 10/22/2024 2:29 PM, Khatri, Sunil
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB5753DC49036662D60E1234CE934C2@BL1PR12MB5753.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	color:black;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p
style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;"
        align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:windowtext">Validate
              the ip dump date first for vcn before committing. I
              reviewed based on the code changes as it looks fine.<o:p></o:p></span></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:windowtext"><o:p> </o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">
                  amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                  <b>On Behalf Of </b>Khatri, Sunil<br>
                  <b>Sent:</b> Tuesday, October 22, 2024 2:27 PM<br>
                  <b>To:</b> Zhang, Boyuan <a class="moz-txt-link-rfc2396E" href="mailto:Boyuan.Zhang@amd.com">&lt;Boyuan.Zhang@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Liu, Leo
                  <a class="moz-txt-link-rfc2396E" href="mailto:Leo.Liu@amd.com">&lt;Leo.Liu@amd.com&gt;</a>; Koenig, Christian
                  <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Deucher, Alexander
                  <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 29/32] drm/amdgpu:
                  dump_ip_state for each vcn instance<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p>Reviewed-by: Sunil Khatri &lt;<a
              href="mailto:christian.koenig@amd.com"
              moz-do-not-send="true">sunil.khatri@amd.com</a>&gt;<o:p></o:p></p>
          <div>
            <p class="MsoNormal">On 10/17/2024 6:50 PM, <a
                href="mailto:boyuan.zhang@amd.com"
                moz-do-not-send="true">
                boyuan.zhang@amd.com</a> wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre>From: Boyuan Zhang <a href="mailto:boyuan.zhang@amd.com" moz-do-not-send="true">&lt;boyuan.zhang@amd.com&gt;</a><o:p></o:p></pre>
            <pre><o:p> </o:p></pre>
            <pre>Perform dump_ip_state only for the instance of the current vcn IP block,<o:p></o:p></pre>
            <pre>instead of perform it for all vcn instances.<o:p></o:p></pre>
            <pre><o:p> </o:p></pre>
            <pre>Signed-off-by: Boyuan Zhang <a href="mailto:boyuan.zhang@amd.com" moz-do-not-send="true">&lt;boyuan.zhang@amd.com&gt;</a><o:p></o:p></pre>
            <pre>---<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 27 +++++++++----------<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 27 +++++++++----------<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 27 +++++++++----------<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 27 +++++++++----------<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 31 +++++++++++-----------<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 35 ++++++++++++-------------<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 31 +++++++++++-----------<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 27 +++++++++----------<o:p></o:p></pre>
            <pre> 8 files changed, 112 insertions(+), 120 deletions(-)<o:p></o:p></pre>
            <pre><o:p> </o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p></pre>
            <pre>index 9255bcfc6c3d..27e0f206c9dd 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<o:p></o:p></pre>
            <pre>@@ -1964,7 +1964,8 @@ static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm<o:p></o:p></pre>
            <pre> static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>  struct amdgpu_device *adev = ip_block-&gt;adev;<o:p></o:p></pre>
            <pre>- int i, j;<o:p></o:p></pre>
            <pre>+ int inst = ip_block-&gt;instance;<o:p></o:p></pre>
            <pre>+ int j;<o:p></o:p></pre>
            <pre>  bool is_powered;<o:p></o:p></pre>
            <pre>  uint32_t inst_off;<o:p></o:p></pre>
            <pre>  uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);<o:p></o:p></pre>
            <pre>@@ -1972,21 +1973,19 @@ static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre>  if (!adev-&gt;vcn.ip_dump)<o:p></o:p></pre>
            <pre>         return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>- for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {<o:p></o:p></pre>
            <pre>-        if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<o:p></o:p></pre>
            <pre>-                continue;<o:p></o:p></pre>
            <pre>+ if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))<o:p></o:p></pre>
            <pre>+        return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        inst_off = i * reg_count;<o:p></o:p></pre>
            <pre>-        /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>-        adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>-        is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>-                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>+ inst_off = inst * reg_count;<o:p></o:p></pre>
            <pre>+ /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>+ adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>+ is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>+                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        if (is_powered)<o:p></o:p></pre>
            <pre>-                for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>-                        adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>-                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], i));<o:p></o:p></pre>
            <pre>- }<o:p></o:p></pre>
            <pre>+ if (is_powered)<o:p></o:p></pre>
            <pre>+        for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>+                adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>+                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], inst));<o:p></o:p></pre>
            <pre> }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre> static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<o:p></o:p></pre>
            <pre>index 94f000ed4895..665b749c5ac0 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<o:p></o:p></pre>
            <pre>@@ -2072,7 +2072,8 @@ static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm<o:p></o:p></pre>
            <pre> static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>  struct amdgpu_device *adev = ip_block-&gt;adev;<o:p></o:p></pre>
            <pre>- int i, j;<o:p></o:p></pre>
            <pre>+ int inst = ip_block-&gt;instance;<o:p></o:p></pre>
            <pre>+ int j;<o:p></o:p></pre>
            <pre>  bool is_powered;<o:p></o:p></pre>
            <pre>  uint32_t inst_off;<o:p></o:p></pre>
            <pre>  uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);<o:p></o:p></pre>
            <pre>@@ -2080,21 +2081,19 @@ static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre>  if (!adev-&gt;vcn.ip_dump)<o:p></o:p></pre>
            <pre>         return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>- for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {<o:p></o:p></pre>
            <pre>-        if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<o:p></o:p></pre>
            <pre>-                continue;<o:p></o:p></pre>
            <pre>+ if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))<o:p></o:p></pre>
            <pre>+        return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        inst_off = i * reg_count;<o:p></o:p></pre>
            <pre>-        /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>-        adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>-        is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>-                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>+ inst_off = inst * reg_count;<o:p></o:p></pre>
            <pre>+ /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>+ adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>+ is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>+                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        if (is_powered)<o:p></o:p></pre>
            <pre>-                for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>-                        adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>-                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], i));<o:p></o:p></pre>
            <pre>- }<o:p></o:p></pre>
            <pre>+ if (is_powered)<o:p></o:p></pre>
            <pre>+        for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>+                adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>+                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], inst));<o:p></o:p></pre>
            <pre> }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre> static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<o:p></o:p></pre>
            <pre>index 7c9a0169215e..5332b2903ce1 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<o:p></o:p></pre>
            <pre>@@ -1946,7 +1946,8 @@ static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm<o:p></o:p></pre>
            <pre> static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>  struct amdgpu_device *adev = ip_block-&gt;adev;<o:p></o:p></pre>
            <pre>- int i, j;<o:p></o:p></pre>
            <pre>+ int inst = ip_block-&gt;instance;<o:p></o:p></pre>
            <pre>+ int j;<o:p></o:p></pre>
            <pre>  bool is_powered;<o:p></o:p></pre>
            <pre>  uint32_t inst_off;<o:p></o:p></pre>
            <pre>  uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);<o:p></o:p></pre>
            <pre>@@ -1954,21 +1955,19 @@ static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre>  if (!adev-&gt;vcn.ip_dump)<o:p></o:p></pre>
            <pre>         return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>- for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {<o:p></o:p></pre>
            <pre>-        if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<o:p></o:p></pre>
            <pre>-                continue;<o:p></o:p></pre>
          </blockquote>
          <p class="MsoNormal">Since this for loop is removed which dump
            for each instances,clear my understanding here, there are
            multiple ip_blocks for vcn now and ip_block-&gt;instance is
            0, 1, 2, 3 etc representing one instance ?<br>
            Assuming the use case of 2 instances so first time when
            vcn_v2_5_dump_ip_state is called it will comes with
            ip_block-&gt;instance = 0 and then 1 and 2 in sequence as we
            are dumping that information in loop and storing in coredump
            in that sequence only.
            <br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p> </o:p></pre>
            <pre>+ if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))<o:p></o:p></pre>
            <pre>+        return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        inst_off = i * reg_count;<o:p></o:p></pre>
            <pre>-        /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>-        adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>-        is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>-                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>+ inst_off = inst * reg_count;<o:p></o:p></pre>
            <pre>+ /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>+ adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>+ is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>+                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        if (is_powered)<o:p></o:p></pre>
            <pre>-                for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>-                        adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>-                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], i));<o:p></o:p></pre>
            <pre>- }<o:p></o:p></pre>
            <pre>+ if (is_powered)<o:p></o:p></pre>
            <pre>+        for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>+                adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>+                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], inst));<o:p></o:p></pre>
            <pre>  Storage we have linear to accomodate each vcn instance. So we need to make sure that when dump is called for instance sequentially we are adding values in vcn.ip_dump in same order so print should give right value else there could be a mismatch based on existing logic. Please try to cause a dump and hack around the code so is_powered is bypassed and we dump the values for each instance thats the only way to see if its working fine.<o:p></o:p></pre>
          </blockquote>
          <p class="MsoNormal">By looking at the code it seems it should
            work but there are some vcn variable which i am not so sure
            in new design.  Also patch for dump should come first and
            then print to reverse the order of 28 and 29 patch.<br>
            But testing is needed to make sure its working fine.<br>
            Regards<br>
            Sunil khatri<br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p> </o:p></pre>
            <pre> }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre> static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<o:p></o:p></pre>
            <pre>index 061c958700d8..40a3d29d4e71 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<o:p></o:p></pre>
            <pre>@@ -2269,7 +2269,8 @@ static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm<o:p></o:p></pre>
            <pre> static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>  struct amdgpu_device *adev = ip_block-&gt;adev;<o:p></o:p></pre>
            <pre>- int i, j;<o:p></o:p></pre>
            <pre>+ int inst = ip_block-&gt;instance;<o:p></o:p></pre>
            <pre>+ int j;<o:p></o:p></pre>
            <pre>  bool is_powered;<o:p></o:p></pre>
            <pre>  uint32_t inst_off;<o:p></o:p></pre>
            <pre>  uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);<o:p></o:p></pre>
            <pre>@@ -2277,21 +2278,19 @@ static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre>  if (!adev-&gt;vcn.ip_dump)<o:p></o:p></pre>
            <pre>         return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>- for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {<o:p></o:p></pre>
            <pre>-        if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<o:p></o:p></pre>
            <pre>-                continue;<o:p></o:p></pre>
            <pre>+ if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))<o:p></o:p></pre>
            <pre>+        return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        inst_off = i * reg_count;<o:p></o:p></pre>
            <pre>-        /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>-        adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>-        is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>-                      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>+ inst_off = inst * reg_count;<o:p></o:p></pre>
            <pre>+ /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>+ adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>+ is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>+                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        if (is_powered)<o:p></o:p></pre>
            <pre>-                for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>-                        adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>-                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], i));<o:p></o:p></pre>
            <pre>- }<o:p></o:p></pre>
            <pre>+ if (is_powered)<o:p></o:p></pre>
            <pre>+        for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>+                adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>+                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], inst));<o:p></o:p></pre>
            <pre> }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre> static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<o:p></o:p></pre>
            <pre>index fdf346bf3e34..3b2f4f1e0939 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<o:p></o:p></pre>
            <pre>@@ -2177,7 +2177,8 @@ static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm<o:p></o:p></pre>
            <pre> static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>  struct amdgpu_device *adev = ip_block-&gt;adev;<o:p></o:p></pre>
            <pre>- int i, j;<o:p></o:p></pre>
            <pre>+ int inst = ip_block-&gt;instance;<o:p></o:p></pre>
            <pre>+ int j;<o:p></o:p></pre>
            <pre>  bool is_powered;<o:p></o:p></pre>
            <pre>  uint32_t inst_off;<o:p></o:p></pre>
            <pre>  uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);<o:p></o:p></pre>
            <pre>@@ -2185,22 +2186,20 @@ static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre>  if (!adev-&gt;vcn.ip_dump)<o:p></o:p></pre>
            <pre>         return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>- for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {<o:p></o:p></pre>
            <pre>-        if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<o:p></o:p></pre>
            <pre>-                continue;<o:p></o:p></pre>
            <pre>+ if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))<o:p></o:p></pre>
            <pre>+        return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        inst_off = i * reg_count;<o:p></o:p></pre>
            <pre>-        /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>-        adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>-        is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>-                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>-<o:p></o:p></pre>
            <pre>-        if (is_powered)<o:p></o:p></pre>
            <pre>-                for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>-                        adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>-                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],<o:p></o:p></pre>
            <pre>-                                                                 i));<o:p></o:p></pre>
            <pre>- }<o:p></o:p></pre>
            <pre>+ inst_off = inst * reg_count;<o:p></o:p></pre>
            <pre>+ /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>+ adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>+ is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>+                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>+ if (is_powered)<o:p></o:p></pre>
            <pre>+        for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>+                adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>+                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],<o:p></o:p></pre>
            <pre>+                                                         inst));<o:p></o:p></pre>
            <pre> }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre> static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c<o:p></o:p></pre>
            <pre>index daaf2fb6b3e5..be03d31cb206 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c<o:p></o:p></pre>
            <pre>@@ -1757,7 +1757,8 @@ static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct d<o:p></o:p></pre>
            <pre> static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>  struct amdgpu_device *adev = ip_block-&gt;adev;<o:p></o:p></pre>
            <pre>- int i, j;<o:p></o:p></pre>
            <pre>+ int inst = ip_block-&gt;instance;<o:p></o:p></pre>
            <pre>+ int j;<o:p></o:p></pre>
            <pre>  bool is_powered;<o:p></o:p></pre>
            <pre>  uint32_t inst_off, inst_id;<o:p></o:p></pre>
            <pre>  uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);<o:p></o:p></pre>
            <pre>@@ -1765,23 +1766,21 @@ static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre>  if (!adev-&gt;vcn.ip_dump)<o:p></o:p></pre>
            <pre>         return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>- for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {<o:p></o:p></pre>
            <pre>-        if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<o:p></o:p></pre>
            <pre>-                continue;<o:p></o:p></pre>
            <pre>-<o:p></o:p></pre>
            <pre>-        inst_id = GET_INST(VCN, i);<o:p></o:p></pre>
            <pre>-        inst_off = i * reg_count;<o:p></o:p></pre>
            <pre>-        /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>-        adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>-        is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>-                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>-<o:p></o:p></pre>
            <pre>-        if (is_powered)<o:p></o:p></pre>
            <pre>-                for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>-                        adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>-                         RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],<o:p></o:p></pre>
            <pre>-                                                                 inst_id));<o:p></o:p></pre>
            <pre>- }<o:p></o:p></pre>
            <pre>+ if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))<o:p></o:p></pre>
            <pre>+        return;<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>+ inst_id = GET_INST(VCN, inst);<o:p></o:p></pre>
            <pre>+ inst_off = inst * reg_count;<o:p></o:p></pre>
            <pre>+ /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>+ adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>+ is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>+                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>+ if (is_powered)<o:p></o:p></pre>
            <pre>+        for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>+                adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>+                 RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],<o:p></o:p></pre>
            <pre>+                                                         inst_id));<o:p></o:p></pre>
            <pre> }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre> static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c<o:p></o:p></pre>
            <pre>index ff8db22b9614..43b1f3d06157 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c<o:p></o:p></pre>
            <pre>@@ -1638,7 +1638,8 @@ static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct d<o:p></o:p></pre>
            <pre> static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>  struct amdgpu_device *adev = ip_block-&gt;adev;<o:p></o:p></pre>
            <pre>- int i, j;<o:p></o:p></pre>
            <pre>+ int inst = ip_block-&gt;instance;<o:p></o:p></pre>
            <pre>+ int j;<o:p></o:p></pre>
            <pre>  bool is_powered;<o:p></o:p></pre>
            <pre>  uint32_t inst_off;<o:p></o:p></pre>
            <pre>  uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);<o:p></o:p></pre>
            <pre>@@ -1646,22 +1647,20 @@ static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre>  if (!adev-&gt;vcn.ip_dump)<o:p></o:p></pre>
            <pre>         return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>- for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {<o:p></o:p></pre>
            <pre>-        if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<o:p></o:p></pre>
            <pre>-                continue;<o:p></o:p></pre>
            <pre>+ if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))<o:p></o:p></pre>
            <pre>+        return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        inst_off = i * reg_count;<o:p></o:p></pre>
            <pre>-        /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>-        adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>-        is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>-                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>-<o:p></o:p></pre>
            <pre>-        if (is_powered)<o:p></o:p></pre>
            <pre>-                for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>-                        adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>-                         RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],<o:p></o:p></pre>
            <pre>-                                                                 i));<o:p></o:p></pre>
            <pre>- }<o:p></o:p></pre>
            <pre>+ inst_off = inst * reg_count;<o:p></o:p></pre>
            <pre>+ /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>+ adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>+ is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>+                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>+ if (is_powered)<o:p></o:p></pre>
            <pre>+        for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>+                adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>+                 RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],<o:p></o:p></pre>
            <pre>+                                                         inst));<o:p></o:p></pre>
            <pre> }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre> static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<o:p></o:p></pre>
            <pre>index c83a5c09f410..65554c4e86cd 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<o:p></o:p></pre>
            <pre>@@ -1365,7 +1365,8 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm<o:p></o:p></pre>
            <pre> static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>  struct amdgpu_device *adev = ip_block-&gt;adev;<o:p></o:p></pre>
            <pre>- int i, j;<o:p></o:p></pre>
            <pre>+ int inst = ip_block-&gt;instance;<o:p></o:p></pre>
            <pre>+ int j;<o:p></o:p></pre>
            <pre>  bool is_powered;<o:p></o:p></pre>
            <pre>  uint32_t inst_off;<o:p></o:p></pre>
            <pre>  uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);<o:p></o:p></pre>
            <pre>@@ -1373,21 +1374,19 @@ static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)<o:p></o:p></pre>
            <pre>  if (!adev-&gt;vcn.ip_dump)<o:p></o:p></pre>
            <pre>         return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>- for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {<o:p></o:p></pre>
            <pre>-        if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<o:p></o:p></pre>
            <pre>-                continue;<o:p></o:p></pre>
            <pre>+ if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))<o:p></o:p></pre>
            <pre>+        return;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        inst_off = i * reg_count;<o:p></o:p></pre>
            <pre>-        /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>-        adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>-        is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>-                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre>+ inst_off = inst * reg_count;<o:p></o:p></pre>
            <pre>+ /* mmUVD_POWER_STATUS is always readable and is first element of the array */<o:p></o:p></pre>
            <pre>+ adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);<o:p></o:p></pre>
            <pre>+ is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;<o:p></o:p></pre>
            <pre>+                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre>-        if (is_powered)<o:p></o:p></pre>
            <pre>-                for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>-                        adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>-                          RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], i));<o:p></o:p></pre>
            <pre>- }<o:p></o:p></pre>
            <pre>+ if (is_powered)<o:p></o:p></pre>
            <pre>+        for (j = 1; j &lt; reg_count; j++)<o:p></o:p></pre>
            <pre>+                adev-&gt;vcn.ip_dump[inst_off + j] =<o:p></o:p></pre>
            <pre>+                  RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], inst));<o:p></o:p></pre>
            <pre> }<o:p></o:p></pre>
            <pre> <o:p></o:p></pre>
            <pre> static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {<o:p></o:p></pre>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------0A16B0142DA998E2AC752C31--
