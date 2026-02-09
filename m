Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B60BE7E0B4
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 09:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2958310E3A2;
	Mon,  9 Feb 2026 09:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Ilx360I";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9C810E3A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 09:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcqxAEvDmUtePFKyQGjhAKr8MQ3PVrEWGRbKHpsVOc0aRYzBAn/VGlOB4It+QBHrCn3DrJPS+jH1uhA3ymQy7XWlTnsIP+PZt9yRR+YDr5MhMctzK/pMpwImCQqxTDI2JV/Pr9iWDwCjXoX7ZVdwRYlGVteQe6pX5WvHM6bdARuyWyus/Joi+oWj/MOtj/y9CqaicWDVsxMiY3pz/I7ogh2kenwkbcZjiec3y/PnQ4VqWLjbdJLgZJNPh6y/jg5pspHEul2vUJhsme55LcOSsovNz86yWi5A9YesT5xKSWQlnKmd0xmS7TgljGPDb5Evv4Hcvcj2BRBUsJEGfgCBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu0dX6ItKjKdJh3arQrZipSCTYQwJ9VCGRfU7a1bqzs=;
 b=SBMoxnzJBMyC9+qu5SsSogsLf/O2uRA0nlPWSjM6aX3sI18DEr9v81r3k9bSdlilV4FUgCKnA/vKpRUd9UwwodUAZkLiLWHhYpncanU8H7gmEN4TPoLzBQ2qhSOFnbU3Ffk5Uelf3bl31dsxIPnLxXspJxHiaVYC8lcB+oCfFtdUnHX6zqD4WviA8D4HoVjGL7w+LDhGP24wPI3TZklY+m09kZP6XnfsDuyz5NvUzMC8QlLZiQf8iIjZOvR2VN2GLwBApQIENc48RlDwQZQhSJbAn0dsYLcNqC/kkT51BQz+nCkxrH/sS+//LKo9RsxnpOQQnJxyWBiCDZlSaQVymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu0dX6ItKjKdJh3arQrZipSCTYQwJ9VCGRfU7a1bqzs=;
 b=5Ilx360IUg5kxmEWU+XjtEhTB03IHz3YO6ZKGHaF1Sh71zf3cahnA28Gj0+bF2poEP2sGCu7aljSEHKl0/+EQYrHmc18TKayozLbd/kWp/oaMlqrRcApxvXc82XrKpT74Od+qWNEoQrXfub79fJs6JBSjFRrE86dCeITLfpMSRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 09:41:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:41:28 +0000
Message-ID: <65a74779-bcf9-4d19-a1b7-ca0b148dfbda@amd.com>
Date: Mon, 9 Feb 2026 10:41:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Don't propagate errors from amdgpu_vm_flush()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260208062713.1500367-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260208062713.1500367-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 31eda585-518f-4093-4034-08de67bf660d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG0yZCttYWJKaFU5a3hLVnhTVlA0U2JKOFBjYm9OYmlUZFZmMWRsRWEvcTRY?=
 =?utf-8?B?ODBLbFlqZUtwbUprL1cwWEkyL2s5azFwNkc1NEdGaTVmaXViQVorVU0vTDFa?=
 =?utf-8?B?MmxZMy82a21hYUd5UEdyaEpROE9hUGpqS0VOTmdxU0JXUHZoREtEMWlNQVdI?=
 =?utf-8?B?aFpyMTMwdll0RDhXV1AzYWMxTEhvR2lPMGEveGlVN3NXMG9OdXU5R2xvcWFw?=
 =?utf-8?B?WG5HYjM1b0R2a3JuQUwvU29zTFg4dTJ6cnJncnBOekVpRzFyckg4YjRodzFh?=
 =?utf-8?B?M3dDN2ZQRVlQRzRSRmRvOU1PSWtMNGFXZDNpeW11K21kVjZQS3VTaUptazhT?=
 =?utf-8?B?RWd3WWZsSGhFTWVISi9McTFOVjhHTVlZN29CY0tjN0pQaER5eWZ4akxLTFZ0?=
 =?utf-8?B?U2o4TW9IZGREeG1wRkVqZmZNTEJ4dW1PSGVtNjJ4MlUxQ3hNMmorMDZoeUFG?=
 =?utf-8?B?YXg4cXZ3Zyt3UFlpRkUyTmR2QlpZa0dRQ3liY3hvRWhBQWdQcXdmN2VTZjlq?=
 =?utf-8?B?Mm1HQnJBM2RXMmhjbmgzTEljZEhYVXRxZEdkRjFPWTcwL25ucDVhT2xjSElx?=
 =?utf-8?B?UDJLMVk1d2ZHbkdac3BYcXV6UU9KN2toOHJyN09Hd2tkTTd4aWFEbFNHR0U0?=
 =?utf-8?B?cmVlL0luNHh2Q29QUmN0Vk1WVng1bGRCbU1lak5Kajdma24yTjgzNEhocys4?=
 =?utf-8?B?YkFlUlhmU1FjZlAzSTdWRnpUZy82UmFMdFcyV09jMkxibVpkZFJXaS84YTFQ?=
 =?utf-8?B?MUpleEhQTzlwOXVWWFBIdDdwd2FPbS9jeHJhaE5FQ1Zmb2xTbTh4MDQyYXZW?=
 =?utf-8?B?S0ZTSDZiNHJWc1BTMFVodlhleklxdmo0N3F1c2NaQ29zUUJUa01pbnZhUHNw?=
 =?utf-8?B?eVhTTDM1R0FQM05WNHdzalVYWWYvWXJ1M2F3ZThHMDliWFhDRkxoR2dQaWpt?=
 =?utf-8?B?aUNNbE8zMkMwYm9ZZS9oNERJMmRzMDJjWEZEajFiRDhISWNybitzOEFweDZH?=
 =?utf-8?B?WFhBdS9rZitVT0REcTU0MElvdWJVMHF2aklQTXJDYnFQWFZYS1NldVZMdlhx?=
 =?utf-8?B?aWhOWVNiRHlxWHlDTkVvajRPSjA2bEdlb1hXZnUwcUlMOElXMlBPWDdsbVpj?=
 =?utf-8?B?RVdINWZ3Y2labzhHZnIvSmFHci9KMndldkQwSHovNkxmRjJweUFwcXJFMmVB?=
 =?utf-8?B?UW91dkRwMkdyL3Q1QmduRGpGWVNqZGZZM0MxS3NsYm84a1U3T2MyZEVFTSt4?=
 =?utf-8?B?azBMUXJhbjA4ZTlSTHpYb0JUdld0bkROVjZ6Q0NaQ0tOeUxaaHFXZUZCWURn?=
 =?utf-8?B?RWpwODYrNzUxRk03Mk40WEMxOW1Pa0ZXUU4rQTdDTHpickFGNUgvYldYQ0Ry?=
 =?utf-8?B?Rm53ZjFZZ0dNU0YzSFpjMXNpNFNMSTUzOEk2UFFES0lsRS9WK1JMRVpxQ3cy?=
 =?utf-8?B?WkR5a3YvQ29GdUNTTFQxekpDOE1Wc2ZHbitmQTJYbjl2VjdPWGhkRDJEMk0r?=
 =?utf-8?B?d3pJVzN4dTlhL3o2TTluWVVFb3R1UnJmMXVNVTh2Y0xnNk5raHZqRjRld0Jv?=
 =?utf-8?B?ZEpVaU1tb3RQMG1SaHNvY29WcTNnWGFkVVpuK0RRdWFYdmlkSC9LVmpKaFdG?=
 =?utf-8?B?SXBSdEwyMndVQmJsd1lyYzA2b045SUtlUnV0L29qNDQ2RW44YWFhRGRqTGg1?=
 =?utf-8?B?eUlraUVSd0ZHSDNOVGgrZVJ2d2UxOUR3UFp4OU9LL3dKQzlVcUl6MlJBVTdI?=
 =?utf-8?B?ZG5xTk1nMGRUMXd5UUs0YmNKN05mVEFzSTJRQ2JSUS9oVmNValpSdzZRcTJX?=
 =?utf-8?B?eXF0TGhLbDZRUXU4RVh5QTE1M0pkZ2dxUGFlb3VEN2RETnlpUitYaHpGK3dR?=
 =?utf-8?B?a2o1ZUo3dHlyZEJZMlNxdm9HRU9veEs0YXQyQWhxdFlaMzd5cWhCMDJsRUpT?=
 =?utf-8?B?MHQwL1M3SlF1bDl1NVBjenl0UDNpSkVNRnprQkZGaUFCV0tBR3c0WW9QZmRW?=
 =?utf-8?B?R2J6Q25KL0g4MWVqaWFCeFVZZ244OHRMaDYvRm00dVJZWGY1N29UTFRBTWds?=
 =?utf-8?B?c1M2Vk83MDNMR2dpSWh5RHV2a2ZKdzUxK1VUQzZ6M0pOOGFhYzBLU3oraFN5?=
 =?utf-8?Q?WmO8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vjl1ZFdPMHh1UWx0SGpEZzJkbzZPbk9wK3pDU2N1cHg0eFZVakNBNXA1THhZ?=
 =?utf-8?B?Zlh5V2hyNjE2YldLek5OeUFLdkRpa0VqOWVPNTRvM05vOXFNL0hUWkVCeFNz?=
 =?utf-8?B?amtNRmtmZXphamM4THJmUUJDa2IwR1N3RlNGZVN1NlEzT1F4d3Axa2NQQUtX?=
 =?utf-8?B?cm55KzZvdTlhZHhUT002VnRsSnVJVjNPbnArKzJVdTVyRnhwWkh6QnJ0a2xY?=
 =?utf-8?B?bzdKR2FSRUoyR1BHRnFaTS9RWThwZ1cxOGJheU12Q2xJcEtoemZGUjN6Nm9L?=
 =?utf-8?B?WDJ1UEpEZTcvNUtSUENVRTU4aEVSeklBUWwyTk1XR0p3cHNjaTlaYzZEbFlz?=
 =?utf-8?B?R3J2VGw4SzhjbCtEeW9HUGNqdlFQVmpWRG8rLzNjVXB4RGdiQ0lLQU9FMjBW?=
 =?utf-8?B?WmhBMGtCRW5oc0tUT2Y5N2lVT05MY0xGRlNNdFFrQTFYa1MyQ0JORGtjRDdh?=
 =?utf-8?B?YUpKZkUySHRFelA1Z2JKU0xBN0JzVEtFZHdRRDdCb0czTEhIVDRWVk84czB4?=
 =?utf-8?B?L2o3Q0xPTW5SeGNzREdKSjN3ZndKelJlcktqRXhZRGF2dTFjTS9sdm51alZw?=
 =?utf-8?B?aVhHNXdmRUdOcWdqeEl4SHIrdDIzdkhTaGx4QVQwUWtpSVExS3lYREJHTmZ2?=
 =?utf-8?B?RjQ1M3ZzTStMcEw3dmFHMUtKcGdLVXlvVXdhbFRnS2VKWVBNazMwVEpXWi9C?=
 =?utf-8?B?Y3c2Yi83TW5HVGNTVTNtWFcxSlZ6Y3FmblFmaUVwdURuZ1NoYVJmTE1lR25n?=
 =?utf-8?B?bHc1MnpCTE5seXcyUmUrcWN4MXJpc1NMbjl3WDFqaFRNVll2Ly9BNXlOd2d3?=
 =?utf-8?B?a1Y3d1VvSmROTjdkUzdVNFRFanJ2UW9LZWRHRS8wQkhJay84OEI2bCsyNEZs?=
 =?utf-8?B?M3lhL29nNmZyZU1rRXhnZEs4WFp3UzhkdzZtVXdpWHdjaWhjdTBvbXpubytG?=
 =?utf-8?B?U3lPR2FsR3dJajNjR1hucnV4Zk0yWkVtbFFBT0QxZm84NjFkSEk1Ym4xblBS?=
 =?utf-8?B?WEViUlljM28ralhRMXBBOTM3Nm1XMjAxcTFVKzhnbzNNQXRocTRheFl3VmI0?=
 =?utf-8?B?dkQ1QU00U08vMk1qRzBabnBrRStJck9PUzJ0QlhmenluSXBMRjJ1UStFa21C?=
 =?utf-8?B?dm9Ndkp3czI4SEFvUVJmTkZYQ1lmd3dwZk9QYndadVRZQi9qUWw3NzRvN05O?=
 =?utf-8?B?bmNqcUdqQnhmQ3Z6R1BjV2w0d1RtdDd1VkZIb2psa2VpQVUzblZOV21ENDhz?=
 =?utf-8?B?SURFbDRhWDErZlk0STEwTEE0R0swc2ErTWFkQVdCU1ptV05uVnVGSGkzZ21q?=
 =?utf-8?B?ZGp1eVFOcUpTc21jRWMvalNlVDJCWDZMT0dNR3NVMXo2SW1RZ08yQzRCNkdV?=
 =?utf-8?B?S2NvNWxXNUJic29CdGtUY0JueGdqdFUvK05jQjk0aldlSlN5SDZKN3lpTzdt?=
 =?utf-8?B?OVhZcXUzdkVVVEdIbEVtZit5Tlh0cDNDK090d3JuQUhWdllZOFA5S3p4ZEZx?=
 =?utf-8?B?RVh5WjJ2bTVQc25xZHF3c21MZTlNanBLdTZhUytxb3psUkxpanY4WXliNmNU?=
 =?utf-8?B?dHcwc296c1RzQTJNcnQzNHJOUFovQ1dKZ0g0eGx3WWE4UktvalhQc2JxZXJV?=
 =?utf-8?B?WVIvYS9mZUlESlArckMvUUo1UGV6NThVRUZFVklFMjZyN1NXRVdWWmQ4YzBn?=
 =?utf-8?B?Y1FFdGNMZjM1azVRckxaN0F4NzE0TW1UZFRQN2o1Wm9vdVZZRnZqZWVJRFVD?=
 =?utf-8?B?dlhXc1JyNU9HRFF3WjRmQ1orbkhoVVZDTDhVWTR4NVh5WjJWR0pEdDJDeUEr?=
 =?utf-8?B?NTg4bVJQazVPWmxmckZjTm1KZFpxQ3BPRzFwMU4vWUV1Z1hYVkw3TGNqb3k0?=
 =?utf-8?B?amwxTTQ4eXlCWVRaUFBxYnZkZjFEWDJLWDMxQnRiQllZS3JVTzNnYTJTZklo?=
 =?utf-8?B?YkFwSUZ3WDJseklvREl4cnpVWGRvN3RNbmc5NWZDLzE2Vnk1T29Mb0x1OFl4?=
 =?utf-8?B?czFSOEdzbFBaYzc0dkxIbHl0WVEyOElnbWZlMDg5c3NXelJ4WUwvdHI4M2Rl?=
 =?utf-8?B?Z2hSRGNJM1JpVElMWm1SWTVlYmFPa1pwR2FzaHZONTQ1U3c3QnpaUmRyQ3BL?=
 =?utf-8?B?Q0JKZng0ZFg2ZEdsbW9mNnloWm4yMEFLaUR0dXE0VXdKbHBMcTlMSjdpOC9O?=
 =?utf-8?B?MHhkMHhqZ1lSalllT1lWSzVlWnBKaExkRlMyeWtmUXNyZ0c1M3Z1dTFOMDhL?=
 =?utf-8?B?OHdRTTFBRlFmOUJWN2hqV2FROTMxYkd3ZDczU1Z5dDdyWXRKNm5BNElZUDRI?=
 =?utf-8?Q?sT/Q0819+jABAOCzzA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31eda585-518f-4093-4034-08de67bf660d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 09:41:28.3490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AE6WnH1z45Ds0ulWQdjWtTMi77wQMoEJezN2uePKWjl1GzCnYB1Q+UpMc1MlBwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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

On 2/8/26 07:27, Srinivasan Shanmugam wrote:
> amdgpu_vm_flush() only returns an error when amdgpu_fence_emit() fails.

You need to take a step further amdgpu_fence_emit() can't fail either.

The fallback wait inside that function blocks forever until the fence signals and that should never happen in the job submission path in the first place.

Regards,
Christian.

> That failure is not expected and the caller should not have to handle
> it.
> 
> Handle amdgpu_fence_emit() failure inside amdgpu_vm_flush() by undoing
> the ring and return 0. Drop the return value handling in
> amdgpu_ib_schedule().
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  9 ++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 +++++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
>  3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 44f230d67da2..e763b2c1a386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -225,13 +225,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	if (ring->funcs->insert_start)
>  		ring->funcs->insert_start(ring);
>  
> -	if (job) {
> -		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
> -		if (r) {
> -			amdgpu_ring_undo(ring);
> -			return r;
> -		}
> -	}
> +	if (job)
> +		amdgpu_vm_flush(ring, job, need_pipe_sync);
>  
>  	amdgpu_ring_ib_begin(ring);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 807f8bcc7de5..2698a3bf7970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -764,12 +764,9 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>   * @need_pipe_sync: is pipe sync needed
>   *
>   * Emit a VM flush when it is necessary.
> - *
> - * Returns:
> - * 0 on success, errno otherwise.
>   */
> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		    bool need_pipe_sync)
> +void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +		     bool need_pipe_sync)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
> @@ -783,7 +780,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	bool cleaner_shader_needed = false;
>  	bool pasid_mapping_needed = false;
>  	struct dma_fence *fence = NULL;
> -	unsigned int patch;
> +	unsigned int patch = 0;
>  	int r;
>  
>  	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> @@ -812,7 +809,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  
>  	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>  	    !cleaner_shader_needed)
> -		return 0;
> +		return;
>  
>  	amdgpu_ring_ib_begin(ring);
>  	if (ring->funcs->init_cond_exec)
> @@ -846,8 +843,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  
>  	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>  		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> -		if (r)
> -			return r;
> +		if (WARN_ON_ONCE(r)) {
> +			/*
> +			 * amdgpu_vm_flush() is not expected to fail.
> +			 * The only possible error originates from amdgpu_fence_emit().
> +			 * If it ever fails, undo ring writes and don't propagate
> +			 * an error to callers.
> +			 */
> +			dev_err(adev->dev, "failed to emit VM fence (%d)\n", r);
> +			amdgpu_ring_undo(ring);
> +			return;
> +		}
>  		fence = &job->hw_vm_fence->base;
>  		/* get a ref for the job */
>  		dma_fence_get(fence);
> @@ -892,7 +898,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	}
>  
>  	amdgpu_ring_ib_end(ring);
> -	return 0;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 139642eacdd0..322193b97d3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		       struct ww_acquire_ctx *ticket,
>  		       int (*callback)(void *p, struct amdgpu_bo *bo),
>  		       void *param);
> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
> +void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
>  int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  			  struct amdgpu_vm *vm, bool immediate);
>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,

