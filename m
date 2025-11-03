Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39150CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 10:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D548889838;
	Mon,  3 Nov 2025 10:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ui7nn0Wq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D18C10E0B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 10:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyUqvrH7JuxSUCfvUkYozv2ttNnCoVD+rY+TzHmojKWeyQdIRHiTtLabLUxdfx/OPn/27lZyce5c4LaEia5k41RJnweLFaZuANX4UqrkfcbYDxfy6Yh+BFCjXBpJ0X4t4C3+lM/jiBKsNK/XPYuhNHyX3SE1X97Xm0LyecfQfLNytE9x4kRICD/WEICUn4Et9POXg01SMdQczYZFohFLJ0rMVEPt23E6id6hKVoq96Yy43RHwRMtmiVYWlpwOPpup5/NsmrWmLvhWo9JrEuF5RqARYwMa+tiI0FrSVaWDYuSFF6I0MD63bDNAwLxGqxJi3aT6h2axETz0R64cs3eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSJb6j+b0FYQgjPf5cZ7SOKzdKDOg6eiT3+HUzthM0k=;
 b=dqsWyRB6XYr5VzkMqOQbjN/sQDDb5GalHF/lhJEhtnfwnx25L9PoVrVxAo6SBUXWXWjOYWQCN+nt7qOEhx28aLhOi08z+S2w5G98DyEU389GtnzczPtg9zp/3+qdQwcGgoqwA1GFC6qUojD51VI+v4sNVNHK3AglaqPVAuU5Ch/0ZqHoXdBV1oQobXrREOFf8Hvy+1Ck8XKOALcI/KeaIUDXdq/8HyLHAAN2703QyJNNcdlwvx6LSznTUqBOYV8gj1T6AGsl8xc74LEHKpTWRXEJwIjZeTkACrOK+yBE4iY4HKNh2f0qrYOqubSgKwg45V6WXYRrIBYcgXurIIxkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSJb6j+b0FYQgjPf5cZ7SOKzdKDOg6eiT3+HUzthM0k=;
 b=ui7nn0WqoHH+PHcOsJZObR3Qg76fjNilCk9dNCgjai14BVpYs8DIHVYVc/+E9gGzJ+I+moI40I1yo1PTzPkU5vvBi4g8IfYVzxjhwnA1G7pjh+ZniVknlYy05XptJp7SrigALkiGxIiIaab+6le/6rg7Sz0hdikLwAHkmdF11vI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 3 Nov
 2025 10:28:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 10:28:18 +0000
Message-ID: <e5864d92-cc89-4785-86a2-6c18a00438a3@amd.com>
Date: Mon, 3 Nov 2025 15:58:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix gpu page fault after hibernation on PF
 passthrough
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Qing.Ma@amd.com,
 Owen.Zhang2@amd.com, amd-gfx@lists.freedesktop.org
References: <20251103100613.19798-1-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251103100613.19798-1-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dba3b78-9f75-47ba-afe9-08de1ac3b441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG5FTk1PMS9SOWdIVzN2bDJJNURWcXRNM2V3ck9XVWJ3cmFzQ1pTT2lDWWo2?=
 =?utf-8?B?Y3pON1ZJUmlQa2RFbG5ueG1jVGVTNDdad3Bya25lWmtjaUJwZW4yc3NpWWJC?=
 =?utf-8?B?ZXJObTRBdnpoY3doRjBMUXVQWEREQUpFeE9FV0ZzZVhnZFhiZWw3UERPYlRk?=
 =?utf-8?B?S3czQjFvcjJtZUVhRjdHcWp1eWRtN2ZUVWJKVkRGM1JDMU0wa3FvZUFidC90?=
 =?utf-8?B?dHozWnJpVXgydnFXK2JubWFmREtOanNheXZaVTBPeVRydjJhcWNSWmVtUFEz?=
 =?utf-8?B?bmhlTWxKL3RPb25ySnpHYm16QnF3cXRSRmwwWCtPUXh0cjdmVFNOVlVDKzVY?=
 =?utf-8?B?cWNRVTRtSjcxVlRoVUhZR25CZnhpY0NpcTBMZFk1Njlrc3FHN2U2TGw2NmxJ?=
 =?utf-8?B?azZ6ZldyMlRTUGF6SUVYTnlCMng2aDRSZEVVdTRvc3NvNDlicGFnUnZRUmxa?=
 =?utf-8?B?RFVVTStQdUdEWmJlWFdYVEFwVUcxTTlZck1xVkZsRUR6VUVLTEN3UXZ5NThJ?=
 =?utf-8?B?cWdVdFA5WnkrR0dteEJkT0hhSUFrTnJOdEFTeHF0cnB3d2U0eklRZ21IaVRw?=
 =?utf-8?B?V1ZEZjBoVmxWK0ltQ2hSSnRlSHV3OWRiMk9lYjhoSHpLRnRxM0tJbm41Wi8v?=
 =?utf-8?B?SlVidnZtSjBkcUg4QXEvYmdTcVlPZWRvdVRLOXkvWnd4dHZ6RXd1QU9zZEdz?=
 =?utf-8?B?WmVsV09CNThNUmI5Ulc3SXRVcCszN05hV0pkMGk5Yk5FcVdvT01JbTFOWXA2?=
 =?utf-8?B?WE1VMERxd1IyOGRyam5RMU94ZlJRY2ZLWm1vUkNQdHJacjJ5ODkvdW5BOUpC?=
 =?utf-8?B?SzRaQTFmSzdLd2EycUNZenRKVkthWU5EL05Sa3BUUzdSOFVMSGtVMm5heGlZ?=
 =?utf-8?B?d1k2TG5na2srVFdKUW5NT1ZGN3NaMmtzTFo2MW1iS3o0SWREM1Z2VWR1aXFx?=
 =?utf-8?B?OFRrbERmcDFyUVYxdFhWUmhwekNYbmtrbU9OVng0eXR3dTl1QTd4clNOd0tS?=
 =?utf-8?B?ZittRXY3NDROTEpiTE5xdmdlbWxHallwMnY3UGhrZTdyQlR5d2hkaU1kZ0NQ?=
 =?utf-8?B?VlpVeWMzQ2puSStHVEFvenNaUlpQTWw0dkhLYjhSNis1ODZIRlVrOXY0T3RI?=
 =?utf-8?B?VnNwbmdmcURUZ1ZyYmZKRkMrcDE2dUNVcExNblZ4ZkFSY1pMWUoweUxDRE9F?=
 =?utf-8?B?S2VELzdHa2J4YVZFdzdXWW9iaTd1aS8xRGJBVWV1U2c0V1hNdXd6KzJNZk0r?=
 =?utf-8?B?NGNnYmlzSFo4WXhSMlNhRVBQTnRyT2pET1JYWWJtbThieDNZRGxqQXVhcEdW?=
 =?utf-8?B?YkhRekxmaFFESDdrYzlzMDdHQkNuTG01YWNPMnVyY0JIenFTaE03aEJoTS83?=
 =?utf-8?B?bWRrUFBtanRUMFZJYnR1YTMzL2w4RU9VNDJRcWx0blgrWWV4eFg1UjJUSGwy?=
 =?utf-8?B?UVdoTXNGd0MrNFlpUERYWW5BVlAydmJyK0Z1TkdKNFNFelpMMVk3ZEtpK3hR?=
 =?utf-8?B?dkw4QXFyVFE1bzNJdEpKY08vaHFXd2RwZmJGWnJFckMvOHQvT3lSc2ZKQ0VN?=
 =?utf-8?B?VzlCTEp2Mjl3cjJodWNwZWFIQjlUOFQwbVE2SnMxUzhndGFieDJ6QkFUSnYy?=
 =?utf-8?B?amUrOUE5UE1Kakw2Q3UwWm5NY1hlbm5uRUMrTnY3bkRQWE1YeTBXemVlQkQw?=
 =?utf-8?B?cVR0Y3VxSGNkRHVxRHhCVUxIWWxUV2VXcEFabTZ4Tml3cm5SZ0dTMk1ZRThF?=
 =?utf-8?B?UXkyOVZPK3dxS1NQYnhqKy9TTkxCcHRHeDIvMGtjb0U1NWZ4KzZXZW8yRHlK?=
 =?utf-8?B?M0dUbUNPVUhCdGJhV2FRMmJlQ2NuT292b1gvZk8yaU5XQi9YTlZ5ejg4YU01?=
 =?utf-8?B?dmMvMExxMWVuUVhjdGhLclV6ZkpndEtMWTdTbStleEg5TmJMSDRBQ0s4aC9k?=
 =?utf-8?B?N1l1SExGZmtJS3pRQnkzeEJpTEJ0Y2JHN05BUWlkTFRZbFFxeUx4UzAzZHgz?=
 =?utf-8?B?Ykx5ZFQ4c2NBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFppOGxySGxibXMxc25xYmJ2KzJXVUpsQVEvQlpULzRiRnE5cGVKNVNkbHdX?=
 =?utf-8?B?REFqRHFDWWFRb1hONWtQamtqUmlJMWNab3hCSE5sM0toR2tMK0JDY2NDS0Yw?=
 =?utf-8?B?aW1sUjJNWjJSdmFNUWJKQklBNWRKRDJnQXlBOXowSW9aVFNEN3BqWWd4N0NG?=
 =?utf-8?B?Rk9sVTdkazFsT0FSWjE3WVhYOGtaZ3h2d3FDL09yOW5aYldvaiszemNYR0dv?=
 =?utf-8?B?YkJMQk83QnhiZDRVVC9uc3FkckxmMTNiMkMwcFAzSE5QQTB3VDk5bHFSd0Zq?=
 =?utf-8?B?VGtWOXRyL1RTQ2hqckFORUYyV3BCaVp2dzQ5TWMwUzRpZlAxNkFDVlVpbG9U?=
 =?utf-8?B?VjdxRHNQWDhZV3lpL2ZlVEppbVFCaUdBczhxMnYyMmk5YzFMMEpheGJvVFJa?=
 =?utf-8?B?WXpIeHkzbFZ1TEVjbzRwYVhMd3hkbTQwQUxPN1l0c1hvbzhYNHdYYlZHQVJn?=
 =?utf-8?B?WG82b2VBdUFsTnJBejRpdDlFdnJLb0lDeGFtODlGazJ4SVlYZFFBWW1ZZVgy?=
 =?utf-8?B?djVCa05meXczd3VVMHUyMU5FM2RCakNlazlJdlk2MHNzb0dLZWtHdVRNUzlX?=
 =?utf-8?B?d1NaM2o4elcvRWJMNm8vSUlRZDRidlJJVVZ0Vm9uYnIvL0pGdFhYZGhubzVr?=
 =?utf-8?B?OExpRkkrbWVPNy80ZVFZQkVKdWc1QWRucURvckFjTWxydzBjZ0hPZmtqeC9a?=
 =?utf-8?B?eGNmL3hlNUI1cXZtWFdaeHgvUzFWc1doWDY1MGN0SGkrN0FHb0xQT21yRFBq?=
 =?utf-8?B?ZjZwWGF5UXJ1UDlEOVlIZ1hiZENsNnNydm90anBvTTlYd0x4MTZKTklCLzV2?=
 =?utf-8?B?cVUyNEdacFg5d1E2TTg3dGFMV2wrYXZBTkZsWk1vUzAraVN4WCtiNTJ5SDNt?=
 =?utf-8?B?aVp3d1UyeTRSV0Y3SGdpbjFPZGtRbmE2WUVibDRPTTRJcTVOVjl5QzVOMjgx?=
 =?utf-8?B?N0hXMnQ2V0JaVmltTS8yN1FOLzl2VUdHNklYOWxaQVhSVkFnODFyckRLQzNa?=
 =?utf-8?B?OE84T1VaQ0tEWWlFUnhwUGNCSlpQNXpkemt4MVRxYzVNaTZQd0FycDg1T0Yy?=
 =?utf-8?B?U0RFSThGdFB3M0dHSURoQnhsM3loR3JtWCtSUjlMUldTOWk3ZlFuWkhMVTF5?=
 =?utf-8?B?ZnQvNXFvWkF2YU9WS1JQd2x4RGNBK2NzMWJBazRoRzhHcWU4eDcvNFB0eE5m?=
 =?utf-8?B?VTNodXJLVFNkMGMvK2t6eWpHeWg3OUNXVVBZaXNobXFHeitjL0x4T0QrMVE3?=
 =?utf-8?B?R28zamc5ZkpCQ0MxZ1NWV0tGKzZYK0QxbmRnYzJrTGZYNjhEUjJVQTk5eHdm?=
 =?utf-8?B?aktSTWtSbVVjMHRrdkpYTmk1V2dnenMxQlNxWkYwNUoxRFVUcys3eVRBWmpi?=
 =?utf-8?B?Z2JCWHIvNTNNYzZGd2J6enBNZnNLT3ZVWE9idmdFckg3QnVxaXJwT1ZKYmIv?=
 =?utf-8?B?N2NwTDF3eHBaVDRYK0NCelAzSVhEcXQ5SUtubGF4TzM2V2JYSkNRNkh3SmdW?=
 =?utf-8?B?aHp4VXpGWklpWks0a01SV1dpallaNlQ2WmhoVE5jSXVQRStsWEUvV2RPTmhs?=
 =?utf-8?B?T1ZEV3UxOEtGbnB0SWlnMktGV0xETHB6MTZpTjJiaktXb2ROc3FGbGVKT3o5?=
 =?utf-8?B?RFNkdS9wcmE5dEVmeHA1bVVXU29WLyt1YVk4dUcxdk9Pa3BobXkyZGo1ZGh4?=
 =?utf-8?B?R3NWODN6cjU4Q0g2MVlabEJqdjFDc1dpbXgvZVdaRTlrbWJkTzlyQ2tSR25R?=
 =?utf-8?B?R2dhVkRnd0FrUEg0bnpNc2M4VEZIRXV3bUdldUxZYTBaVGZxa3ZvUXRLakdY?=
 =?utf-8?B?elhNQ3dYSkVBY1k0Nkx6WXpUeUFoTmQ2Mlh4aERkRmtPNjZKS29iWXN6NDVL?=
 =?utf-8?B?M3JBTlZ5a3p6ODNydmx0YXdGUFNhaDAwcFRsK1VVMVR6Z0h4Q3ZvbWRUMUlH?=
 =?utf-8?B?VVkzb0w0Yk14VnZ6RW1OdEFITlllYUY3RWNDUHgyR0Jkai9kODZtWkUwRExm?=
 =?utf-8?B?UGZVRnJ1RUhabG9US1RtSDhwVFZBb2IyUVJncjQ1Q2UxcjNYNys3Ykt5c05Y?=
 =?utf-8?B?WHkvdzNCTm10QURRMDJHeGt2TkpKM1gxNWxyRTJKUkN0dXEyUEJPZGRmSlBW?=
 =?utf-8?Q?GgC8DUeV95H+aOUS2/JPSbMar?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dba3b78-9f75-47ba-afe9-08de1ac3b441
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:28:18.2211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmXcBHRvyKpgym2s3BwuaIyNrTA38fJPeOqVR+xkDT27b8vOD5iaOqX6z9IWqXdK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
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



On 11/3/2025 3:36 PM, Samuel Zhang wrote:
> On PF passthrough environment, after hibernate and then resume, coralgemm
> will cause gpu page fault.
> 
> Mode1 reset happens during hibernate, but partition mode is not restored
> on resume, register mmCP_HYP_XCP_CTL and mmCP_PSP_XCP_CTL is not right
> after resume. When CP access the MQD BO, wrong stride size is used,
> this will cause out of bound access on the MQD BO, resulting page fault.
> 
> The fix is to ensure gfx_v9_4_3_switch_compute_partition() is called
> when resume from a hibernation.

You may also that KFD resume is called separately during a reset 
recovery or resume from suspend sequence. Hence it's not required to be 
called as part of partition switch.>
> v2: switch to use amdgpu_xcp_restore_partition_mode().
> v3: use in_suspend to replace in_s4.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

With one comment below -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 811124ff88a8..f9e2edf5260b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -407,7 +407,8 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>   		return -EINVAL;
>   	}
>   
> -	if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
> +	if (adev->kfd.init_complete && !amdgpu_in_reset(adev) &&
> +		!adev->in_suspend)
>   		flags |= AMDGPU_XCP_OPS_KFD;
>   
>   	if (flags & AMDGPU_XCP_OPS_KFD) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index c4c551ef6b87..a5748088d9a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2291,7 +2291,9 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
>   		r = amdgpu_xcp_init(adev->xcp_mgr, num_xcp, mode);
>   
>   	} else {
> -		if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
> +		if (adev->in_suspend) /* Restore if resuming from suspend */

Please take care of this comment style during submission - 
https://www.kernel.org/doc/html/v6.17/process/coding-style.html#commenting

Thanks,
Lijo

> +			amdgpu_xcp_restore_partition_mode(adev->xcp_mgr);
> +		else if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
>   						    AMDGPU_XCP_FL_NONE) ==
>   		    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
>   			r = amdgpu_xcp_switch_partition_mode(

