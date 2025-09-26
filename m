Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DADCAC5B5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 02:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D31910E173;
	Fri, 26 Sep 2025 02:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T869LRkp";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BC010E173
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 02:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSrzIV0LjyNZ47fqHlC7YNRosp6Mz/knZN8ebnAWf6BE0YXhY1o+5tM0dHIu/9VmCEYIm+wocALBoBzu1g1weqRJugKKkJCDlXcyL4sS/aEUrZRLrBE29qq+TlZ9PyiOVgekcdy0Ywj9hWdtcknlSLP/11P0vCalNEGvlWD7S1takrzOtiHEzb8PooOiBMagKWpRgns9TuQ6exiow3xss4gOlbMX8RegrJE9TLGspCCHAEr60y1Ukoj6r9Bm20nM1CZEELDw5ZLt9VbjaTL5L17Xu444EpsmwRcadX9xYEbCRlc0udgBu/55ugDKG+dTOP/kzmEF8jmuleWN7geQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp8NHIw0n9uSdTDKAjd3GG62ddaZXSemgBu9ralT6Ck=;
 b=j31XEvEzjg2xR5IpUKVprodEowedArkO+KC8iCf1jMq5umVRgUzIp9AeY/ceYUZTpNMWArTs+P0OrcU83BCs3NLRrdc0z9V/30ipYH5bTcGEl43viTZcvmqhRMTjb/cgu8ktiBa2vUdT3ED8tQQLVzxwuVZdrZWRolJOLRgg4OkJLto7CSPYC483gfrkH9znx15xW/lqJPkVnS4CTz8/FqUkKNa0Fh+zVN6d/nKr5/biTEW8HzzsdkQGrHkeZUwxjoYfg0XGT4TUwfKsnIo+81TZvNImcDfU5lmnap+T0HvcMcxUYJ4dVBf66PlvbilMLot+4jFMbwJh0/8Rwf98Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp8NHIw0n9uSdTDKAjd3GG62ddaZXSemgBu9ralT6Ck=;
 b=T869LRkpA7vnt8wYC1lCgGh0ud0KthijvaDArlr8d0dwjWTqHZjaMf532DkljSDDYD0TD1m1KqMI8AjeKckuc6rtOGyVENArHDueZDcdnYCEUyte7OCV16JQiOH+eJFNEJshB799shHKyXw4WcwEM0VZ0UCTylhJ7JcevlIsRIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 02:49:41 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 02:49:41 +0000
Content-Type: multipart/alternative;
 boundary="------------PfYIYcHXl0ohc00ubybZvCjq"
Message-ID: <498cf72e-6204-41ee-8a22-d7be901a8f77@amd.com>
Date: Fri, 26 Sep 2025 10:49:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 17/18] amdkfd: set_debug_trap ioctl only works on a
 primary kfd_process target
To: "Kuehling, Felix" <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
 <20250923072608.252345-18-lingshan.zhu@amd.com>
 <08ecb504-abb8-4ad8-bbbb-a18e19daffbe@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <08ecb504-abb8-4ad8-bbbb-a18e19daffbe@amd.com>
X-ClientProxiedBy: TY4P301CA0016.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::19) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 281ab091-d385-40a0-b868-08ddfca75723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1IxU3pKcXBUcW5lVm9naUtoWHZnNUlPQzdvblBEY2tGOFM2elVQY242MHoy?=
 =?utf-8?B?RHNtbUJod0QvZnVtVEJPUEdhaHRmdmRCR2ZaZmVkUjgxZEt2Zkx3RTVFU0dy?=
 =?utf-8?B?aSs1V1ZCWmdTb0lUM202R3ovNUNuQXRVUllIWFJuYTF5SHl2WEhqanU3Umhk?=
 =?utf-8?B?UHFZd0NlYkJBWVlzQkJOcnZyL0NXQ2lPRzByQklFMGQ4VjAwSDZvNGF0Z01y?=
 =?utf-8?B?aE9sL0Zod3p5Q09OcHU3cjJhMkwyc295bjhURmNqMzIrNjdHWVY4cnZ1Wlcz?=
 =?utf-8?B?V2dxcWlxcnN3NGc3L0NIN243THJMVm5kdWlRc0RZRDYwai8rcStXUWp6YUNI?=
 =?utf-8?B?VWJtaE1DaEdROUdBellmbmxvN0JhN3NRMCtlaFhFQnQ1ZzdVWG5pNlB4S1h5?=
 =?utf-8?B?TkFVVWVoUnlwclFZUFN6aU1LME5PMENXckpzdGo5bTFwaE1jaW44b2svKy9X?=
 =?utf-8?B?UzNPV3ErMGFtSlA0WFBtYnJMNWZsRWJoQkJHYUpFWGtYR0FBL0tUc1lqOW9U?=
 =?utf-8?B?N1FqdEoxRGVhb1V5TThneTNJYi95TmFwcG9LeUdsMVE1MkZaV0N0MjFYQnRn?=
 =?utf-8?B?cldzUDhIWGdyL2kvOFlKY1NkOEFzTVc0cjMyVjB4a2ZFOGJueDl0cHlCTUE0?=
 =?utf-8?B?VlBiekk2dCtaT2tVakQ4cU9nc2EzQWgyWSttQW5lRUhMRmUyYjVGUjV6Zkcz?=
 =?utf-8?B?dHlGWFk2a3o3cDRoVEw5YktDbkNJWUtQMk9mUFV5WUhoWTJGSU5oQ0lHVFBS?=
 =?utf-8?B?aGdRc0dwYml5M0cvN2o3M0tvRE1YeFBOVFBobGhuQkZCWWpIWnhVdWxaNWJU?=
 =?utf-8?B?YTNMMlNMQTU1THl0aFZUOU5RcHJ0NkI0aGVWVjJ6SlFUZSs2eXZVNEJSeisz?=
 =?utf-8?B?c1VLd3ArWjZ4cVIwa3BaUFNGQ3RkRjlzVnNwdjFMNnBNQVpsdGZpOEJnL2Ix?=
 =?utf-8?B?bHN4Z0tlNy9RSUJjSDV5NDBtaWJZWnNZOG84dmN6b0FjNkZuZ2Q4SWpENFJl?=
 =?utf-8?B?cWUvbWlSVnJ3bEdBS2dQckYvcm5lTU1Kbm1kRDF0ZXVpcVJoUk1CcVd0RUQv?=
 =?utf-8?B?b09IUnJCU1dPT0dHb21mcHQvRi8weVdIOXlIRFhjQlZSaHlhRmJKRTJUTWdF?=
 =?utf-8?B?RVNlY1V2b1FFc2w5bUp3cUxEdXlpeUc4WGRXUjZYSUEydk0rNjdZNzdSVWdC?=
 =?utf-8?B?QkNneW03c1JTdkV3dm1WU0hqY1lYT1h1YlJOY1VFZlgxY2hBWEZQQzl1ZkE5?=
 =?utf-8?B?cmZDMDErbHlxdFIwVDJ0eHdvV25jbWsyRDNQaTF5SjllZWgzTVlTaU9EdXNa?=
 =?utf-8?B?UVZVdmhkYVpjeWlxb2dNaHZGd090SHZtVXdsTnR3T255OHc5bUVzRE9vYmhS?=
 =?utf-8?B?M3c0aTZudTE3SVJneU5uYWkzS3VMNXBpS3dYTitENG96TG0zdngyQW5QN2Iz?=
 =?utf-8?B?UWFUVHIzUGVmZkx2L3MyR0pYZXRjczBtRGFmdDBDWStZVWNITXFxRThZdGln?=
 =?utf-8?B?OHEyZ1ZKMjhHOTV4ZzA2dnllelNZcFJwTUIzSm5PMkJZKzJTaVhzSm5MR3Zm?=
 =?utf-8?B?OTZhUWZlakkwVFNnZWR0STRTd1IwTTMrams4ODRESXc0QnY1azFlNzVFUXc1?=
 =?utf-8?B?WERSSU5zWjZXRGtzU1NiZVBZR2dMdlJPYXhYeXVwVGxwU0JtWEw0Q0plTElt?=
 =?utf-8?B?cGpwYzZWeG11UlN3SXBad3JhejV4UE1aQy9QRXppNGgwVFkxS0s4cFdNL0pw?=
 =?utf-8?B?ZDJ6ckNVa0JNVFQ5dDJ5VHgwZ2VlendGTjl3dFFvYlhxY1VDRlhKeTNNZ2F5?=
 =?utf-8?B?OGFNR2VvaUptOUVYSmtIa0JXMmhWN3JsNkR4WEZjeDlFOEdtUGxnek52V3Rh?=
 =?utf-8?B?VWdteDhpYWpKZWQ1MWxSRi9IdjR5VWN2VytlZm84ejYrcC9BNTJrRDhQV2tC?=
 =?utf-8?Q?LgmRWjcCJTsABRovAdtfntU9EtGciBrm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnAxZHpKOTVUWVgzYTFnZ2JtVEN1NHAwa21sMHlzREhTTWtEcjA1SVhKY1J4?=
 =?utf-8?B?eHpCejlIRnN0enJnT0I1M1RocURSUWtKZjRZZmtsS0ZHeTAvR1JNMXl0djVI?=
 =?utf-8?B?M2oxQ244dXQ3VEp6RzBweTcyWGFmR2RVYk9hVmp4bkhveFZYNm1hMzlZcjRX?=
 =?utf-8?B?aGJpMi9NNEh1UnlsT1M1YXA2T0RHVXpUdnF6L05BVlNRUDM1aSt5Y1ZMcnZw?=
 =?utf-8?B?bG93b0VlQ0dKUjZEeEsyMThwQkIydk5XUFB6SE01L2xCMjh4alZqbzg2emtN?=
 =?utf-8?B?bHl4cm9rNWR3aXZxT0tZUkdRbkg4YVlnSVM1TCs3SmFpY2tCNUhySkNrbHVh?=
 =?utf-8?B?N05oQ2cwVTA4VjFFNXBVQUo1V3NQdDgyMjRkN2lPOFVnQmZwU2k4ZndKcmFW?=
 =?utf-8?B?QkEwWEJRcTJPSXEwYzVOU1F6U0NrTHArNkZoaUhxN1ZhL2lodHRXdnZhVDdx?=
 =?utf-8?B?NWFVS0lQYURQVWd0WFVaSFR2cWRBVzBHSVJPUlk5Wjd4NEhmN1l4K2o4K2p6?=
 =?utf-8?B?MVlVL0ZNTldzZUh1Tll1VHM3M0M3eGlKZ0hEVGJiSlIwblFNS2JTY2FsUGxM?=
 =?utf-8?B?WG9vaFZqYm1EdFkzbVFTT0JhbG9HNXVxVTRPaHNEeVAyRnNpZUhsdkMrbUR5?=
 =?utf-8?B?UUUzSTcvVTFIOU5KclNWelVRYWg2Mms2aU9jSTFxQ3lTWUwrUitsN0VrUC9m?=
 =?utf-8?B?TC8yUFloUWpadkowb0RnT2FVUHR2dzVLeEpzazlGZkpNUXl4RXRzTW9qTFd3?=
 =?utf-8?B?U2ErYk1UZ0o3T2JsQzZncnYvSXVjMEtvTDh5SUlsL2VVTUNGM3R1Q1gxSUZm?=
 =?utf-8?B?ME94MkVUejVMWG5DMCtEQmFDUmFUYW1JSkNaOG1SQmlqZjc4UmVqWkhyNjIz?=
 =?utf-8?B?Vzh2S2QwVGluWVRxQkJmTWdFUk9oRlgxaEJIcTVKMTZrcmlHYnJWVU51N0xF?=
 =?utf-8?B?ZUN5VUh3NWp4eGRvU2ZDa0JxcXFxMmlEakRGMEIyRGtIbytTQjZHME9wME8x?=
 =?utf-8?B?MFdOMGk3SHBtUjQreEtWc0hvQWh5dXJnM2dUajlNS0ZjVjRvb0xMaEgzVmZM?=
 =?utf-8?B?Uk1NR2pBdlhxMWZIcktZQ3doWW9tMVhMZXozSmw4TEFudHVPWXU5WVlZaTY3?=
 =?utf-8?B?bm0yNURiY1F2d2JvQ1B0YjlBZjVpdVdqZGhsa0c0dmQ1VW5MMzdlbGVqVzJV?=
 =?utf-8?B?Q2p2a0s1WGlQTm5DV3NoUzczRlNLUUYrZ0dPSU9QUThwVHFoaXV1ejNPZzVx?=
 =?utf-8?B?OWxWRzI3K1BYdDloT0hFblg4M3VldXg4RGw3Qm80MUhlbVk5RE92YUxIL2lp?=
 =?utf-8?B?UnRPekxXUEEwL2JYaHBmcis4a0hEd0JvMjc1OFcwOUcyUUFIWnRGYTZQWXpo?=
 =?utf-8?B?ZitzNnBncDAwcWlLOWJsK1RBcDkrZGM3QXdUaDNyQllvS2NYbVpucWpzU0NK?=
 =?utf-8?B?eHMrS1NkZTRkS1ZWQ2JxdkNJNFV1eGV1SllOcy9UakZmbXdjdCsrSms2SHMz?=
 =?utf-8?B?R2hocVpmNDg2cFdDVEdVVTVOZjJibkNuYWtEc0E1TnhESFZSNUVPd0NDeGlI?=
 =?utf-8?B?RXh3YXlEYzcwSGY3ZktqZ29TKzlWdnVrOGVHOFJDeG5rQnozZVh0M0t2cXYr?=
 =?utf-8?B?UzhxQjg4MUxVZmRKV0ZSSzhSa2xzUEtsMTB1RWRETjYwdkp2d1pvOXZHMTBq?=
 =?utf-8?B?WVV6aWdxM2dKckx3WnNPVlZ2anlPRmNKOUJuOEg1WGs4b1VDQjhMeUNkSDEv?=
 =?utf-8?B?a1hEdDNwR0tKRVFHV2p5K3ozSFhlVWVZdVppajUvaUlyRUJ6akFPZGlPakoy?=
 =?utf-8?B?YThCaTUzTGZtemVJeTlaUDlxNytSd1pwMUFuR0EwcnlnQm1GTFpiZFJQa2Z1?=
 =?utf-8?B?NkRnV1dtQkZJL0ZHY3VyUXB1N2RzLy94UFRaU0FJZUtHSEExSVgrb0FmeGpv?=
 =?utf-8?B?UFJvTFM1OUhHd1kyZUtaZ1pzci95bCtKQk16NktZbSs1VW01RS82WTE1RWVQ?=
 =?utf-8?B?NnlPakxESENpZVB6anVJWCt4NmhrN09GUzlTaUNyNTQ5OXNQOFFyT1RLTW1M?=
 =?utf-8?B?UU50SFdaTkJrdEg1Tkt1Qko0VXlJMStsU1o5ZHpKUXJ1V25qMFF1N0V5WmQy?=
 =?utf-8?Q?Fs7r4uhM8+/q2yLErAcIPEvXX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281ab091-d385-40a0-b868-08ddfca75723
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:49:41.0301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiWqmRqZAviWJ4v3vH8HOXsaZBNyBzsQNmrcV5pnrBxXgH2DgBIOGBwtn5yeFB3tmRrhUOX3XN6NXMVy3X7rzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
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

--------------PfYIYcHXl0ohc00ubybZvCjq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/2025 5:50 AM, Kuehling, Felix wrote:

> On 2025-09-23 03:26, Zhu Lingshan wrote:
>> The user space program pass down a pid to kfd
>> through set_debug_trap ioctl, which can help
>> find the corresponding user space program and
>> its mm struct.
>>
>> However, these information is insufficient to
>> locate a specific kfd process among the
>> multiple kfd_process that belong to the
>> same user space program.
>>
>> For correctness and backward compatibilities,
>> this commit only allow set_debut_trap ioctl
>> work for a user space program which does not
>> own any secondary kfd_process.
>
> What happens if a secondary context is created after the debugger
> attaches to a process?
>
> It may be simpler and more consistent to allow debugging of the
> primary context, even if secondary contexts exist. Just ignore any
> secondary contexts for the purpose of the debug API. 

Do you mean reject any set_debug_trap ioctls on secondary contexts, and only allow debugging on the primary context, just like how we handle SVM and user ptr?

Thanks
Lingshan

>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 29 ++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 662b181f1fd2..2df095e25c2e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/ptrace.h>
>>   #include <linux/dma-buf.h>
>>   #include <linux/processor.h>
>> +#include <linux/fdtable.h>
>>   #include "kfd_priv.h"
>>   #include "kfd_device_queue_manager.h"
>>   #include "kfd_svm.h"
>> @@ -2918,6 +2919,25 @@ static int kfd_ioctl_runtime_enable(struct
>> file *filep, struct kfd_process *p, v
>>       return r;
>>   }
>>   +static int kfd_process_count_cb(const void *num, struct file
>> *filep, unsigned int n)
>> +{
>> +    u16 *ret = (u16 *)num;
>> +
>> +    if (filep->f_op == &kfd_fops)
>> +        (*ret)++;
>> +
>> +    return 0;
>> +}
>> +
>> +static u16 kfd_process_count(struct task_struct *thread)
>> +{
>> +    u16 count = 0;
>> +
>> +    iterate_fd(thread->files, 0, kfd_process_count_cb, (const void
>> *)&count);
>> +
>> +    return count;
>> +}
>> +
>>   static int kfd_ioctl_set_debug_trap(struct file *filep, struct
>> kfd_process *p, void *data)
>>   {
>>       struct kfd_ioctl_dbg_trap_args *args = data;
>> @@ -2927,6 +2947,7 @@ static int kfd_ioctl_set_debug_trap(struct file
>> *filep, struct kfd_process *p, v
>>       struct kfd_process *target = NULL;
>>       struct kfd_process_device *pdd = NULL;
>>       int r = 0;
>> +    u16 process_count = 0;
>>         if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>>           pr_err("Debugging does not support sched_policy %i",
>> sched_policy);
>> @@ -2984,6 +3005,14 @@ static int kfd_ioctl_set_debug_trap(struct
>> file *filep, struct kfd_process *p, v
>>       if (r)
>>           goto out;
>>   +    process_count = kfd_process_count(thread);
>> +    /* The user space program has secondary contexts */
>> +    if (process_count > 1) {
>> +        pr_err("Detect multiple kfd_process owned by PID %i, please
>> consider close any secondary kfd_process and try again\n", args->pid);
>> +        r = -EINVAL;
>> +        goto out;
>> +    }
>> +
>>       mutex_lock(&target->mutex);
>>         if (args->op != KFD_IOC_DBG_TRAP_ENABLE &&
>> !target->debug_trap_enabled) {
--------------PfYIYcHXl0ohc00ubybZvCjq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/25/2025 5:50 AM, Kuehling, Felix wrote:</pre>
    <blockquote type="cite" cite="mid:08ecb504-abb8-4ad8-bbbb-a18e19daffbe@amd.com">On
      2025-09-23 03:26, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">The user space program pass down a pid to
        kfd
        <br>
        through set_debug_trap ioctl, which can help
        <br>
        find the corresponding user space program and
        <br>
        its mm struct.
        <br>
        <br>
        However, these information is insufficient to
        <br>
        locate a specific kfd process among the
        <br>
        multiple kfd_process that belong to the
        <br>
        same user space program.
        <br>
        <br>
        For correctness and backward compatibilities,
        <br>
        this commit only allow set_debut_trap ioctl
        <br>
        work for a user space program which does not
        <br>
        own any secondary kfd_process.
        <br>
      </blockquote>
      <br>
      What happens if a secondary context is created after the debugger
      attaches to a process?
      <br>
      <br>
      It may be simpler and more consistent to allow debugging of the
      primary context, even if secondary contexts exist. Just ignore any
      secondary contexts for the purpose of the debug API.&nbsp;<br>
    </blockquote>
    <pre>Do you mean reject any set_debug_trap ioctls on secondary contexts, and only allow debugging on the primary context, just like how we handle SVM and user ptr?

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:08ecb504-abb8-4ad8-bbbb-a18e19daffbe@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 29
        ++++++++++++++++++++++++
        <br>
        &nbsp; 1 file changed, 29 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        index 662b181f1fd2..2df095e25c2e 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        @@ -36,6 +36,7 @@
        <br>
        &nbsp; #include &lt;linux/ptrace.h&gt;
        <br>
        &nbsp; #include &lt;linux/dma-buf.h&gt;
        <br>
        &nbsp; #include &lt;linux/processor.h&gt;
        <br>
        +#include &lt;linux/fdtable.h&gt;
        <br>
        &nbsp; #include &quot;kfd_priv.h&quot;
        <br>
        &nbsp; #include &quot;kfd_device_queue_manager.h&quot;
        <br>
        &nbsp; #include &quot;kfd_svm.h&quot;
        <br>
        @@ -2918,6 +2919,25 @@ static int
        kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process
        *p, v
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        &nbsp; +static int kfd_process_count_cb(const void *num, struct file
        *filep, unsigned int n)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; u16 *ret = (u16 *)num;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (filep-&gt;f_op == &amp;kfd_fops)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*ret)++;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +static u16 kfd_process_count(struct task_struct *thread)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; u16 count = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; iterate_fd(thread-&gt;files, 0, kfd_process_count_cb,
        (const void *)&amp;count);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return count;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; static int kfd_ioctl_set_debug_trap(struct file *filep, struct
        kfd_process *p, void *data)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_dbg_trap_args *args = data;
        <br>
        @@ -2927,6 +2947,7 @@ static int kfd_ioctl_set_debug_trap(struct
        file *filep, struct kfd_process *p, v
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *target = NULL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = NULL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; u16 process_count = 0;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Debugging does not support sched_policy %i&quot;,
        sched_policy);
        <br>
        @@ -2984,6 +3005,14 @@ static int
        kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process
        *p, v
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; process_count = kfd_process_count(thread);
        <br>
        +&nbsp;&nbsp;&nbsp; /* The user space program has secondary contexts */
        <br>
        +&nbsp;&nbsp;&nbsp; if (process_count &gt; 1) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Detect multiple kfd_process owned by PID %i,
        please consider close any secondary kfd_process and try
        again\n&quot;, args-&gt;pid);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;target-&gt;mutex);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;op != KFD_IOC_DBG_TRAP_ENABLE &amp;&amp;
        !target-&gt;debug_trap_enabled) {
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------PfYIYcHXl0ohc00ubybZvCjq--
