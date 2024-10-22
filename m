Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4CBD1CDA4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 06:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE3C10E077;
	Tue, 22 Oct 2024 06:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0a1snRdM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EAAE10E199
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 06:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwJXfZEdUSKZlsQ3Wq5Yw7NzA8iSCWNJGKBjL6HmJcj6s6xCAA9LvWi33Rxd4wMEoQer3pZ84qEq+MU3Dxwuw0+6J4t0ciEk8vGIIYd24chwd6s/48VW2+iqaFkt+tB9kg9stYxadLaqBJNuziP1MeRWoyI7US7mtoUKET+++aBhwvuH0t/wW6J62rE5qFDT7UkPzAOdbHotB5RNWZsi96xAnQRA54lPSBFCK1hnFhIXiyFVNsBQqPZknlD+jcuQ4DZS88779kJYLfNgUi3A93N1ZHoaXDAm7CWsQX8pEn6+iY5P/ljlP6gXJp5Cc+S5ku6RIkkq0hNd0ZU4HJ2QrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABz5xnTb6iH92yxBFDYCWKlrqGrKGshAE2OqZ45aIRc=;
 b=MHCrUH5VSOXxs94eE8+nD0U6PpdQJVO1pzDH+lVFuUOqtfqqf4s49pOWCrIW5JKPASrz4TZPEzkvewk9yiZ83+M7844hqek/uFOPhCBeyQHzsBYEXBUBGflZeY9AChWxImpdnRKctxuBieb5Gykfcch2LxHkjM5fdqRHtGXkrFqfhwBIPQqJOpG+R6GFYuwvJCVeMHrXz40SDpfSgI0nKmjRgjv/qLzKelUZsgGh+QMJT2IKWLrR6jAJz7kP6uuXCuaoNBX9st1ZhIcCIyytJFcBFul75+HWdEm7Bxd7AHwhrC6rx43xaRpdb0texzy2k01J/35osJCu5sM2lfGe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABz5xnTb6iH92yxBFDYCWKlrqGrKGshAE2OqZ45aIRc=;
 b=0a1snRdMb0oWuUpJ+sOS0ZsGAwzINioEy8Po5pU/pBWU38QOVFjXzG7Eq6AOJzS/FS1uK04OmN2RVGU6A2z4HlZDXYs9r+Wll92jsdia9fWmFsr39l0R4UNwYS384dj654Cds2q6SvzytCAM2aAwr2QfQLYMR72ze+DYLQKd3As=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 06:25:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:25:58 +0000
Message-ID: <f8811d12-bb61-4a7c-9d85-2a5e7d98ccc0@amd.com>
Date: Tue, 22 Oct 2024 08:25:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/32] Separating vcn power management by instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 alexander.deucher@amd.com, "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 93469674-95cd-4f75-f865-08dcf2626441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTY4aTBIc2thK3VybXRoRUZkQ3BUVUdmcFNOTjEydkpsV3JwZm82RS9Ld2I1?=
 =?utf-8?B?d0loTStGOFdFUytkVkNoZGJuYVZQZUtuNWhlRUdrSnlKNjZSSldQRnlrN2cz?=
 =?utf-8?B?ZzJWRkxIMTQrampsOWlxT2VtNEg1RHptMmJPNEUxQ2ZKWWUxR1E0RmxCUHln?=
 =?utf-8?B?ejg4bm40TXg1bDIwbnd1RFo5V1pVNnBqTTQwUUI4VXFEVmtnQ2JTNDdRZHZi?=
 =?utf-8?B?VTNXQVV0L3Vvb1F1SjA3SzhOYmtEMjVzNEhpNXZQOVgrcVE3MzR3aXI1OTcz?=
 =?utf-8?B?YjNNOEdDL3NqaUtxSllidjd6R3VkMSs4VllyUmFGeFRESDhHRzJiem1MRU1U?=
 =?utf-8?B?UTY0SWdUY2YvRmpDa0hoR1hURkMxMWVncnJ1ZGVxV0R6eTQ5WjhIS3RRaDZl?=
 =?utf-8?B?Qm94OGxiR29IeExqUVJidVc2dFNKcGNMUnBMQmVVaGkwdDliNnUzM0xsbWNU?=
 =?utf-8?B?d1M0TllkRERNbGdJdi9OVGViNWpBT3lLZVVLNFBhWnJyUFZ4U3BBVkZkbnVW?=
 =?utf-8?B?VERVdEI5dU53TmVqQUZQeDRqblgxNjlYbHYyelJrMndoUW1ydS9QU1VCdjl2?=
 =?utf-8?B?am9YbkpxTHNlcWVvc2hUbUJMYVFWUWd4dzk1QTBrZmFkc09lWk85cHRMQmUz?=
 =?utf-8?B?ZDB2TzF1Q2drQStrd2xtbkVaU0lsU1VsUkcxK1lMcDFpLzZrT1RYSVNObURp?=
 =?utf-8?B?elNHK1VXZnBhcHJtWDN3TjFBRFhudndGQzlBV2d3TjB1ekhtVnVwU1A1d041?=
 =?utf-8?B?RE4xb0d0OTJpbTRsSXErWUtsMVVuTzZ0b08ycDhaK1RwajQ4bkxId3Jibkk5?=
 =?utf-8?B?SlNleEsrZXVDZmVSaURXWTJTdEJJYTZ2TjZFMmRseW9lTmxOdGJjQ1Uzemgz?=
 =?utf-8?B?RmdPQURuNWhydmxBdHI1Wm5HVTRqb2h1M256cU4vWkE3cVFnTE5QUVlONmxL?=
 =?utf-8?B?bElXVHQ1UzhoMUpOT05ndW9RcnlqSUs2c21hYXMyM0xUQUlMTlljSHVFM21G?=
 =?utf-8?B?cTdWS1ZLVzNBQjdNNVB0ZUl1cFNPVHllYnJzMXhTZUswTFJBcjIwK1ZHT2Zy?=
 =?utf-8?B?OHJRdFEzY0k0bkZWdWVJbm1NYVdkcEpDK0dRRWNVc2RYeEk4ZllLSEljeGtq?=
 =?utf-8?B?VmExLzVuU0svYVp5OWcvQ21EWncvKzRxWU1GNGRoR0VjMWVkWVhFK1Q4djcz?=
 =?utf-8?B?bnpqMW5MTkcxUlBtc1FyZkowemNLbDR3dVhqWWxOT20zdGNnbnlTKytXR0hh?=
 =?utf-8?B?aWxrcDlPUFQyRy9xdU5HZitDT1dDUmdkc0J5NDBtS0RRM0c2bWp4S3grSTVx?=
 =?utf-8?B?NTBWNFBuK0U3L0s1MHJHZWkzWW9BQ1d0OWNJNy9GaXZKRHhJYmdKVXo0N2ZD?=
 =?utf-8?B?N0VjSUdkUUEzeHdmdndpQ0tIWXBSZDE3ekt3enpDVmxuOXdaQkd1UWpJRzNN?=
 =?utf-8?B?ZUJ1bHZNZnV3S0JLaUdBay9zK015cjkxbGVENmIvYkp3cFZFQXBuNEZLTXdM?=
 =?utf-8?B?aG41ejBObmozL2lYcjl6QVhkUUU0VVVZNzZtU2MxK21TenY5T21JM010OWMz?=
 =?utf-8?B?d0dPeXdRZW9BUTdmZVQzZzQ2cVFhdDA0akx5VkJxSXpBMFVreTc0MVVXZktR?=
 =?utf-8?B?aklEVUVRb2Q4NmFiNE5KUGlhM0tjWFFIdVFCNkd5WGRtVU5OYTkxUFFrVlpQ?=
 =?utf-8?B?S3lOeEsweXNMU3JXZUl2Tzh1UDVDVkJTbWhFK2F2TUJueGowZG5PSmdUVnY2?=
 =?utf-8?Q?mUmj4WFuUM5j7q8joMRPVa+rayWLtBRs8vdDJkD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEdncDdNRFJVNVVMWlhTVlhSZklSTy9nWE5SNC9jeHdlVm8vcjNMMG8yZVBO?=
 =?utf-8?B?bjV4djgyM2RldDVnVUpFanIvaTM1QU1oTVJobUtkQ081a3NUZldtNVZlRi85?=
 =?utf-8?B?MzFLSHJqNkhjYngvTEJYZEY3WnZOM3V6Zjh6d0pDZ3lvTGx6SFFyR2xkQmpR?=
 =?utf-8?B?UFNyaUd3YWlwNk53U1ZlM3BzWTBUTXgyUWxuOE1aRTV4UUt4ZlZRbUs0TVZK?=
 =?utf-8?B?dXNsQXJFOTdvZHF3dWV3V2NBeHFuUFI4S2VDMmNVZE1UZmhaWGNxaTZ5RGxJ?=
 =?utf-8?B?cStHdkxCQlVNZ05PNmx2ZVJwakY4R1J3dGJQZlkyclV6c1Mvb3JneUVLMXZW?=
 =?utf-8?B?MzFxOUREYURVT3ZRZTRKRURNTFZRYWZOVkpKamJ0ZEtDZ1o5cXkyZ2tOY28r?=
 =?utf-8?B?SmJkeEgzRktpL0g4L25DVmhGU2pRaG9jTmpGbjBzVXdnc3A0V2Zjc0xvdDdC?=
 =?utf-8?B?aEhQY3JEbXdGUUpCaVVJVksxN2kzMmhIL2N3VFBRaDBmQWEybVFBUmFlNStm?=
 =?utf-8?B?OXFoQ0pPVWl4TkcyV0xqci9RdGpzSzlyODRxeXk2TzkyeFZqc1dQTmc1eXAx?=
 =?utf-8?B?c3JoUXUralFNMzRoaU5YM25QcldhSzdZS2gxQnNUSmt0dkVYTVVtZ2x2ZU9o?=
 =?utf-8?B?aXE3VmFQeEt3d2FxdEdpalN2aXNUbVcyNkltakpCOE01elVtQTBYVUpBdkRk?=
 =?utf-8?B?TyswVkM4dFRsU2VvL0pwZnJTOWltem9iNU9RR3pmVWlZYTJadTBBU05ZQjh2?=
 =?utf-8?B?Rjc2cSs4d1lqQ0huTUhoWHlTQVplS0xhaEh4anRFOTJpSm9MaG15eHNrRkx4?=
 =?utf-8?B?WGQweFBMYWlqbmpLaTc5TElMYzg2MGxvaks5d0R5Z2RtSEV2Zlp2RlAzNUZK?=
 =?utf-8?B?TGJLK0t1NE1OKzRIYzJpOUlEQzZ6YWJTQ1NoU0RaR3BUWkc3dWxHV1pFQ2U1?=
 =?utf-8?B?cUc2b1pWSThveEZjMGtRR2ZMVy9FbTZvREJlVzB4eGRjSmgyMURFZlRkZk1Q?=
 =?utf-8?B?dTg0d0tScEZrTTdzRzFvMEF6b1NtWG43ZHVXWElOdC9qSzhKeTZIcDVLVkJC?=
 =?utf-8?B?TGxJdjJGRi9JcHhEVUdFY3Jxa0cxYThsNTBKOWlDQTIxdmo4RVIvVjB3R1Mr?=
 =?utf-8?B?U0F1Nk9sQ3pYTFduMkU1Um9rbmNURk5jOXU4cnZZYjd5eWNlelgrdy9vK0Jn?=
 =?utf-8?B?MlZJWG9OZUp1dVFWbmpJQ0Z2ditjbGNZeERIbmh3M3pCVENIeHBZK0lKQjNK?=
 =?utf-8?B?NGxHdHVkdVFQN0c3UllNV0Q5Tytnc3VRSS80WHVYOVd2cWpReUs4RngrNEJ4?=
 =?utf-8?B?QXNZR3kzSVg4bmhTQlpSWVB1dTJnbC9QR2taMDZSbk1BZCttcld3bXY5MmdL?=
 =?utf-8?B?czY5QWNFQjhLd2hOb3FPMGNyMVF2aUdpK0JSOXVyVSt1QnlFZU80VW1CSEpS?=
 =?utf-8?B?UDBmWFRRL2FLVmorZVBnNk1RTDRLcGhZY2RRZnp1MHVKaVdqaTBvSitDc2lZ?=
 =?utf-8?B?TWJQaGtOOEFqZ2E5MGNMUGltVi9WdUNlb2Fla0ZrVnB3NDg2Z2dNeFozTG94?=
 =?utf-8?B?a01TTnFDdjlKL2E1M08vK1FyZXN1aFRoZVgwbE5zcTZDZ3k1SXFBODlBeWFW?=
 =?utf-8?B?SUkvelZaNGh0VlpRNnN5SUlnM0tRV25vYnp0TXVaeFpXMFZNU0RNc25qQWxx?=
 =?utf-8?B?L095a0VPcUprM2xWb1paKzM3Q2RpWXFxVEMyWUFaWXlvc1V3Y0JUQ01vcTlL?=
 =?utf-8?B?TnUxTG1veTJJTGxNS2w5L1lVYmlKNHJvcGVlTzdyUXZ4UW5teDQvNFdOdVhX?=
 =?utf-8?B?czRsVnk2dG4zMTFDTWZCM3Rya3FoeUxzQ2tlZ0tpOGVNZlV0UzNYQVd6dkpu?=
 =?utf-8?B?UW9GampkVjBqZ21yZU1wR1VsVllFQk9DZm9tTk9IajIxYnNtZ2sxRmVPalBN?=
 =?utf-8?B?b3liWVB4bnhtbVNwUmthb3FHdmZxeTFnRUJoSFVrRFNtbHhkNVMySHBnSDNG?=
 =?utf-8?B?eFUrd2hmYTlscWhteSt5dS9zY2ltSUFNNHJXRnRwN3NVSXdaZ3gxQ1hHN00y?=
 =?utf-8?B?S1IyY1NSRzdZMkZRT3NGajB4cExVaURwand2N2NIZXUvK3JVOUJXTUZQOXEv?=
 =?utf-8?Q?VOe44oPHUUEIK3nBbfZ0IoW3o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93469674-95cd-4f75-f865-08dcf2626441
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:25:58.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OR2RhNgffOCjwtjMc3WekFVhbXYQ4JT6JoGLoZ18+OQAMproR0DKPx+MlZ/VR04y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904
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

Patches #1-#5, #7, #8, #32 are Acked-by: Christian König 
<christian.koenig@amd.com>

Patches #9 - #19, #27 are Reviewed-by: Christian König 
<christian.koenig@amd.com>

Patch #6 the drm/amdgpu prefix is missing from the subject line, apart 
from that the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

For patches #20-#26 I'm not sure if those won't break the driver in 
between. Alex what do you think?

Patches #28 and #29 look good to me as well, but I leave the review to 
Sunil he wrote that code and should know it best.

Patch #30:

+	int ret = 0;

...
+    ret = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE,


That will get you a warning for an unneeded local variable 
initialization from the automated checkers.

The init was only necessary because we previously had the loop over all 
instances here.

Patch #31:

int inst = ip_block->instance;
int ret = 1;

if (adev->vcn.harvest_config & (1 << inst))
     return ret;

ret &= (RREG32_SOC15(VCN, inst, mmUVD_STATUS) == UVD_STATUS__IDLE);

return ret;

That code looks really strange now, maybe drop the local variable ret.

Regards,
Christian

Am 17.10.24 um 15:20 schrieb boyuan.zhang@amd.com:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Previously, all vcn instance will be powered on/off at the same time
> even only one of the instance requests power status change. This patch set
> enables vcn to ONLY power on/off the instance that requires power status
> change. Other vcn instances will remain the original power status.
>
> v4:
> code polishing and minor fixes.
>
> v3:
> move all of the per instance variables from struct amdgpu_vcn to
> struct amdgpu_vcn_inst. (patch 10 - 11)
>
> update amdgpu_device_ip_set_powergating_state() to take the instance as a
> new parameter, remove the duplicated function in v2. (patch 19)
>
> update all amdgpu_vcn_* helpers to handle vcn instance. All functions
> are now only handle the given vcn instance. (patch 20 - 26)
>
> update all vcn ip callback functions to handle vcn instance. All functions
> are now only handle the given vcn instance. (patch 27 - 32)
>
>
> v2:
> complete re-work for all PM changes as suggested-by Christian König and
> Alex Deucher. Adding instance to all existing functions, instead of create
> new functions. Remove all duplicated PM functions in previous patch set.
> Use a new logic to track instance for ip_block with same type as
> suggested by Alex. Also, fix wrong ip block index and remove redundant logic
> suggested by Christian. Finally rebase all patches based on Sunil's ip block
> changes.
>
> Patch 1-6 are SMU changes to only power ON/OFF given VCN instance.
>
> Patch 7-8 pass ip_block instead of adev pointer for set_powergating_state,
> set_clockgating_state, and is_idle
>
> Patch 9 is to track VCN instance in VCN ip_block.
>
> Patch 10 move all of the per instance variables from struct amdgpu_vcn to
> struct amdgpu_vcn_inst.
>
> Patch 11  VCN change to separate gating status for each VCN instance.
>
> Patch 12-17 are to handle ip callback functions separately for each
> VCN instance, so that only the given instance will be powered on/off.
>
> Patch 18 is VCN change to handle idle work separately for each VCN instance.
>
> Patch 19 is to set powergating state by VCN instance in amdgpu_vcn.
>
> Patch 20-26 update all amdgpu_vcn_* helpers to handle vcn instance. All functions
> are now only handle the given vcn instance.
>
> Patch 27-32 update all vcn ip callback functions to handle vcn instance. All functions
> are now only handle the given vcn instance.
>
> Boyuan Zhang (32):
>    drm/amd/pm: add inst to dpm_set_vcn_enable
>    drm/amd/pm: power up or down vcn by instance
>    drm/amd/pm: add inst to smu_dpm_set_vcn_enable
>    drm/amd/pm: add inst to set_powergating_by_smu
>    drm/amd/pm: add inst to dpm_set_powergating_by_smu
>    add inst to amdgpu_dpm_enable_vcn
>    drm/amdgpu: pass ip_block in set_powergating_state
>    drm/amdgpu: pass ip_block in set_clockgating_state
>    drm/amdgpu: track instances of the same IP block
>    drm/amdgpu: move per inst variables to amdgpu_vcn_inst
>    drm/amdgpu/vcn: separate gating state by instance
>    drm/amdgpu: power vcn 2_5 by instance
>    drm/amdgpu: power vcn 3_0 by instance
>    drm/amdgpu: power vcn 4_0 by instance
>    drm/amdgpu: power vcn 4_0_3 by instance
>    drm/amdgpu: power vcn 4_0_5 by instance
>    drm/amdgpu: power vcn 5_0_0 by instance
>    drm/amdgpu/vcn: separate idle work by instance
>    drm/amdgpu: set powergating state by vcn instance
>    drm/amdgpu: early_init for each vcn instance
>    drm/amdgpu: sw_init for each vcn instance
>    drm/amdgpu: sw_fini for each vcn instance
>    drm/amdgpu: hw_init for each vcn instance
>    drm/amdgpu: suspend for each vcn instance
>    drm/amdgpu: resume for each vcn instance
>    drm/amdgpu: setup_ucode for each vcn instance
>    drm/amdgpu: set funcs for each vcn instance
>    drm/amdgpu: print_ip_state for each vcn instance
>    drm/amdgpu: dump_ip_state for each vcn instance
>    drm/amdgpu: wait_for_idle for each vcn instance
>    drm/amdgpu: is_idle for each vcn instance
>    drm/amdgpu: set_powergating for each vcn instance
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |   22 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |    5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   41 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   24 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |    4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |    6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |    4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |    4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |    4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |    4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  338 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   24 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |    6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   14 +-
>   drivers/gpu/drm/amd/amdgpu/cik.c              |    6 +-
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c           |    8 +-
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   10 +-
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c            |    8 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |    6 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |    6 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |    6 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |    6 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   16 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   12 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |   12 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   14 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   12 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   16 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   14 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   12 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |    8 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    8 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |    8 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   10 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   10 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   10 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    8 +-
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |    8 +-
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   10 +-
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   10 +-
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   10 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   20 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |   20 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   20 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   20 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   18 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   20 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   20 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       |    2 +-
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |    8 +-
>   drivers/gpu/drm/amd/amdgpu/nv.c               |    8 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |    8 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   10 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   16 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   14 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   10 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   10 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |    8 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |    8 +-
>   drivers/gpu/drm/amd/amdgpu/si.c               |    6 +-
>   drivers/gpu/drm/amd/amdgpu/si_dma.c           |   14 +-
>   drivers/gpu/drm/amd/amdgpu/si_ih.c            |   10 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c            |    8 +-
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |   10 +-
>   drivers/gpu/drm/amd/amdgpu/soc24.c            |   10 +-
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |    8 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   10 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   14 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   23 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   25 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |    4 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   16 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   20 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   12 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  140 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  124 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 1154 ++++++++---------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  909 +++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  801 ++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  727 +++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  782 ++++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  690 +++++-----
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |    8 +-
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |    8 +-
>   drivers/gpu/drm/amd/amdgpu/vi.c               |    8 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    6 +-
>   drivers/gpu/drm/amd/include/amd_shared.h      |    6 +-
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |    4 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   55 +-
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    3 +-
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   18 +-
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |    6 +-
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   10 +-
>   .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |    6 +-
>   .../powerplay/hwmgr/smu7_clockpowergating.c   |   12 +-
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   12 +-
>   .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |    6 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   65 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |    4 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |    3 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |    3 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |    4 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |    4 +-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   24 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |    4 +-
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |    4 +-
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   19 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |    4 +-
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |    4 +-
>   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   38 +-
>   112 files changed, 3442 insertions(+), 3433 deletions(-)
>

