Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6791EC369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 12:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4DF10E38D;
	Mon, 21 Apr 2025 12:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJTIqkRF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE6A10E282
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 12:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOTvSIq+JTl5M+YyBVH5LcafN51BWC3ySubdSxp5KoseG4avjL99eIhTJKlPOR8WbA6jb02JcgoBlELQ04Z//6+z2aaJ936FzhcQ84YU14/1xY1VPB4lkYtmgnz8JAM8faQoupj3ooBxsqFqU8XbIWkuZNGY25+d0mIZ/MOz0M7gJEnu5/+5gKWldIqKVoHcO/REYb487EdKSAottGo+/eA7Sa5Ij4ZfGKPQu3NazuomuDAAbgRR7TqJpcir3xCX7dNJJ0DmAMLtxl5ny/3NNaV8w2aTeUn2f7ujU/htorN0+lpJKJ9HoH0MwqxyDM4VRj+l52Mt24WS1VvU9dzf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNho9CDEuZ0VSnQ7hVzOd9nl7cwfe9gFiRN24gNXy0Q=;
 b=i4JOHB9jme/WjzBQG0GALZt039XYF2M0POzva94O7r1n/4c0Y1MQ9gRX8tGps1O/nIkxtjxRqGWkP/LqleU6rgS7J2JYfrzkuJKG1uGs/lOm7AnRYGomjfJpbphcLaA+NrpohQjHvcXt1jXegChEe1at0Q2voPk75tFKG7J2NHEqEIC/emljXVzShbqSRtRn3Shqb/Qnbxn3/A46id728DdsOdr3uNraA+aP6s6dGJJx8gHjMJNY5f0fN9rp7nyhCYxOFYc9o+zjVid+++tY4zkCrw5vHMBnCs/xBv2MkzdhVHGIQZ6/Fb7DvgXRI1uULDoMirhuJr0RsLDGvgqNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNho9CDEuZ0VSnQ7hVzOd9nl7cwfe9gFiRN24gNXy0Q=;
 b=FJTIqkRFGxLHEOQgYzGxksC9CNDrTUVY5WvkMnq0rCZx6TVWTN/MOiXKA3Dnxc3rOqqBXR11YErH/1uutFQbguM/rpfFeiyTlLVCX15zYNS8sY3ZkC4qx64WTKDPCIeYYhaiZzYRj++Uafv6h2BeR542dyVKnLXw/J+ULLkvCPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 12:38:19 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.025; Mon, 21 Apr 2025
 12:38:19 +0000
Subject: Re: [PATCH v1] drm/amdgpu: update fence ptr with context:seqno
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20250421122100.725187-1-sunil.khatri@amd.com>
 <BL1PR12MB57533E07F96B44E74806210193B82@BL1PR12MB5753.namprd12.prod.outlook.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <7f6addc8-0410-3442-3d90-2f3fe409a76e@amd.com>
Date: Mon, 21 Apr 2025 18:08:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <BL1PR12MB57533E07F96B44E74806210193B82@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------8CF2D2ABDC8661D0114B2919"
Content-Language: en-US
X-ClientProxiedBy: PN4PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::13) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b55df00-5100-4b2c-4a5a-08dd80d16535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW1VRVp3M1k1ZEc2UUhQODAvY21FMWJ5OUUvTTNHbWhMREkwNnhKRFhia0tU?=
 =?utf-8?B?d2NuUSt2V291dG9jcjE1UzcxL2RTc00yNU9uT3R1Z3JaSmZyMGN0NHNXLzlW?=
 =?utf-8?B?U3V6VWRNYXBkZGRYb2JCVW9xeW5CWk9hUTN3cktHT044WWQyeU1RbTl6Rk9T?=
 =?utf-8?B?VlM1SXNqLzhBbm91bC9Ia2I4OTJ2c0Jpbkg3aXMyeWYzU1RxYnV5RjljVCtV?=
 =?utf-8?B?WjdhY0dNUUhyN3hSeElNdm5XdDcrRWkwOW1sSmo1ZHJ2S2xoWjFFUTlxODZC?=
 =?utf-8?B?RlNrREZ2MHc2UHJNb2o3S3BZZHJXbU94cDNiVmdsN053UUxsQlFqcnU3RS9a?=
 =?utf-8?B?Ri9zT1NLelZncW12NWNRbFNYOXNZamZMdE9ZRDVjN3BGUXh6MlVNUHhEdDRC?=
 =?utf-8?B?QkFqY2c1RlBtbEpBWVU3bDVDZGNDY2krbkl4dEozRVEvbUp6VHRXcGdOdDFD?=
 =?utf-8?B?QzJZYU1jekhNWUM4TStyTHIweUNCRjRqNHVCb2h5cjBMWks4RGdBTE1pNHll?=
 =?utf-8?B?a2tHVTN2UmVONng3UkJVOXhNb3loRGJQaHdOYllLeEF3eGg4RlpRTitPeGRy?=
 =?utf-8?B?QW03MWJLdkFuMFNtK1Vpak13bHljR2FXUSs3WEhFdkhYOHRqengvMVhZK0FO?=
 =?utf-8?B?dlkzRzlGQ0g5RjdUWVdSeSsrL3N1VHF4aHdsam54UjcrRWxZZFlQNkd4T2dz?=
 =?utf-8?B?SFN1ZmtaRkF2WEpwbUVBRUF6OW5ROFNhK2V4bUk5UUF4NHJtNHprS3ZHekZ6?=
 =?utf-8?B?cExoelpTaEtNQVIzY0ljQjRvL2FkR2pjWndoeFVQUjU5aGNLcmVWRkNLVGIr?=
 =?utf-8?B?M1MyN0RVeXgrUElVeGZ1Qlora1JNa1k4NzRnYjgyTERSSEJqUk1qZlFDZVRJ?=
 =?utf-8?B?ZC85TTZySS9uNjNnRm8vSm94djNPYW1KZGlOZmxsMEorRTNOcExmcFdDMHQ1?=
 =?utf-8?B?cGZLRk1uZzZITURTUVI0bVNPUW8xaGkrenhuWjdqdlcwOG5YckErejgrcm41?=
 =?utf-8?B?cVBKejZuSCtvQ3FuN0xJWWsxeTd0dXdnYmdlbFVHY3FkNk9rV282SDNxQUJN?=
 =?utf-8?B?a2k1Tk1kYk1GbnVHZlEvcW5tZ3pBL1JtVExIbnpiUFJkVE8xM0pubzBGR3lp?=
 =?utf-8?B?dEpSTktEa2NoVEx3U2Q3Y0JvZlVCUStiVzVwUFY2OVhmekFCQjFOV2VubTVn?=
 =?utf-8?B?ZkxFRmVVM01kbWdHN0NiMlJwY1U4c1VpbUMySTFoWlYza01KSERXUDBSbkhZ?=
 =?utf-8?B?N0pTeStQSkxVZzNyKzh2NE9pa2MxbzZXMGF2OVdTQTZNTFpnNnFhQytJNlhE?=
 =?utf-8?B?ekk0MHBFVmtZbW80R0l6ejMyMUp2SUpaeG5pbzh6aUQ4VlVPTDRHZXEvdUFZ?=
 =?utf-8?B?UWQ0M2QyejRteWdsVkpFbXFqa05HQ2lvaXNCU3FCWHR6aXlRNWtYeCt1Z3Fh?=
 =?utf-8?B?OWpnVmsvbG5LelFVNVZpWVZuRkJIaHB0b2xYQnY4dnk5UEQxdTRDekVjYjE0?=
 =?utf-8?B?VC95L2VrQkh6VDE1akpxL09GUDBxTG9vVVYrY0d3NWRFUEJwNHJMOHhjZmtp?=
 =?utf-8?B?aFNnamwzZmRUc1RtOFRXZndodDMrcC80RDNOSkZDWEhOS2NLUCtjOW80cjBY?=
 =?utf-8?B?ZStUbTRGNTF6YXhEc0ZJczhHNTNlZDNtL3N0bkdIbFRLTFVMRjR1YjJEdURG?=
 =?utf-8?B?VlNMT083aDdXS0pqZjU0SEZyWXdjMVgzQTloME1ScXB0bVRxQ05waFdrY0Iw?=
 =?utf-8?B?aEZTK3dqYk5VN1RaK3hLa1Z1bnlBaWVUTkdrSkxFelBZWHhBV3hiR0NJVU1N?=
 =?utf-8?B?Y0pKVTVYVjZSdXZjSGlQVjVoMEdNQWNLd1FOYVkwZ0Y1Nzc2NGVjaFM3ZkFk?=
 =?utf-8?B?MjJydnozeHh3bkFpTzFwbjNXT3Rqc3VCNFpER1BFYlhBMld1bnhmYWxUaUhP?=
 =?utf-8?Q?pWfL9WTyKew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFdHak9uNmt5YXZiVFEyUklYMElOT0RXZ2NZK3k1L3VibnN1L1lFNzd3eGdP?=
 =?utf-8?B?NUtRN0lJVFlVZFdzNnZkVDdlM01jaVNKRDlWSzVSYytiN1g3b29uekpsZnBR?=
 =?utf-8?B?eWhTQ0VSeWxmRDhaZ2pLbFhaYUhJTjlpZHpHSjFUOEZ4RDhrN3BYNWVpSC9Y?=
 =?utf-8?B?cTIxWGorQVdyUXJ2WTF2ek5BZ1Q3Q1Y3cjFJSlNpeXp6akR4MXVydG56T3FF?=
 =?utf-8?B?Ulg1L1NsZWhmNW01UUtONG52MVp6WS9FVW1Fbnc1Ujk5WVQxdEdFM1JHazc4?=
 =?utf-8?B?ZGRnTVZsK3BGMkx6NHZtaDJJaUppUGoxcnJFd3lJbVJTbGJQR2xUSHVibkVz?=
 =?utf-8?B?cXZmN2Y5U3ZMMDJoNUZDMWp5cXgwOTVLeGszQk1LNlhvMW5PWkduZ3dzTmdE?=
 =?utf-8?B?aUJGZlNDclZCRTdOdExTSlM5N3ROSmtFbjJNODdkY1B0NHRObVVaRXJwS1BS?=
 =?utf-8?B?RlBuakIwYWF0K0IzVWRDVVJncHZxVUpvd0lyRkpHTkhiSkRGRzBCNlBOT1Q3?=
 =?utf-8?B?YlVmcDRURlYrdCtvQnBXbWhpSE5TQmgxc2doY3kzSnlrWWh2U3VLOGVSL1Za?=
 =?utf-8?B?bzBSb3BtNWFBZWhtOVljZGpJMUxYTTMyRzNId1U1TjRZM3lDdzdmNmYwNWlI?=
 =?utf-8?B?SURyWUZJbmVmMTRWYmoyNlVqWmVCSHlvY1RMS2hsNEVCYlorbFQzZzYwa0I0?=
 =?utf-8?B?cXZ0aWYrcy9hZnZ6K1YzNkdpNFFVNTd2S0JRaXE0RDlmcmpoSGdzY01FU3hO?=
 =?utf-8?B?bXFVbTFoRmtCS0FZU1BzN0NaSlV2a3pxc1JpN2RQeXdyY3Y2SldLZm03d1Nj?=
 =?utf-8?B?amxwaE1RN2FYV0U3OVpIM0kyWG9ScFVOZjU0L2R6RlNlWllET1JmSzdYWEpM?=
 =?utf-8?B?eDlpMGJtUmNVVkJUbXN3a3R1TkZDVkV1bDVmckV5UGVteEhnVkhMUlViRnVl?=
 =?utf-8?B?YXY4SHVsUmlNd1lzd2U2UHJqd1VHTnU3ZlQrbEJQN3JqcVFTZ0xBaCthUHVE?=
 =?utf-8?B?aXVYaXNpajJMalF2WkNWQlpaN3k2TFliRStvZ2dNMW5xbUVuaHJTQ204SDgy?=
 =?utf-8?B?VjQ2S1ZLVWRmMlpGY05LMS84c2FsUWM5S3ptcVNxMEVkR09ERGwzK2NST2pG?=
 =?utf-8?B?N0NNSlhQQ2NOR1Y0ZHRWOVJBeGhjVHZqY0ptRlpKSzZzVTRCWXFpMjAxTTBp?=
 =?utf-8?B?VWRvbTlHNW1JeWpZTFU4SmowR0J3d0kycDk0RzRvdnM1VWdtK0o3aENvZGUy?=
 =?utf-8?B?aFQ0VGh4Yms4MzNhMnJBeUZSRkM0eEtFRXdBa05hNFhYOU5xU2ZkZVRLSFp1?=
 =?utf-8?B?WVpSa2djcU1zeEVJM0ovbUl4TTJpdzVsZy85bU1JRU13dUVYK0JLSkwralJT?=
 =?utf-8?B?SGxmNktOV0VZR1dDcFY4bTZTdmRlZ2JBQVl6UFVia3h1TEZneDFtSmhJSnJO?=
 =?utf-8?B?c3Z2RDZOWTMxVUhNMkZqWFBWaE5qQVJxR0FNWnBXeXY1QytZNFlXTkp6K2lo?=
 =?utf-8?B?OXUySkVtNUg5ZlIwN2tiR1BabFM5QTF0S2VRclJUV1RKY2tGeGR5cE9wQVBV?=
 =?utf-8?B?OHpOSUplWFFwdXRScVlhWHFaQnZEQ3NWSWhtR1owbmg3anY5YjBmb01FN054?=
 =?utf-8?B?MDk3WVE5em1jajBJaTRpdWZHM25xSjk1eTdTeXJKZ2lCSHhYcWh0L3JDK1Uz?=
 =?utf-8?B?RmFOWmZKZFdOWHZOOHFlV25hTG5LTkI4cFpFZ3E0czlrbWdPRm1RN21NUHZr?=
 =?utf-8?B?cGZPS1NxZzVMVTlncUhPdVZiUFhVc2RWdW8xMGI3TUx0a1dwQzJvSEpZY1Rj?=
 =?utf-8?B?MHdiOU1VY2tOSHFQZE5SMVpjSmFUVEx4czRuOVZMMnBVWG0rWlRGODVJZ3Jm?=
 =?utf-8?B?MHhmczlTMmxFMCtldFhITklhbzAyTjM4YmVSOEZSQk1kLy9hZ3FGLzhNUkNk?=
 =?utf-8?B?dFZCa09OaGtWdjAyd2VlZitNQTljNGRxb3p0K2dueXVqUmEreWxvanQxeS9Z?=
 =?utf-8?B?WkZoczNyeUdnZ0FaRWpPRDlMdmR4WExpcklyRG9OdjFxNmZsNW1XQkF1WDk5?=
 =?utf-8?B?cFBYaEJ3cnNPZ0NXZnBDbDhGbnhDWWdzdkFHQTBMSVVPVTJVMHN5T01PQlVK?=
 =?utf-8?Q?ZmWdOSNoWbxM451XcByBK+VbT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b55df00-5100-4b2c-4a5a-08dd80d16535
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 12:38:19.4099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FftM1uzCSeGlsiX7blTkC1fMR7ktg6rEY0bQhmqanIzfncpE4eP4MhqQMDLSNLNt9jL/uQjw6q/stujr+M0LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945
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

--------------8CF2D2ABDC8661D0114B2919
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by:Arvind Yadav <Arvind.Yadav@amd.com>

On 4/21/2025 6:01 PM, Khatri, Sunil wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Sunil Khatri <sunil.khatri@amd.com>
> Sent: Monday, April 21, 2025 5:51 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>; Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Subject: [PATCH v1] drm/amdgpu: update fence ptr with context:seqno
>
> log context:seqno of the fence during timeout rather than logging fence pointer.
>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 4be72bebcf34..b0e8098a3988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -94,7 +94,8 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>          if (f && !dma_fence_is_signaled(f)) {
>                  ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>                  if (ret <= 0)
> -                       dev_err(adev->dev, "Timed out waiting for fence f=%p\n", f);
> +                       dev_err(adev->dev, "Timed out waiting for fence=%llu:%llu\n",
> +                               f->context, f->seqno);
>          }
>   }
>
> --
> 2.34.1
>

--------------8CF2D2ABDC8661D0114B2919
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><span style="color: rgb(33, 33, 33); font-family: &quot;Roboto Mono&quot;, &quot;SF Mono&quot;, &quot;Lucida Console&quot;, Monaco, monospace; font-size: 13.006px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Reviewed-by:Arvind Yadav <a class="moz-txt-link-rfc2396E" href="mailto:Arvind.Yadav@amd.com">&lt;Arvind.Yadav@amd.com&gt;</a></span></p>
    <div class="moz-cite-prefix">On 4/21/2025 6:01 PM, Khatri, Sunil
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB57533E07F96B44E74806210193B82@BL1PR12MB5753.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
Sent: Monday, April 21, 2025 5:51 PM
To: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Khatri, Sunil <a class="moz-txt-link-rfc2396E" href="mailto:Sunil.Khatri@amd.com">&lt;Sunil.Khatri@amd.com&gt;</a>; Tvrtko Ursulin <a class="moz-txt-link-rfc2396E" href="mailto:tvrtko.ursulin@igalia.com">&lt;tvrtko.ursulin@igalia.com&gt;</a>
Subject: [PATCH v1] drm/amdgpu: update fence ptr with context:seqno

log context:seqno of the fence during timeout rather than logging fence pointer.

Cc: Tvrtko Ursulin <a class="moz-txt-link-rfc2396E" href="mailto:tvrtko.ursulin@igalia.com">&lt;tvrtko.ursulin@igalia.com&gt;</a>
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4be72bebcf34..b0e8098a3988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -94,7 +94,8 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
        if (f &amp;&amp; !dma_fence_is_signaled(f)) {
                ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
                if (ret &lt;= 0)
-                       dev_err(adev-&gt;dev, &quot;Timed out waiting for fence f=%p\n&quot;, f);
+                       dev_err(adev-&gt;dev, &quot;Timed out waiting for fence=%llu:%llu\n&quot;,
+                               f-&gt;context, f-&gt;seqno);
        }
 }

--
2.34.1

</pre>
    </blockquote>
  </body>
</html>

--------------8CF2D2ABDC8661D0114B2919--
