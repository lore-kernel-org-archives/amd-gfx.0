Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9089EB28C1
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 05:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BF310E329;
	Fri,  6 Feb 2026 05:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dIz0/Gug";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 330F810E329
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 05:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrlK6fHi1nxNpJuf+UI0UdrSMBm5soirSa3AVv3SFcxgs1EIb2B2uvgqEWJWCwV+2kqxjkvf+Pt1oIhFgBCfzuik9QDINGLC25w54mGv3APZ7e9ja6zwtiY4RKO1SJFmlx6EREXFyANeKZjt00bBxPWeWSVU9I0h3rcTDUU/DcKXIznBtC6W8c8FgzHVZEIw12NVr6cQndT7xtuackQVCj5QTq1149O3nmGKOoKzHY/0o1d1TeD2rldtAs7asApiCTTnGdfQn7abzca05QL+prVvIyoH90hdWU8TRjSoMf0Vc75rISHQmnLZP8LaqXBrWNx+n6AOjPH7/hqvhvXwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBKaWBzDQoWgqi7Ek8PcMZLBP5WjGFN4APTakkFaPaQ=;
 b=otCM3CBZl9cFvaO+2EvhebiqoX1Mzfan0vLCiCUnkJCC1DnNSFMhDYU4lWzskQDnMawLzV+rhrhbw/tDb3zGJDYcYcq+9PxQVx2UGAlgdQ6Vxn3odlGhckwcbJq8XncAXrklm1dTZ+KO24qewkogmbmgxzwNMGAqj9rk/JCCFy82O9lFlpbF2vVRPUIDVS/KMxm2fZtqgOmIlsYLPIXP0OE3kIep8BEdHwRQJIM9180CxgyiWcSW4YRQJW7yNFPihL5buzJ6naJBRACz+XLnCvFHDPTtX66m6pym5LFVgLBrBJMR/Za7Kq0ofNrm69/sNI7eI0Qa24eNyX+VBj3a0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBKaWBzDQoWgqi7Ek8PcMZLBP5WjGFN4APTakkFaPaQ=;
 b=dIz0/Gugt1uCDujE2wduvd2FGElcZ23NCKqYs2wFWaGWVeoGUV5x5GorBNciCG42YPuSVgJG/IvjsTYRElNs6MPk6ByxfnnxFxZyv9iVLTHBLmr/2Xy17fHXIqR8O87z1qhyD7WBjgKgrFy+/qnIbrdIbwe5tGKq6qsdRHTd0Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 05:16:52 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:16:52 +0000
Message-ID: <5f7c6f94-1e84-47a7-8acb-13ba2c678669@amd.com>
Date: Fri, 6 Feb 2026 10:46:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] drm/amdgpu: add amdgpu_ptl.h for PTL format and
 command definitions
To: Perry Yuan <perry.yuan@amd.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: yifan1.zhang@amd.com
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-22-perry.yuan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260205065130.654921-22-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0170.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::7) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: b38cbd15-4082-44f2-1f45-08de653eefe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVdMU1Jma3E3ZlBwL2hNLy9FMmhndGlpeHZrdEkxNUU0WndlR1AxZ1BvM2Nk?=
 =?utf-8?B?QmFXUkxzR29zWDdoUlg2cHd2a0JYTUlZZWVSRjRwT0c1ZUxMKzA2cWxQNXpC?=
 =?utf-8?B?bmhSNHlXNU5tOGJOTmkydjNOcFVhbmMzcVJNWTNVSkl1QStmMC9xemNod3Fn?=
 =?utf-8?B?S1NCYUswTzNrS2xQcUlLeXQ0VU9JZ2NTOTFjNUFIa1kwdzk2aENKRmdQV1Zp?=
 =?utf-8?B?NWxCQnhYZ1RnRFE5NEh3NUt2Tnk2djlMYU9tY0JrVnY1bmttRC9FdUw5MlRP?=
 =?utf-8?B?U3BXRTdxMHN4ZnVoQjZqZWVXYmFPZ2wzc01CZHo3d0xkRUdibjdlOTlZWGha?=
 =?utf-8?B?SGkzcXByRUV5YkRmb3dyZGtrZ1hjdUFSR2I0SXhVd0xOaVdxUnVWZUswQUYr?=
 =?utf-8?B?ZnZNSHNmWmZPU3RUdk5Za3hleDcwUW9heDNtczhTS04ySk9ac055ZEVmR0wz?=
 =?utf-8?B?N2d5QVdPcDZyZjR4TzREOWt0eWJUUFpoS3RkY0pUaFQzQkhES2t1dDFwcHZK?=
 =?utf-8?B?V0gxM2pmcE03ZVhDOTNoNjBrbkJKdFU1d2syMkVKUkJXZ01sbnRjKzlGMkV1?=
 =?utf-8?B?ZE5aZWRXVWw0NFJzTFhWRU9tOVV4NFoxUkhHaFpLWEZCcFU2TE1CeFVkVU53?=
 =?utf-8?B?TndsSzZzSVJMRDkwQ05tNDVmT3VtOVBaQU9UVW03UWhZWGdkcDFaSmJzTUYz?=
 =?utf-8?B?U1drSVF2TTVUS0MvMmxxM0Zkc1dZeU92NG1jNnBBVW5pRTJxRnNEWUREa25Z?=
 =?utf-8?B?Mk9nNHRCdHBPZkttam1lcmtydFk3ZFVOR0J5T0g2cFMxV3dLU2YycGNRU1JF?=
 =?utf-8?B?TmZtWXZKSDk2REhZbXErU2tYQjJBSzkwaGtWb1UvdklNTGozQnh6Y2F2ZzA5?=
 =?utf-8?B?azViL0NxYW5BVGlhMFJNNUVmUkRTMEIyMmNDVnJMZ0N4TU80LzFSOWJkdHB4?=
 =?utf-8?B?c1pYNS9vMGxmUTVhNFQvUXFPdXBRQ3JWVVdOVno1S3lBS09LSFVoQ0RUYjdV?=
 =?utf-8?B?VHlTTE4xd1RJNHF5WXFKRWhrZXlSU3puMmY2dDRiWVIxRG1CemF2T0RKY3lV?=
 =?utf-8?B?cGVqWnZuK3hzbmJ0M0ZqU0RDUWdPa05vdUNlakk2T2lnU2xKOGhJRkE1cSsx?=
 =?utf-8?B?M25tdmt4aW1xZGtxaVp2aHp0WlJ5Rkl2OGhrbCt5UzUzMmpXSlhaaHJ5ajIz?=
 =?utf-8?B?aFh0NVNtVkxlVnErVE9pNlZLQ2JoeU5iZGI2Z2RWNHVtTDUvVXBjZDhYNkFK?=
 =?utf-8?B?MHowSVZEeGpmMzRER3kvbzZDcEhuMlV0TjNISWdUdXRIVktNbnF0TG1aa3RU?=
 =?utf-8?B?RllMck1VbjA0UTB2Skg5YVVSZ0h2YzI5NmZia05YWkRqcXV5VXg2N3FhcjlU?=
 =?utf-8?B?NnQzWGFjZVpkM1JkZHE5YVY2aHhCbUhoa3pvUk9LSmNzcDVRYXFIaEFpRzIw?=
 =?utf-8?B?VnBORHQ2a2EyU285S2p6ek9GdXRBMFlaZFdrVnp4M3JYdGgvRGZ0WWdaQXJW?=
 =?utf-8?B?N1IyeEtTa0puTjZTL0dvQlhSQUlZNnJBTWpocDFwSDFXYUVJbElmcHpnYVBV?=
 =?utf-8?B?dVNrNGxJdWY0OHNoREFZaGtadTEwWUlCTmcrVTlkN1BoaGV5bzBvMWF3aHpr?=
 =?utf-8?B?MXNyZ1FVajdnbHNUaXN5WWJQc3JKLzIyeUEzWEwzODZnRE5JNm8wWGRheHYz?=
 =?utf-8?B?VFNxSTM1OVJINGtqVW8yelllczIzTHdvRHZXQ0NtZTR2UVYwVVBEaXVMQmY4?=
 =?utf-8?B?VDRzdjNkWjRwaVpJUkJIWUU0N0lWbFV5YlJVRHErc0pLYU9oVnJlbWRDSWJt?=
 =?utf-8?B?WmRzazYra2dLZE1sWXVGdmtaMU9uV3NLSENlL1AzS3dZcUpQSmhBMUhWbnBO?=
 =?utf-8?B?bGIvZk9jc0RuVzRrOUx2UGRyVmh6TWp5akFSVDZUN3ZVT0RWV3RRUFhpS1Zl?=
 =?utf-8?B?blpVMjc2ejRnSnJtUkFEalRRZFpWa3BLc09RY3UwSCt5N2Jvd0ZqdEJwak14?=
 =?utf-8?B?bFkyQ2hCYlRJRVp5VlVQTmo4V05DOE5pVGxzNnFONXRwWXFJdllPdml0SElS?=
 =?utf-8?B?bEN2VnM0SkxHL2x4UUtMOHhJbG1MZWd5aDlRQk1ZN1ZVMUdWYWhtZWxUczha?=
 =?utf-8?Q?gGNA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3BHbC9JZE1wSTR2MVRjNFZEQ3RuOXUzVEpmV3dCZjFXNmVaR2laOTI1a0w0?=
 =?utf-8?B?bE5QM3ppblJmd0NMeEVkSEJ3WXJXQTVOWHZLWVNtL2xRNmRsU1h2eGt6d3Qr?=
 =?utf-8?B?MUMrM01qN0paUU5DOW5FSU9rUm1nL09RNVdsckVTS0FJblI1b09RM0dzbVJO?=
 =?utf-8?B?QzRGQzk2UC9qV0NuK1V0RnpWdmxkK0ZYSDZOc25LOWxRTXdCdEpDZVY4NDZQ?=
 =?utf-8?B?bjJ3NllDRkVTaEI5Q2pGSWJ2REM1bzduMUJFZGFUOFpOUXRSZG52ZEFLTG9Z?=
 =?utf-8?B?QTdtR1B6TmQwQ0xOWk5WWmwvZlQySEFOdm9UcnlUTmJRRllpVmlLQmRQYVI3?=
 =?utf-8?B?ampVeTJyaG5CYjBDVEdUMDFhWFE4dUZZb2h0Zk1LRW16bkt4ZG1mejE3SGhv?=
 =?utf-8?B?UjNjL0EzQ2RJTGFxY0Qwd3Z3aXcxb00zZWtKUkhsL3hhOXlOTzMybmtxYmR3?=
 =?utf-8?B?endJKzlkL3NITDF6N3RJV1VTZTBORk9CWlhGSS8wTTgzUU1GNG9xUnNnazRv?=
 =?utf-8?B?ejNIQ1V2TEtiWDA2QXk1R1UvMng0WUkrTHhrK3BwNXRBZ1hLYnRtRXF5QUt6?=
 =?utf-8?B?RWx5Z1JjNXp6SDRPVEtSeXRrdy9vcnRVWXRDMTAyYXE4OWJ3ZkFXMnhYM1U2?=
 =?utf-8?B?d2hVL2Q5U1VtbjMvdlZNS3RMMXBEMDR6YzhDUXRmOW5vM2JEL293NCtXMWZN?=
 =?utf-8?B?S2xXMHEvOW1WbFBQL1BKYW45M091SHFySy91U2JndzVFZHE4Um9WMWY1V2tS?=
 =?utf-8?B?UERHb0pHY29IcysrOVVpckVzaTlWRTdKbHdjOG82Vk5ERUlSQXBLOHpKa1NR?=
 =?utf-8?B?TldBYlU5NitDRVVOd3dyVkw4amNJUXd0ck1tUlNyNUx4VlNNenRSVklvSWwz?=
 =?utf-8?B?WUdhUWR0OTJDMjdRYjFUVm1XcDEza2NlZjJIZm1ORFNnRUhFY3JDbHJTTmZv?=
 =?utf-8?B?M2MwNk85V1RCRm8wSzdCRzJId2RndGRzeGlwczdEeUJkaWRSV3EwY014Q2Rs?=
 =?utf-8?B?ZW1CRjZyK2M1TWFqcFNkbkRzZ0JIc05NY1Jadm1pVkZXOXVmVUNOSmFlRjcv?=
 =?utf-8?B?bWI4QTJiTkNLclVTci9RU0k3RnJTYkVPWUZ6QjlUSzM2MElvUzJKaU9pbGZW?=
 =?utf-8?B?L2JXZDlGN00rdlZLQ3BZVFNNU09lbGxEQzNmWXVSbi91NnZQcHBYZnFBRXhv?=
 =?utf-8?B?a3orYWQzendCeE1tWTNCK0RJekVlTUpCYS8zOC9XRjdxa2VZUTI2d1FpWU92?=
 =?utf-8?B?dTJNeFhhSjlsdzdYaitqbkY1NGZ2RkNPM2tzOTVtZGF2QzE1ekVTbklzRHZW?=
 =?utf-8?B?bWNzMTI2UExCVE9rbHZXWFNTTXBmL1RyTGNHWjdCR3dLeXFrZ2FobGl6YWR0?=
 =?utf-8?B?Uy95ZjkxbXppRjhCSkRTcFJtSFdjZEFLbEJrQ3pBZ2pUcUtkSUExUjVyTExP?=
 =?utf-8?B?czZJMDJuNnZkYmNid3hxbm11RmVEWk5EM01FQW4vTGtYVmlqRFF0OVppaWFN?=
 =?utf-8?B?REJPUUxBODFFNWIrVVdpVjZmUzltZkNCVlI5RVlPVzk2OS9zcHdzYkd1VFhV?=
 =?utf-8?B?YkdHZHU3SkJOM1hvMGxhMHpsMVhtL24zbno2ZUpHa2lCTzB1Z1NqbVhmdHp3?=
 =?utf-8?B?eGRVeDV6c2NLanZEenhRdmpveVdhSmhPM2VVNkg4SFVvdTZNK2FEbFJzNTRn?=
 =?utf-8?B?UXl1dmxwSHNlaFEvNnFCYXRHaXVMSkR1ME1lQksvQjBEMzB1UTREK0s2ZmUy?=
 =?utf-8?B?ZUowREFkZWtjYWNpNnVpbnhKRTVTSUNBd002L1loWVlHMGtvUFN3aEp0Nmsr?=
 =?utf-8?B?K3NSNktHQ2xWdFd0REY1RUJQUXhBb0lMWmZDSTA4eWhSaXFqRUc2TVhRaDBL?=
 =?utf-8?B?aDNYdWd5eGwvRE4rbU0zelpqUGdpRUJGdGRMQXJiaURZZGFPR1pMSEluV2lz?=
 =?utf-8?B?L1ppbHFpalZNWnJmcEFHVUZYZWxqd1VFdlovQmg3Z0luQ1c4UXdHM3o0SnpS?=
 =?utf-8?B?Qm9CZFIxbjE2ZHgzVWRhKzd1SW9PMmlpOFY5UWpuUmZpVzdRdURjZzh5b0VJ?=
 =?utf-8?B?enJhRjZpWWdvV0s5a2RtRm5HTHlwNzdhaTBrNjR5OExuSEJ4OXFEUEFLaC8x?=
 =?utf-8?B?dXdBVVg0VGx3anVFeFFiZG1WVmcvRkVDWEQvWG5Xd3RYR3ZWUVhYRm1zSWY1?=
 =?utf-8?B?c2x5cVV0Rlc5UHpCdTFyOG9yTWFWR29VbmdhWDRoaGZvaGp6K0EwZHh6dXkv?=
 =?utf-8?B?eU9RRnFOcW9LRGlzeVR0b3RzTGNkRXVCbkhOUXF5UlhSc3Z2cFQ4R1FuSDBW?=
 =?utf-8?B?S3pEL0dPR01seDBiRmdzYjlSVGZ4S1NSZ25lZWEwc2M2b0VIZ0U1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38cbd15-4082-44f2-1f45-08de653eefe1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 05:16:52.3912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+QActqscbeM3xHd33P7vBPLEajKtdYzSPWAdWwz3zQjkaoambE1UEplXu9tQIjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
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



On 05-Feb-26 12:21 PM, Perry Yuan wrote:
> Collect amdgpu_ptl_fmt in one header so both GFX, KFD and PSP drivers
> can share them without duplication.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       | 23 +------
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  1 +
>   drivers/gpu/drm/amd/include/amdgpu_ptl.h      | 60 +++++++++++++++++++
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  1 +
>   include/uapi/linux/kfd_ioctl.h                | 11 ----
>   6 files changed, 65 insertions(+), 33 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ptl.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index cdbab7f8cee8..4fee011c2e26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -38,6 +38,8 @@
>   #include "amdgpu_vm.h"
>   #include "amdgpu_xcp.h"
>   #include "kfd_topology.h"
> +#include "amdgpu_ptl.h"
> +
>   extern uint64_t amdgpu_amdkfd_total_mem_size;
>   
>   enum TLB_FLUSH_TYPE {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index c6a896003596..562f731bf16c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -32,6 +32,7 @@
>   #include "ta_rap_if.h"
>   #include "ta_secureDisplay_if.h"
>   #include <linux/bitops.h>
> +#include "amdgpu_ptl.h"
>   
>   #define PSP_FENCE_BUFFER_SIZE	0x1000
>   #define PSP_CMD_BUFFER_SIZE	0x1000
> @@ -64,7 +65,6 @@
>   #define MBOX_TOS_RESP_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
>   
>   extern const struct attribute_group amdgpu_flash_attr_group;
> -extern const struct attribute_group amdgpu_ptl_attr_group;
>   
>   enum psp_shared_mem_size {
>   	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
> @@ -385,24 +385,6 @@ struct psp_ptl_perf_req {
>   	uint32_t pref_format2;
>   };
>   
> -enum amdgpu_ptl_disable_source {
> -	AMDGPU_PTL_DISABLE_SYSFS = 0,
> -	AMDGPU_PTL_DISABLE_PROFILER,
> -	AMDGPU_PTL_DISABLE_MAX,
> -};
> -
> -struct amdgpu_ptl {
> -	enum amdgpu_ptl_fmt		fmt1;
> -	enum amdgpu_ptl_fmt		fmt2;
> -	bool				enabled;
> -	bool				hw_supported;
> -	bool				permanently_disabled;
> -	/* PTL disable reference counting */
> -	atomic_t			disable_ref;
> -	struct mutex			mutex;
> -	DECLARE_BITMAP(disable_bitmap, AMDGPU_PTL_DISABLE_MAX);
> -};
> -
>   struct psp_context {
>   	struct amdgpu_device		*adev;
>   	struct psp_ring			km_ring;
> @@ -679,7 +661,4 @@ int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
>   
>   int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
>   			       u32 *ptl_state, u32 *fmt1, u32 *fmt2);
> -int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
> -void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
> -
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f375dffcbdf6..eacb2ab25a6f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -44,6 +44,7 @@
>   #include "kfd_smi_events.h"
>   #include "amdgpu_dma_buf.h"
>   #include "kfd_debug.h"
> +#include "amdgpu_ptl.h"
>   
>   static long kfd_ioctl(struct file *, unsigned int, unsigned long);
>   static int kfd_open(struct inode *, struct file *);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ptl.h b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
> new file mode 100644
> index 000000000000..19eb8f6a765c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
> @@ -0,0 +1,60 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef __AMDGPU_PTL_H__
> +#define __AMDGPU_PTL_H__
> +
> +enum amdgpu_ptl_fmt {
> +        AMDGPU_PTL_FMT_I8   = 0,
> +        AMDGPU_PTL_FMT_F16  = 1,
> +        AMDGPU_PTL_FMT_BF16 = 2,
> +        AMDGPU_PTL_FMT_F32  = 3,
> +        AMDGPU_PTL_FMT_F64  = 4,
> +        AMDGPU_PTL_FMT_F8   = 5,
> +        AMDGPU_PTL_FMT_VECTOR  = 6,
> +        AMDGPU_PTL_FMT_INVALID = 7,
> +};
> +
> +enum amdgpu_ptl_disable_source {
> +	AMDGPU_PTL_DISABLE_SYSFS = 0,
> +	AMDGPU_PTL_DISABLE_PROFILER,
> +	AMDGPU_PTL_DISABLE_MAX,
> +};
> +
> +struct amdgpu_ptl {
> +	enum amdgpu_ptl_fmt		fmt1;
> +	enum amdgpu_ptl_fmt		fmt2;
> +	bool				enabled;
> +	bool				hw_supported;
> +	bool				permanently_disabled;
> +	/* PTL disable reference counting */
> +	atomic_t			disable_ref;
> +	struct mutex			mutex;
> +	DECLARE_BITMAP(disable_bitmap, AMDGPU_PTL_DISABLE_MAX);
> +};
> +
> +int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
> +void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
> +

Please move amdgpu_ptl_perf_monitor_ctrl decalartion also to this file.

Thanks,
Lijo

> +extern const struct attribute_group amdgpu_ptl_attr_group;
> +
> +#endif /* __AMDGPU_PTL_H__ */
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 295ce9364362..44e225e097d0 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -33,6 +33,7 @@
>   #include <linux/dma-fence.h>
>   #include "amdgpu_irq.h"
>   #include "amdgpu_gfx.h"
> +#include "amdgpu_ptl.h"
>   
>   struct pci_dev;
>   struct amdgpu_device;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 905acff01700..32550e581673 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1558,17 +1558,6 @@ struct kfd_ioctl_dbg_trap_args {
>   	};
>   };
>   
> -enum amdgpu_ptl_fmt {
> -	AMDGPU_PTL_FMT_I8   = 0,
> -	AMDGPU_PTL_FMT_F16  = 1,
> -	AMDGPU_PTL_FMT_BF16 = 2,
> -	AMDGPU_PTL_FMT_F32  = 3,
> -	AMDGPU_PTL_FMT_F64  = 4,
> -	AMDGPU_PTL_FMT_F8   = 5,
> -	AMDGPU_PTL_FMT_VECTOR  = 6,
> -	AMDGPU_PTL_FMT_INVALID = 7,
> -};
> -
>   #define KFD_IOC_PROFILER_VERSION_NUM 1
>   enum kfd_profiler_ops {
>   	KFD_IOC_PROFILER_PMC = 0,

