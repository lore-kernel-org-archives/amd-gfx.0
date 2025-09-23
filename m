Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D90ECAC5B0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 11:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5E710E5F6;
	Tue, 23 Sep 2025 11:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IicQpBZ3";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79EA10E5F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 11:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDElVixlfHi1i4WEfFYKzQHwFbEzcVqTLu2ASVglVpAwLymVfPe003MENZd5yJ30YQ8c7eYbBsSYDZMnWm6BTUIPwbpSBmwIOS7OrFIFhuu+UECK2AQpFwIwgEY2RHAO6VE6X22M2U6AMUHIS5y8lVp2Cru4xweUd4Mnvm4eGCUiib7AR0HrOwoq1axvI5oZp7qDZj4idtKQ2veZkRS3ecDpuqsqxR5dDePXD3cxrHmTKbimGcimIw3VlCFPS98oqyNtJdxTETGoczVgIQXmuP51Sm4TShIEbQb76MiLS7IfXQOBR48h2QRXbJnpxiq77i/3KyCTbbFTfK1+GoTWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N92kypCXYdXXPqT+gii4Axp48IWnnkagbsQVfxiMIT8=;
 b=qtrhwufWXz5jnPzbS+BVT3tnry3hYb5UYN9jwdiWM05KC09daDDmM/f/aFyu8qNB4Z56d3lveE84fNkIBKabj5JNXAtB67+qW27Oooge8KtwNc3dZ71vLVrzYYSf3kZtepZGsnA4i4JJrlscr0SxcRQn2njWbkLc9oExvXkHRZyjzIC3LwMBon/ag8rxovueswpY82SoGeiK6IqM1An1vJEpcBYY/bvTSp9NnQX5OkOHncVtbrYhxX0jOabF2TOqXdQTclk4BiSFtipO1eQ+0RMd2BfzGbKLtFabKqcg3H8/JSVihGhIGjYnkulMYrjEUlDMaMC73CKfq67lgAQ8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N92kypCXYdXXPqT+gii4Axp48IWnnkagbsQVfxiMIT8=;
 b=IicQpBZ3SbfToRuRqeCNSK2BYG6gfvZyHPyU+wF5HXC94hPmWtv979CzULkraNxRe3/nACbJCU4OSRxlguOsv3ujA5KBBYZ0wff4iu296Jop2ka9bNBVNl9eVuiNjqwP3uFG89KxzEYXA7UA6Fbsu9IEtQyKdAtbwIR1fZk8fF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 11:44:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 11:44:54 +0000
Message-ID: <47b8ccc9-7575-492b-82fe-2f70cb704623@amd.com>
Date: Tue, 23 Sep 2025 13:44:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix pipelining jobs with timeline syncobj
 dependencies
To: David Rosca <david.rosca@amd.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 amd-gfx@lists.freedesktop.org
References: <20250917095939.41615-2-david.rosca@amd.com>
 <c1f6d69f-7f71-4d6d-b475-fe22f5316ca3@ursulin.net>
 <74ed415e-2938-4b3c-ab68-4b074d35e4ba@amd.com>
 <31124176-c73b-426d-bb35-793161b44a68@ursulin.net>
 <a950349d-69e1-4a7e-bd99-d9d6a1528533@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a950349d-69e1-4a7e-bd99-d9d6a1528533@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0026.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 663cb9ff-a18d-4ea9-4f57-08ddfa969d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akhwS3ZaUTF4T0ZZM0pBZDB6Uitxb0lYZmtGUVRTeFp2ZXJKSWhOeXUvdDRa?=
 =?utf-8?B?NUJPalJkaXd4aVpIZkxkTUhaT3R4c1JnWSs5bzN3WW10Rzc1OWEyd09FeG1r?=
 =?utf-8?B?azBqdFNPajdWMXp2TitIZmhJWjZoQ0xpaUJ6amo0NUN5V2VtVy81K1JCcXYy?=
 =?utf-8?B?VmJjSWttMHBPWU5nK3dNbUxuWVBDNndVYVZ0OE1STkJEeFJyRERGMi9UMEtl?=
 =?utf-8?B?U3FZOUdXUURUYWdRWkU1dXJjYS9YVElBWmRWNEhITVBranZ3WVg4ajNxdE1W?=
 =?utf-8?B?ZXFUUnhzbjFQVlp6SVlZZCtoanRPQ01UbVVSa3FPWDhRaG1pcVREaGcvbnBC?=
 =?utf-8?B?ajdybmJkNFViRlJUcC95TTdYMGFDWkRaSDBhUGNOeDhkenpzbTRHUzNUdWpm?=
 =?utf-8?B?OE1WR2FWM1I2dXE0aXhRdjJhZm5sMU1OZVlHSE1aVTRYTm54OWZ2OXdIaEpt?=
 =?utf-8?B?R1RrVmduVHJmVzdaZW0zZVJScUxMVkdqMXQzWmRzd0tLSmU5cmZTQk8zalpl?=
 =?utf-8?B?M1g4bFJ4Um9iVW9ORXlhNVZlS1ZjVGNwSlBUMUxjTk12MGR4bzJNblAvajJs?=
 =?utf-8?B?dGwrZ2lKRS8vRUx2aWgxV3VZYlEwd0ZEOVJhaVUyZERCQzk1RjM2Q2dwRmZK?=
 =?utf-8?B?dzZERWZ3NGIrWGlmVjk4WWlFc1kzUTRRNFZnZ3VSZjcvSUF5VkRrcVNQWEpP?=
 =?utf-8?B?NmtBWnlsOHE5TXZVVzVQQlRDRHVISndvaExCMFFhdVNrNWdoSmlUU3ZWcTJ6?=
 =?utf-8?B?aXhoN2xpckc5RFBBN1hsbXpPM1BnUVNoWjlFcDZQcmNFbjRJZ0JjQmJXNVVp?=
 =?utf-8?B?Tzh6VXhDQTBJVnp0SXNaMEZNQ1VMS1kzYmFmSjREcFg0dkpGWkxxN2xSRTk1?=
 =?utf-8?B?YStTS2JTbnF4UFMrNXErbVdjT2NESmVrdHhUL1pNQ2dVc1BzT1NadjhlV2Q5?=
 =?utf-8?B?MTgvQWtod01nYkJCeVoveWpYcWJxSHhhcTB0T01GODdqeVJOR2ZqQXk5VVFz?=
 =?utf-8?B?Nk1BeHRHbnk5Z0RkTnl0YzlyeHg1b1NsczUwMDN1dGhsekYrSnhEMVE3cU0y?=
 =?utf-8?B?V2E1OGVqY05QOHNFNmQzT2drYWlxT2o2VmFjWXdXRVJjZGRWcmJiSFlqV1p2?=
 =?utf-8?B?Sk1Ka1Q3V2wrMDNlTTFZdVpLRTFCT09HSmVtRzQvV2xiTFVMbGlxNEhSQ1Bn?=
 =?utf-8?B?cXR2eUdqalR3RTdlVE9kZWFRLy9GYkIzNzRIc1ZIQ1p0cS9pa1BiYzZUcjlR?=
 =?utf-8?B?MFFMeHlKNkh3QXNCbjJ1QmFoNmJiUzlXZkpFMm1GZjZtSnIwRy84OFMwTDhu?=
 =?utf-8?B?c2toVFp3Z3I2djRYU2ZyT3pGQTUwcnExNWtRYllCSGYrWEpqY2JZbFYrV2pP?=
 =?utf-8?B?cmYvZ0xDU1laVEI4SFhJcU4yUFluNTNWV0JUWW1xSU9zdkxLSGI4Njl6NTBj?=
 =?utf-8?B?Rk9iK1RjQnRjRkJoV2FZMXIwbmlnaDJybm95bU9mTCtRMVhOaWF5L0Y0Wnh4?=
 =?utf-8?B?NVI5V2R3TWxwWUR0TmpEZm1aZWp5UFVqKy9ULzQwN041TkFMc3hCNDJBckFP?=
 =?utf-8?B?d01RVmZ5RGhId1ZuczFHenVyTURRSkY3SXRkOGVwajcwZVMxWUE5dGNNMXN5?=
 =?utf-8?B?OC8rQ2RqWnNSR1d2cUVSRHliSGd5OEFVU3VwNVlLWmMvc0p1NEpuM01OMTYv?=
 =?utf-8?B?TDh2NFFqL3RDcDErUEdOdkJYV1N4Y3JNcFVXeXFWamlQU3k4clFIeXVpU3ZS?=
 =?utf-8?B?RkZ3M2tUdkRVOGtpSFFUYnJZM004TlVpeHRmZEtzdGttSmVFOEs3cDJGQkNF?=
 =?utf-8?B?enJ0YTlsNTRaU2ZKTE9iVVQ1enY0TkZjREpydWo1RGEvRjNhdUo2cGdYdFd1?=
 =?utf-8?B?U1NucStleWlYVGJSK0MxbW80Zk54bVNMcHpKY0o5ZEFxb1lZOVl2V1o1VGlz?=
 =?utf-8?Q?yf8gtdBWn4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N25WSGtUZitCZ1hya3N6SlFSek1DYXR5bTNiZFR1bE5WdFFXdjluM2h6WHpY?=
 =?utf-8?B?YktTTTNONFJ1U0VxVzUvNGhTUFpQL0JWWWZNeXlvOTN1bHgyaEwzNjBqZjNN?=
 =?utf-8?B?RXcvYjJxTVFNV1dHZmEveWFPeHRBOFJzS2hqeExJcXRFK293UWt1QTdwbit5?=
 =?utf-8?B?eGx2Z3FQWS93M3NWOUt4eG1ISHBsa3Z2V1kxd2RPM2taaHdKcEdOV1F4KzJD?=
 =?utf-8?B?SjVSeGNkNlNBcHMwa21PaGtqYkZtSTBtamcxTys1NFRBcEVQTFVZTDlnbG9y?=
 =?utf-8?B?NVJ5aUFFZERwZm9oR245RXZ6OUJQU2ZLUXk5MUhGbmRvUFFwbkhXRGhUZEhU?=
 =?utf-8?B?SS8yQlVkT09UcWlaVGQ4S3MyTUxraWZ6ZndKOUh0YjVYait3Yis2N2d6R2kz?=
 =?utf-8?B?NXEvcUh3VDl3SU8rYkNyeE1TdjVwNnU1aGFpalAzMmkzS01OcmRVbXhCU0JT?=
 =?utf-8?B?MlArbm9tUTJ6UlRUeTQ0SWc2dzRwQnVQWkdvb0xoR0w2dU9sdHgxSFIrNXBZ?=
 =?utf-8?B?T1E3UFY4d0RRbExxZXBGamg5M3crcFBUTEFBMWg1bUMySC9HTHFhc0RIaU5X?=
 =?utf-8?B?NXY1QmYzd1IrNVRFeVR2WjQ2TDJMbSthc1E4YmpXeGtaQkxRZ25Dayt5b0sr?=
 =?utf-8?B?dHQxcEFvTUQveFA3a1RlSVNsYlQzVWdWZkNLNDI4dEJ3VTVuYTRLVkRaVlVx?=
 =?utf-8?B?bVRIQ1l6Qm5QcVZxcjk0VFRreTczSDNnZmVxRjM5cFl0N1o0UU1yb1QzRndx?=
 =?utf-8?B?S2ptSExHSFFGeXhaM2hMUjd0T0JKRDFVU3FIS09tdERxcitobmZHZzBSQXhJ?=
 =?utf-8?B?eU1FTzBhNnFSUDVCNmRZSUZwd1JGYkszR0VFYWJJVW9jMUo2M2NJN2g3bk5S?=
 =?utf-8?B?RmUxSkhrUVBFVzd5d2JEVnZlRjJkelpDZ0xuYUpZSllwYnZBdHRTZ3kwTHJ0?=
 =?utf-8?B?aUduNHhZd04yWjdWM2h0Mitlb0V4eWQxSGZEdDJ5QlIrUTUzMWpKWXkzTXVz?=
 =?utf-8?B?SlNiNlkrSTBSSThWOHNBYi9EdCt5b2tub0tZZExuMFo4dXRQQjZpM0g5Qkdn?=
 =?utf-8?B?ZjNCSTVZN0tZbXpqM3lCUnBnWWxJYjR6dHRGWnJBOCtFbVpEeXM3OWpKRERL?=
 =?utf-8?B?RGd6TElaMTRodWovL2thekpJaytseVpRelREQ3R0SmpTWkRGUXd0RWJQNmRB?=
 =?utf-8?B?Q3l0SzA5b0NJOFNQVFYrT2FxRDRsMWxqelkyTEdSK3RtU2RQNDg0K25CVlh3?=
 =?utf-8?B?T0hFb0RmZkdGZEVabkN1d0dhS3RWWUFhS2liWUVXZ1J3TzhTWC8yMUpUUURu?=
 =?utf-8?B?MXBqY0Fwcm02bzIxcVJ3dlRvMzJnUlBrMjMzQTVwdkVlaWdoMlVnbi94blpU?=
 =?utf-8?B?Q3Y3eXR3QWEvVVFzNE8vMmV0THBkSE84NkxVYU1tTC9RYmdWQ3l4VGNUL25y?=
 =?utf-8?B?N2NqM2lFMC9keWRoczNKT2cvRWhOZm4vT3VSMnVIVnloVlE0N2Z5MkIxZmY0?=
 =?utf-8?B?UjVkYVduUjJkUGxMelA2cGpTT3NaMkpKRVUwLzF5NkRxVlI1aWdhK3ZFT0Nx?=
 =?utf-8?B?Und1Vk15TC9CYStCUktHUm1NbldpZXFNVG9zT1ZzMmFtYlpLVU94ejBaY2dD?=
 =?utf-8?B?NUg1K2lkSmNEVVVSRG5JT3RmTDBjaUpjOS9RdWZBN091V0x1WElISU52TlhP?=
 =?utf-8?B?QmdZQWlzMmJJTjRZblpLOHA4VkRFL2h4Z09DSUVHWHJEc01sdnBpYlEvZ2Fi?=
 =?utf-8?B?c1UySWpEcFpPcXhCR292bk90UDB4dkhuVzMrNW5oKzA0azd6eWZYVTdMOTIv?=
 =?utf-8?B?K0lOSnI5bTJod3F4OWhrTFRCdmQ4ZTJFQVZiaVZtZ3lxUFArTEF2RVpHbnRI?=
 =?utf-8?B?dy8wVFRZRzN4WVlvNXhYamFiN0RXcUVBY0QzaW41VldxTytOR2pWaklCUHRv?=
 =?utf-8?B?ZWY5MG5PRFFJbDN1UXNjdEJJN2tJc01WMjlxZGxWZVhyRldoWmVIS3Rvc25r?=
 =?utf-8?B?VWFSazMrNzRlMG1Fa1dxWXdTM2x1UVh4bGlSd1pxZm1IM3N1MkFTdDdQUjZV?=
 =?utf-8?B?ZWtxRDlleVY1c3MxQmp2S050Wi90R3czZFVoQWlxNUFvVWJTdkFML09WeEY2?=
 =?utf-8?Q?wFFaBwp/WXQNpBW9MEane8Pz9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663cb9ff-a18d-4ea9-4f57-08ddfa969d05
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:44:54.4748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEq5r8Q10x48g544fa1tX0sJCTvF4KkNCUBswXD7fpQiisZK2DARMQRYyHcs9nbx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
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

On 18.09.25 11:13, David Rosca wrote:
> 
> On 18. 09. 25 9:47, Tvrtko Ursulin wrote:
>>
>> On 17/09/2025 11:54, David Rosca wrote:
>>> Hi,
>>>
>>> On 17. 09. 25 12:15, Tvrtko Ursulin wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 17/09/2025 10:59, David Rosca wrote:
>>>>> drm_syncobj_find_fence returns fence chain for timeline syncobjs.
>>>>> Scheduler expects normal fences as job dependencies to be able to
>>>>> determine whether the fences come from the same entity or sched
>>>>> and skip waiting on them.
>>>>> With fence chain as job dependency, the fence will always be
>>>>> waited on forcing CPU round-trip before starting the job.
>>>>
>>>> Interesting! I was sending patches to fix this differently last year or so, by making the scheduler use dma_fence_array for tracking dependencies and relying on dma_fence_unwrap_merge to unwrap, coalesce contexts and only keep the latest fence for each. But I did not have a good story to show for which use cases it helped. So I am curious if you could share which scenario you found gets an improvement from your patch?
>>>
>>> The scenario I am trying to fix is very simple to reproduce with Vulkan when using timeline semaphore to sync submissions on the same queue (eg. each submit waiting on value signaled by previous submit). I have noticed this issue with FFmpeg Vulkan video code, but it will happen with any Vulkan app using this pattern.
>>
>> Still out of curiosity, is the performance loss from the CPU round-trip something you are able to measure?
> 
> Yes, I'm seeing measurable improvement with this patch applied. I have tested three cases (decoding three different videos) now and the result was +2%, +4% and +6%.

Mhm, I'm nearly 100% sure that we unwrapped the fences when we added timeline support. That must have been broken at some point without anybody noticing it.

Potentially when we moved the dependency handling from driver specific into common code. Probably a good idea to add CC stable to the patch before pushing it.

Going to review it on the original.

Regards,
Christian.

> 
> Regards,
> David
> 
>>
>> Btw your patch is I think fine, so:
>>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> But you will probably need Christian to ack it.
>>
>> Regards,
>>
>> Tvrtko
>>
>>>>> Signed-off-by: David Rosca <david.rosca@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++--
>>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/ drm/amd/amdgpu/amdgpu_cs.c
>>>>> index 2e93d570153c..779c11227a53 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> @@ -29,6 +29,7 @@
>>>>>   #include <linux/pagemap.h>
>>>>>   #include <linux/sync_file.h>
>>>>>   #include <linux/dma-buf.h>
>>>>> +#include <linux/dma-fence-unwrap.h>
>>>>>     #include <drm/amdgpu_drm.h>
>>>>>   #include <drm/drm_syncobj.h>
>>>>> @@ -450,7 +451,8 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>>>>>                        uint32_t handle, u64 point,
>>>>>                        u64 flags)
>>>>>   {
>>>>> -    struct dma_fence *fence;
>>>>> +    struct dma_fence *fence, *f;
>>>>> +    struct dma_fence_unwrap iter;
>>>>>       int r;
>>>>>         r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
>>>>> @@ -460,7 +462,11 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>>>>>           return r;
>>>>>       }
>>>>>   -    r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
>>>>> +    dma_fence_unwrap_for_each(f, &iter, fence) {
>>>>> +        if (!r)
>>>>> +            r = amdgpu_sync_fence(&p->sync, f, GFP_KERNEL);
>>>>> +    }
>>>>> +
>>>>>       dma_fence_put(fence);
>>>>>       return r;
>>>>>   }
>>>>
>>

