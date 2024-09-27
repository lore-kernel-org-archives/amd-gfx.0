Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7FACEBF69
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37E210E1A3;
	Fri, 27 Sep 2024 04:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hhT6Evtg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DB910E1A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHpIQmLcjUQ8cUWlgCgcv0gUTtpXGnoXl8CAKkHYSxWX/ewu8Ac+27KCf3ylr9lqsMKsHQLRqYxeWA4kg//MdkjKFuLb5SlwYYP9zvSWBa+Dl+lx+owOcXORJ42mfoznyOhpbryaJn+Kf2UKUfG8Dx9jKkhAZCQ+X3gXukDCDCWfmDjGqYob1ZTvC9kx2cH/2q3p6Zwxft+xh7URI3KCiVmXCz2jgIkn+QEtwLAGwuPnk6qbkIDM2Iu54/Cd0eDelclhS8DTF+cKpGJndFRanbuyhSh8AXqZ+SDj4JOcC4yCgesfhVQslvqKTgJ7fZKMdMssKMiqMu1qAObiJI9m6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmuZAm0bt9cvxRbS9fHpjzfw4Dzd6LOd7pShA78mnCM=;
 b=VObZ+goI64MuU4iXAX3R6NQm+PXJ06sKWCPT7KdxytvjHfsdQNW0ns+y8O7k+t+xBra1lMvGcTS62841sXDAazgx+DV7dAPupwiSdzgL8jnezLrqIOC2JsBEYa0K8sWRp0HCCqxbRAr1p9DPilmcWZbV6gBKhkk5H1c5CxSWAlMcJcFLbu7V1Karid5W70oxu/ifBzdTE5nBVvlpGmaRUWNAgjKR+wlarm+o+E/xmkUSxFbmQ4DFHJRisjiBODF6ArWT5vNJdGjKpdTSyW66Ai2sb4kK/mOCRV31pRXtPQ7uYj/jg56JddCYy0u71c45SSBFT7rlblXuwOkp2MhNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmuZAm0bt9cvxRbS9fHpjzfw4Dzd6LOd7pShA78mnCM=;
 b=hhT6EvtgsNbeY2kP6E5ddSHs004AXU1SFZhCWkHEvAHo5g7Lc9kRL8gZlvg31gye33GkV4c+FyLe0PqrsVqvd0EY/PDtKWOXpXkeoN7fPH0ZBwAhSptopKwQNN/teUPclvXst+qrU7A1DgOBF8IDsvllhKdTpKJjGggjMDsrMN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.26; Fri, 27 Sep 2024 04:40:00 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.031; Fri, 27 Sep 2024
 04:40:00 +0000
Message-ID: <18552185-d008-4e40-9190-1615dc17de4a@amd.com>
Date: Fri, 27 Sep 2024 10:09:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
To: "Xu, Feifei" <feifxu@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-7-lijo.lazar@amd.com>
 <CH2PR12MB4152398EF93FAEDC322ADBEEFE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
 <641b8541-1277-1092-25da-26d1f33561c2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <641b8541-1277-1092-25da-26d1f33561c2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f947b9-013d-47c1-c506-08dcdeae7212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmxCTXBNVWMvc3g1dE5uNTdaV2R1Z2xpSEtJYnlUMlpDdjhPTFYrS2poQkZr?=
 =?utf-8?B?MXBHODAzSUVNVktYQ2E1ZGpWWW9GNWV6RWgwdFA1SktNQUR5ZU4yR3VpeHNR?=
 =?utf-8?B?cExTQXVNNWU4RG9UbGg4dkN2QWtPSXQvQTlkV0czZTF4YStBbkNVWForUHNm?=
 =?utf-8?B?SjVGWVBCS1VpTWEycFpTVzFEdlkxb2EwRFh3SUNoMHVnMENEZCtpRlJzT3lx?=
 =?utf-8?B?SWFpeGdRVlFHWHB0QkFwUkZSQkQzbUhIQWNLWVp1RHNpOTdEY0RjYy9YT1lX?=
 =?utf-8?B?a3V5OXFvOHBqcU81bFFjYmY1SzNnRkpWUGVOc0hKZURiZ3JBK2xVT0JBSFp3?=
 =?utf-8?B?SGlVa3dxbTBOTFlzeHRzTTNQWjR0Ni92dHN4UDNtb3owL0wwZUxkbTlwa1dt?=
 =?utf-8?B?VWlZeW1GUnJReERGbjBqSDdacUh3WHlzblJqS0I4QXUwQ1VmdFNaaGxrMFlt?=
 =?utf-8?B?TmQ1dU5lTVlnaVM4eitDV3NQTlVWRTk4dnBselBMY0lId1lpcVMzL1p5NzZR?=
 =?utf-8?B?MVNIS1NRUWUreVBnQlI0Z3hpdXRTakpaeEJvTW1wR2pwdGFXVStQczUxandN?=
 =?utf-8?B?aDI3dTRCb1ZIbUV3RnZBcHdwNS9sSnlXYVloOERRVzR0TVFCT2VVSVhWbzgx?=
 =?utf-8?B?YmJvd3U0Mk9DWDVGTys3SEtDYVUveU5ISFNNb0hBQ01xTE1qQlVDVUF5ajZr?=
 =?utf-8?B?dzZ5Q2N0bzNvdGd0TGFYOXJaVjBqVWJaR1NidmtSblc2WmloU3NWdG40dysx?=
 =?utf-8?B?TitmK3dnaVRQOXdhZm9ZaEdwUVVFVS81endWbUpFNFBKVkdQUXh3RjBVaDkv?=
 =?utf-8?B?Z0M3TXJmMEMrUWRHbGlCRnBmcE0xVU9ZRnBQQkVvTXpqYWhwRFZCRlZFTnd5?=
 =?utf-8?B?bk1HUkpwUFM4TjROeGVUZjhCUjUrdjdYUEtpclNrb0wvVTh2Q3Y4WlEzV09S?=
 =?utf-8?B?bjgyS2duM1hJUFBrMTlXZzRhMVcrcklTcS9CaW9tMFRZelFTWFpJdXYyaEJG?=
 =?utf-8?B?SXo2Rm53SmwzczNZdm1EVERHM3dlLzJhTVE1K2ErQUwyTlZmckc1VUszRjNM?=
 =?utf-8?B?b2VFem9PQ3ZLeVJ2Q1VlQ3AvR28vVnJ1SHpVY2xSbG0xbFBIT0J2bEN0MXBK?=
 =?utf-8?B?OW9pcWpJWlAvWE9wYUxCZlhxVmlldmJJQmtza2N0RDRXTUNtR2V1MStMVXpv?=
 =?utf-8?B?OEgrY1lxR29HMzE0NVVMYVNZMEUxbGVaWktXdWJ0RUFRWnhLbzZYYzJ1ZmtZ?=
 =?utf-8?B?ankydWxZbmo3VnJIM3FyOWFjWGd0MVBINkN2dGx4L1BDNWczR1NxVXJucFBu?=
 =?utf-8?B?TEMzOG82QXNQOFFJamR4UDJNbURVUUw1ZnlOb1NzZWgxVEw3RDdBczU4S1I5?=
 =?utf-8?B?RXl3eXhhcmYwdGxaZVQ0NjV2UVZ6a3ZDYjhnZllKRnhNWVBKeUE3UFQyb1ho?=
 =?utf-8?B?dDhZN1doUGFwOGhnUk9SN2o2REw2MkM5bDNXS20wMmJRajFKZXJxWlowb29u?=
 =?utf-8?B?Ym03QmpyWkdFVE8xWnNyRE5nVGw3M0xPWU55UGppQXVXTmhaaW5xV0hhT0ZM?=
 =?utf-8?B?cWxvNUtoQ1FEU0RwVjN3d2tvRnBVU3RVOHRjRm5leWg2V1NweTE5SGxrZm1i?=
 =?utf-8?B?cWJFS1RjT1Nta2VkdXk0VXpVeFlLSXRWbG5sVTJvamQxWnJxdmRjakJ5SG5D?=
 =?utf-8?B?a0JONlp1K3FQWHordlVvcjJYdTZQbEttSWx5Slp3ZjBqYittTjc4Ly8rZit5?=
 =?utf-8?B?MTRBbjd2QS9sU3ErMjRnRlRTSU9mUkxnMzZTR0hiSG9SY0dnV1g2ZElFcTFB?=
 =?utf-8?B?Rm9XUmlFblJLd2FxMjlLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lzh3ZDJ4OTV6cG93dDV1cHJ0bHo1cG83a1IycWUyR0JKb24ybmRDVjVZeUky?=
 =?utf-8?B?MGd5cmRCVmd2SlZXN0pxeGhqQ2trNXdQL0VobHBHUnN1ajVPaVRLRFEyRndi?=
 =?utf-8?B?L0t0UFRSdmNwYVRDamtIT3h2VlRKSzFGQVp6K3VIZTJNZXFCaHNnS0Y3eHBj?=
 =?utf-8?B?TEhWbG5pSTNKSDRMS2RYL2dubkM1amdpMjFkN0RBRE5ETi9YRHVxZGJWMW5T?=
 =?utf-8?B?ekF4MzJWZDJ0MUJ2YzhDNzFtYThrMXptUXdyNElTT2dFdEZUM1E2WWo2MlF2?=
 =?utf-8?B?TUdaa2NJNTFZb2QxZk84ZjA5VXp0Z1drVU1LUHZyTS9xWFhJNFFRU3FaYVBs?=
 =?utf-8?B?SlFkTEMwZGRzYldER1BGMFVCQmM1L2I3eU9qTmtlcGxuYVJNSG0xVFV2TElv?=
 =?utf-8?B?Yzd5N3lHemZsRFNCcE9zL05zZjA4a0NpN2V1S09uS3hsNEkxQlVqRDBlblUw?=
 =?utf-8?B?eGVha2F0bElrTG55NHBUTGFuaU9KZW5vKzZVZytWWGxwWmU5Ri9kMUdRQ0ZI?=
 =?utf-8?B?Y3BzRUxnSGs3ZTlVK09TeDZ1M0dyMis3N25mcVM3REtPdjU0dzkycVpBazF5?=
 =?utf-8?B?elh0SFh6RXpFcVROUTVWQUJmaWw3ZndtQXIxUS9pQTNyR05UaHQvclpwYkdl?=
 =?utf-8?B?cWlxZUw5MkVlWDdYTnJCM2ZmN3ZGS0JoT2dzMytaenNpY3JQc0p0azhRUnRC?=
 =?utf-8?B?RzFjbFZSeUVKb3RZVGJnOGlFRm1vQ00rOTFvb3hmZWJWR3o1WFFBZ1Brdjdn?=
 =?utf-8?B?c2xiSTRzcFE0QVBUaU5seFFudUFhSVY1Qm9lMWozNE9FL2gveG8zNGJPckgw?=
 =?utf-8?B?S0xoTGJnekRsbFJBNlBXNmIxSlJXYWZNRWRHSDIyUkh3VzBJd0VOVU81SWxw?=
 =?utf-8?B?dnhYNWNZZktJRXY0U2sxU1RzajN6ZHhUL3VlZkVQRHpSUzlMblZmZ24raENy?=
 =?utf-8?B?MXNBYmZxTWtaOEZaYUtMWVQrQStUK3VTSDhQOTg2dHpMVkpsOGlYYjFDaVda?=
 =?utf-8?B?bG13UFBYRnVZdWMvaG1KQThSUWJ3WWpHUVhUOWhsRlpYR3VIMUZFWXNJR1Vv?=
 =?utf-8?B?VHhYTHpqY0VVNUxCYkNrMjVIQXVoU3NvdVdrTlFEelMwdG1oZTNwQTM2T1hk?=
 =?utf-8?B?LzFXQVV3WGh5VEVRdUNyejM2cDZKMTRsK1JZMnMrL1Z6U1ZXdm1TdDY5SDdZ?=
 =?utf-8?B?QjdqTDUya1Rsb2NHZ2NSUnROaVkzUGRqUHpBa2JGcDVta1l5dzh5RHlhN25Z?=
 =?utf-8?B?dDNTYUxhU09YbTY3T1gyNGdDTlBEajRMem1ZRHZQZkRQSldvOVZkM0tzbHpR?=
 =?utf-8?B?NVYwL2VyZFdPb3JmQyt5enIzZjYvbDZTdm5Ocmx3U2FDM014Y3dMbWphQnRk?=
 =?utf-8?B?SGp6bFFBYW1QMXdYZnBid0tPUjNWSFp0OHI1eG9takZpbmFrekNDU00zQ2tj?=
 =?utf-8?B?dVNWczdLSlRYa3hnZmpiczJxRU85SXFnc0RsMklWZDc1Z0pjcXVoSXJXSWV4?=
 =?utf-8?B?QVhnWkRaT3dWcTAvN0l3aUNDYnFseTJ3U2V1SXdHeDNwS0VWL1VwMmhxeGY2?=
 =?utf-8?B?UENjS2t3aG5pZ0FPeW1yUndiVjBOQ0REWndnUlZPbnQ4TGtFNy95bDN5Szll?=
 =?utf-8?B?Mm1SZ2VHUk5RVGI2ZzVtUnlrVHAycHM1ajZhUHczczdGSDBkU0xCOFRQbzlY?=
 =?utf-8?B?THduMGZOSnJVcjcvaW5TdERGM3F1bm90d1cyNGM2aGxDRXhGazU1MjlvWXpO?=
 =?utf-8?B?MEFFNGhJQ0NEY09ScUJMc05Hd0MrWFJBTFlSbW0wbDQxYXNvblJRa0trcU9Z?=
 =?utf-8?B?VHM1UFh4c0Q3YWpSTkRyZ29qbGJTK3RxYkNkUDE1OEtjUGx5ZWFhSHZvWkg2?=
 =?utf-8?B?cE5mT3JHNUxqeXd1c3RzaGFkWE9Cd2xMSkc1TVNReHAzbEZMZVBkemNqSGpB?=
 =?utf-8?B?dDR4cU92dHVoMmxGOUROSnNCWHBoT3ZqMVhwOGx3QU5IQm96OC9UVWcvazZa?=
 =?utf-8?B?Q0lwWUdGcDRETHRvY2JXNitkZEpLU3NXSlJZUjA0c3VVc2lQQUNBSGRTM3Fl?=
 =?utf-8?B?RG1Cb1ZpQ2pGVVkybkU5bWRGZDl0QzJZN0JuMU85Nm5BZmpmY2xrRUxZNkY3?=
 =?utf-8?Q?BOEUdTYMFD2yS0fwczw00n6Aj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f947b9-013d-47c1-c506-08dcdeae7212
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:40:00.2996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFqPCRCC9/1sFoCvtgxGn8Ff1paIInrxBOd/L7looHiwmmWatZZhr+NrBTxmTKB5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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



On 9/27/2024 9:26 AM, Xu, Feifei wrote:
>>>I guess you are referring to the below corner case
> 
>>>            1) Place NPS request
> 
>>>         2) Unload Driver
> 
>>>            3) Reinstall driver with a different TOS (possible but quite
> unlikely)
> 
>>>             4) Driver reload
> 
>>>             5) Driver checks TOS version first and goes for a reset
> 
>>>             6) reset_flag of GMC is not set, hence it doesn't refresh
> the NPS range.
> 
>  
> 
>  
> 
>>>I think changing the order in soc15_need_reset_on_init() to check for
> NPS request before TOS version check will solve this.
> 
> Yes, I was thinking of  reset_flag and tOS reloading
> (adev->init_lvl->level set to AMDGPU_INIT_LEVEL_MINIMAL_XGMI) changing
> at the same time. And NPS refresh will be ignored. Though might be
> likely in debugging or regression isolation cases which changing driver
> packaged with different TOS.  And yes making NPS refresh checking before
> TOS version checking will solve this.
> 
> And if we do not return ahead when checking NPS request before tOS
> version change in soc15_need_reset_on_init(), we can drop 
> (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) check in below
> refresh checking:
> 

This check is used when NPS request change is identified. During swinit
part it will be at MINIMAL_XGMI level, but at that point there is no
need to refresh this information as reset is pending. It is refreshed
after a reset when init level returns to default.

Thanks,
Lijo

> +     refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
> +               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> 
> refresh = (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> 
> Thanks
> Feifei
> 
> On 9/26/2024 5:01 PM, Xu, Feifei wrote:
>>>> +     refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>>>> +               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>> Is there a corner case that reloading with a different version tos and refreshing nps change co-exist?
>>
>> Thanks,
>> Feifei
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
>> Sent: Tuesday, September 24, 2024 1:57 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
>> Subject: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
>>
>> Add a callback to check if there is any condition detected by GMC block for reset on init. One case is if a pending NPS change request is detected. If reset is done because of NPS switch, refresh NPS info from discovery table.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
>>  drivers/gpu/drm/amd/amdgpu/soc15.c      |  2 ++
>>  3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 21f1e65c9dc9..011fe3a847d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -1261,12 +1261,15 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>>         struct amdgpu_gmc_memrange *ranges;
>>         int range_cnt, ret, i, j;
>>         uint32_t nps_type;
>> +       bool refresh;
>>
>>         if (!mem_ranges)
>>                 return -EINVAL;
>>
>> +       refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>> +                 (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>>         ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>> -                                           &range_cnt, false);
>> +                                           &range_cnt, refresh);
>>
>>         if (ret)
>>                 return ret;
>> @@ -1392,3 +1395,11 @@ void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev)
>>                         adev->dev,
>>                         "NPS mode change request done, reload driver to complete the change\n");  }
>> +
>> +bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev) {
>> +       if (adev->gmc.gmc_funcs->need_reset_on_init)
>> +               return adev->gmc.gmc_funcs->need_reset_on_init(adev);
>> +
>> +       return false;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index b13d6adb5efd..d4cd247fe574 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -78,6 +78,8 @@ enum amdgpu_memory_partition {
>>          BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
>>          BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))
>>
>> +#define AMDGPU_GMC_INIT_RESET_NPS  BIT(0)
>> +
>>  /*
>>   * GMC page fault information
>>   */
>> @@ -169,6 +171,7 @@ struct amdgpu_gmc_funcs {
>>         /* Request NPS mode */
>>         int (*request_mem_partition_mode)(struct amdgpu_device *adev,
>>                                           int nps_mode);
>> +       bool (*need_reset_on_init)(struct amdgpu_device *adev);
>>  };
>>
>>  struct amdgpu_xgmi_ras {
>> @@ -314,6 +317,7 @@ struct amdgpu_gmc {
>>         const struct amdgpu_gmc_funcs   *gmc_funcs;
>>         enum amdgpu_memory_partition    requested_nps_mode;
>>         uint32_t supported_nps_modes;
>> +       uint32_t reset_flags;
>>
>>         struct amdgpu_xgmi xgmi;
>>         struct amdgpu_irq_src   ecc_irq;
>> @@ -468,5 +472,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,  int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
>>                                         int nps_mode);
>>  void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
>> +bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev);
>>
>>  #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 619933f252aa..97ca4931a7ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -833,6 +833,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
>>
>>         if (amdgpu_psp_tos_reload_needed(adev))
>>                 return true;
>> +       if (amdgpu_gmc_need_reset_on_init(adev))
>> +               return true;
>>         /* Just return false for soc15 GPUs.  Reset does not seem to
>>          * be necessary.
>>          */
>> --
>> 2.25.1
>>
