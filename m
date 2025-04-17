Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D740BC369C2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 14:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8541010E273;
	Thu, 17 Apr 2025 14:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r1dl9Wi2";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F0310E273
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 14:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqwCMtSSpe2c1U4SJS/qA7F7HmeGfnL5kNBqnghQxKt9fU0D8t8YBsjP3yZodggUnSKOE53t+5UIgzkuBr1H3/R/NpouaaUin1/6YSGbP7uTU/aTiS9ubOc2Dm3VusczAtNSVJ+BQF++jEyQlOzrNtrET7gjSRxtFwZiH9nZ0abJszEgnu5jK50B5MzCGvQLR/IyKsGM3kuyz9Ez7T1W6VV2SNRE26UKljQSwYoiwb9itrX1D1W8U9E5io83bKCtf65PWvZRwTaXmnmBVb++maocR58Xr4imU692i4o3Nn00rxBmXTMDd5mE41iAVW8onBB/iNrk5VluXjhQx5qDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPRFn/pG+mPtChTW9qblov5+AL26pHEmLbnPk+xZygM=;
 b=VXEydMOb9LfJyUU/ksOZjf5ETk6v6i1ztyWXhNhPoz0QXfP7BJGIJnK2yxhyA2LEin5nEXVRtexcDgyCTFcxpjaZJ0/fXBEJUr/MZx+2LcucmxensQAN16oD86cARI+n396M3UyyIH6GQAV/CYPPMR20pPoOiMh4Qx7TAtjslKUdgy/U3oyVJks19un8kHBBQZTirxT/ccFwHoGgDrOr2jl+l88SuECwMnCFgE3p9NOCEvfblDbEvYvn0g4/JIsCntcuAGs10A6OUctsG7wlckipEaaoHq2/bz/1W5fVHcej0J4jqbMfMGNju4dEVSfHUgP8E/OhfYhHcrJjZIjigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPRFn/pG+mPtChTW9qblov5+AL26pHEmLbnPk+xZygM=;
 b=r1dl9Wi2XxWv9b3FGRf/+rWM5J56htjJJ0LPnvlNJiuPu5lvhkWeROzsMBPjBACbwHs3DkoufQcD3UyL8PK6ySRVszttx0AE9p0srL3yzvDUii1R6ZBa+iZX/LX2in3lVlvjtX8QEMrcO7vhU4sLi1bJ9+X1AYyxd1wJn39khzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 14:14:14 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 14:14:12 +0000
Message-ID: <2b6fc77b-9b71-b18a-1e80-a5cab04e5e09@amd.com>
Date: Thu, 17 Apr 2025 10:14:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix some kfd related recover issues
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250321105200.1661803-1-Emily.Deng@amd.com>
 <b27f2a75-1d42-44df-bb62-7070d93848bc@amd.com>
 <CO6PR12MB54115099731812C703C96DA28FDB2@CO6PR12MB5411.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <CO6PR12MB54115099731812C703C96DA28FDB2@CO6PR12MB5411.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 063f33ce-60f6-4bb6-2124-08dd7dba20eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mi9YRThRQ0J3WDZKaFE3ODFwVVU3UGo0RGE0MmM2bThPeThuRTNCM2ZjQm45?=
 =?utf-8?B?cXFpay9sdnk1OUNhK1lnQUVIN1cvSm1tM2tOckRJbWRFTzBDVWxibFJUdmFi?=
 =?utf-8?B?MDYwQ1Y2Yk95QVdGbkEvN01oWUNGK3RKUEwwMmJXTzR5ejhyeTRyWGNnNE0y?=
 =?utf-8?B?R3k3T3ZHYlBvNE9iS2xaWlFUY2tNNHlINXptWCtkR2Vkd1JwUGh2M2JRS3BK?=
 =?utf-8?B?aG11eEdQWXZoNk5mdjNzK1U0UVp1aUtkbTRhOFNiTWJQODl1YmhhQm9kK0JQ?=
 =?utf-8?B?dkFQMWtCWGtiUmhDYW1jM2srL2ozNzlZYkFNcnI1cjN5YmUrUmZwVXIzdC90?=
 =?utf-8?B?WWpWOW1UMURkMnpGWVM0QlA3WWdSTVhvQVpSU1p5Z3N3WndQSXgwUnA3MENj?=
 =?utf-8?B?VGY1eWdtaFJ3WXRtYW54VUkzNVgydzE1MmZJY3dNUVR6NERRNHBtMkkxQWMx?=
 =?utf-8?B?bnBGTGNZcUJmVFJHd3V0YzgyNkhSVEVqSkZKMmVTUzQ2RGZkNFlPL05tQy9w?=
 =?utf-8?B?RVJQTDFoMG90bGt5Z21IZTM5ZHVXR3JvMlhQbXR1QWU0SWVNb2ZVdjRJTzl4?=
 =?utf-8?B?NmxZWHM5WUhmaGZJaW1lSURuQ1lvelU3VlpQeldJUDZ3NVlBeE9RTzNLL1g4?=
 =?utf-8?B?dDlmSU5jNG1sSHV4YnJOM3FGbDB1RzBFdVZuVTVzVHlHT2c3TFlsdDEyQ3d2?=
 =?utf-8?B?Ly9YNkRRUEpTQXJRSWJyK2c0YjQveXI3R1ZIL0IwMStRMk1La05nb2hKUVpn?=
 =?utf-8?B?Y0ErY212Q3ZXNUU5SkRtV3J4OHk5WFNRa3YrWWcxakVRYXRmNWN2MnlMOXUw?=
 =?utf-8?B?NS9LeG00UlMrSG90aGFFQTBaSTR0VmlTbm5OR3pyT0YxUzR3UGhJaHZrNHdM?=
 =?utf-8?B?bG96Tnk2VE1sK21XNWRKVHBEM3dvWGduR3JhK200OEFhdDZtRlFGQVMyOTFJ?=
 =?utf-8?B?V1M3dnRGT0twUnZNT3g5eFpIeUhtR2tGTVdhWDFTTVdMbEpBOVQrWVRncW1l?=
 =?utf-8?B?bFY2bXBaaGN2ZGExQStoYU5GOVRMOUtUNzFuVUVJSnZjRmwxcFhxdW5QNXI2?=
 =?utf-8?B?K2puTWZLUkhSUVh4NUU0TEtxbXMvejc2RkF5dTJyM0FJQ0hMMmwweDl6NmJH?=
 =?utf-8?B?MFQ0bFVKaUU1T09sNS81cGhPYjVYUUZQdmJXbWdScEwwWmdHU25HNWg2NHow?=
 =?utf-8?B?M0lMd0tROThoOXJESXNVcFM0V3YwSzE5Mm8rM0k2TjNGazdaQ3JaK1NDRSsr?=
 =?utf-8?B?cXV1eit6NkpRRWMvbVUzQU1EL2p4b2dFT0IybzRTRlFwbldMbWJyUlV2N0hL?=
 =?utf-8?B?T1ltQk5acXN2MG1ZemxSS2I0Vnk2eDZleU1tS2JrQWtoTHFWeHE5eVR3UjFj?=
 =?utf-8?B?N3IwQm4xSk94RmNyRGJQUStxTHRleDhMSTNjZjllL2hTcUFtME8veE9CakNN?=
 =?utf-8?B?LzA5S0ROd3NKdVdvRmljQkVYYlA1b2hCa2FsaGk4aG01dENxSXZwZDNrL2s1?=
 =?utf-8?B?anpaWG42bnREVjloUHE3eFFEdVYrUThTeGJESG94YTljb05iMUh1WmxPTkRj?=
 =?utf-8?B?ZmtNQTZtYzFOOVFEcnZLYWJsMG54aWl0aGQwVElXRllxR0VZUDhyQkJRVVVY?=
 =?utf-8?B?M041R2x6MnNseTBSQXo4My9KMFIrbGx0OUJpcnRqYVoyaWx0TFVSWklTY25w?=
 =?utf-8?B?aVk1TG0yWVYyK2JnaHliMUZxK1JhOG9aeFhOZnFMQ2FER3l5d3V4S2h1OWk2?=
 =?utf-8?B?b3o1U09GVjAvbmppTDcwUW9lbmlNRG1FaUNzVlFqOTFzWjdkRDNydElXdWNG?=
 =?utf-8?B?VXc1b21tN2tpdlY2b3BQSmRZM0dTc1ZFMFBBdWY4R3hYS201M3ErcTBjeGQv?=
 =?utf-8?B?RjhQcWhvT0p2ZEcxRmFJVm1mOHpwM2d4Ym9ETXhFZEZ2WWY2S2ZxT2loREVy?=
 =?utf-8?Q?N18T1bCteno=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRIdHY3Q29SUkpEbCs0NDRxOVgxYWJVaExEanJMN28zRVV6bDhYZ0M1b01R?=
 =?utf-8?B?elhsQ01WV2lRUERrcmNBVVRvU2NlRmtQM1E1RUkrdzZpcjc3UHR4a1ZLdVhr?=
 =?utf-8?B?SXJBeXRQKzdReHB2VXJpWjVJSHZoNkNtS2V3MXBmME9JdGtiNkNRZVRrZjVQ?=
 =?utf-8?B?ZW5zYURLbXdyYWNzSFpBSjJsNlk3cGY1UDVGUG52VmhET3hLTzlvZzNTY25K?=
 =?utf-8?B?R3luTHhLcVJHQWlxWkRjL1RmL0RSQTZSR2Z0SlhlRFBaMzFKNFVuYTJWc0lE?=
 =?utf-8?B?TEhrMlQ3ZTNuV0llSDE1TFJCaXNlY0xmOFVJbzM0eHJJekZ6R1lQRUlDQ0pE?=
 =?utf-8?B?KzA1Z1hhZE9IRUgxVGVZR0RqR3pOS0RGK2ZsaHhlYUowaEw0aDFiMC9KTjBy?=
 =?utf-8?B?eWVsOUNkTFBscnFpS2tTU1NqckI2OVFJMW5EUG1tTHovYkgybGlab3VBb3FS?=
 =?utf-8?B?TEQ5bG1pQjBCNzZuWUhyRnkzRG1BajlVQmdJeW9nV01tY2RzbitUY3dGL1Uw?=
 =?utf-8?B?NlpxUHlZRE1PWHdpVGlWS3gyNnZKc1g2WmoxZHhOYlRkb2RWY3ZOL0lSb0RX?=
 =?utf-8?B?SStCYzZYZnFIeTBQdmNWZVhpeG1mcXRIcEdaZnR3dWIzUzRtNHBDRUJtTnN3?=
 =?utf-8?B?b3JCMUxsZnNoWlY3WW50Nmwyd0VYUHBGV3kvVUllUjN5N3dMazN6d2h1MHdR?=
 =?utf-8?B?aEN1VXBVNXNRRE9FSzQxRWFTaXBBdGVlYmR6Z3cvT3lDMjhMTmJyeEI4ZEFu?=
 =?utf-8?B?eEFvQ0ttMVd0V1Zid1VNcTBlVlcrODJrMW1RWlh2MFluVENUdHQyVFhhWjJR?=
 =?utf-8?B?Zk9qNUorcFdud2dQR21YYmdnWmYydHJSU3BWalU5eE5BdStlZUJMTmpsd0R2?=
 =?utf-8?B?UFhGb3RwRXRhM2pldE53b0d2aDdNdmUyd0VnN3NQcDFRa2E4b0FVSjJ3bGMx?=
 =?utf-8?B?UXZya1BWOE9kWi9JTGZZVFd1d3V4elIrc3FKVjRJZ1h4aVllSDBmbFNTa0Yy?=
 =?utf-8?B?RUZLNWdGaFJYdmpZZy9ldUN3em5LbUpSMWMxTVB2Q0p5YUxqNitSZnNBV29E?=
 =?utf-8?B?R3RZOVNuY01xaHR3YWhHK2IyNnJmN3djNTcyS3dDZXZrVmtBbnhabFRuM1U3?=
 =?utf-8?B?cDY0RmNaQUxYRkhtYkZ0N3Q0Rkw2c21rU3JiRk82T2lQTVpEWlkzcDQyN21P?=
 =?utf-8?B?RVBCZVBKZ1lJZGRRY2JjbDU1eXdwWmxYTGxCTjAweGtCMFBuYVJ6aytrdjZl?=
 =?utf-8?B?U0VOZFRpeDR2eVRiT1FwYWR6MkZGa3ViZ2VQMUlYVkRlTTgwRlNsWjNISTQ3?=
 =?utf-8?B?Snp6MUxDYjB5b3M5ZzIyYlUyWW1iSGVZdk5UelRNNkl5UlQ4QmgrbmQ4ZkZS?=
 =?utf-8?B?VzlEeFJCdEZZL3c1ZXN1NHZEaFZPWU5qdVkrU3hOWjRReklGSDFUUzRyZGg2?=
 =?utf-8?B?RzJjMEdVZmJ3bkdRYzdHdFgrU25IUEU3TVUzZmpJL1JWL0o1UGo5RktGYnlH?=
 =?utf-8?B?RmE4SnprTDMyU2ttK200YUNKdkVyTHF1NVNNOVllS2JzaHVmakdnZWk0V3lC?=
 =?utf-8?B?WHhpL0swNW1zU0V1NG1Lc2NJdDBZaE5JeE1hajJ6Wldad3NkQlYyR0hWcFA0?=
 =?utf-8?B?Zlg1eHY4SUFpZXFvc29FeGQ1L3dwZlhHWnl6UHpXZFNkWHU2RjJwR3c2aEd5?=
 =?utf-8?B?bFo5VGsxRitRdVM3OVdHOFJ4UWFLVEpSSmZmbStWaFVkMFFlZm50cGJQdDg0?=
 =?utf-8?B?aS9uOUJ1MXpwcnM4YlJoKzd2NHpaME9vOGxRSFdwODVRSWlUMitDck5iYzRu?=
 =?utf-8?B?Q0N6aE9FUkxpTVQ3TlFZM0FiN1RvcklyaGJReWgwOURtZ21WUFNVV2J3SGRs?=
 =?utf-8?B?anJiZTdhNWRSY0NGV2l1eU1TQ3ZxcG5WUmljcnNLb0JVUUhMSWVLeHBQQ0ZQ?=
 =?utf-8?B?NElFU2VSVSs5TldRanRqSTk3Yncyc2ZwNWJJZWNFdVYrK0M5S0tyNjdZNzlG?=
 =?utf-8?B?UmZqeFhXMUZKQUZaNWpXTUx2T0s1RUxybmNSU0drMmNseml5RHd5TVRHTy9H?=
 =?utf-8?B?djBmTUNSaGdKWkxQcmxHNDloVHUrdFEyNlYyN2NyemJBbExWQXduSHlFenBj?=
 =?utf-8?Q?R658=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063f33ce-60f6-4bb6-2124-08dd7dba20eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:14:12.8676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxc/jAJEyc9y1YqId3HgE3WUGtqVBCWN5kGr6+ZWKcOrdo2siWkW1CJGlFGjUUF3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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


On 2025-03-21 19:35, Deng, Emily wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, March 21, 2025 7:06 PM
>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: Fix some kfd related recover issues
>>
>>
>>
>> On 3/21/2025 4:22 PM, Emily Deng wrote:
>>> It need to check whether kq has been initialized correctly in
>> kq_acquire_packet_buffer.
>>> Or it will hit memory corruption during recover, as for recover, it
>>> will uninitialize kq first.
>>>
>>> Need to flush tlb after recover successully, as it maybe has create bo
>>> and map bo during recover.
>> Is this related to any specific type of 'reset'? For mode-2/mode-1 type of resets,
>> expectation is GC as whole is reset which includes GPU VM block.
>>
>> Thanks,
>> Lijo
> This is an FLR (Function Level Reset) for SR-IOV. But for both mode-1 and mode-2 resets, the GPU VM block is reset as well. In the case prior to the reset, there was a mapped KFD user mode buffer object (BO). After the reset, the page table cache also needs to be invalidated for the corresponding PASID.

This is misunderstanding, KFD processes are aborted before reset, and 
then after GPU recovery, outstanding KFD BO free/clear/unmap will be 
executed (job created and gpu scheduler paused during reset). Then new 
KFD process map queue will flush TLB.

During recover, driver should not touch h/w, can you provide details of 
memory corruption during reset?

Regards,

Philip

>
>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  4 ++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 22 +++++++++++++++++++
>>>   4 files changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index b9c82be6ce13..eb2df5842618 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -1000,6 +1000,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>>>               return 0;
>>>
>>>       for (i = 0; i < kfd->num_nodes; i++) {
>>> +            kfd_flush_all_processes(kfd->nodes[i]);
>>>               ret = kfd_resume(kfd->nodes[i]);
>>>               if (ret)
>>>                       return ret;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> index 2b0a830f5b29..5e4ae969818e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> @@ -238,6 +238,10 @@ int kq_acquire_packet_buffer(struct kernel_queue *kq,
>>>       uint64_t wptr64;
>>>       unsigned int *queue_address;
>>>
>>> +    if (!kq) {
>>> +            pr_debug("kq has not been initialized\n");
>>> +            goto err_no_space;
>>> +    }
>>>       /* When rptr == wptr, the buffer is empty.
>>>        * When rptr == wptr + 1, the buffer is full.
>>>        * It is always rptr that advances to the position of wptr, rather
>>> than diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index f6aedf69c644..6c073ead2b06 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1059,7 +1059,7 @@ int kfd_process_evict_queues(struct kfd_process
>>> *p, uint32_t trigger);  int kfd_process_restore_queues(struct
>>> kfd_process *p);  void kfd_suspend_all_processes(void);  int
>>> kfd_resume_all_processes(void);
>>> -
>>> +void kfd_flush_all_processes(struct kfd_node *node);
>>>   struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process
>> *process,
>>>                                                        uint32_t gpu_id);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 7c0c24732481..4ed03359020b 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -2110,6 +2110,28 @@ int kfd_resume_all_processes(void)
>>>       return ret;
>>>   }
>>>
>>> +void kfd_flush_all_processes(struct kfd_node *node) {
>>> +    struct kfd_process *p;
>>> +    struct kfd_process_device *pdd;
>>> +    unsigned int temp;
>>> +    int idx = srcu_read_lock(&kfd_processes_srcu);
>>> +    struct amdgpu_vm *vm;
>>> +
>>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>> +            pdd = kfd_get_process_device_data(node, p);
>>> +            if (!pdd)
>>> +                    continue;
>>> +            vm = drm_priv_to_vm(pdd->drm_priv);
>>> +            if (!vm)
>>> +                    continue;
>>> +            atomic64_inc(&vm->tlb_seq);
>>> +            kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
>>> +    }
>>> +    srcu_read_unlock(&kfd_processes_srcu, idx);
>>> +
>>> +}
>>> +
>>>   int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
>>>                         struct vm_area_struct *vma)
>>>   {
