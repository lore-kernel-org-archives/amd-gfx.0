Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC40CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 12:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FD810E71A;
	Wed, 24 Sep 2025 12:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xbz0nT0o";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F9F10E70C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 12:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmJEgaAqm8Y1sI212ywW7Ne6UVLbDv9I/uNfAevh7/gWpjbmz8gmPSLcKdmGe/S2g29tYDAFSyyWShofnVZmgsI8xrDtBRIyoijzVL0BQcKOl8TGfWYsuHazGauDuUP0F/Jh5tJXMhVY3oKD8b/oEOeZSQhmJOsxCjIBPYJpCBh9uqzVASLCFTaAeB55BOuOokgwsYXf1GdrhFUxeJaNcN+rXSR5wjijOPWlwmR51Xd3tMhdY5iNOFlnYdtEJw0VqsVb/SG2crMtJjYZUimlYHxDB+UTgAtxrtsyiqVGSXVu36kedxkNbp4hZpD3YOHW8Z1r+2b63VGrI7U7hpiUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LoZuRNQAwo1JGidTOuBGREkCq+IbjwbxRl3YmvdCLg=;
 b=LpX6qpPhPliKKTJq1aHWibbRfgvGZHEx7l2nSs6vU3+EsO742s2WDyPQuJBlKJXOpqn07p3kdVnv4BkrSrSmf6URnLVpXoPzquniT2fIceyXj9wCssPfo/Fr3qD/xasSqMHqH9YtfZ1GKaaZuMcdVi4QVulbMYhR2bn8cM6OjnxJhwJEPoVgMpwCywxE/TjrzCLEPFyZAxqLd26hnJtB+rVQyzyc10xWN2MKiau9yY7ot/2hAMf2vEclXFIBHKvBkdxjsyJ4oaIp0LH8H+kLIAxJEIUE63R/hlYRG4ILxv8/hQTU2OpmSWrTYCNTRDyOzQmr8Mk88sDJgsPEVL6voQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LoZuRNQAwo1JGidTOuBGREkCq+IbjwbxRl3YmvdCLg=;
 b=xbz0nT0ofKZLoiTJfX1ZJYQ4OdRqhmPJhVMc2IWZbWAqphiy0mq03AvENYnEt+/gojeIoIztq7vmtL1Y7XvPYvlNntQRqKsM4eJvVSlbvgDKS3jFZIlWj2s5IPoMBCPxG3HiJYc7Hd2XoOvXcVdKFWKKNIJUli4l9lxChxQy17I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 12:18:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 12:18:23 +0000
Message-ID: <74c1d28c-3018-444b-b63b-1b1d2a2a7a69@amd.com>
Date: Wed, 24 Sep 2025 14:18:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 1/2] drm/amdgpu: Convert amdgpu userqueue management from IDR
 to XArray
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250924073715.2335544-1-Jesse.Zhang@amd.com>
 <11a5dba9-fa4a-4d1a-913f-36cfa71390c4@amd.com>
 <DM4PR12MB51529C961983528372EC5BE6E31CA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB51529C961983528372EC5BE6E31CA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0022.namprd22.prod.outlook.com
 (2603:10b6:208:238::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec209fa-c3c1-4753-f281-08ddfb6474cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MElaRE9tWDZpTzY4S1dRaWdFbWdTblpGNnFwYjgydTJxTzg5MTdLSU9YRnpw?=
 =?utf-8?B?QnJQcW1YeTBrODUzM3dhNFczUHBweTJiazBGdm02dXJIRU1ySHJjL1pLRUtY?=
 =?utf-8?B?c1dPN05lR0pMU29jc0QrZmNHcDVlS1lHbWRXVE5hNzdTdXN0OVBIN1hkdzcv?=
 =?utf-8?B?V0pxMlp3ck5LNUorSkk0OGhROStRcVY4dVh2YktrdWhzM2xaUUxzNjV1TGFV?=
 =?utf-8?B?RHBZaHV1TDQ4eUh2OFp5UWdOcWs1NUt0R2FjVzdHanduMG4rZmFuczJFc0Fz?=
 =?utf-8?B?UXI0TXJCYit2RTFvZjlBaFp3dEtmenREbE5PMkdYUHU1eEJydE5EMTJzWmxI?=
 =?utf-8?B?UjVHTG1UTDdjRzJsYkhIL1FhWUJYenhJK1hnL3YyYUZlREJEeFZNUXRvZVdL?=
 =?utf-8?B?OWxja0pjYUtOL1hSTm1EbW1NYXdXK1UrQkEyN2lzb2JCdkdnMU8zNHROWWw5?=
 =?utf-8?B?TDdGd0NYY1ZtWnRESTBOcm5iV3I2U080ZHVDZm5JMEZCSk5CbGNueWEyM1M4?=
 =?utf-8?B?b3lmaDFGbjUrNkdMQVZ5M3k4WEh0blFZWGxqQXVpcExtc3NTZ1AvSFR4a2pR?=
 =?utf-8?B?U0gvcFAzOGdPejh3WFY2TGFKd21zUUFGb21WTms4Y2NJNzJ5MFNwZnFLK1Jh?=
 =?utf-8?B?SjhVK2VMR1g5MHliTG00VlB1T2R5VFdaMHNnMXBOTlg2NUx1cm40VC9MKzZF?=
 =?utf-8?B?dTlDcGU3WjA5RHAwTUhjcVJPTjl2cTIrSjRKWXozb0VjQzNkeGUzb25LTXox?=
 =?utf-8?B?NzJjUExGWjgzTTYzcEczR2RUbmZXTFNSUFZkTFB1ck9FcC9lRjlJMzZMbkhm?=
 =?utf-8?B?a1pZZHJLTEJEUUhpa0hMemNRbGgxNFhqQnRZMlVOeW9XNmxPcGYvM05BYkNB?=
 =?utf-8?B?ZFU5T1hwdU5hdlJYRmYybGZ2T2VjUGNlRUxYT0IzamhmTGF6SjdhRGdXVXNZ?=
 =?utf-8?B?eVAzWk9nSUg2RWowWGNPa25aWlc1YlVjWitoUEdBV0xtRjlzeFZaMVViOHIz?=
 =?utf-8?B?V09keGVpRTJzWkE1cTVsMnkwMEp1REt2VzNLNmZJeWZZbEhKM0hmeTEwKzVK?=
 =?utf-8?B?MzRkQy9PdG15anZEN3hvbDFIVTJpVmUwYlVzcWlWaCt1TWw5Ti9pS1RLbHBE?=
 =?utf-8?B?MUhhTUhXaStZclhaUUtYVHN5RXNxc1dwV3RYdkN1cHZ5c2QvK3hlVDdta3ox?=
 =?utf-8?B?RDhPbzBLMy84UE5JM0tJc0Y5SEhuMUdUSExWWkVFZFJ6dmg2enpJaEYxWnlo?=
 =?utf-8?B?SGJBZ0d2cDdlL2MrVjR0ZlJkR0Z3Q0kyKzQzL3ZCQVBzbDc0RDVXUW5tZWM3?=
 =?utf-8?B?bWJsNit4VDJXbDNjTnBLZ3o0YjJNakZrUDRBNUVUR09BR3pvbGJDc3RTVzIx?=
 =?utf-8?B?NFUzZW4rRmg2Y2hnWDVmVStUMWxFUDU2L1FOQXVoc0QvZXNDTG1LdDA5Q3g3?=
 =?utf-8?B?aEt0QW1hVndad01GdEZLL3Z3UnBhK1BtRnNEaEQwL3M5SnVkWmpPQWpPMjVC?=
 =?utf-8?B?NVV4VWQrc1NoYk9BM1haVjZieEFFT016ZnNGc3p5ZzBRdFFpUnRmZ0RmK0Uv?=
 =?utf-8?B?V0RaU1h4L015cnZzZU4xckRQcFdkZzVLSEI4aXdpNVhvZUlRZFV1a2x4dmg0?=
 =?utf-8?B?MnpZbDVsc3h4akNWaStrMjNEa1lZOUR2Wm5QQkwyU1JRWlVjMzU5UThLSm42?=
 =?utf-8?B?QlBWczRiamZPbGZpY1IwZjF4SkRya2FpSzVRcjhlS3hXU1o0blF2c3drTTBl?=
 =?utf-8?B?UEdDdm1yUjg2N2pTalpETFMzRUlBQlRuMkVnMHBoR0YrUjNJRUZSeERLRTFa?=
 =?utf-8?B?SW1WNUNoU2U5RGFQc0txK1RvY3greXFTenBpMjFIZTd5WlFrSFp1U0I2RWNq?=
 =?utf-8?B?QUhZSUp6MVZIV0NoVkdHRXJMWDBHWEMyUkFocmJqQ1MrS1RTZkpob3BZaUNt?=
 =?utf-8?Q?0n0KUFtDqMA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZNYjc4Uk1VQ3R0REZxUEpITHJ3ZzB5WkN0WlVsQWVqaVZIVWMzampVRWtK?=
 =?utf-8?B?SmxQdk1VaGNLT0ZQUGo4L3lITDhaY1JmZTJzNDdURUgzTU10WmF2eGozUzgx?=
 =?utf-8?B?YXovK2EwWFh2a1QzSGIvS1RWbUJhZHZ4NFhtODlpeU8xeWNZbTNjUjlEWnpM?=
 =?utf-8?B?ekg1MDQ1OXdibEpkRStJK2F3SnBPZGdUVHlneUFOYWUyQ0RvMktlRXlrS1ZT?=
 =?utf-8?B?Tmc4b2VCMFRHUVYxRFBVTjNSVG5uK2ZkdkVoM2ppd1dLT3p1R2dCc0hwUjYy?=
 =?utf-8?B?QnBZWXNFaXZUOW0xTUVXNWJUV1doVGlGZXBhWkQ2aHM0elpGRXBVRmVrQmQ5?=
 =?utf-8?B?VXNEMEk0ODY2akZHZlEzZDRaektya0VVSFQxb0c4a2ZNZWMzSjNCUG5pYWpE?=
 =?utf-8?B?V1NaRWhtNFk0L1U5T3E1STVGdW5SMDNYZ3VFWFVjMHV3cFdnOFdQODI5K1R5?=
 =?utf-8?B?K0lvRWEvQjlRUnNMYXdpNUNqZDhJVURHVlJJayt1RHpMblpVc1hLRHNSR3I0?=
 =?utf-8?B?dTRwMDQyNTNMbS9aako1VitkK0wxMnFDWHhGcERJSUNsSG5XWWFvUFpYbWtW?=
 =?utf-8?B?elhLYWJZV1R6UFJMbnBwdnZMeTRSOThraXA5ZU9nZGY3c2gveFJxVzZ2OWcw?=
 =?utf-8?B?aEVKRnRGeUxmWEg1U2RldjBTMExUT09BMnJmeVBGdVgwV0ViZTlFMGprNWY2?=
 =?utf-8?B?NmxSRlZxWWpITElJK25vT1RQUGU0ZmtJVHJqNnpyRTBBWGxNK1ZpUTh1QWk1?=
 =?utf-8?B?cWxjVEdmK1NjUzRnREFpcHJEanphcHRlQUpzWTF1dzM2ZE1XTldtZVI5REJt?=
 =?utf-8?B?N211bXhlTVdMN0h3OE5SS0Zhb1Y1ZDRjVUpRanBmUnpKdUpZMGtQYlFOVW9Z?=
 =?utf-8?B?ZjR0RzBxWCtVb3RxejZ2bXQ1NUZtaDhONC8vM1dmZ2RBcVRrYklwTCtSSzlV?=
 =?utf-8?B?QW14Vk85NnphV3l6eVRLWG10ZXp2WXpFK002Y3l6djFLTXl2WlpDanFrbC9m?=
 =?utf-8?B?VUtHTTJDT3MydU13ZGNzRDRnV2FlM1ZuMG1KVjdhcWkwM0xzTHdycGpTa2d4?=
 =?utf-8?B?OEFrUjVWbEFua1RWbzArdjBNMDlXTzQ2cEtPVHpPY3B4Q0JSTzNMR01jUEZ0?=
 =?utf-8?B?am1VbmlXTzdwQm02ZFlxR09oTG5vSDcySnVJRG5DTjB0ZzgzVXZLSjR6VExP?=
 =?utf-8?B?VGl6THBQN3l5eGU3Vlh5blNvT2YzbHhkR2NMYUQ4QndOdDIxUklnbVpVY2lq?=
 =?utf-8?B?MnFhUFNrN1QwM2Vud3FpRTgvMHdXWjdINkZ3UGlKajdQd0xEdnczdlN0L25Y?=
 =?utf-8?B?bC80b29Xd2pKZlRveWlnNHI2MWVYVmhRWnlKVW5NVGYyTUJVYktVeGpqSU5P?=
 =?utf-8?B?bUxMSjI2MFdULzdwOUZkOEk0ZDF6TzBZdUp1NVNSVEdWZnE0RUoxb0VmTnVx?=
 =?utf-8?B?SHNycFRQeGZnd00xM0t1Q0dGdmR5L2NkZkpUeHJqc0VHdjlnVWFWcHZNcDJi?=
 =?utf-8?B?VEhCNkZ0eU9YSmtPWkVWOXJTNjhLVHBsMUJEZmhoVFh5WGtCaFYyRFNVRHJt?=
 =?utf-8?B?WUcrVnNqbmJGOUpyV0prZ0kvaWhRNVFua0ZpU3JsQlJ3WThsM1JLYkhjL0JN?=
 =?utf-8?B?TXFHUlVWS2RZcTBHbm90OElDemlFbGRhM1BIVjVrTnZ2U3RHOWxWSFdlSHgx?=
 =?utf-8?B?MElZS2xNdHJ4Qlh0SHRUWVBDemF3TkN6cnA3NXdGZWhwU1NLY01MTWsyQ1Bz?=
 =?utf-8?B?U3dXSk5EM0dxUUdxdWJreGJ1NzlRbU9GVzZGU1FhMEJtRzhFak16WnlvaDNE?=
 =?utf-8?B?N2s5TzVvZ0FTTlkzMFZ6ZzhMSzhNUy9RNnFsODhzcWFWdkdXRFZ2Zk1YemFG?=
 =?utf-8?B?Rmc3eHpUcFVMT0xQK1RlcUNjekl2WDNOcGQyb3UxcC92bDF3ODkzaWU3UFdP?=
 =?utf-8?B?M2lKQXBBT2QyTlVaL080OCtaMy85RENYSENSdmh3WU1CNlRkd0dmOGIyb2ph?=
 =?utf-8?B?L1NFS3hRM3MvMkVzeUZaQlUvZmxWbGNETXlRU2JBMGZWZE1tUFdBd25rMnUx?=
 =?utf-8?B?WEpDNmxzZGNHeWVNbCtoVnRMY3RoUHRrNXBhWjhocXlobWhCYXhrRnZxN0M4?=
 =?utf-8?Q?eD6eDEviKCQ5Qjt+XsUgUOXP9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec209fa-c3c1-4753-f281-08ddfb6474cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 12:18:23.3805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVot4Wd1kRhkNhWFyX9cKKKxFiwJ/8aBh2+5S+oqAv9v64AeixatJTH/g8I1lPKk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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

On 24.09.25 12:26, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, September 24, 2025 5:29 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [v6 1/2] drm/amdgpu: Convert amdgpu userqueue management from
>> IDR to XArray
>>
>> On 24.09.25 09:34, Jesse.Zhang wrote:
>>> This commit refactors the AMDGPU userqueue management subsystem to
>>> replace IDR (ID Allocation) with XArray for improved performance,
>>> scalability, and maintainability. The changes address several issues
>>> with the previous IDR implementation and provide better locking semantics.
>>>
>>> Key changes:
>>>
>>> 1. **Global XArray Introduction**:
>>>    - Added `userq_doorbell_xa` to `struct amdgpu_device` for global queue
>> tracking
>>>    - Uses doorbell_index as key for efficient global lookup
>>>    - Replaces the previous `userq_mgr_list` linked list approach
>>>
>>> 2. **Per-process XArray Conversion**:
>>>    - Replaced `userq_idr` with `userq_mgr_xa` in `struct amdgpu_userq_mgr`
>>>    - Maintains per-process queue tracking with queue_id as key
>>>    - Uses XA_FLAGS_ALLOC for automatic ID allocation
>>>
>>> 3. **Locking Improvements**:
>>>    - Removed global `userq_mutex` from `struct amdgpu_device`
>>>    - Replaced with fine-grained XArray locking using XArray's internal
>>> spinlocks
>>>
>>> 4. **Runtime Idle Check Optimization**:
>>>    - Updated `amdgpu_runtime_idle_check_userq()` to use xa_empty
>>>
>>> 5. **Queue Management Functions**:
>>>    - Converted all IDR operations to equivalent XArray functions:
>>>      - `idr_alloc()` → `xa_alloc()`
>>>      - `idr_find()` → `xa_load()`
>>>      - `idr_remove()` → `xa_erase()`
>>>      - `idr_for_each()` → `xa_for_each()`
>>>
>>> Benefits:
>>> - **Performance**: XArray provides better scalability for large
>>> numbers of queues
>>> - **Memory Efficiency**: Reduced memory overhead compared to IDR
>>> - **Thread Safety**: Improved locking semantics with XArray's internal
>>> spinlocks
>>>
>>> v2: rename userq_global_xa/userq_xa to userq_doorbell_xa/userq_mgr_xa
>>>     Remove xa_lock and use its own lock.
>>>
>>> v3: Set queue->userq_mgr = uq_mgr in amdgpu_userq_create()
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  16 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 143 +++++++++---------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +-
>>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
>>>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  22 ++-
>>>  7 files changed, 97 insertions(+), 107 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 2a0df4cabb99..ae10832a09f4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1174,6 +1174,12 @@ struct amdgpu_device {
>>>      * queue fence.
>>>      */
>>>     struct xarray                   userq_xa;
>>> +   /**
>>> +    * @userq_doorbell_xa: Global user queue map (doorbell index → queue)
>>> +    * Key: doorbell_index (unique global identifier for the queue)
>>> +    * Value: struct amdgpu_usermode_queue
>>> +    */
>>> +   struct xarray userq_doorbell_xa;
>>>
>>>     /* df */
>>>     struct amdgpu_df                df;
>>> @@ -1308,8 +1314,6 @@ struct amdgpu_device {
>>>      */
>>>     bool                            apu_prefer_gtt;
>>>
>>> -   struct list_head                userq_mgr_list;
>>> -   struct mutex                    userq_mutex;
>>>     bool                            userq_halt_for_enforce_isolation;
>>>     struct amdgpu_uid *uid_info;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 0fdfde3dcb9f..e066f7ff2a82 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4483,7 +4483,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>     mutex_init(&adev->gfx.userq_sch_mutex);
>>>     mutex_init(&adev->gfx.workload_profile_mutex);
>>>     mutex_init(&adev->vcn.workload_profile_mutex);
>>> -   mutex_init(&adev->userq_mutex);
>>>
>>>     amdgpu_device_init_apu_flags(adev);
>>>
>>> @@ -4511,7 +4510,7 @@ int amdgpu_device_init(struct amdgpu_device
>>> *adev,
>>>
>>>     INIT_LIST_HEAD(&adev->pm.od_kobj_list);
>>>
>>> -   INIT_LIST_HEAD(&adev->userq_mgr_list);
>>> +   xa_init(&adev->userq_doorbell_xa);
>>>
>>>     INIT_DELAYED_WORK(&adev->delayed_init_work,
>>>                       amdgpu_device_delayed_init_work_handler);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index ece251cbe8c3..fdea7cd4b3ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2771,22 +2771,8 @@ static int amdgpu_runtime_idle_check_userq(struct
>> device *dev)
>>>     struct pci_dev *pdev = to_pci_dev(dev);
>>>     struct drm_device *drm_dev = pci_get_drvdata(pdev);
>>>     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>> -   struct amdgpu_usermode_queue *queue;
>>> -   struct amdgpu_userq_mgr *uqm, *tmp;
>>> -   int queue_id;
>>> -   int ret = 0;
>>> -
>>> -   mutex_lock(&adev->userq_mutex);
>>> -   list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> -           idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>> -                   ret = -EBUSY;
>>> -                   goto done;
>>> -           }
>>> -   }
>>> -done:
>>> -   mutex_unlock(&adev->userq_mutex);
>>>
>>> -   return ret;
>>> +   return xa_empty(&adev->userq_doorbell_xa) ? 0 : -EBUSY;
>>>  }
>>>
>>>  static int amdgpu_pmops_runtime_suspend(struct device *dev) diff
>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index b649ac0cedff..0712b88782c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -180,17 +180,28 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr
>>> *uq_mgr,  {
>>>     struct amdgpu_device *adev = uq_mgr->adev;
>>>     const struct amdgpu_userq_funcs *uq_funcs =
>>> adev->userq_funcs[queue->queue_type];
>>> +   unsigned long flags;
>>>
>>>     uq_funcs->mqd_destroy(uq_mgr, queue);
>>>     amdgpu_userq_fence_driver_free(queue);
>>> -   idr_remove(&uq_mgr->userq_idr, queue_id);
>>> +
>>> +   /* Use interrupt-safe locking since IRQ handlers may access these
>>> +XArrays */
>>
>> Wait a second where are IRQ handlers accessing those XAs?
> [Zhang, Jesse(Jie)] gfx_v11_0_eop_irq on gfx11 also accesses these XAs. With lockdep enabled, a warning will appear without xa_lock_irqsave.

Yeah, but only the fence_drv xa needs to be irq save.

If the uq_mgr->userq_mgr_xa is used in the irq handler then something seems to be wrong here.

> We can replace it with xa_erase_irq, just like you suggested with xa_store_irq.

Yeah that's certainly a good idea.

> 
>>
>>> +   xa_lock_irqsave(&uq_mgr->userq_mgr_xa, flags);
>>> +   __xa_erase(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
>>> +   xa_unlock_irqrestore(&uq_mgr->userq_mgr_xa, flags);
>>> +
>>> +   xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
>>> +   __xa_erase(&adev->userq_doorbell_xa, queue->doorbell_index);
>>> +   xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
>>> +
>>> +   queue->userq_mgr = NULL;
>>>     kfree(queue);
>>>  }
>>>
>>>  static struct amdgpu_usermode_queue *  amdgpu_userq_find(struct
>>> amdgpu_userq_mgr *uq_mgr, int qid)  {
>>> -   return idr_find(&uq_mgr->userq_idr, qid);
>>> +   return xa_load(&uq_mgr->userq_mgr_xa, qid);
>>>  }
>>>
>>>  void
>>> @@ -462,8 +473,10 @@ amdgpu_userq_create(struct drm_file *filp, union
>> drm_amdgpu_userq *args)
>>>     struct amdgpu_db_info db_info;
>>>     char *queue_name;
>>>     bool skip_map_queue;
>>> +   unsigned long flags;
>>> +   u32 qid;
>>>     uint64_t index;
>>> -   int qid, r = 0;
>>> +   int r = 0;
>>>     int priority =
>>>             (args->in.flags &
>> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
>>>
>>       AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
>>> @@ -486,7 +499,6 @@ amdgpu_userq_create(struct drm_file *filp, union
>> drm_amdgpu_userq *args)
>>>      *
>>>      * This will also make sure we have a valid eviction fence ready to be used.
>>>      */
>>> -   mutex_lock(&adev->userq_mutex);
>>>     amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>>
>>>     uq_funcs = adev->userq_funcs[args->in.ip_type];
>>> @@ -546,9 +558,17 @@ amdgpu_userq_create(struct drm_file *filp, union
>> drm_amdgpu_userq *args)
>>>             goto unlock;
>>>     }
>>>
>>> +   xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
>>> +   r =xa_err(__xa_store(&adev->userq_doorbell_xa, index, queue,
>> GFP_KERNEL));
>>> +   if (r) {
>>> +           kfree(queue);
>>> +           xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
>>> +           goto unlock;
>>> +   }
>>> +   xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
>>
>> You can use xa_store_irq() here.
>>
>>>
>>> -   qid = idr_alloc(&uq_mgr->userq_idr, queue, 1,
>> AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>>> -   if (qid < 0) {
>>> +   r = xa_alloc(&uq_mgr->userq_mgr_xa, &qid, queue, XA_LIMIT(1,
>> AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
>>> +   if (r) {
>>>             drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
>>>             amdgpu_userq_fence_driver_free(queue);
>>>             uq_funcs->mqd_destroy(uq_mgr, queue); @@ -556,6 +576,7 @@
>>> amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>             r = -ENOMEM;
>>>             goto unlock;
>>>     }
>>> +   queue->userq_mgr = uq_mgr;
>>>
>>>     /* don't map the queue if scheduling is halted */
>>>     if (adev->userq_halt_for_enforce_isolation && @@ -568,7 +589,7 @@
>>> amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>             r = amdgpu_userq_map_helper(uq_mgr, queue);
>>>             if (r) {
>>>                     drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>>> -                   idr_remove(&uq_mgr->userq_idr, qid);
>>> +                   xa_erase(&uq_mgr->userq_mgr_xa, qid);
>>>                     amdgpu_userq_fence_driver_free(queue);
>>>                     uq_funcs->mqd_destroy(uq_mgr, queue);
>>>                     kfree(queue);
>>> @@ -591,7 +612,6 @@ amdgpu_userq_create(struct drm_file *filp, union
>>> drm_amdgpu_userq *args)
>>>
>>>  unlock:
>>>     mutex_unlock(&uq_mgr->userq_mutex);
>>> -   mutex_unlock(&adev->userq_mutex);
>>>
>>>     return r;
>>>  }
>>> @@ -689,11 +709,11 @@ static int
>>>  amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)  {
>>>     struct amdgpu_usermode_queue *queue;
>>> -   int queue_id;
>>> +   unsigned long queue_id;
>>>     int ret = 0, r;
>>>
>>>     /* Resume all the queues for this process */
>>> -   idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>>> +   xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>>>             r = amdgpu_userq_restore_helper(uq_mgr, queue);
>>>             if (r)
>>>                     ret = r;
>>> @@ -846,11 +866,11 @@ static int
>>>  amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)  {
>>>     struct amdgpu_usermode_queue *queue;
>>> -   int queue_id;
>>> +   unsigned long queue_id;
>>>     int ret = 0, r;
>>>
>>>     /* Try to unmap all the queues in this process ctx */
>>> -   idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>>> +   xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>>>             r = amdgpu_userq_preempt_helper(uq_mgr, queue);
>>>             if (r)
>>>                     ret = r;
>>> @@ -865,9 +885,10 @@ static int
>>>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)  {
>>>     struct amdgpu_usermode_queue *queue;
>>> -   int queue_id, ret;
>>> +   unsigned long queue_id;
>>> +   int ret;
>>>
>>> -   idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>>> +   xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>>>             struct dma_fence *f = queue->last_fence;
>>>
>>>             if (!f || dma_fence_is_signaled(f)) @@ -920,44 +941,30 @@ int
>>> amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>>                       struct amdgpu_device *adev)
>>>  {
>>>     mutex_init(&userq_mgr->userq_mutex);
>>> -   idr_init_base(&userq_mgr->userq_idr, 1);
>>> +   xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
>>>     userq_mgr->adev = adev;
>>>     userq_mgr->file = file_priv;
>>>
>>> -   mutex_lock(&adev->userq_mutex);
>>> -   list_add(&userq_mgr->list, &adev->userq_mgr_list);
>>> -   mutex_unlock(&adev->userq_mutex);
>>> -
>>>     INIT_DELAYED_WORK(&userq_mgr->resume_work,
>> amdgpu_userq_restore_worker);
>>>     return 0;
>>>  }
>>>
>>>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)  {
>>> -   struct amdgpu_device *adev = userq_mgr->adev;
>>>     struct amdgpu_usermode_queue *queue;
>>> -   struct amdgpu_userq_mgr *uqm, *tmp;
>>> -   uint32_t queue_id;
>>> +   unsigned long queue_id;
>>>
>>>     cancel_delayed_work_sync(&userq_mgr->resume_work);
>>>
>>> -   mutex_lock(&adev->userq_mutex);
>>>     mutex_lock(&userq_mgr->userq_mutex);
>>> -   idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>>> +   xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
>>>             amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>>>             amdgpu_userq_unmap_helper(userq_mgr, queue);
>>>             amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
>>>     }
>>>
>>> -   list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> -           if (uqm == userq_mgr) {
>>> -                   list_del(&uqm->list);
>>> -                   break;
>>> -           }
>>> -   }
>>> -   idr_destroy(&userq_mgr->userq_idr);
>>> +   xa_destroy(&userq_mgr->userq_mgr_xa);
>>>     mutex_unlock(&userq_mgr->userq_mutex);
>>> -   mutex_unlock(&adev->userq_mutex);
>>>     mutex_destroy(&userq_mgr->userq_mutex);
>>>  }
>>>
>>> @@ -965,25 +972,23 @@ int amdgpu_userq_suspend(struct amdgpu_device
>>> *adev)  {
>>>     u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>>>     struct amdgpu_usermode_queue *queue;
>>> -   struct amdgpu_userq_mgr *uqm, *tmp;
>>> -   int queue_id;
>>> +   struct amdgpu_userq_mgr *uqm;
>>> +   unsigned long queue_id;
>>>     int ret = 0, r;
>>>
>>>     if (!ip_mask)
>>>             return 0;
>>>
>>> -   mutex_lock(&adev->userq_mutex);
>>> -   list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> +   xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>> +           uqm = queue->userq_mgr;
>>
>> That function is used during reset, isn't it?
> [Zhang, Jesse(Jie)]  No, amdgpu_userq_suspend/amdgpu_userq_resume are not used during reset.
> but They are called when executing the suspend command.  I tried the suspend case, amdgpu_userq_suspend/amdgpu_userq_resume and no error occurred.

Testing can only disprove a design and not validate it.

During normal suspend/resume this isn't an issue because userspace is completely frozen.

But when this is used during reset as well we need to be super careful to not access fredd up memory.

Regards,
Christian.

>> If yes we somehow need to make sure that neither queue nor userq_mgr is properly
>> initialized and not freed up while the reset is ongoing.
>>
>> The easiest way of doing that is to hold the read side of the reset lock while
>> creating/destroying queues and the manager data structure.
>>
>>>             cancel_delayed_work_sync(&uqm->resume_work);
>>>             mutex_lock(&uqm->userq_mutex);
>>> -           idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>> -                   r = amdgpu_userq_unmap_helper(uqm, queue);
>>> -                   if (r)
>>> -                           ret = r;
>>> -           }
>>> +           r = amdgpu_userq_unmap_helper(uqm, queue);
>>> +           if (r)
>>> +                   ret = r;
>>>             mutex_unlock(&uqm->userq_mutex);
>>>     }
>>> -   mutex_unlock(&adev->userq_mutex);
>>> +
>>>     return ret;
>>>  }
>>>
>>> @@ -991,24 +996,22 @@ int amdgpu_userq_resume(struct amdgpu_device
>>> *adev)  {
>>>     u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>>>     struct amdgpu_usermode_queue *queue;
>>> -   struct amdgpu_userq_mgr *uqm, *tmp;
>>> -   int queue_id;
>>> +   struct amdgpu_userq_mgr *uqm;
>>> +   unsigned long queue_id;
>>>     int ret = 0, r;
>>>
>>>     if (!ip_mask)
>>>             return 0;
>>>
>>> -   mutex_lock(&adev->userq_mutex);
>>> -   list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> +   xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>> +           uqm = queue->userq_mgr;
>>
>> Not sure about those ones here, but the same point that applies to the reset
>> handling applies here as well.
>>
>> Apart from that the patch looks good to me.
>>
>> Regards,
>> Christian.
>>
>>>             mutex_lock(&uqm->userq_mutex);
>>> -           idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>> -                   r = amdgpu_userq_map_helper(uqm, queue);
>>> -                   if (r)
>>> -                           ret = r;
>>> -           }
>>> +           r = amdgpu_userq_map_helper(uqm, queue);
>>> +           if (r)
>>> +                   ret = r;
>>>             mutex_unlock(&uqm->userq_mutex);
>>>     }
>>> -   mutex_unlock(&adev->userq_mutex);
>>> +
>>>     return ret;
>>>  }
>>>
>>> @@ -1017,33 +1020,31 @@ int
>>> amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,  {
>>>     u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>>>     struct amdgpu_usermode_queue *queue;
>>> -   struct amdgpu_userq_mgr *uqm, *tmp;
>>> -   int queue_id;
>>> +   struct amdgpu_userq_mgr *uqm;
>>> +   unsigned long queue_id;
>>>     int ret = 0, r;
>>>
>>>     /* only need to stop gfx/compute */
>>>     if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 <<
>> AMDGPU_HW_IP_COMPUTE))))
>>>             return 0;
>>>
>>> -   mutex_lock(&adev->userq_mutex);
>>>     if (adev->userq_halt_for_enforce_isolation)
>>>             dev_warn(adev->dev, "userq scheduling already stopped!\n");
>>>     adev->userq_halt_for_enforce_isolation = true;
>>> -   list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> +   xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>> +           uqm = queue->userq_mgr;
>>>             cancel_delayed_work_sync(&uqm->resume_work);
>>>             mutex_lock(&uqm->userq_mutex);
>>> -           idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>> -                   if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>>> -                        (queue->queue_type == AMDGPU_HW_IP_COMPUTE))
>> &&
>>> -                       (queue->xcp_id == idx)) {
>>> -                           r = amdgpu_userq_preempt_helper(uqm, queue);
>>> -                           if (r)
>>> -                                   ret = r;
>>> -                   }
>>> +           if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>>> +                (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
>>> +               (queue->xcp_id == idx)) {
>>> +                   r = amdgpu_userq_preempt_helper(uqm, queue);
>>> +                   if (r)
>>> +                           ret = r;
>>>             }
>>>             mutex_unlock(&uqm->userq_mutex);
>>>     }
>>> -   mutex_unlock(&adev->userq_mutex);
>>> +
>>>     return ret;
>>>  }
>>>
>>> @@ -1052,21 +1053,20 @@ int
>>> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>> {
>>>     u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>>>     struct amdgpu_usermode_queue *queue;
>>> -   struct amdgpu_userq_mgr *uqm, *tmp;
>>> -   int queue_id;
>>> +   struct amdgpu_userq_mgr *uqm;
>>> +   unsigned long queue_id;
>>>     int ret = 0, r;
>>>
>>>     /* only need to stop gfx/compute */
>>>     if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 <<
>> AMDGPU_HW_IP_COMPUTE))))
>>>             return 0;
>>>
>>> -   mutex_lock(&adev->userq_mutex);
>>>     if (!adev->userq_halt_for_enforce_isolation)
>>>             dev_warn(adev->dev, "userq scheduling already started!\n");
>>>     adev->userq_halt_for_enforce_isolation = false;
>>> -   list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> +   xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>> +           uqm = queue->userq_mgr;
>>>             mutex_lock(&uqm->userq_mutex);
>>> -           idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>>                     if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>>>                          (queue->queue_type == AMDGPU_HW_IP_COMPUTE))
>> &&
>>>                         (queue->xcp_id == idx)) {
>>> @@ -1074,9 +1074,8 @@ int
>> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>                             if (r)
>>>                                     ret = r;
>>>                     }
>>> -           }
>>>             mutex_unlock(&uqm->userq_mutex);
>>>     }
>>> -   mutex_unlock(&adev->userq_mutex);
>>> +
>>>     return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index c027dd916672..c562c8d2b53a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -88,11 +88,15 @@ struct amdgpu_userq_funcs {
>>>
>>>  /* Usermode queues for gfx */
>>>  struct amdgpu_userq_mgr {
>>> -   struct idr                      userq_idr;
>>> +   /**
>>> +    * @userq_mgr_xa: Per-process user queue map (queue ID → queue)
>>> +    * Key: queue_id (unique ID within the process's userq manager)
>>> +    * Value: struct amdgpu_usermode_queue
>>> +    */
>>> +   struct xarray                   userq_mgr_xa;
>>>     struct mutex                    userq_mutex;
>>>     struct amdgpu_device            *adev;
>>>     struct delayed_work             resume_work;
>>> -   struct list_head                list;
>>>     struct drm_file                 *file;
>>>  };
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 95e91d1dc58a..cc597fae8971 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -537,7 +537,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
>> void *data,
>>>     }
>>>
>>>     /* Retrieve the user queue */
>>> -   queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
>>> +   queue = xa_load(&userq_mgr->userq_mgr_xa, args->queue_id);
>>>     if (!queue) {
>>>             r = -ENOENT;
>>>             goto put_gobj_write;
>>> @@ -899,7 +899,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev,
>> void *data,
>>>              */
>>>             num_fences = dma_fence_dedup_array(fences, num_fences);
>>>
>>> -           waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
>>> +           waitq = xa_load(&userq_mgr->userq_mgr_xa, wait_info->waitq_id);
>>>             if (!waitq) {
>>>                     r = -EINVAL;
>>>                     goto free_fences;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index 2db9b2c63693..9e4229c79c69 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -205,9 +205,9 @@ static int mes_userq_detect_and_reset(struct
>> amdgpu_device *adev,
>>>     int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
>>>     struct mes_detect_and_reset_queue_input input;
>>>     struct amdgpu_usermode_queue *queue;
>>> -   struct amdgpu_userq_mgr *uqm, *tmp;
>>>     unsigned int hung_db_num = 0;
>>> -   int queue_id, r, i;
>>> +   unsigned long queue_id;
>>> +   int r, i;
>>>     u32 db_array[4];
>>>
>>>     if (db_array_size > 4) {
>>> @@ -227,16 +227,14 @@ static int mes_userq_detect_and_reset(struct
>> amdgpu_device *adev,
>>>     if (r) {
>>>             dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n",
>> r);
>>>     } else if (hung_db_num) {
>>> -           list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> -                   idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>> -                           if (queue->queue_type == queue_type) {
>>> -                                   for (i = 0; i < hung_db_num; i++) {
>>> -                                           if (queue->doorbell_index ==
>> db_array[i]) {
>>> -                                                   queue->state =
>> AMDGPU_USERQ_STATE_HUNG;
>>> -                                                   atomic_inc(&adev-
>>> gpu_reset_counter);
>>> -
>>       amdgpu_userq_fence_driver_force_completion(queue);
>>> -
>>       drm_dev_wedged_event(adev_to_drm(adev),
>> DRM_WEDGE_RECOVERY_NONE, NULL);
>>> -                                           }
>>> +           xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>> +                   if (queue->queue_type == queue_type) {
>>> +                           for (i = 0; i < hung_db_num; i++) {
>>> +                                   if (queue->doorbell_index == db_array[i]) {
>>> +                                           queue->state =
>> AMDGPU_USERQ_STATE_HUNG;
>>> +                                           atomic_inc(&adev-
>>> gpu_reset_counter);
>>> +
>>       amdgpu_userq_fence_driver_force_completion(queue);
>>> +
>>       drm_dev_wedged_event(adev_to_drm(adev),
>>> +DRM_WEDGE_RECOVERY_NONE, NULL);
>>>                                     }
>>>                             }
>>>                     }
> 

