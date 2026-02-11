Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FB1ECD6C1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 16:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB5310E635;
	Wed, 11 Feb 2026 16:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VPM9Q6iU";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89BD10E632
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 16:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWqbbWdEdplMXMLmc4Yg1HQBlCw/+VKz5HSbt9jjexlI13pdGjBqmQ/PBsgRL8hxy6hCLKlyEZtO+K2PmLyVD4USoSBoc2KJNyaV+TKHRykl+95VeBxkXF8yCXfNiTqamhuIpji3X7W1gBS4eK0nZLT2bLHl0TA9m/7uh0AVn3N3v//G0I/dyjS88rY4KyNoB6IX/Nh8qa9NyQIPnxIdravqFEfy87HrZevG50aOt9ujDUQi5ESdodt+EOIozngIza93F40BpaUoO+wynu9E9FuJvB2NzHYfyeXgLYkFR092vIfai0bZCc6X6xxJ4nvdZ+XorZARS/bPmKcgiZ1AYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ZJCpIihbi5yp+ungJLgK/KonivLrWwTu1CvpFnN28=;
 b=tYeVJvezUmLmN8bVaXKNdEdbdlF5TyfgsS7pbQu/jeQRItQHQVpydJL/BrdAwYNhCc3+wSXqTjDUCqtRX8lVC4L88Iww1BbDcsVJQV/yn2oRegRCRQzm6Vi3ZHS/Cd6r45naYUF+cpYnS86z8LUFGYf0Tur7Vo7Kgi6Pukhbs/xX1oxs/ge5bH/fXDsWflIXXNEmIwtMcG4QLResJZGc6FSKU0A3RvmaQbJqFxR2uHXapxyUs74jBW4NQXvoHEHOPYwqJP2PwjJhivP9mWWoYme0hCsKofTe+Yy7iEL2l99ZheQHFot9o1eWbp/ngMM5Bv9qCB3JDmNRyRa/yyjJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ZJCpIihbi5yp+ungJLgK/KonivLrWwTu1CvpFnN28=;
 b=VPM9Q6iUvEZFxZnTlwhscUVUSbXvJm91xBlDRjZKdujaX+kFjaruevNe+Dm3bjzTMRbb+NiYlrY1qQwrkVbMqKmhB8ixTyy5ZpXuzqXlIU3kUQ+X1GFScfc9Hh9/3Y4W9Dv9btPhJW+zq/LyRZeSiSlc92AuGU5VO95nO2y046o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 16:45:26 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 16:45:25 +0000
Message-ID: <1e830669-0647-4508-bcab-a407eb46aeda@amd.com>
Date: Wed, 11 Feb 2026 11:45:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] amdgpu: Add amdgpu profiler IOCTL functions
To: Alex Deucher <alexdeucher@gmail.com>, James Zhu <James.Zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 david.belanger@amd.com, chris.freehill@amd.com,
 harish.kasiviswanathan@amd.com
References: <20260122151110.3072843-1-James.Zhu@amd.com>
 <CADnq5_P1DcMS7qPfUOSAvdZKBtSoojk-n_H6QO7NenZzht6=gA@mail.gmail.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <CADnq5_P1DcMS7qPfUOSAvdZKBtSoojk-n_H6QO7NenZzht6=gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::15) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e7dc9b-bccd-4c74-fbb5-08de698cf46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnhpL1lkbW9sSFk4R1hJbXRWZDlEbjRob05Bd3gvdTM5bXVpTUFWcHNidEJK?=
 =?utf-8?B?SVhwSnJUQW5BNEdoaFRlQTgwdHJOQ1FhS25VbDdRU3UvbEVkL3JRaG1SMEE1?=
 =?utf-8?B?T1pmOVBrUGY1bDB5OXlsK1hZVWJraHE4bnNUb0E4Y3hDN3AzcVhxWWVFMnQ5?=
 =?utf-8?B?K0RsSVNWaDROMmVCd25JZEFLZnhKOXRIZkhPbmZkT0tXUHh3RVJWSEtrWFpZ?=
 =?utf-8?B?aDlZOXNjMmR3YlpZQXk4QkJVSGROVTVjRVBCdW9LcWlST0hhQ0JWT3hQWjc5?=
 =?utf-8?B?RW9jMUh0ZmMydHFRZ3NNbmg3MkpaZ3RWTUZ1Q3dxTEp2Q2JGQjR3dlhtQjBt?=
 =?utf-8?B?UEJmSkw3ZDlBdSsvN3lpb2dWUk5IRDE1OTFMRHczYzVIbGpZUjZHd0NSTW5P?=
 =?utf-8?B?R0ExbkZzL09SZkd1UGZkSmVTT0kxOVJCek0zdUtONlhaMnJPZG9pWllTU2tR?=
 =?utf-8?B?ZWRaMC9jRk1QcnAva0w3SGN1UHZGTUhGT1gwb2FHTXNPUkhpSkNUV09BYzF1?=
 =?utf-8?B?QWxhaDBUY3dETXlUbi9HYlZqeGlocVh4T2tQcmk4TnJEQ1duWERwYXdCTVlh?=
 =?utf-8?B?c212UnBvSDJCSVY1MzVWb2lBeXBJaDY2TWVnK2MyN25YdUk4alhhdGJpa29n?=
 =?utf-8?B?RFd1YlJjbDdoZHhCY1VGazN4NEd1U2FiTGtxbzlkWXJ4RDkwbGpZNzI5ejJL?=
 =?utf-8?B?ZWdpYklRTk1Nd3lhVlFKUWV5UktkaWxWQU9NNllhR2dDc05jUmhMeGtuNm9F?=
 =?utf-8?B?R2RIaDVtQmgxWnhRUlNLc3ZQL0gzOGoxT3VHZVBmNzBMdUZRb3o2MmhGMi9N?=
 =?utf-8?B?L2Qwa3JWQ0dwbUNSWE9veUVZSXl5aVpVVVNHbUxtMC84Smg5QWE2WTdrS1NH?=
 =?utf-8?B?Sm96NGRWWXdkOThUS1RlKy9rTFBUaUxDSVFFUXRkM0ZrNlYxbkgyTTlQSEtX?=
 =?utf-8?B?OGdDaVhOT2l4Qm9DTll6NGdFWmZCVnhHOEFUZFltN1o3cE5ia0w5dnhJZHJI?=
 =?utf-8?B?cWFoNlk4TEtBSVR2ZERkYVY5ZzhvNVFzbVlkVmpvZ1RxUjN1YXZESHJQSEV0?=
 =?utf-8?B?YVVxMGFiZytPZHhQZThLazEzSFhlWXA5UGVvTk1EVVRoT09TejhRcWUyOUcv?=
 =?utf-8?B?czdtVXc0NkZhbVVxSE9RTkZKU1BWeDVlMlhIN2FrOVR4TERQUW9CRXd3Z1Na?=
 =?utf-8?B?TndQQ3l4cmwyeXBiTktvaUtmVmVRektLbTg2MFFpWUV2NGVlc3l2VkhOaERK?=
 =?utf-8?B?WEd1MEwvOGNESjZKVGRTei9VZkwvNDJBRW5OVlJiSkpwbUlLczJiRmtYYW8z?=
 =?utf-8?B?anEvU3RxY3ZkdEYzSzJQZDF2SjBOL1N2cUhUQVFGWFRiakUvVll6SStPMi9o?=
 =?utf-8?B?TytLS21oNDdXcUJsbTVJN0U3eTNDSVdiQkhvOFJtRmRCVmVVRDkzZ3VKZFdM?=
 =?utf-8?B?TlQ3bFJYcDBkV2pkYWlnU0pPM01VQU9WR3FzK1g4YS9SN1gzOEhMQm1WVWh5?=
 =?utf-8?B?ZUNSa1ZHT1MzZzFiekI2VWJ5QmtzUnl1NHRxM3Q0RmdKcFIrT3dMc0lIdTZU?=
 =?utf-8?B?RzJvZXBvdDU5NW0vblpvcTQyc1gwemF4ejd0Q1FJWG5vNkVISlBGZEY5NU5v?=
 =?utf-8?B?TmxJQkhZNHpyYWZKSkdWMDduWlFmMXFFTDg1YVR5VHQ5S0NPd2RIK1g3cEo0?=
 =?utf-8?B?WWFCdnp5QUpYWEM3UGh3WWJnSHVPUGpXeWVHcE5Wc3gxajZQTmtUbHl0K0x4?=
 =?utf-8?B?UElMVnZrWVA3ZnpZVU5jSGkyUHA4YmJvckNwVElvcTdCSnhnQ1V3MWhVUW5k?=
 =?utf-8?B?NGkwTFFpd0kyeDRESTdoKzJBUUIxNzhpV3o2STI3VzE5c3VpWjNnTGhFaEpX?=
 =?utf-8?B?czZNOStUZkZERDg4UnpYamNjb1ZzSDdtN3lwUlVtTi82ZTlIZldJOCtBcU5E?=
 =?utf-8?B?cHdMRWVIQjFpbmtYbHJPdzBPZUx2YU9pczFlZENWeTYzVi9pVDN2UDJrNE5W?=
 =?utf-8?B?eWxwUFplZ0RFOHd3bU53VGxUbDJJWWlUWTFnLzduV09ycVdxYkpiUjNZSExw?=
 =?utf-8?B?M1NFbHVoYmFNd3prcGhEdFRFMmNiU0F0V0JEb25XZk44eVVMTFd4dG5OWmgw?=
 =?utf-8?Q?X/RY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enQ0bFJhYUNZL0hzcmZ6UGwxSjFhSDNXSG5PNlV5bU9MOTRoNndFRzl4cTY1?=
 =?utf-8?B?bmVaMWFPblFRdHBPWFVlYnFrUGVoMnF4TE5IUU44NWxPOHlyVWJFMHU3TmNh?=
 =?utf-8?B?SytXU1JqcXBSbWhWbjliNWIreVI4NUlIZWsxaHhHU1pnNk1aajNZRmpXSlEy?=
 =?utf-8?B?TVd0bUJRQ29rSWZWRktkOHBaaUdDVzN5TExFdVRITFl6cDRGR3Z4cDdLVExs?=
 =?utf-8?B?VVJUMXpWTEVlRzZ6SytQdllwdExhNG1DOG9zdmMrOGhIOHQ0Y2VEbTVBOVNy?=
 =?utf-8?B?KzFhcGRBK2FkanFIdEhNbEpkSEpTNUxubmgzSlFoN2JscFduRFduSWpSRTlv?=
 =?utf-8?B?bjJSdjZsSkwvY3FTV2FnQVIyS0RwSkRUcFgrWDd6MzRpc2RaNE9Pb0oyNlIv?=
 =?utf-8?B?U2s1VTFMajhTTmwra0cxSnJoVi9oNjlXdVRvTlBaMEYyM2JjdFRPVzRXNUQ0?=
 =?utf-8?B?YW1QeTBXU3MyS3dYc2FkKzduanRTMzRQaGNra2tTTkFCMDh3TlBtaTAvOFZQ?=
 =?utf-8?B?dmxyS2dDMXZzVWdWWitGTTVudDVPaVlib0VsS01DOW1rQkkya0hvMGN5d0xl?=
 =?utf-8?B?MGJOeTl5cDBHUFE2SktMc1pwRWN0cVQ0bjMvdllGZkcwZUZTd29RUDU4bUtv?=
 =?utf-8?B?NjJDVnpWZEFmeFNwMUJEc0VjZVM2dkFPSnJRdGxLb0NjaEVpcjQzbDJRMksx?=
 =?utf-8?B?VmFyMFExdm5Qb0ZJYjdOcmwzYmZmNTA3a1RjWmZXdTkvVTJNN1hsQkNEa1d0?=
 =?utf-8?B?ZWdyVEp0Z1RON2FOaVc1dXBQUkk5RGVuUVJvUUVtcTlMbHVvRDRQRSs1YVAv?=
 =?utf-8?B?SnRtRzF4a1REeUUwa2M5S1lOYVNHSG1DTHJnWThDQVhWRk93ODEvL1lMT0pM?=
 =?utf-8?B?MFhKZnd4MUNIUGtzaENWaFAvTjZJRGprbVArTk1RTm5oQmVtQWl4V2twZ05j?=
 =?utf-8?B?cnIzQlRRaW5QMDNQN0VmcFpWVVBPVnIwajdHS0l5RW9MMjBZRy9wejBvd0JF?=
 =?utf-8?B?R21JTDlzaHZhaTc3TWpOQlM3Y1JRVnJycDExUGVCWDJKUi9Qb3lpaXh2c2VO?=
 =?utf-8?B?anhoKy9CSEFheFZRdFNYZU52eE1XendFKzRWTUpxRzRQaTlaZWt6ZmFqZmND?=
 =?utf-8?B?eHdZM3k0WlhlL2FxNkZGSmNwb2dnb3MwUFlYYjU4cmxuem13ZVVzVWhwdFVP?=
 =?utf-8?B?RFJFQlZ4Rkc5UlVNR1pwbXdZUmtFNU5VTURKaFkzWUlHbkNEUWZNWEx0c0dS?=
 =?utf-8?B?WUlJQkdka0JyZnRtSHBFNThOeDNjU1BFQk1TS1laUDNxNm13M3FZNUh2dVpG?=
 =?utf-8?B?YW1ZMVpKR1ZQdTZvcjhxKzZOZEpDSEJEamI0azlCUEJ3MHArZmthc2JSeWYv?=
 =?utf-8?B?WTc4R00zenlwN2ltNDhsV2tnei8rVHc5OFNVRmJMTHhrRTJEd0M2ay9mMzVt?=
 =?utf-8?B?ekFZdmZVWEhNcmJRMGMrLy9DVnBNNGlhZ1k5SkNBL2N1ZDZXZ1EvWEVqM0Fj?=
 =?utf-8?B?elJSWE1ydndLUEFRd2EzTXFoZEhRSkxaWWprOTI1Wjd5YTl6Wld5RU5BUTk3?=
 =?utf-8?B?L0NZVVFtb2xycEhkc0swQzJuSGs3N0JoWCtPZm9YTlJySDcvVDJZNTNPVGZ3?=
 =?utf-8?B?SGxNc251Z2RVUTdmdHZycDMxb2VlYWsvSjd1YlhINTdRQytmVGNJUFZPaUFQ?=
 =?utf-8?B?Qkljd1NxeUdMQllhWll4MUhqMkRmR0ZBVGhMZnB3REhPaldkbWxtN2wwc3Zw?=
 =?utf-8?B?MHJ2UDN6d0QrR3NuUEVOeXZvUEFveUxGUHI4ZXp6OXhJNTRZakp3RkpBWXdu?=
 =?utf-8?B?czdiWUZGYXpxQXUveGRRQXhENERwUXFEZkFQSEJOb05FMXdaWXp0VFlRRFpG?=
 =?utf-8?B?eVdFL2FhS1hJV3NVV3I5cVMvdzI1V1BxS3EzU083V3RVWnluMWVTZmhMQ3ha?=
 =?utf-8?B?dWlHbHQrcGNYS3Frckl4Tms5UDFxSGVvQWJVNWRqMnk3L1gzd0ZXakovQnBR?=
 =?utf-8?B?MjB1TC94dXh2T3ExZmRiSDNjTGlDdGFXc09IOHlGV1hNZzN2RllDak53SzRs?=
 =?utf-8?B?NEZBOTk3QnJOMlpiZWpmOXRLcWRmN1FCS0tsUFJRaGVrczBYb1RQL0tmYWpG?=
 =?utf-8?B?MDdUbStLbHJiZlhoNUhqVWZYNCttOXdnR2lxY3BTZXpZbndxMjZ5SVA5Y0lx?=
 =?utf-8?B?b1pCUGhjSzV6NklNS2RtdWRhdmx1MS8zNkNacEZwMW9pYXpnWWRFSWVMa0RI?=
 =?utf-8?B?YVlxZHJpNHcxcW9XWFRJcWF0OWNDdWo5d2pTcmV4V2t3N0dIVjB1ZEs2ZEVE?=
 =?utf-8?Q?Kpf8eRXh/6PhZwr4ma?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e7dc9b-bccd-4c74-fbb5-08de698cf46e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:45:25.5509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp0MWDIIrzWr3807ISvRmjNg69erN59AfHzH7kDZsJ/ltaJ0AKoaNhBF9VQkv1cq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
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

Hi Alex,

Thanks! Answer in line.

Best Regards!

James Zhu

On 2026-02-11 10:26, Alex Deucher wrote:
> On Thu, Jan 22, 2026 at 10:22 AM James Zhu <James.Zhu@amd.com> wrote:
>> to support PMC, PCSampling, SPM etc.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   amdgpu/amdgpu.h          |  8 +++++++
>>   amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
>>   amdgpu/meson.build       |  2 +-
>>   include/drm/amdgpu_drm.h | 19 +++++++++++++++++
>>   4 files changed, 74 insertions(+), 1 deletion(-)
>>   create mode 100644 amdgpu/amdgpu_profiler.c
>>
>> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
>> index 39b61539..87eec030 100644
>> --- a/amdgpu/amdgpu.h
>> +++ b/amdgpu/amdgpu.h
>> @@ -2072,6 +2072,14 @@ int amdgpu_userq_signal(amdgpu_device_handle dev,
>>   int amdgpu_userq_wait(amdgpu_device_handle dev,
>>                        struct drm_amdgpu_userq_wait *wait_data);
>>
>> +/**
>> + * Acquire profiler version
>> + * \param   dev               - \c [in]     device handle
>> + *
>> + * \return  0 on success otherwise POSIX Error code
>> + */
>> +int amdgpu_profiler_version(amdgpu_device_handle dev);
>> +
>>   #ifdef __cplusplus
>>   }
>>   #endif
>> diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c
>> new file mode 100644
>> index 00000000..8d4dffe4
>> --- /dev/null
>> +++ b/amdgpu/amdgpu_profiler.c
>> @@ -0,0 +1,46 @@
>> +/*
>> + * Copyright 2026 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include <string.h>
>> +#include <errno.h>
>> +#include "xf86drm.h"
>> +#include "amdgpu_drm.h"
>> +#include "amdgpu_internal.h"
>> +
>> +drm_public int
>> +amdgpu_profiler_version(amdgpu_device_handle dev)
>> +{
>> +       int ret;
>> +       struct drm_amdgpu_profiler_args user_arg;
>> +
>> +       if (!dev)
>> +               return -EINVAL;
>> +
>> +       memset(&user_arg, 0, sizeof(user_arg));
>> +       user_arg.op = AMDGPU_PROFILER_VERSION;
>> +
>> +       ret = drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
>> +                                 &user_arg, sizeof(user_arg));
>> +
>> +       return ret;
>> +}
>> diff --git a/amdgpu/meson.build b/amdgpu/meson.build
>> index 3962d32c..d781f2e9 100644
>> --- a/amdgpu/meson.build
>> +++ b/amdgpu/meson.build
>> @@ -27,7 +27,7 @@ libdrm_amdgpu = library(
>>       files(
>>         'amdgpu_asic_id.c', 'amdgpu_bo.c', 'amdgpu_cs.c', 'amdgpu_device.c',
>>         'amdgpu_gpu_info.c', 'amdgpu_vamgr.c', 'amdgpu_vm.c', 'handle_table.c',
>> -      'amdgpu_userq.c',
>> +      'amdgpu_userq.c', 'amdgpu_profiler.c',
>>       ),
>>       config_file,
>>     ],
>> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
>> index 947bf261..107d2b69 100644
>> --- a/include/drm/amdgpu_drm.h
>> +++ b/include/drm/amdgpu_drm.h
>> @@ -57,6 +57,7 @@ extern "C" {
>>   #define DRM_AMDGPU_USERQ               0x16
>>   #define DRM_AMDGPU_USERQ_SIGNAL                0x17
>>   #define DRM_AMDGPU_USERQ_WAIT          0x18
>> +#define DRM_AMDGPU_PROFILER                    0x20
>>
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -77,6 +78,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_USERQ         DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>> +#define DRM_IOCTL_AMDGPU_PROFILER      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>>
>>   /**
>>    * DOC: memory domains
>> @@ -1616,6 +1618,23 @@ struct drm_amdgpu_info_gpuvm_fault {
>>   #define AMDGPU_FAMILY_GC_11_5_0                        150 /* GC 11.5.0 */
>>   #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 */
>>
>> +/*
>> + * Supported Profiler Operations
>> + */
>> +enum drm_amdgpu_profiler_ops {
>> +       AMDGPU_PROFILER_VERSION = 0,
>> +};
>> +
>> +struct drm_amdgpu_profiler_args {
>> +       __u32 op;                        /* amdgpu_profiler_op */
>> +       union {
>> +           __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
>> +                                         * lower 16 bit: minor
>> +                                         * higher 16 bit: major
>> +                                         */
>> +       };
>> +};
> I think this seems fine.  I think we'd need to see what the other
> opcodes would look like.  What is the version query used for?  Can you
> provide an example of how the profiler would use this interface for
> actually profiling a job?

[JZ] Profiler team requests this to track some profiler internal changes to

conduct profiler version control.

The op will include PMC, PC Sampling and SPM so far.

>
> Alex
>
>> +
>>   #if defined(__cplusplus)
>>   }
>>   #endif
>> --
>> 2.34.1
>>
