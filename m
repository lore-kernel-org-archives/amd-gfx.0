Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882E2C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 13:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29AB510E2F0;
	Wed, 29 Jun 2022 13:58:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0895810E2F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 13:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCSJxqgsjwzQMyzdnI1dXCmmWIOBm1lurjSZ04VEBHbhjYOnVsobyM+I3OlGuKRsA+TpSGK/PjR0UbfJNcD7Ouf7EJZOf1VcKkpRxH5sa7rY9Wsu0GbL2dxF48j8VW47o+lXRVp4lXc4e4kMyimRdAdlGgBKFOWh0pwagRkzsi7SQXeMoHV9E0wFhPtc425ROly3b5BdpqqaGfSuiJZ1enjWYNHtZDZ0Mnq9+8G37U/A6+UrksusiEcFk0Pw7bTCG6c728s3XNcm5bbyXAXyfIBJUPqlJMEkTCMgkxtlv+1dSyBImL2XVG0zOVYBLLJvvoDvYEOaqpVNYA7Th9+TUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwYuwTeXrKVk8PC5SVHwcxdPDv8r+thhE8Wcn9J9KP8=;
 b=cYTm3HlRt3f8dOleRMY5x+M4S1RqgkBwZGZqTunX2HHQG5euYUZtcJPFLFmNYZ7fdpqRwzH9sYnbW9ohZkontCK2ZMrWZpdbyBA38McItbyvbFKMt38WCuqI6rImmg4fFjySjsuN1CzYrmF3OL0xAAb/agfU61OtAoJhhDAxIWwAGM72VbMYrGtByG6AsLjo4ayGytwqjOGOrNZZoxp6gGuL0D7+gauDeIE+piPQCOrQS5ktzXELhivjzaVqITVly/GR1nH8PTa7maCM8It0t6wBPHUqKlZUgK4TGGmYDPrw16Ms518zDzkGs3RbdJeuxQ7l29Nw7lQmnLv7tCNOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwYuwTeXrKVk8PC5SVHwcxdPDv8r+thhE8Wcn9J9KP8=;
 b=STR/c3Vp2wpApmt5IZYAVFRPTa9FZczyVZA+wt4Td+hwieESaXY4NPW97OaWgJwYa9oNictGviwwsZnJp8ZXeEtIWIdk10bf9fUjBHIMIc3yMDAWAcuRzdazhCU+wa4LGb1nLjwIktL8N2LKkT5932mnsJ4bTMpFxVkg4lBvrGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN6PR12MB1395.namprd12.prod.outlook.com (2603:10b6:404:1f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 13:58:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 13:58:24 +0000
Message-ID: <3e62a389-68b8-bd38-54a9-8fdb6b630c34@amd.com>
Date: Wed, 29 Jun 2022 09:58:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Content-Language: en-US
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
References: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
 <846ecd13-edaf-c0eb-44a9-5232dca997c7@amd.com>
 <SN1PR12MB2575F5E425FB5B43CB1BF119E3BB9@SN1PR12MB2575.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <SN1PR12MB2575F5E425FB5B43CB1BF119E3BB9@SN1PR12MB2575.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88e6f1cd-7218-4741-125a-08da59d76eee
X-MS-TrafficTypeDiagnostic: BN6PR12MB1395:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxdAku52NFcorQxEe5etz0uIZn7YiIcEyUw/XC5wNn9cnFX9a1OH8rKCHdifUbnIFV4zPPefM6fcW/bD+3CjRsAB63jbyoFy1VPY3ojzB4hzViVVC+qiMWa5vQ7yZ2d6w4b0uZ1VFuSlI3U7qfpohvtrPZAvU31QSeiVbGdoQ3bhkC3IYUPGDqnxyhphUGHDkdRmV6RchjxUXI+Z7uY40qpnzk6JOD9I2r91Gze3Qei6L0bJb3mtx/X9LNjsP6A7BUWuD+ROiXEpTSc5QSqTrEwrCeSLRancRjGOBJQXHTTlM01O6TGBDX6ai8QdjhPn7goNeAeX3lrV48+KkOdwAjSlOOf86hPFjDmIzHso1SShNOi7M9JbHLzfof+bT6khNRGvVV+CVytCuk2bsS4fDiY45YrJwDvWlBmUQ7m7A2zcfke+qrqnQXsZ/0YaZtteLW2Ox7765So4EEuGGnmavSmpj9nPC9gvWo0vC04tOrcquZJsbyv0ErsDUFPjZNZLrM0BqVzxl9BNSHs8CKl7Ozy47ZnvQqbkhgBQJyZ2CIVIOsnT1mVe0BrqMA5Ld5WRdofYV/99SVGWZ3NbQKvp6qbqSs74NL6PLjZaR7STjtrgSFWucRcShHgiUBg91sEd4ODwzbEWp3yhJlL9xDPw0NLRxQri/DFQrsdYmGlz6ywTVfn2p8HablPanBeiw9DR/Unx6zsd3J/R2qd2Qo3xOoQmYCxZ5vGUey2QkAeFCGxJLJMpDmqe3WBSTRZL3LWcHMihNVsv79T9h4oREBSKjqE2gr34ZWEsdnh3A/JXDe7QU2aqj61nMzhF3s0Ajv4c3bmjWAVY/Fu+fbJPWwSB0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(6506007)(53546011)(5660300002)(186003)(6512007)(26005)(110136005)(6486002)(2616005)(316002)(41300700001)(66556008)(66946007)(31686004)(8676002)(44832011)(2906002)(8936002)(66476007)(83380400001)(36756003)(478600001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1FDN0FSNmNOYWxBbENEQ1lub2pPU21SNFVYd3NBa3p0UmU3OXpFR3hPU1Zl?=
 =?utf-8?B?aXpJVC9SdnRwRktjam5Cc1dMcmNXMkR1azJINmJoVEZkY3FFZURseGQ3dit2?=
 =?utf-8?B?Z1NNL05RVVZRclc4NG4rNlprNStvYkdCL3FDWCs4bGFPdlAyL29rb2tQeG9K?=
 =?utf-8?B?V2RSNmlzY1d6ZkdqZDJmd0pGREp4cXFZVy9mTEQrRXpjS1ZsV0JXYWs4bEU2?=
 =?utf-8?B?cHNlNGZBVGVBTGxSazUzT1czajhyUDBBbE5JYndGK3U4NDFvc29Na1NCRnN5?=
 =?utf-8?B?RjloRSt0WUl4R1gya3JaMmd5akpPMktaWXpIS0VHbVFyUStRSDdQMDVyR2NF?=
 =?utf-8?B?RkNldzlFOWJDY1I4ckFwbXlDV0dvMkhMUDhBZjNCV2JaSlllMVBjSWFjV3Vi?=
 =?utf-8?B?ak8yMnorMVl0WkF5WndSK0RUaU5FQXlKRUo5ZTFwdEpnT2twNmpoc21mdDJZ?=
 =?utf-8?B?OElIdGIvTW53L3ZCSG8zLzBvT0orOHRvdXdvT2dsYmUwK1V2YVBmMWZibjNC?=
 =?utf-8?B?NEkvckRVT2tTcE9zRmp2YWQ0OGFXQkxJdllaa0J4TFMyYUZFa0NvWFV1b0Jz?=
 =?utf-8?B?SXZCMWR5emN6K0lYNVlvd2tQaUZoL1p0U3ZOSWNSMEs1U0UycWVmZTN3azV3?=
 =?utf-8?B?Qm9VU2QwdUdpYi9WTUl4eXVqR2xGOXhyRWJoNTYxZ0FpUzV2VkhOZmE2VE40?=
 =?utf-8?B?Y0NhTHhmbVIxWDIyUC9GT2F1azRiNHdFbzBZZTAvdXRTY1FscERDakljK3lO?=
 =?utf-8?B?SFEwZGJ5MExONGZGZkdXNnhGTXFXUE9NbVFnSDJLUkFlblQxWjRzK3F3RWF5?=
 =?utf-8?B?YjlONHJPc3ZWWThla3JZT1EvS3VvK1lEVjh1emJCZVN2c2lXbGlPajh1V2NK?=
 =?utf-8?B?bjRwRENnUjVxdndtSkRTWlIyenArNU81WDM4b1FsU0cyZ0pmMDMxV3dOdi9a?=
 =?utf-8?B?V0x6THppbFJ3eG1MdlRCQ2FFZWZDTWgvdFlYdUxYYS9MbmZLRER0UjFNZXN6?=
 =?utf-8?B?eDdmSVAvYkIzd25wRGE1bVZtS2FTVGhyL1RXOVQ2WldXNEZFd1ZCeFR1V1Zj?=
 =?utf-8?B?V0NyQnN0VVFvYWFZQ2wyUmpjR29FV2hqMUJPQkJTd2dNUFVMRDdMMTlMRktU?=
 =?utf-8?B?YmFvVVp5WWJwSW55dUFGSGZLQ3d0UEtnMGIwcCtVM05hMFRVc0dTVzlBT1d2?=
 =?utf-8?B?NHd5NDlIeGJET3JUZ0lLY1JRYitZZUl1R1JVS093RExJSHJDT2Frc0c3MnhP?=
 =?utf-8?B?aXUxQ20vK0c2S2xiSUY3TXphTTRzRmVsYmJCb2lOeExkWlNvK1hkSElLOTBa?=
 =?utf-8?B?dUNxNW1UMkEvU1dTNnRLZ2FHWEtwd3pVTy9qdENBQTRSZzBWb0xRSEF5MjBH?=
 =?utf-8?B?MEhTV0wrbTR5d0hUR0tRV3FOUVNUdDQrN2xvVXZTOGhxaWZmN2FKb0gzdDAr?=
 =?utf-8?B?N2dYRVpiT3U1b0ptRVNqdjlrVDdNMlJkUm1IaFBmWG16UExiVHRpOEc0VG5D?=
 =?utf-8?B?eGx0RElBV1N3N2ZuUFhzeS9MRk9CMzVPeFZaZ2Q1ZExLcVlKcklXM0kxaXRo?=
 =?utf-8?B?UDBVV2dEU0t4d3NmbVBTSlVuV0pNMGlKV0ZJMnY4QjJLeUxWa1lObEszTFV3?=
 =?utf-8?B?eUVnWWNob3dBbVUrU0FYc0paOVh6MHJVUHNVWnJ6SDd2U3ZXQ0FPMkl1WTBX?=
 =?utf-8?B?V1F6WktMYklnamJsb3FGanZZQlNBSzJUVjVtWVE0QVRveEUxcFgxdFJ6NElN?=
 =?utf-8?B?QU1TUWUxOGNxL0xKL3NmbmxjWjhsWFZyYzk1WUJRdzJVUHlHOE5jQ0ZDQitL?=
 =?utf-8?B?TjhMRmRrVHFoTUNtc1dZR2hkb2pvTkw2MDc5MlB6anJZektyVEVRbG81S1FN?=
 =?utf-8?B?SkoxYkVKVmh1dDVRaHlGUzZFT2t0K2RoNUpsN0U5alBXZ21NNTdyclFzbit3?=
 =?utf-8?B?RHNZZDVPLzRGZjFNWjBFdGZTYTdTdVMxTFdMajhIVHMrbUh0eXB0d1JEc0tG?=
 =?utf-8?B?bDlOTWdIK3l3TVVhTDdMdC9TTUIwZnhvZnNtdXluSG5TSXRRKzJNSzhtZm9w?=
 =?utf-8?B?VVJIZ21PMnNMcmF4ZHJza0FJVWd5K1RwRnRIMFdZd0dqclVhVnp3WmxVS3Ay?=
 =?utf-8?Q?mzLdkiGv6zK3LbFmmjlLA4Bvb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e6f1cd-7218-4741-125a-08da59d76eee
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 13:58:24.1688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 293bWQ9gdeyUHlvev/81ZRr4/DL92E+1cwFqYuAGT45mBsW5f/0CWTbutFc9IhrRRTMrLMCl7Gz8yqxEfz+2Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1395
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

Am 2022-06-28 um 20:03 schrieb Errabolu, Ramesh:
> [AMD Official Use Only - General]
>
> My responses are inline
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Tuesday, June 28, 2022 6:41 PM
> To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; amd-gfx@lists.freedesktop.org; dan.carpenter@oracle.com
> Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
>
>
> Am 2022-06-28 um 19:25 schrieb Ramesh Errabolu:
>> The patch fixes couple of warnings, as reported by Smatch a static
>> analyzer
>>
>> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>    drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 36 ++++++++++++-----------
>>    1 file changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 25990bec600d..9d7b9ad70bc8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -1417,15 +1417,17 @@ static int
>> kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>    
>>    		/* find CPU <-->  CPU links */
>>    		cpu_dev = kfd_topology_device_by_proximity_domain(i);
>> -		if (cpu_dev) {
>> -			list_for_each_entry(cpu_link,
>> -					&cpu_dev->io_link_props, list) {
>> -				if (cpu_link->node_to == gpu_link->node_to)
>> -					break;
>> -			}
>> -		}
>> +		if (!cpu_dev)
>> +			continue;
>> +
>> +		cpu_link = NULL;
> This initialization is unnecessary. list_for_each_entry will always initialize it.
>
>
>> +		list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
>> +			if (cpu_link->node_to == gpu_link->node_to)
>> +				break;
>>    
>> -		if (cpu_link->node_to != gpu_link->node_to)
>> +		/* Ensures we didn't exit from list search with no hits */
>> +		if (list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list) ||
>> +			(cpu_link->node_to != gpu_link->node_to))
> The second condition is redundant. If the list entry is not the head,
> the node_to must have already matched in the loop.
>
> Ramesh: Syntactically, it is possible to walk down the list without having the hit. The check list_entry_is_head() is for that scenario.

If you traverse the whole list without a hit, list_entry_is_head will be 
true. That is also the only case where cpu_link->node_to != 
gpu_link->node_to is possible. Therefore that condition is redundant. 
Just checking list_entry_is_head is sufficient.

That said, as I pointed out below, you're still using cpu_link outside 
the loop. Therefore it's likely the static checker is still going to 
complain.

Regards,
   Felix


>
> But I'm no sure this solution is going to satisfy the static checker. It
> objects to using the iterator (cpu_link) outside the loop. I think a
> proper solution, that doesn't make any assumptions about how
> list_for_each_entry is implemented, would be to declare a separate
> variable as the iterator, and assign cpu_link in the loop only if there
> is a match.
>
> Ramesh: Will wait for a response from Dan.
>
> Regards,
>     Felix
>
>
>>    			return -ENOMEM;
>>    
>>    		/* CPU <--> CPU <--> GPU, GPU node*/
>> @@ -1510,16 +1512,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>>    		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
>>    		if (cpu_dev) {
>>    			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
>> -				if (iolink3->node_to == iolink2->node_to)
>> +				if (iolink3->node_to == iolink2->node_to) {
>> +					props->weight += iolink3->weight;
>> +					props->min_latency += iolink3->min_latency;
>> +					props->max_latency += iolink3->max_latency;
>> +					props->min_bandwidth = min(props->min_bandwidth,
>> +									iolink3->min_bandwidth);
>> +					props->max_bandwidth = min(props->max_bandwidth,
>> +									iolink3->max_bandwidth);
>>    					break;
>> -
>> -			props->weight += iolink3->weight;
>> -			props->min_latency += iolink3->min_latency;
>> -			props->max_latency += iolink3->max_latency;
>> -			props->min_bandwidth = min(props->min_bandwidth,
>> -							iolink3->min_bandwidth);
>> -			props->max_bandwidth = min(props->max_bandwidth,
>> -							iolink3->max_bandwidth);
>> +				}
>>    		} else {
>>    			WARN(1, "CPU node not found");
>>    		}
