Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D692E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 06:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE52110E266;
	Fri,  3 Jan 2025 06:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xZ8rX58n";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A86710E266
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 06:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtA0cB6C9O33uHOAjR2G9MKBckiGHTDhAvWy7gyZtkqKK9d+zoz9qD0t8gbRq3t8uDsGTK26p6CPHbA1Jww1z0d1qau2kV+/9lMFKAsz9yewnJ4jhLJGUW/17rYD1a1mw+sFr3dbd3V6FsRFTZetdiUvO0Y/MwNnwwP+zQCepjvHa/L2NACkRN77LUSdahdmlyVuc2izCXtnUvrcayNfZIWQeDTaRPfhpgu++f3asNK/8TTMlOETeAj/q2RRhv5e131FEgZ4JQ+qlBOmwd0XZKz558+7pXvmGiihScKUHdpv1QBLCMZZqpTG4JcEceEGV0STMfq7hiLctkOdaMy/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XizTKXyJ0O1OVmgDwYZhSfWyq9XFOtijkFQcEwkWD5g=;
 b=guPWX0pWauTjptsvLoNawUBDEAzYAMFNoo0ifqm+5lyr8EGpipDY2EhqsDJJ93vM4zOXGO0VKev6BInDDmOKT9Dx1vv3qsUCMsz5XzYahwCEeYh7AjE2IiUqyRd+NclVUdiQl2ZMX6MiPaMttPvuvSR/B6CvGlO0hhA5/qXcQw2GVHMk0Ez9e58LTqAqekVLLgc2s1BqkAp0CGEZldajKEjQMoCzU5j3ymbCwIl6elIwKgF2Km46o7TzIX8CJG+pGgSQX3KeF8s1i5Q9PgToTdA4+GvpW+i0mjmD5ik0Z6V1rbNI+48mP5tW09Sb08Uz1Yl5PbPNxZW+qEyUviBCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XizTKXyJ0O1OVmgDwYZhSfWyq9XFOtijkFQcEwkWD5g=;
 b=xZ8rX58nrolCM3SAR/ciKGhko9KxD1Ha1IJClzJbMnAdV4umO3zkCQU5Er22tERo5QUPSOoXevv0ljYglZh0VrV1RTrn7J/beQjPThbuOOLK4nwKnEME35xCZwVsWUhSqAiof2gzi+VFeJbvBZPtX9ptemgQcn7dhNMDqp4dC+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.14; Fri, 3 Jan 2025 06:19:07 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 06:19:07 +0000
Content-Type: multipart/alternative;
 boundary="------------XG0U1feCRx9IaFOEEYjhIEh1"
Message-ID: <cf334b81-87eb-4d19-bf03-e11ab06d8ec1@amd.com>
Date: Fri, 3 Jan 2025 00:19:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] amdgpu: fix invalid memory access in
 kfd_cleanup_nodes()
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: amd-gfx@lists.freedesktop.org, kent.russell@amd.com,
 shuox.liu@linux.alibaba.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com>
 <b835ec1b-f40b-4abb-8267-934a0e497415@amd.com>
 <3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com>
 <c7a76b1e-fabb-47be-8408-4505ddc1296f@amd.com>
 <DFEBAA6C-D1D8-42BD-8934-58011EBDBFF4@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <DFEBAA6C-D1D8-42BD-8934-58011EBDBFF4@linux.alibaba.com>
X-ClientProxiedBy: SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::15) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: caa63380-3f68-4690-e94d-08dd2bbe8796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkZRSUhRQUFUNVRGMlRSbjh1dGkyaS82clNubmhqMkNGaEkyTWkwaCtJWlZC?=
 =?utf-8?B?TDU1ZVI0UDIybjl1SEZBWXNmY0xjRDVEK2N4RHZkRVhGM21LcHdLWStLOU9v?=
 =?utf-8?B?ZkxQcGsyaHNBcytCd3R4U2dPVkQyWHowcENGVnBod3QxcTh5NndnU3JncHlU?=
 =?utf-8?B?VVIySDF0b0xjRzlkWnU4VkRITWhCMUVSRWJ3LzVlTk9IMTFjeFNDOGFFaHhC?=
 =?utf-8?B?a0xoTmQ4bmhtV0lPRkl5OVJNanFrZDBab08xQndxMlNMTEhkSjBHNWR1L3dr?=
 =?utf-8?B?YXJ4Nkcxa1RUeURlVFJkK3VQMW5WWVJMaFdGcE9ITDd1ejErc0wrQUZIdGhJ?=
 =?utf-8?B?VVNKQmQ0Rk04ejVQY0c1SytGd0lzaU01c0RSbnQxamNZVEMrdXFCZkJsNWw3?=
 =?utf-8?B?RmpHQVBkZ0xnYXpubHRQVlpqcGIxb1Q5SVUwenhHRDRwVFR5WW9mdDZwQjVF?=
 =?utf-8?B?Q3cyVWNJZ2ptZVZQWWJmdFhIQWluc1BnOHBoaXJTUVVOVFp0RnpUcVVzNDZ5?=
 =?utf-8?B?TDFJdWZhRjcxT1N3T25WbnJFd2xiZm13SWJCd1NsMkFhazZrYk9QM0RibDhC?=
 =?utf-8?B?MmtJMk96WTBMZmhqVjZUU2t5QmowYUwxL0JrdDZ5REF2TUswSXY1UU8wMFRK?=
 =?utf-8?B?bERxQjdiQjNrNkpodnB2ajdXT2dTdFI3anRiUTUvdEtKbytPeWZ6QU01MGIz?=
 =?utf-8?B?L0pGcXNmaGNMOUtFMER5QnNEL0pUYVltZFNNVERpQ0dEb0dSRTl0M0FrU05H?=
 =?utf-8?B?WHlZRlR2RlBNa0hkeitoaytTZ25HanFjR3prSkJmUS9MeDhkK05QbmM0VDdL?=
 =?utf-8?B?cnpmR2RxZlpJREpqbi9VeGpTczRVbTVYNVdneUFNc2Qyb0pSZ0x0YjdKUXNF?=
 =?utf-8?B?VEgzMWlaSk0zbnNmOVFYWTVHY2Z1dGJSTWRHNllIM3N5R29WbTlwdnBGWVFo?=
 =?utf-8?B?T2xYQUlLRm95RzNiK25oZDQvdHdUcTB3WkVSZVdFYmVhb1NoNkxCUkRMb0Ju?=
 =?utf-8?B?NkI1Y1VabjQ4YUtSeUFxM20zQXRTSDROYXVBTW15a25lb0UwUGdmZGdtWkZa?=
 =?utf-8?B?S3d5L0hldFBmUm41S2xRcHlnRkJudHBYeEVqc2lsNlVmMUZNUGRQZkxOZS8v?=
 =?utf-8?B?bWJnU3BidVhGcUZQQWl3N0FyL0FaWGdNNGhBOXBUdGUvUXZaMjZ5V01RQzZC?=
 =?utf-8?B?d2ZBZEZPSzJvSXR1eU9vRkdlWFlKdzhOdTlralUwMTZReTdFMVRJZ2xpN3Vr?=
 =?utf-8?B?eXBHQ2NnWlBDVEpCNEZYTDJsbFNEdy9RL1dzL0dWbUdmejBPRzIxb1Y5Y3RE?=
 =?utf-8?B?R0JmTXhsclh0S0ZCK21DSkNabUUvVStISERid2pNWEpSNytxZVArODBVSWRQ?=
 =?utf-8?B?WmdTbmpSa3pGZUx0dGp1bTlIaVFDa0tyaGNiTDRGUVdCMHRZR3dkNEdUNm51?=
 =?utf-8?B?VnlaVnJ4ZXF0WkFCVmtmUnZONXhjWVIxRzFJV2dHNG9vYWI0RERVL2d5NXZu?=
 =?utf-8?B?T0hIcUo0c3VudS9NdklueGxsRndnbEhXeFkvU3BmejFMZFgydXFLVUhObVdu?=
 =?utf-8?B?NGh5RzZyVzJVNUdBVUlPVzZHbkthMS93ZHArSnpid21oMDNXeFN2Smp5VUUr?=
 =?utf-8?B?NmFrek1yVWJJTWVEMVRhWVQyMTZEczd6VTRHS2svOFpYcDFUeDh2M2ZKV3Ey?=
 =?utf-8?B?b3EvTysra0h2L1g5T1ozd2JzbXNjV2dkTXhCN3BJWitNSjdQakR0VGFQWEty?=
 =?utf-8?B?MDhSRUx3MU96R1RCOTlUbXkzR3Rwc3pmdWxqbTlCOGp1SkVLTVVpQXZuNWdH?=
 =?utf-8?B?citzM25ESkJ6OW1yeE53S0hET1cydlJyZXowZFZIUHJwNllYN2RhbVZmTFNR?=
 =?utf-8?Q?+BOm4jEYlIlx/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVdqWGF0NVFvOHVOa2llcmU0N25OZmwvajRseEZ2T09JcTk0bEJYYi9sZnc0?=
 =?utf-8?B?bUdkRFpnM2xNVmhRam5FK0QrdmtoVDBTL001ZUpHSTk0bFJxcHBYZGtMV1c5?=
 =?utf-8?B?YzZsOGFrKzdDZzMrS2lwOE53dEZkU0tZYTFKVjl5NlNxaUNxNDR5OHVYQjdU?=
 =?utf-8?B?cEtaQVUzRGxiMkJoSFVjdUtjNVBTS3BsNG4rTkNyOGRUekdEQTZmVnZCSGhK?=
 =?utf-8?B?Vkc2VkZXNWlQV2tkZld1VWhOSjBESzZjOHRwLzR1OE40ODZ4Rk5PNmRtL1lD?=
 =?utf-8?B?OGZRSUkvYWw5WFBvT20xOGdQRWZVSWUwSUFyYUd3Q00yYm5oeDhUc3VONjg5?=
 =?utf-8?B?Z2NwdDhkWTduZFc0SSs1Qi9KMXQvSHZqTDdlM3lHalZFVVExOVM3b1d6clJB?=
 =?utf-8?B?a0phekNtekRKWFU4QUdCUENkZ2FZYXNnZXRhRFpUMitFZDR2MmY4VVVUcHhD?=
 =?utf-8?B?OTF0cG1SWGVsOE1GZlB6YW5qUGJjYWJTbmxDZGRYMHRxTjdTMG4yZ2hNd2hG?=
 =?utf-8?B?TnBadVN3ZWRGZitGUmFEc2xUSy9hR1hNVUhPRWRWbmprcms2YTU5M0hkUnF1?=
 =?utf-8?B?OU0vVlhwRFJHbDl2V2h5SkRrQ0VYcFFBbDZYZG0rZUFEcm9wQTU3OTVJcTJH?=
 =?utf-8?B?M0RLam9WZ2pIUWN0STVzQUtkNVFtTXdldksxbDZTR3g0c0svUzE4ZzJWR2hr?=
 =?utf-8?B?dUU2ZnN2NUl2UEF5dVlnZ2dCNDdyNVZCcmVlNFBMcTVsRWVkSjRQRnBRT0RJ?=
 =?utf-8?B?d0FwQVFMN0lLSk5KejZ5S3JqWExMUGRBcXFZU1pRZ2xxZzFPZVdOd0YzTXBZ?=
 =?utf-8?B?Ui9qK1o3MWVNRGc5cmFGYVg2R0M1eHQzVUFJU04rUWtOT0ZBajlqMWI5Uklo?=
 =?utf-8?B?TTlSdEM2STAweGtvaWtjaGxuMXE5VFU3MWVSVTl4VGNhVC9RZXpTZlpxQldz?=
 =?utf-8?B?NHBvbjZRZ0NBV240SEhSWXVhZ0xJdWwzaWRLVFBGU2o4Rk13QmtrbDVBa3Ix?=
 =?utf-8?B?RXN5YTY4R0lFOFNvZXA1RkJrOWpRRW9VLzEyRGQveGdrTlZMTU1RZlZJUXpt?=
 =?utf-8?B?MjNxMHlWUVppb1NTTjl1ZDN4UW5qVjFZY0wzdGRIWU1PRGdidm53MGZHTzVV?=
 =?utf-8?B?ZmszSThiTmEzTTkxLy8vZk9sd1Y1b083S3l6UjdGckFUWXJsRkcrbUlkbkVY?=
 =?utf-8?B?VDNXaUI2WmQzcU8yNXRvR1J4Q2x1ckZtUnhQT0NnbEpiQ2xZYkFVNzFlcXZ5?=
 =?utf-8?B?TXI4MFZNTnh6UlpRc2lsVGZXQndubSs3TWZmSDdlRGhNYWVpVXVMakFFeDly?=
 =?utf-8?B?Rnd3RE9CRXh3bExLSWlmRm5WVGx0emdwbXdudW5zY1M5QnlOSGIyR2phanVT?=
 =?utf-8?B?akY1S29raFFPNUxwKzRjWHBlTTl2Z29mb3BTcEV5eXZHOHc1RENUL1NpbE5S?=
 =?utf-8?B?TFl4OWlGK1BGSldaMVhzdmpFS21NRzFqMTlGclF5NlJ2Q3pyNnU5TVJXR2Rk?=
 =?utf-8?B?R3YvTzZxNFdwVlVBWmtjc3VsYjgwZ0xMRm1URlZVTFFMdWc0TVBLcklraXEw?=
 =?utf-8?B?OUkzTWQwMm9aTEs2cXBZYXZoaVVDcU5ZZE1MSGd0dVl4eEJXUGd2UHNKVXFo?=
 =?utf-8?B?NDhxbGV6S0s0bk0zVHRjSmlyRVM5MlFyYUdlVmx5c2dHT0VlZWd5TG1OTWYv?=
 =?utf-8?B?WlNEazRwMHcvSDE1VHhqQ1c2NmRqME5QZnErWmV1Ny9Obzlmd3RGd0dBTzZX?=
 =?utf-8?B?RUdVQ0Z4dERZald2TXliWS9ZYWY5Vy9IRXNFMzFpODBtTjRFdFAwVWExNWhi?=
 =?utf-8?B?dDVyMnFXYjdoRVR5WERZMDZjWG04R3ZDa3l0aE9qTXorUVdNZXVHWlBZLzJl?=
 =?utf-8?B?OEkzT2N5ZXV6dVBhdmh4WjJSNlhyOXdKS21ISXp3UXlibG5Uemkrd2t2Tmox?=
 =?utf-8?B?R3MyNkcvcGNkdUx1VnVmSStTcFpPYWF3RmtNTzBiRXFsSnVhekFiTis1bzRi?=
 =?utf-8?B?aDZwa2d3dXp6cTg2MEFYTHJzRG1PQ3RHanBoU1ZJb1J0bm5JZHUvSW1uaDM3?=
 =?utf-8?B?em1iQ1lIcGxmSlFDR3RYL3JJYjBxWDRmcitLcmNMeEY1bjNtTlk2U3BMM21l?=
 =?utf-8?Q?RTxc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa63380-3f68-4690-e94d-08dd2bbe8796
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:19:07.6786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTlZnyzkZSIxiW9+N9TUX3iEUHZNbyk0HmaSIVVkaSsejN38luoxF6LETPOqSVGl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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

--------------XG0U1feCRx9IaFOEEYjhIEh1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/2/2025 11:55 PM, Gerry Liu wrote:
>
>
>> 2025年1月3日 13:44，Chen, Xiaogang <xiaogang.chen@amd.com> 写道：
>>
>>
>> On 1/2/2025 8:22 PM, Gerry Liu wrote:
>>>
>>>
>>>> 2025年1月3日 07:08，Chen, Xiaogang <xiaogang.chen@amd.com> 写道：
>>>>
>>>>
>>>> On 1/1/2025 11:36 PM, Jiang Liu wrote:
>>>>> On error recover path during device probe, it may trigger invalid
>>>>> memory access as below:
>>>>> 024-12-25 12:00:53 [ 2703.773040] general protection fault, probably for non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
>>>>> 2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
>>>>> 2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>>>>> 2024-12-25 12:00:53 [ 2703.809188] RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
>>>>> 2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 45 e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 00 00 00 0f
>>>>> 1f 44 00 00 55 <80> bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d e9 65 df 9d f4 8b
>>>>> 2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: 00010202
>>>>> 2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: ffff97ad689a3ff0 RCX: 0000000080400014
>>>>> 2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: ffff97ad627e93d8 RDI: 52445f4749464e4f
>>>>> 2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: 0000000000000000 R09: ffffffffb5814c00
>>>>> 2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: 0000000000000001 R12: ffffb5313df07e98
>>>>> 2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: 0000000000000001 R15: 0000000000000000
>>>>> 2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) GS:ffff98a93ec80000(0000) knlGS:0000000000000000
>>>>> 2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> 2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: 000001008fc50001 CR4: 0000000002770ee0
>>>>> 2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> 2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>>>>> 2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
>>>>> 2024-12-25 12:00:54 [ 2703.935444] Call Trace:
>>>>> 2024-12-25 12:00:54 [ 2703.938962]  amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
>>>>> 2024-12-25 12:00:54 [ 2703.946080]  amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
>>>>> 2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 [amdgpu]
>>>>> 2024-12-25 12:00:54 [ 2703.959789]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
>>>>> 2024-12-25 12:00:54 [ 2703.966501]  devm_drm_dev_init_release+0x42/0x70 [drm]
>>>>> 2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
>>>>> 2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 [amdxcp]
>>>>> 2024-12-25 12:00:54 [ 2703.983906]  __do_sys_delete_module.constprop.0+0x138/0x2a0
>>>>> 2024-12-25 12:00:54 [ 2703.990775]  ? exit_to_user_mode_loop+0xd6/0x120
>>>>> 2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
>>>>> 2024-12-25 12:00:54 [ 2704.001166]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
>>>>> 2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
>>>>> 2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0
>>>>> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>>>>>
>>>>> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> index b6c5ffd4630b..58c1b5fcf785 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> @@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
>>>>>   
>>>>>   	for (i = 0; i < num_nodes; i++) {
>>>>>   		knode = kfd->nodes[i];
>>>>> +		if (!knode)
>>>>> +			continue;
>>>>
>>>> I wonder how knode can be null here? kfd_cleanup_nodes is called by 
>>>> kgd2kfd_device_exit under condition if (kfd->init_complete). 
>>>> kfd->init_complete is true only after all kfd node got initialized 
>>>> at kgd2kfd_device_init. If kfd driver init fail kfd->init_complete 
>>>> would be false, then kfd_cleanup_node would not get called.
>>>>
>>> Hi Xiaogang,
>>> It may get triggered on error handling path of 
>>> ‘kid2kfd_device_init()`, when it jump to label `node_alloc_error` and
>>> then call `kfd_cleanup_nodes()`.
>>>
>> If it was the case kzalloc failed. That means there is no memory 
>> available even to allocate struct kfd_node. From the backtrace the 
>> general protection fault happened at
>>
>> RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
>>
>> It happened during driver module got released, not init time. I do not see how the patch is related to the issue you talked.
> Aha, it’s caused by another bug which got fixed by "[PATCH 4/6] 
> amdgpu: fix use after free bug related to amdgpu_driver_release_kms()”.
> Without the fix in "[PATCH 4/6] amdgpu: fix use after free bug related 
> to amdgpu_driver_release_kms()”, kgd2kfd_device_exit() will got called
> twice in case of device probe failure. I caused me some time to figure 
> out the double free issue.
> Actually we should reset kfd->init_completed to false in function 
> kgd2kfd_device_exit().

We can set kfd->init_completed = false at end of kgd2kfd_device_exit, 
but how kgd2kfd_device_exit was called two times? is there another bug 
caused that?

Regards

Xiaogang

>
>> Regards
>> Xiaogang
>>
>>
>>
>>> Thanks,
>>> Gerry
>>>
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>>   		device_queue_manager_uninit(knode->dqm);
>>>>>   		kfd_interrupt_exit(knode);
>>>>>   		kfd_topology_remove_device(knode);
>>>>> @@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>>>>   		kfd_doorbell_fini(kfd);
>>>>>   		ida_destroy(&kfd->doorbell_ida);
>>>>>   		kfd_gtt_sa_fini(kfd);
>>>>> -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>>>> +		if (kfd->gtt_mem) {
>>>>> +			amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>>>>> +			kfd->gtt_mem = NULL;
>>>>> +		}
>>>>>   	}
>>>>>   
>>>>>   	kfree(kfd);
>>>
>
--------------XG0U1feCRx9IaFOEEYjhIEh1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/2/2025 11:55 PM, Gerry Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DFEBAA6C-D1D8-42BD-8934-58011EBDBFF4@linux.alibaba.com">
      
      <br class="">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">2025年1月3日 13:44，Chen, Xiaogang &lt;<a href="mailto:xiaogang.chen@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">xiaogang.chen@amd.com</a>&gt;
            写道：</div>
          <br class="Apple-interchange-newline">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <div class="moz-cite-prefix">On 1/2/2025 8:22 PM, Gerry
                Liu wrote:<br class="">
              </div>
              <blockquote type="cite" cite="mid:3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com" class=""> <br class="">
                <div class=""><br class="">
                  <blockquote type="cite" class="">
                    <div class="">2025年1月3日 07:08，Chen, Xiaogang &lt;<a href="mailto:xiaogang.chen@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">xiaogang.chen@amd.com</a>&gt;
                      写道：</div>
                    <br class="Apple-interchange-newline">
                    <div class="">
                      <div class="">
                        <p class=""><br class="">
                        </p>
                        <div class="moz-cite-prefix">On 1/1/2025 11:36
                          PM, Jiang Liu wrote:<br class="">
                        </div>
                        <blockquote type="cite" cite="mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com" class="">
                          <pre wrap="" class="moz-quote-pre">On error recover path during device probe, it may trigger invalid
memory access as below:
024-12-25 12:00:53 [ 2703.773040] general protection fault, probably for non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
2024-12-25 12:00:53 [ 2703.809188] RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 45 e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 00 00 00 0f
1f 44 00 00 55 &lt;80&gt; bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d e9 65 df 9d f4 8b
2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: 00010202
2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: ffff97ad689a3ff0 RCX: 0000000080400014
2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: ffff97ad627e93d8 RDI: 52445f4749464e4f
2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: 0000000000000000 R09: ffffffffb5814c00
2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: 0000000000000001 R12: ffffb5313df07e98
2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: 0000000000000001 R15: 0000000000000000
2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) GS:ffff98a93ec80000(0000) knlGS:0000000000000000
2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: 000001008fc50001 CR4: 0000000002770ee0
2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
2024-12-25 12:00:54 [ 2703.935444] Call Trace:
2024-12-25 12:00:54 [ 2703.938962]  amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
2024-12-25 12:00:54 [ 2703.946080]  amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 [amdgpu]
2024-12-25 12:00:54 [ 2703.959789]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
2024-12-25 12:00:54 [ 2703.966501]  devm_drm_dev_init_release+0x42/0x70 [drm]
2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 [amdxcp]
2024-12-25 12:00:54 [ 2703.983906]  __do_sys_delete_module.constprop.0+0x138/0x2a0
2024-12-25 12:00:54 [ 2703.990775]  ? exit_to_user_mode_loop+0xd6/0x120
2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
2024-12-25 12:00:54 [ 2704.001166]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0
00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48

Signed-off-by: Jiang Liu <a class="moz-txt-link-rfc2396E" href="mailto:gerry@linux.alibaba.com" moz-do-not-send="true">&lt;gerry@linux.alibaba.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b6c5ffd4630b..58c1b5fcf785 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 
 	for (i = 0; i &lt; num_nodes; i++) {
 		knode = kfd-&gt;nodes[i];
+		if (!knode)
+			continue;</pre>
                        </blockquote>
                        <p class="">I wonder how knode can be null here?
                          <span style="white-space: pre-wrap" class="">kfd_cleanup_nodes</span>
                          is called by kgd2kfd_device_exit under
                          condition if (kfd-&gt;init_complete).
                          kfd-&gt;init_complete is true only after all
                          kfd node got initialized at
                          kgd2kfd_device_init. If kfd driver init fail&nbsp;
                          kfd-&gt;init_complete would be false, then <span style="white-space: pre-wrap" class="">kfd_cleanup_node would not get called.</span></p>
                      </div>
                    </div>
                  </blockquote>
                  <div class="">Hi Xiaogang,</div>
                  <div class=""><span class="Apple-tab-span" style="white-space:pre">	</span>It may get triggered
                    on error handling path of ‘kid2kfd_device_init()`,
                    when it jump to label `node_alloc_error` and&nbsp;</div>
                  <div class="">then call `kfd_cleanup_nodes()`.</div>
                  <div class=""><br class="">
                  </div>
                </div>
              </blockquote>
              <p class="">If it was the case kzalloc failed. That means
                there is no memory available even to allocate struct
                kfd_node. From the backtrace the <span style="white-space: pre-wrap" class="">general protection fault happened at </span></p>
              <pre wrap="" class="moz-quote-pre">RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]

It happened during driver module got released, not init time. I do not see how the patch is related to the issue you talked.
</pre>
            </div>
          </div>
        </blockquote>
        <div>Aha, it’s caused by another bug which got fixed by &quot;<font face="PingFang SC" class=""><span style="color: rgba(0, 0, 0, 0.85);" class="">[PATCH 4/6]
              amdgpu: fix use after free bug related to
              amdgpu_driver_release_kms()</span><span style="caret-color: rgba(0, 0, 0, 0.85); color: rgba(0, 0, 0, 0.85);" class="">”</span><span style="color: rgba(0, 0, 0, 0.85);" class="">.</span></font></div>
        <div><span style="font-family: &quot;PingFang SC&quot;; color: rgba(0, 0, 0, 0.85);" class="">Without the fix in &quot;[PATCH 4/6] amdgpu: fix use
            after free bug related to amdgpu_driver_release_kms()</span><span style="font-family: &quot;PingFang SC&quot;; caret-color: rgba(0, 0, 0, 0.85); color: rgba(0, 0, 0, 0.85);" class="">”</span><span style="color: rgba(0, 0, 0, 0.85);" class=""><font face="PingFang SC" class="">,
              kgd2kfd_device_exit() will got called</font></span></div>
        <div><font face="PingFang SC" class=""><span style="caret-color: rgba(0, 0, 0, 0.85); color: rgba(0, 0, 0, 0.85);" class="">twice</span><span style="color: rgba(0, 0, 0, 0.85);" class="">&nbsp;in case of
              device probe failure. I caused me some time to figure out
              the double free issue.</span></font></div>
        <div><span style="color: rgba(0, 0, 0, 0.85);" class=""><font face="PingFang SC" class="">Actually we should reset
              kfd-&gt;init_completed to false in function
              kgd2kfd_device_exit().</font></span></div>
      </div>
    </blockquote>
    <p><font face="PingFang SC">We can set </font><span style="color: rgba(0, 0, 0, 0.85);" class=""><font face="PingFang SC" class=""> kfd-&gt;init_completed = false at
          end of </font></span><span style="color: rgba(0, 0, 0, 0.85);" class=""><font face="PingFang SC" class="">kgd2kfd_device_exit, but how </font></span><span style="color: rgba(0, 0, 0, 0.85);" class=""><font face="PingFang SC" class="">kgd2kfd_device_exit was called two
          times? is there another bug caused that?</font></span></p>
    <p><span style="color: rgba(0, 0, 0, 0.85);" class=""><font face="PingFang SC" class="">Regards</font></span></p>
    <p><span style="color: rgba(0, 0, 0, 0.85);" class=""><font face="PingFang SC" class="">Xiaogang<br>
        </font></span></p>
    <p><span style="color: rgba(0, 0, 0, 0.85);" class=""></span></p>
    <blockquote type="cite" cite="mid:DFEBAA6C-D1D8-42BD-8934-58011EBDBFF4@linux.alibaba.com">
      <div>
        <div><br class="">
        </div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <pre wrap="" class="moz-quote-pre">Regards
Xiaogang


</pre>
              <div class=""><br class="webkit-block-placeholder">
              </div>
              <blockquote type="cite" cite="mid:3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com" class="">
                <div class="">
                  <div class="">Thanks,</div>
                  <div class="">Gerry</div>
                  <br class="">
                  <blockquote type="cite" class="">
                    <div class="">
                      <div class="">
                        <div class=""><br class="webkit-block-placeholder">
                        </div>
                        <p class=""><span style="white-space: pre-wrap" class="">Regards</span></p>
                        <p class=""><span style="white-space: pre-wrap" class="">Xiaogang
</span></p>
                        <blockquote type="cite" cite="mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com" class="">
                          <pre wrap="" class="moz-quote-pre"> 		device_queue_manager_uninit(knode-&gt;dqm);
 		kfd_interrupt_exit(knode);
 		kfd_topology_remove_device(knode);
@@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&amp;kfd-&gt;doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, &amp;kfd-&gt;gtt_mem);
+		if (kfd-&gt;gtt_mem) {
+			amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, &amp;kfd-&gt;gtt_mem);
+			kfd-&gt;gtt_mem = NULL;
+		}
 	}
 
 	kfree(kfd);
</pre>
                        </blockquote>
                      </div>
                    </div>
                  </blockquote>
                </div>
                <br class="">
              </blockquote>
            </div>
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
  </body>
</html>

--------------XG0U1feCRx9IaFOEEYjhIEh1--
