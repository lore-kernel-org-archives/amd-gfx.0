Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F603D5E144
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 12:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3B910E92E;
	Tue, 16 Dec 2025 12:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wkX8SAkD";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC99610E967
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 12:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soYPWMOheOtHOTump6JZtZTU2juzICK/a6Qg9w5OQULztU03ic5JaqmMbw1a82sv6+gQFNZMb8PgHw4jDU7wD90jpsaQW0V3uprTPiPHhs2SBh9O9uYag9QGxOkrLfeYVnLPdjYh7JJ4WO4zjRCFDV+7F6x9Wak4Y6F3zE8mW/xub68Df7vLe8HDWS2TRvjYLBkXDqRxfOJaBVgQEpCPt0QTbLvG0bypwbJqMJRF3LIDqxBTjGew0A2AQtpRDiJzqiD7IVlh3jsAfyJluYySdJvy4V1uqFjQHArbBrPzhwRDsRkZA5gBASrY/0gPCKz8aopyqQ7yFnpK8Wew4KVAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX26oS5dWV5yvZJdDiFdsYmhJNTrRVwe0dfnkmOnOy0=;
 b=qZweuw1ppuAMcR0DBawSF7NUaIBMb1FpZ7Je6nFvfvyeDfDxUSe8KforVkJ4eIoU7Ee+87z0muXLpceLtoyWu613/bqmmuNiajUy7lImYLeNXbwEyi9CydkSd72mFeDzG4V4TbdDrLnqoJn9UK3w781bhh/kHb8i79LS2kPZFq93KFxT26o18qhwFXjle0yWqmRrmjwMJtJ8tmW0EIatBUpPWGpJbvLXn/bst1IsWbd9/JkIORcsIbVMa8m4LGUmHOVplefAUpf+kCXCRw60kFCW4wjPfEdlPiJiPfrtRqGb/r8Z3WpEumOiZCBm0oLpLL7YCM4j219zKJghLabdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX26oS5dWV5yvZJdDiFdsYmhJNTrRVwe0dfnkmOnOy0=;
 b=wkX8SAkDU2UoxSZ7s7nSvVsyRiYk5QjwZlCTpeINEF2glTzSEpOydeCn5aQbDR/peOmOx5jUx2EaPrYKBhmOzrk35cZP0ZeyP4oBZABAOMx9+HWoHLzfnE4vMngu0fWA39r4M+N6KlXcoFRtpR4m8jM0kFSlbrPdZrIjzgAk5bQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 12:40:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 12:40:32 +0000
Message-ID: <b75ee437-7ad3-4dd3-85da-bff838d9c175@amd.com>
Date: Tue, 16 Dec 2025 18:10:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] amdkfd: Add device links between kfd device and
 amdgpu device
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com
References: <20251216060046.3131-1-superm1@kernel.org>
 <20251216060046.3131-3-superm1@kernel.org>
 <3dc170db-c7d3-4818-9fe3-5981aa03cf42@amd.com>
 <173943ab-3c7a-4e32-9d7d-a7d0973aa6be@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <173943ab-3c7a-4e32-9d7d-a7d0973aa6be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: e62ac0c5-c3a9-4c3a-fb8b-08de3ca04d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGI5YkxoeXJ2bVROK1lPUzJHeDVuQyt2ci8yZ1UvRUxlaXdWR0pRSnArbkxR?=
 =?utf-8?B?V1J3VlJIRUpiakUvcGExelljeE8wVllmaENRRkhlV203QWwyMTN0R2ZmSTAw?=
 =?utf-8?B?dFZTM2xEdE50QlNETzNORFJ4R3VLOENwZlp3bSt5RlVONTFFMUJ3WHBiakJy?=
 =?utf-8?B?dGZiUURWQ0RybXROQnMvbEZobENITko5bTdsT01pSGRGU1orMkFJR25zaUp5?=
 =?utf-8?B?RUtMUzQxYjJxdWtNNGh3a2dSWFdSYVBRQnpXd2RVK1NlbEZ3YWlTNzlqanB2?=
 =?utf-8?B?dWttT3RMa2o2eXNlVWh6ZmV5aFhzUUt2NVBaNUN1SXRtMlNsRWpMVUpOK1VO?=
 =?utf-8?B?bnBVVzNRWDVMenIxZ2NSUDdXOUhPZklURnZZbVFwZ0poNVg5Y24xbzU4NmNv?=
 =?utf-8?B?cVVvaXdkZlkrbGhSRVRUQ1QrajF5cTFLa3plM2M1K1VWRUtKZ0NENVovaXBm?=
 =?utf-8?B?d1VqQXNCU0FzbWVna0M5ajRUWGI0Mi9ONll3NXU0eWtsTkR3ZUwrZERkTFR3?=
 =?utf-8?B?eElkM0Z0ZG1nRDRkWFpHbXZKSTdudXJqakdVQXlkQ1hLall5RkRBNUUxK1ZX?=
 =?utf-8?B?ZHZBK0JXdE9tRUc5cFF4WWFEZUpGZUEyek9TR2hOOFZpR3dENXRjcVlwblNy?=
 =?utf-8?B?OTFuTUZiTHdnQlpUNEJSNkpRM09yR05CM2tJTVhhOVA0T1JSbldxUDBTdXB3?=
 =?utf-8?B?U1pYNitEa3k5Z3JKUmdPVzJDdjRNR0cxWmJpeGNVYnF5dm1tK0V0WW15Wk1Q?=
 =?utf-8?B?Zmd1UkNUQ3VMRHcvVUplL280Zmx4SG9Cam5ra0Z0c3Bmdm5uM2ZmZmVFNSsz?=
 =?utf-8?B?OHFLSkJGSkhSUSswQ2p5Vk9BNjVnMDN5RnZsdnBtYWJDSTFqYnU4WnFrUW0w?=
 =?utf-8?B?NCtiam9DVTVzUmNLWjA0WkpzR0wvbnhCSHdHMktqbW12bjdrVngrdDBCZzA2?=
 =?utf-8?B?c1NMeUxqKyttV1hkaHE2dE96YmdEVW80TEF1M0VGQlZYQ3RlVmJFNnhIVDFk?=
 =?utf-8?B?NXJwTHgzQktPMXdEbUZIQWtzaTZ6RDNBcE4yQTRQLzJEMDhIVDFDdEdDazdx?=
 =?utf-8?B?cmFVR2V4ejVmNDNhMmd3eVpDRDhHN0w0Sm9kRWcyWW9TZGtQcndrNHB3OFhy?=
 =?utf-8?B?bG0xOUw1SDJQcnJUUUF0OGl4Zm5QMVpyTHI5ME9zVUMyOXlLcVlrYTJ3dE5m?=
 =?utf-8?B?SnNVcXFFZUYybGppSWU0VVI3VmIrUDBoVVlwVjNqTlRtU0d6ZkhseTE4WTN5?=
 =?utf-8?B?SXhJNEtCd3lnRTRCNkFWU0hrZG0wTytrcjJNbUdUYnBBbFNKTFVnVHowYWN5?=
 =?utf-8?B?Qi9SN0xpUXVxSlE5dEoxeDlxSFFPWjIzd1o4WE0zd1ExUEVCNGx3anhrSnhB?=
 =?utf-8?B?enJHcTJ4QmRYNVRiUmdOMTRNTE9WSDAyeVRIUHZySzkwVnlTUW1pL2MrR2VY?=
 =?utf-8?B?aXBWNE11YXlxMVpBRlR3a01rVU9IWUxmUitmRFg2VEx3ZjV5a2llYklHaW1M?=
 =?utf-8?B?K3UvU0E1S1loZDJhRWV3QS9BK0lsTXlEVHRPMlk0TzMyWTUzYVF6UGJFbGlm?=
 =?utf-8?B?WW1iV3ZMZ2Fra2tZZEl5UmFYU05hN0gySElaR3NzQmZXK3daYXRyL1BFbitJ?=
 =?utf-8?B?U0VTeXJiSFhSejcxTXBBZlllK3ZZODdCeDBoN3NBVFduV3F5Q1NDTkQrSDFv?=
 =?utf-8?B?NEliMW9hdDN3OFVmZWVIS1BUWDhic05QYkNyenVyek14cVBxQnljRjl0S2Vy?=
 =?utf-8?B?WllCM2I2TXZ5bHRORHhTZHFMNlQ4TDVKdjdGK2JKZHFBRHdVMHgzS3BUbjYw?=
 =?utf-8?B?N3NBckJTaVVpb3lLdXFuRHZtK25tbWxqakQ5TFh3UEVYaWlVSUw0MDNBQjVY?=
 =?utf-8?B?Qk4zNytYMlZYbHlJS2N3SHFUM2NhOEs3QWI5MUo4MlFtdFgyeFVpK050dzFV?=
 =?utf-8?Q?O9DGV0hU8VdnAU76CyIJbdSra+W5RVE2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDI5TVBZNDM3bmFzK2p3MTdkRVREWC9YdVlyZXZUbk5hRlFOa1dBck5UelR4?=
 =?utf-8?B?QUtnN0NFUm5GYzBiM3MrMUd5ZURETzRXcEJ1NmN6cGJJU2EzL2lhcDg3NlhM?=
 =?utf-8?B?K0h6dkZnN0grQlFsNzlwR3IzbFlQTHJVQWVLaXQ0RzFlRzV0clJWc1NFRFNr?=
 =?utf-8?B?WVpxR3dKNDNpd21uSUl4Y3ZNTFZMclVZc1pCSGhhUHUyYy9uRjR6emZGd2ls?=
 =?utf-8?B?WmluUkNBWUpzT0lZdjlmUjNUMGRtMHg3ejBxRFRWUnJSUHh6YzE2aFZ6MGRZ?=
 =?utf-8?B?WFdOK2FWbGNVNFdJbHYzVjQ1aXBJejc3UUk2S3NDNGNGWENWS3pDZXlGcXZl?=
 =?utf-8?B?M0ZtcnN5OCtnVS9DQi9kKzladktCcXlEQmxOMWlnUDg5M1Byck9WaGlqaXBt?=
 =?utf-8?B?MUd3UDhGQzNRVFppTTJiR3EzZEYvY254ZkFXdWIwd0F2VlpvZXFSMzJBbUdh?=
 =?utf-8?B?WDRHKzNOQ2tucHVQbjZEU25TOXpQWk43cWdnRUZvODBUUlpUTGxrTFVDWWE3?=
 =?utf-8?B?dS95UEkwYy9RN01YeVdOUDlpcE1YQXVwVXRYdHVzdjY2SWROckhjVjBDRVVL?=
 =?utf-8?B?S2x0UlAydmdPQ0Y2QVYrRXNFWko5VE12a1RGVWp4ekxETjN5SHAzVy9uMm9B?=
 =?utf-8?B?a2FLaFY4Ryt1T2hNZVlTS0l3dWxVZ3J4UTM2ZGhNU0JpTGlkVmZhT3VtNUJ0?=
 =?utf-8?B?cTNZcitscnl1bFlkYklxTmdXWmhuWjhzdUd2UGlGUlNndGVNZE9kZ1h4N3l5?=
 =?utf-8?B?d09VYVVteitsWGNXeGNCS1ZKdktJVzBZUEFIMEhHQXVBYmNhYTFUaG9rWTBt?=
 =?utf-8?B?UlpjSHU2Rms2dUJvUnk2TEFXUVhFWWVmM0EzcXlBVnJOT0NtV2NXWDFnTjFx?=
 =?utf-8?B?dUc5eHlIQ2dnbk9LNy9tMXVzc1lVYTgxb2dIVDdQVE42ZC9lbzJ3WjlzS2dP?=
 =?utf-8?B?QUVHWFZJY0o5OG9qZWp4bktFY1Q0WkRoKzdhTVZpa0l3UWt3V0hwUGx6NzZC?=
 =?utf-8?B?cDFZUXB3SDJXaFFEdm9oUDZiQVNveGE4VHEreFUrZEc0c1dBV0diZlJWM2NN?=
 =?utf-8?B?cnZleG1GbmtwQnVpQmMrbGF5aVZWOXJubUFxZEwxRlB6WEF2enVoejNTS2NP?=
 =?utf-8?B?bUVKcU5tUkpaUVRJeGFBd2oyT3c5LzRmYlpoZ3JVYy9VaDh3RzlyVVZrK1dJ?=
 =?utf-8?B?MksvWDBaNmpvcXBmSVo1Tkc2dit0cjJtaGt0OC94bmJxRTRUUjNDM0RKaUlP?=
 =?utf-8?B?eUIyL21TRHI5RmVFRFZJblJWMkxRR0ZMS0J6NFdsM2hnbndEeFdxVzU5cS8w?=
 =?utf-8?B?ZTkxK0ZQYXdDVjI2NWhyMDNQVERjUEtsMVlGYjNyenAwUXBpbG0vc1JpcnJq?=
 =?utf-8?B?SHE0VDZtL3JvbExpRVFVbURmWkhnRTdEbGNDdnhxa0hCYURMNFBtWUxUbDVR?=
 =?utf-8?B?TUdVaGdNdXdjczhyUXlCQ2tvRytQVk5Ea2ZyRmVyaFFGWVlwbkp6Z2ptTWdP?=
 =?utf-8?B?RWlQemlCMitva292L1RpVHNid1p5Z2owTlR2eTJOS3VwNzJNVTlleVdFNm0y?=
 =?utf-8?B?UENKQUk0TTZGTnYwQXJSWGp2SVBqeXRKeCthUG5aNU1XOFYxUEZjdXFraGF5?=
 =?utf-8?B?TVpNeWVudlNHeURZYzlhbHZ0VmVaNmswcEJKYXJ2UEJHb0JCWFIvaDRDQlR3?=
 =?utf-8?B?SUVET1hUdEVjcWJZUy9rdDF5ZmtxdlpDVTdIMnEyNTdNdC9TWjdlVVhQTzFX?=
 =?utf-8?B?NkZhWnR3V29CTlhYckMzSEg3RXdacWZadVFkeGV5MDQzTkI5YXN5RExlUzZs?=
 =?utf-8?B?SnhiVkVHWVUvaks3TkhmaXBXSjRmdFFXOFFNMStMcEdwMFY2bTg3eVBjcmV5?=
 =?utf-8?B?Smovc3RhWHptS2hNVklYMGJtYTBFV2lqMHFjd0l0ZmthUzBveDBNU2FGbkNJ?=
 =?utf-8?B?ZWNxMFdPK1BNd0tXQmgwQ2pvZzh2TlArWkk3MTh3d3lRRjA2R1hjNWtreTU3?=
 =?utf-8?B?ZXhldWkrcnNTajMyVUgxdXlvSGdNemY2MzRmM3ZOR3dZN0p2Vm5YYlZlUnRT?=
 =?utf-8?B?Q3FiMGdOVnFhR2c5ZWh4SkxGZThnd29vM3dLVFRkczdCOEkzSkV2UWh0S1dL?=
 =?utf-8?Q?vdm2BabZGyIdYQJBEPvotyTXK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62ac0c5-c3a9-4c3a-fb8b-08de3ca04d1e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:40:32.3245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB0Hmowz++bmyk9FyCWO6QbRTk6VUeavV2wccq3zFmixaV9H8HexWd69c2WGX0v1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
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



On 16-Dec-25 5:49 PM, Mario Limonciello wrote:
> 
> 
> On 12/16/25 12:22 AM, Lazar, Lijo wrote:
>>
>>
>> On 16-Dec-25 11:30 AM, Mario Limonciello (AMD) wrote:
>>> Mapping out a KFD device to a GPU can be done manually by looking at the
>>> domain and location properties.  To make it easier to discover which
>>> KFD device goes with what GPU add a link to the GPU node.
>>>
>>
>> Access to the full device is not desirable in container environments 
>> where it is restricted to the particular partition's properties.
>>
> 
> Container environments don't typically bind mount the whole sysfs tree 
> do they?
> 

AFAIK, only selected ones and access restricted through cgroups.

Thanks,
Lijo

> Nonetheless; even if they did this information is already discoverable, 
> it's just a PIA to get to.
> 
>> Thanks,
>> Lijo
>>
>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> ---
>>> Cc: Harish.Kasiviswanathan@amd.com>
>>> v3:
>>>   * Create link when topology created
>>>   * Only call update topology when amdgpu is called
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      |  8 ++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  4 ++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c       | 17 ++++++++++++++++-
>>>   drivers/gpu/drm/amd/include/kgd_kfd_interface.h |  2 ++
>>>   5 files changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/ 
>>> gpu/ drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 67a01c4f38855..870a727d6e938 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -910,3 +910,11 @@ int amdgpu_amdkfd_config_sq_perfmon(struct 
>>> amdgpu_device *adev, uint32_t xcp_id,
>>>       return r;
>>>   }
>>> +
>>> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev)
>>> +{
>>> +    if (!adev->kfd.init_complete || !adev->kfd.dev)
>>> +        return 0;
>>> +
>>> +    return kfd_topology_update_sysfs();
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/ 
>>> gpu/ drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 8bdfcde2029b5..07aa519b28d45 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -268,6 +268,7 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device 
>>> *adev, uint32_t node_id);
>>>   int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, 
>>> uint32_t xcp_id,
>>>       bool core_override_enable, bool reg_override_enable, bool 
>>> perfmon_override_enable);
>>>   bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, 
>>> uint32_t node_id);
>>> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev);
>>>   /* Read user wptr from a specified user address space with page fault
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ 
>>> gpu/ drm/amd/amdgpu/amdgpu_device.c
>>> index 467326871a81e..d4c8b03b6bf57 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5123,6 +5123,10 @@ int amdgpu_device_init(struct amdgpu_device 
>>> *adev,
>>>        */
>>>       r = amdgpu_device_sys_interface_init(adev);
>>> +    r = amdgpu_amdkfd_create_sysfs_links(adev);
>>> +    if (r)
>>> +        dev_err(adev->dev, "Failed to create KFD sysfs link: %d\n", r);
>>> +
>>>       if (IS_ENABLED(CONFIG_PERF_EVENTS))
>>>           r = amdgpu_pmu_init(adev);
>>>       if (r)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/ 
>>> drm/amd/amdkfd/kfd_topology.c
>>> index a95be23fd0397..5f14c66902f9d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -571,6 +571,9 @@ static void kfd_remove_sysfs_node_entry(struct 
>>> kfd_topology_device *dev)
>>>       struct kfd_mem_properties *mem;
>>>       struct kfd_perf_properties *perf;
>>> +    if (dev->gpu)
>>> +        sysfs_remove_link(dev->kobj_node, "device");
>>> +
>>>       if (dev->kobj_iolink) {
>>>           list_for_each_entry(iolink, &dev->io_link_props, list)
>>>               if (iolink->kobj) {
>>> @@ -819,6 +822,18 @@ static int kfd_build_sysfs_node_entry(struct 
>>> kfd_topology_device *dev,
>>>               return ret;
>>>       }
>>> +    /*
>>> +     * create a link to the GPU node, but don't do a reverse one 
>>> since it might
>>> +     * not match after spatial partitioning
>>> +     */
>>> +    if (dev->gpu) {
>>> +        struct kobject *amdgpu_kobj = &dev->gpu->adev->dev->kobj;
>>> +
>>> +        ret = sysfs_create_link(dev->kobj_node, amdgpu_kobj, "device");
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>>       return 0;
>>>   }
>>> @@ -848,7 +863,7 @@ static void kfd_remove_sysfs_node_tree(void)
>>>           kfd_remove_sysfs_node_entry(dev);
>>>   }
>>> -static int kfd_topology_update_sysfs(void)
>>> +int kfd_topology_update_sysfs(void)
>>>   {
>>>       int ret;
>>> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/ 
>>> drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>>> index 9aba8596faa7e..0ee1a7d3a73f5 100644
>>> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>>> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>>> @@ -335,4 +335,6 @@ struct kfd2kgd_calls {
>>>                         int engine, int queue);
>>>   };
>>> +int kfd_topology_update_sysfs(void);
>>> +
>>>   #endif    /* KGD_KFD_INTERFACE_H_INCLUDED */
>>
> 

