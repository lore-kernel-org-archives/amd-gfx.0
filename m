Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAF1ECD993
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 18:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E58810E940;
	Thu,  5 Feb 2026 18:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sna8lZ2y";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2C910E0E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 18:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzR9BpNllIJes2lOlkUkguphqYzteez+DAMEdDEBM7clh3U61ytdlGmETzz6urpurkJ1VcROUfeP0ycgz5ripizD64ObHNUiyJCPIcuMAQkWYiitIMN7CObWO9C++wKaAhvn8I9/MFWRL0a5mlJ2D0wq8wokCKiBfrUg1H2gh8mkzHoYMhKTR197gSV1BTLkxPwQmZ1zOQE8ko6VcxxucUMgrm+CT4Pxh0IoHeff3G1SYs74ndMX08BECO0hLEKVUDMIr0js4Hl8FqGQrsFBp0/VfdMRQO+Oj98dCZe48yGhk1e3SWtgbdTnk7hcuUMau/NLFpDDbQoaOEhk1wxozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaZXblcHdUtBU9lUoz+xg5WrlDYnb6zZ3xCw3Yd+HEM=;
 b=QWVF9C7vcJml/KIrddMYGjNXnAfCM+vXbV1q1w2brbcwFmc3h4FkbyEvYZ/VrvDPoJwhjutI0GLYSuuXKNoOqSd62PxfCTT8+giqKqPDhlxTqJI0Gw27h3W3iJGTc3S5d5J+eoU83NCyEx6WVWtekl/CnolhjR57qXf3ysNpyJRNyysoz6e0oksfopoCgOQfHFcxicj35Pt1YjwoNBQNFG8WEfMNjL19PEI8UdZTe01HV1gXfmZBpnIG72e4Vh9LVqo/PGjhjxAeprizy0EG3F7v0mxb8DOES9St4AeUtiQ2XKoLzAdrDLaCl65qubjI5G4kXEDPLPhlX8DT2zr27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaZXblcHdUtBU9lUoz+xg5WrlDYnb6zZ3xCw3Yd+HEM=;
 b=sna8lZ2ywkTruGzU5X9jHxq2Ns3+rkxwXba3ZDA3cY+Zy5pghgCMbCUNqr2bcDkrX5nOOIIG8Zsh+3fFtYw4EPAwoh4HOV5ekZpdwrzOqIQwcq5txpnFuh+Glcy/9luC5+TXGxloDSUbKWltQmS+FhnNDGwL7JkPZY3lPp+ajsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 18:09:03 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::62e2:3bb5:bf24:5e96]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::62e2:3bb5:bf24:5e96%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 18:09:03 +0000
Message-ID: <f05102ad-0902-46ff-8bc2-29ed809b11f1@amd.com>
Date: Thu, 5 Feb 2026 12:09:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
To: "Alysa.Liu@amd.com" <Alysa.Liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, harish.kasiviswanathan@amd.com
References: <20260205162846.106865-1-Alysa.Liu@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20260205162846.106865-1-Alysa.Liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::20) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: ca14b22a-afc2-43e8-1fa0-08de64e1a51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZW1SNVdqdTdoSTNwMjcxMDZEcFVpSzJNVC84cnVjWXg5S09mZ3J5cmo3ajh6?=
 =?utf-8?B?NGVZK3U2STB0eVF0MDNNV0ZCR2lBd0FIZFBIU0RKQzBBQ0VhdlVISW5IS095?=
 =?utf-8?B?NVVKa3BHbTVJMHRLcjRXdFdvZ0Q1bmVmcVdXclFjTlNOSi9LNlJoV1czVHZY?=
 =?utf-8?B?ZnU0aE5rZ1h4S2o5QWtEMnNyOWlsZkVoc0xkZUZ4RWtQbk9YNFJRUEEvQ1Q2?=
 =?utf-8?B?dmlSUC81QkJhL1dvb2dxYzc1alJGUVNHS1JlcHV3cUgvRnh1TklHUUw0dXRD?=
 =?utf-8?B?Z3pmb0FFc3RxTTFlUWxtdlkzNFNwVUxhTm85UHF5WDQzcXp1cW5rZ3IyYTBt?=
 =?utf-8?B?eVBDdkc1S296NENmamlBeVpOMC9MbVB0SFZnNTU0aTNEUkpRRGV3WWRKcVNx?=
 =?utf-8?B?bHpBSVBHZnZYdEJ2WmpQOHVLYkRERkxTcTAxTjAxcU55aHNNVWp5T1BRQlUz?=
 =?utf-8?B?S01xTnRZUVNHempuY0o4b1AvQTVSTDBoR0RkMUErR0ZxMHdoZjhyQTliTXBU?=
 =?utf-8?B?MUt3ajFlNGpWLy9qUjBZVkhtZUhCLzdwTmdNZnVCQUV5WmxuR3BJVGhxUWlo?=
 =?utf-8?B?NWNobkh2OWlRdWFDSmx4dk1oQUlZNTRPdnVSOTd1cHBhbTZnL2Q3MVFMQjBs?=
 =?utf-8?B?RE9ocDIweWFOd256WkErNzZDSWIydytHNjI2R0VvcythY3pUYW1FRDh4MlZT?=
 =?utf-8?B?VVRxODRlakpjeDFsdVZ2U2VHdWVwNmVSbGJ3cXVMcUpIMFA0M2d0SzFlTks2?=
 =?utf-8?B?cE5GdEo0Wkcrc3FnbTJud0ZTd2JkOXlXMGVUb080d1JyUEx1a2J3VVE0N0J3?=
 =?utf-8?B?cFJJYk9BNXUzMFBBUDM3eTV6SzRlQXlJZjludGVXZ2pOV0llMFhvY0RzY0Ri?=
 =?utf-8?B?V3hwTmR5eENPNzZFTE4zd0libjdKcEQxS0dpVXkxTzdtTGd2S2dScFFMdzRu?=
 =?utf-8?B?TG9nTUd1NGhTQnl2OUh1eXEzc1FZaDRJQjQ0OVkvekRXamd3K0pla21IK0t0?=
 =?utf-8?B?YnJxbXY5SU04SVRzcGpGR0Z6ODN0bi9yb2hIMWdQMldJdVRXRk52QTM5VUp2?=
 =?utf-8?B?bWdRRWQ4NWcvZFo0RWRHQTB0eW9TQTRPNlZGWU1GT013Q3NzdlRnRDhZT1RZ?=
 =?utf-8?B?OGY5UFU4Sy9oMUF2cjBxelRINkNoY3FaSWY4aUtQblhwOVFmdDNJVERXOWgx?=
 =?utf-8?B?aGYva1N4ckVPakRjdzFBTFY3dmt1azc3dGNJTUxPczBPVkh6S2pxV2oxWmxv?=
 =?utf-8?B?UXZBL0Jra2ZVTlNoclVSZHo4U1NqR0FTTkp3bFdDWFo1ZmNsNWlOSTNQRXFY?=
 =?utf-8?B?YkxFbVVSbHFHQkJLN2o0U0M4TmFxMnQ4WERJWldVbGNaTXVUVmFMMG8xL2hq?=
 =?utf-8?B?cUpRRlVqWElUejF3dUxwRzNtRndGZXU2UmVTRjllTkdBNW5KQWdrQ0gwV2Vq?=
 =?utf-8?B?N3A2WG5Td2NYUVZyQVUwdVJnaTBjZmRyZGV3TUJyZHMrdVRoME1IUXJSL2dl?=
 =?utf-8?B?Q3VSN09paWZHd0dTeFZYbHVKVjdqc3EzOTh5UmNmSk5PdElPOStTNmV1MHF0?=
 =?utf-8?B?cGJUM0syc3NzOGxCazZtQUkvSmxpQUZZbjBGQ1RuNUJ1dW84S21PZDdGWkVu?=
 =?utf-8?B?b1ZTN1BjbCthNkNSY0JoVVBibXZLbm9IMVJ3SnVoSWVRU3lnTUw0RzdiR0dr?=
 =?utf-8?B?QktzNm8rUHdUV1UyVE1uZnpncU1SU3FEODVQd2pUenNETWhNU2Q0RVc3SHR2?=
 =?utf-8?B?dFlXYVlSVHFqSWQ2ZFh1NDBYd00zcFo0ZkZ0anlMbGtqeTlrSW4xeHNFK0ww?=
 =?utf-8?B?d24vdzB2UmdTK21pUkNZamVkNnVzTGlTQ3NRMm13MzRwRVpFN3NHVE1zUHJr?=
 =?utf-8?B?aEU2aktpY3U5LzZjeTIremx2U0h1N1MzNlpCMDBxcXRheG9Pci93cnFQcit1?=
 =?utf-8?B?b1BucjMwVVFabW9IcHdzdGI0aSs3clRhcytnYzRDQkhHRU8wZ1FXNUIxZkZq?=
 =?utf-8?B?NHZxaGMvZ1I0bmZydEZjQzQ2UjdnTGk3K2JYMmVIeWlpT1c2MklsbEtLVWRl?=
 =?utf-8?B?YzE1Y3RNL2FYT1BvaG1ZRkdrNmJKVkZpQituRXZMRDZKYXlCV010NUlnNnVj?=
 =?utf-8?Q?cSBQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWJmcUpIZ05RbGVqMnRObkhNWGlXWStTZHJZSnNWOElHQUtyNmJ0c2Q3TjlG?=
 =?utf-8?B?ckdMMGszSVhFOHdzYlBxNEtzNjNDNWdBSTA3L3pNRGorYksvdTBWeUx1aDJw?=
 =?utf-8?B?Q1FPdkorVGpPRjJueUh1K2JVbmxXYjVuSHNFOHczSGRpc0UyeEZyQzRSVGJo?=
 =?utf-8?B?a0xMTE9QRFJncUllTHNvOGlNYlJCVUJUWjg3SGVzSFJieWNNS1hsekdmSXd6?=
 =?utf-8?B?WXhVRTRlSGIvcWFkR2dBTTM5bUF4MUhhODducHBYTmpQT3dBR2w1LzkvaDFC?=
 =?utf-8?B?Mm85dWY1QzE2SmFNRTVqUDNqRFgvdHVPaEhleWlFdFdtbmROcEdEa2kybjNu?=
 =?utf-8?B?alZJQXBYb3NNUExvK1ZkSTRidHZTTHl6N0dOM01oUTE4dVBadkE0cXVkV20r?=
 =?utf-8?B?Uk0zMStjS0dHMVZ3MVBJUDJyWVhqV2V5RlhiOGg1U2NmUStUMUZ1Q1RsMGdZ?=
 =?utf-8?B?OFFoUXlnRCtBNW1tQVZGSUFuOUZ0QmhlV3hzNkIyK3c1Um90SURDSk85WnRF?=
 =?utf-8?B?MGpGUnlQb3BYMkJTVXlxdS85TDY1VXI5SnQ4ZlZmb0wrb1Yra1JLbkt6d2tE?=
 =?utf-8?B?VHE5ZkhRY0hzOUdZbE9TZFpWemtubWorenZBcTNSN2x5dXhPUjd1NjFXV2FJ?=
 =?utf-8?B?a2NpbG9KMVl3bXB2SmJrRnNvN3BwTElrVkZ0V1E2VW9QTG1ieUI3d3doakdw?=
 =?utf-8?B?QUxtOUpmd1FqTUZSWkl4VEtRVUR6MGduYy9CWkRabGFWN0hPcG5ybDdDbnhG?=
 =?utf-8?B?V3Zqd0QveE5Ha04zdERldWRuT2k1R1EyejFCdXVxRk9CMm45YWtka09hTjZU?=
 =?utf-8?B?TVlmS2x0M2RZcTMzQUxFNnZYYStldDJaT285RkU4SkFOWmRjYWRVb2Z6QzIr?=
 =?utf-8?B?WS9IZE9OZS84bnJDclZMTEF3VjJhYU15WnpRM1VjY3FVNWwxRjMxSGdTT1pT?=
 =?utf-8?B?V0l4RG8xMVlJUTRrVHNmdHRldEwxQkVYMGs0d0xVWm5yRmswaXFkYXBaWkZH?=
 =?utf-8?B?TXhud29taGJ6OVY0dDRpSzBnckhvNUozUDdLR2pOWDJ3ajZhMjVmV2hmUVNI?=
 =?utf-8?B?YTNNZENnWE11TWhkQWhLYVk0clUxU1FXalhHdkk3UTlIWVFQL1JGNjd2WUFB?=
 =?utf-8?B?a2tvbStxTzljTlFRMVV5dUcyS1cvMG8vbEY5VTNqREFkVHJ0aWFHZXpOSnRT?=
 =?utf-8?B?VWdQcUlZNk9RTFFRbXVUWFNCVXpNaHNUK3NGb1V1dk5PRlYybGlPWTdJNEgx?=
 =?utf-8?B?LzcweWxXSHFJZlVFbWpiVTcrV1hoRWI0QmZNTVJzK2xPZFFXS0xlcjk0UWFk?=
 =?utf-8?B?L2ZySVpVN1E1T0JWbXNMaDVQMnExODZGTmp5YWdoNmE0M09ua0NrRm4vdUYy?=
 =?utf-8?B?T3FPbGE2Qm1iMkIvYTUxMk9US1lYRDVMV1J2dzFrYWhsMiszSGlTdmRsYzF2?=
 =?utf-8?B?Rms4NENqa1EvVHlYZ3RQNjMvNjZWVHpydUwwOGVxTVllSWR3N3FRMVB0V1Bo?=
 =?utf-8?B?bGNIQW9YU2lUc1Npc2pvVGZOSDl1WUdGcEdjZFRxcUtaU2EwZkJScU9FRTBH?=
 =?utf-8?B?SS9KTEluemZ6Tk5yOGNIV2ZROHYyRDduTlZXODVtT0FmOHorYWExVVFVMWtv?=
 =?utf-8?B?WklyZlYxNHhFbHdnVmhXdHBqc1NsWjRkUEcxMGtOUzhxb3Q5YkhoZFppTkJW?=
 =?utf-8?B?VGxmNzdEU1hYK3NXY3MwcUNROEhTSGJHK1dkYVRYd0VDTFc3OWw2dXNUbEZE?=
 =?utf-8?B?QkNnRFVuK0JCRERGOE5UeVRRUHJHNkJia1BJajhFYzkreHhPVDhCQklWRlZE?=
 =?utf-8?B?dzFMYmNTRG00eEVTZ1ZJS2U5SlpIc3UvL3BnNWxwQkhxR3RhbDJiTGZBYTUr?=
 =?utf-8?B?d3IycE9mZGk0OEtUUEo2N2R0WFY0VGk4V29KQ2kybk5obHk4bzI5UkJwVzdp?=
 =?utf-8?B?SWlmVGptZjhjNHpkY2I1UFR3bGU1Y01RMHljeTlrSmxLcTlhbUkrMU92emVk?=
 =?utf-8?B?RUtUNXZaWHp6aE92dG9WdVRQcTFKbjFHcndSNWJlNEV4d0NIYkJyN3hTcjRn?=
 =?utf-8?B?b3ExejlnS3Vva2FjbVQwZlpaZDNWSU9uR09aOEk5WHZWY0Fyb1RKWlVBbTJ3?=
 =?utf-8?B?dnllamFEcmtOYVRvZW0zTmlzUVMvdEFkSkE0ai83cU10bDlBSmpORVR5WHpq?=
 =?utf-8?B?Um91T3ZSekYvQ0drSDcxQkwyZ2dSdUVBQncyZ2xOWlFxRVJveG1NKy9qaTBN?=
 =?utf-8?B?QjdlNTBYbTNnMzVSYkY3WGc4MDlTZDRETzU5UGFKUzJOTDVIQjZxdGhnczZ3?=
 =?utf-8?Q?noN5Y1REigPRe6/Key?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca14b22a-afc2-43e8-1fa0-08de64e1a51e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 18:09:03.5489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zp0XQsgYvGty2cZ8ybb56WjP6yhmUqqcRVYkRT1/gSFjBySDgC98JhDUw/OMNxOq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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


On 2/5/2026 10:28 AM, Alysa.Liu@amd.com wrote:
> Replace non-atomic vm->process_info assignment with cmpxchg()
> to prevent race when parent/child processes sharing a drm_file
> both try to acquire the same VM after fork().

I wonder how parent/child processes can share same drm file? The child 
process should close render node after fork/exec, then create its own 
gpu vm. Thunk open render node with O_CLOEXEC.

Regards

Xiaogang

> Signed-off-by: Alysa.Liu@amd.com <Alysa.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 00ea69baa126..f7b2358a0303 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   		*process_info = info;
>   	}
>   
> -	vm->process_info = *process_info;
> +	if (cmpxchg(&vm->process_info, NULL, *process_info) != NULL) {
> +		ret = -EINVAL;
> +		goto already_acquired;
> +	}
>   
>   	/* Validate page directory and attach eviction fence */
>   	ret = amdgpu_bo_reserve(vm->root.bo, true);
> @@ -1472,6 +1475,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   	amdgpu_bo_unreserve(vm->root.bo);
>   reserve_pd_fail:
>   	vm->process_info = NULL;
> +already_acquired:
>   	if (info) {
>   		dma_fence_put(&info->eviction_fence->base);
>   		*process_info = NULL;
