Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B5BCCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 21:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C38810E9C1;
	Thu, 30 Oct 2025 21:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xg/QaG/R";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F5C10E9C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 21:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqykPVNPivNQe4WY/vZGSniyknZgocOHecCfrC+wSr5kVWf3zjfzd+DOcz18xFR3cYZvSRf8h3CqNOxHO0rmQq7iNp8ap0YZRpn23ZkiopaTQBIXZdjHPSxwVB3xRS82JZ2aZ6G4BflSIiyiB7vX51fKVYDsx6TzM20yuU5SbX7Sx/oz+SV//JSnEBzlF/jqmUWyaOHnwN3MGkyABeknjWIrqAlRVSvu+FvqQVhHCyjmghQcDiXnjxMDMHAwFvpAIeV7vk5AFPmK+ZOLwwzxjN8Yi+8gcXyQN/YgkTzVwrmFxoRo4/+K+mSKE1Rt57bs9tdJYcKbzieEDZVbKW67iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7/N+ilRo14T95o4coOxtilaDlXI2ecGB4eROOO7/fo=;
 b=ZVxNPDG1uoGhRg/Os731xRnQSiAoITqh8dhIrLlTM0acTjj2lLvtIPQDLDtlI4dMDn6cZpix3EvDW7KbTEA4KIof0JlTOp2O0HNZ6oGhtKcKeJkGJZs4XD1mdcVih5jAbKosZvA2lYB8UzcYIhaYW4O2qRAKa3ladcUj1TYlLXEVLmb51jB9+zIBMsHpHy9I0gRD0ecvt3CRKSDZAGDrg4iCfRGwWROTdhirE/51EcdsMv/TKS41teDvQE2AFGgyHpaij43iFXKxfQrWVpBd6JaC6MSVBSzxZDS2KDVOYB/SvDpm4pOztk/JALjJEhef+K5NdWXUZZDDwGqL+gO+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7/N+ilRo14T95o4coOxtilaDlXI2ecGB4eROOO7/fo=;
 b=Xg/QaG/R+83DyJzhPJaFZkg360cCV+cgUTmJ9u5ETKVL6zenaX3ZO1WbQvoDNWTWz7UfsmfEvy007miOES/b2TK5gIhF9trsDNvpc0d3WX6Fo6hVBI0eN6GFLAOkR73IyLGOZ2PpphRaLhuz7Nf5QUrE/P0NvXFmxt2lADqnQdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 21:15:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 21:15:35 +0000
Message-ID: <9598909f-1d07-4df8-a09c-ec3e25727b72@amd.com>
Date: Thu, 30 Oct 2025 17:15:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/18] amdkfd: Implement kfd multiple contexts
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c44125-c244-4c30-177d-08de17f9774f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2QxWDJlZ2I0WWRaOWVEWmtBdm9qTWgvTnE2VVQ3WHAzVThMUlJxZ3lyMFJI?=
 =?utf-8?B?WmYxVW1acGdpamtVZ2t6SkxrdWx5dyt6czdwTXRzNU1Pczdwd1FpSE9qcFpu?=
 =?utf-8?B?ZlhTVmtMa1dqVEdYQVZSSTEyZ2J3TnJYMWRKRGxYTEVtUitnN2NlS0ZValRj?=
 =?utf-8?B?cTY2SkxMVVd3NU1LdDlwUHJlUlNrcUFSRE1UKzRwN3VJM2lzbVdaYmtMZ2FF?=
 =?utf-8?B?OEhoUjBBYVJZenlwZmJBVXM1VytJMjdRamluRUhrMlloQ3ZCZDdVUCszRVgw?=
 =?utf-8?B?Wlp2NW8xYzMvbG1VSHJMZ3R6TVYyZlFSVlB3ZnBjcUpEck5yYVlrNThvVnIy?=
 =?utf-8?B?SHpYVTJpaVRiRWgwN1dwYnJKWlZCS05xalJkbVpKdHJ4MS9BNE10V3hUTjBn?=
 =?utf-8?B?WjRSc3VaOHVON2xmUENoZnpsQXUwSTFGUEFTblZSN3FWUHhXVUJaYzJuZkVx?=
 =?utf-8?B?dnlqRVU5RkpYd1kwWnhpVXZiV1Q4MWhvREo4WFlReHNGZVpsdEpIbS84RVlU?=
 =?utf-8?B?ZlZLRFZCaUxwWjk1RXJuU2UydUZyVXJySjBxZ0NGUWcvbC95MEszdDZNYnc0?=
 =?utf-8?B?TlVYeG90STRYSngzY2hMNmI0ZHB3cW4yODQzUkJyWVdJNHFoRjQ4RDFpaW1C?=
 =?utf-8?B?VGVqaVFwRUxNMkhkazAvLyt1LzJjdjZNZ2UxQzlPQUo1cE1NdHhVNjlyeno3?=
 =?utf-8?B?L0JaRy9yMG04bElkNkJnS3NBVzRIRjlNcFVNT2U0eldFQWFCZFB6c3I0UFlx?=
 =?utf-8?B?K2ZKQ0toVUJTWmdIaFdoUm9vaVh0azlpWDF6NE9nakl5T0piUmpHVUpncElz?=
 =?utf-8?B?YU96RU9qbWw1N1ZzWThKU0U3bDEwSTIwUXVEMStQT09rZURoMHZLRjRLSWFk?=
 =?utf-8?B?VmtyMjFudjVGSmZRWDY0bjJDakZmbnVaTW9hUDEvOVJhdHBnWlNjc2VLNFhk?=
 =?utf-8?B?eEEvVXJZb3J2QkhXaEUyK2szV2g1aFhldG9UVDRWRHJpVnFrYlZTUy9Pd1Ra?=
 =?utf-8?B?VVFLYjZLWkpTQnpHcWd0RnplWElrcmlZVllnTGU4VStyblgvWmQzOHVKa3lY?=
 =?utf-8?B?YzEwOWVHZ2YxbkhuR2JmYXRickZOZVBFK1BYNURCbUVEMkhCRGxra3pFc2cv?=
 =?utf-8?B?bkZ2VVdvOVVCRDN0Yi9GaTJmUUU0Y3h0N2l1M1pxbnlURXI5TmUvUTc0Mnpz?=
 =?utf-8?B?S3gySllEWTBQRFF3OXpRMm5JcEpsU3BObTQ4UTdDa2NHUjJ1UUNXa1hHYUwz?=
 =?utf-8?B?Z1pCTEM5R2ZXUVA2NCtIQUZibXpHTVM5OXo0L3l5TzBDdzFVci9yWmM3Uktr?=
 =?utf-8?B?QjR6djZBM2NBS2R1VTgwdjVRU0ducSs4NHNzOUxRcHNyWUdhYUFOS3pKMzcy?=
 =?utf-8?B?RTZCK0NRSzBKdktpbWcvTURrUUtKTHg0YStveGdrMFFzdTVtS3R2U1YrYUx5?=
 =?utf-8?B?VGZMcmo0bm94N2VLYXFERVhpOS9YKzBRTlU4di9rbnlZc25VaFlub0lGM3Bj?=
 =?utf-8?B?UURFelR2MGFjc1VqN3AxcnV6bmF2cDc1Y3pRSzlDUkdjbmNlemtldFFsVDQ3?=
 =?utf-8?B?b0doVTMreUhGRm1YMmZBdG9ZVkZ5TnBnTTJBNmhQU2ZLRklGMUdCZytjNFIx?=
 =?utf-8?B?RDJKMCtkRUEwWE1VRHVPOEc0V0pJejRrVnVGNmxxMi9QSGloa05mNnFoaXBk?=
 =?utf-8?B?STRkbnRkYkYrTHRRZXd2RkhoSTVrT3UvN0hZM1RSNk9mZ0dQWFpKWGRBaVRj?=
 =?utf-8?B?ZGo4VkU1ZCtUa1JNWEJCYzM0aEVHRWpwb3ZXZ2YwOXJhRXlLcm52R1JHMmxk?=
 =?utf-8?B?dk5zT2JRaFlUNXBpak03Ry91Zks4QndGWUZMNzRFT0Vic3pFMnhCS2lzUGl2?=
 =?utf-8?B?MHNzWGJnSW50Q3pVZ0xybk1ETGwvcjhpSDEySjE2WHFDbXZPeEkxd2t0SUpl?=
 =?utf-8?B?RjRaMXRjbHl3TnlZaWhtVFg1QlA1ektRbXBBTUY2aUhMWFJuQ2VWNXphRGV5?=
 =?utf-8?B?M2hsVFcvMTZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmIwbDdOYzIxazNPQURPekhrVUF2NWxCRjRQN29qRGdPb010VlhlSmRSa1RM?=
 =?utf-8?B?YkNRTUFYd25LOVNUV3hFbFUvV05LdTdtZ0VDNU96VSs3c2JWejllOU1jdmpR?=
 =?utf-8?B?Z3k3dWZSMDdOdGZvK2hUcEtGZi9tbHdKNVNYdTlsZzd0ZG1VRXJtYUtnZkdQ?=
 =?utf-8?B?MzhYZmxZcXFpQ3c0SG5QY2JRVjJycUt6REhlUmVZN0NlYVFURXgrSnhqNEd0?=
 =?utf-8?B?cDF5dCtyTHhvWU9ORkRHU2Z1NHU5RllBNzNYUnZRSnR0U1NZeU56YlpBVStE?=
 =?utf-8?B?clFkZlZrT21lbkdoQUVkUmZnMDhXYWtWcFRkaVVPS0cxVXV1aEJzMlRIbldN?=
 =?utf-8?B?eUt5RDExa1JmYVdHMHpnUXFvNGxIdzdnOHFJOHpheXpBVDhQSXgxUWFicTB5?=
 =?utf-8?B?bFRsR1pXWC9CNnhqQ2Fpa285RlE3N2NKRTZMQlg0TVBEWVN3aURFRWh6V0k0?=
 =?utf-8?B?eFNkM1huaFU2cE1IUnE1WHJpb050ZTA1Z0NPUWlGM1E0STJkRVV1UFhsTVU4?=
 =?utf-8?B?Q3Ava3gxZmdBUlJvdzFrdkhxSTI2V0htaU5YdzMvSnF1blpQUmVjSzlHMXFT?=
 =?utf-8?B?QnMxTjl0ODhmVkh6a1BSYW0xZC9sL3RJSHU4U3pqSUNIZktKY0l4bGRPVWZF?=
 =?utf-8?B?bDJueWQ4ZDhMUno2ajV1QXdBaVhIcmtMZHN2UGwrajVMdngwSWM0TENzam5S?=
 =?utf-8?B?MVpKVFd2aVR4OWlGSXhBd29lNDJkT1RtVzF5c2p4MjlaZmJJNnJrYXdzUUdX?=
 =?utf-8?B?ZmNTb3FVZnJpdTl2WWJBUm5Nd29EcFpETk9rM3Q2emtSN1UxYzdMOThHSCtP?=
 =?utf-8?B?RU4vd01BWWhqbXlTY0ZQc3RzZkxkaTVlcWkrbnMxanRNbEdEUGFVUnIvQUFv?=
 =?utf-8?B?WWl6OGw5M016ZVZsblpIYTY0VzRHeTFPN08vM2diS2x5NWhRdTVtZFNsY2RK?=
 =?utf-8?B?dURHL3grTEkvVnlMQ1YzTFhHWS9QODJYWE5LTldseVpNNitkYTBBWTRZdHBw?=
 =?utf-8?B?bTRkZG9Vb1RxejNNLzJEdGtQb3gzNVF3cDVBS3Z3YWNHbUo1WEEwRjdFVW0y?=
 =?utf-8?B?THJJWkthT1VDaEo5cjBDR0pGL3ZSK1BxT2ZtRFhVRC9GUmtEb3lVbHZUSGNE?=
 =?utf-8?B?WXduN2NMenpPaWN4R3djK0duYlozeVl4MnZlNDNhbnFQRmxHckxTV1o4M3Mz?=
 =?utf-8?B?WmgzK3d6V1I4QnlzN3J0NjNrZ2ZpTEErWTFPcVRyQ0UvS1R1NGpyT3doOGNI?=
 =?utf-8?B?OXE0MHF3aHJFM05NWUxEeWgwSkg0d1VKeERlVGsyM2xybXNKbTFRdUZNeWhP?=
 =?utf-8?B?YWpwYVZ0SFd3NzhHMDk4T0RBWUJMNGpSOUVKNkNUbWRhWmJEayt0L1JyVnhL?=
 =?utf-8?B?RUdMeTlIZDZwRGpBV1l3R3VLRDZXaU9hU3Q4YWlRcFRiUmkraXBoRXhoS2dD?=
 =?utf-8?B?UGRmY3hzU2pUWGFydkhGV0pFZW91a01sU28vZ1J3UUxFYnVWZzJVYW5RMUlS?=
 =?utf-8?B?WmZzRHQ2Qm9OcENWaXo4OHlHYXY4TjRsTDlkWVpHditoY0lSNENPRnRabWZB?=
 =?utf-8?B?K0lYb2lVZUdIVi93MTlycFFqRnNkR2pLMTkzZzRLZnlodHlobnF1cCs5RCto?=
 =?utf-8?B?UGhQQkJHeURaTllFVXJTR3hOM0tCWkZSZ01FMU5TeXlQUFh1UEluUE0wb2tN?=
 =?utf-8?B?eEIrM2s1TkRRVzdxN0pwNWlMNGlRRWFKN3crU0J4SlZnanQ3cjlRbUErUlc3?=
 =?utf-8?B?RHprSmM1aFlXOEtoMTM3WHM3TE9FdlpHcnREQ2VCUGpsZTVXRDNsMENoRE5y?=
 =?utf-8?B?Z09YbjhiUndWNjJNTWNuMVJPUk9GcEdJeFVRZ09USXdkek8vc2YzWXQ4cExK?=
 =?utf-8?B?UGFsdnBybnpFUVBTeFJKM3BJT3BlVmJFN0FpZkxFZzhYWWRTRjVadVoxZEJ1?=
 =?utf-8?B?ZXVDV2Jjd3NyeXA1VUFSY2RDVTQrc3VVMGdQdjF4OEZSTGpzSUZqTlY5djQr?=
 =?utf-8?B?UmR2bE5yNG41ampuamJyTWpxTUdwenJlWXdlTHRDSXNqS0s4cGkwM2FxMDNU?=
 =?utf-8?B?aDgxRUVwMzJWcXozSVJDUkExekdWVHB2QkwvWnFyWnlYeUVQclg3bzdhdjNQ?=
 =?utf-8?Q?FMGDDTZdkf7tiGLy5q9kkOaLd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c44125-c244-4c30-177d-08de17f9774f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 21:15:35.0951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsEF+HYfrPhHdrSZbnFqjrqq8FQj0eOtpUEjkgdKpCWjTJed40IEi4m//vZOCr9LxplP7M5QRyxnz0z268FyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
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

https://github.com/AMD-ROCm-Internal/rocm-systems/pull/78
https://github.com/AMD-ROCm-Internal/rocm-systems/pull/110

This repository is not publicly accessible. Can these user mode patches be pushed to a publicly accessible repository?

Regards,
   Felix


On 2025-10-22 03:30, Zhu Lingshan wrote:
> Currently kfd manages kfd_process in a one context (kfd_process)
> per program manner, thus each user space program
> only onws one kfd context (kfd_process).
>
> This model works fine for most of the programs, but imperfect
> for a hypervisor like QEMU. Because all programs in the guest
> user space share the same only one kfd context, which is
> problematic, including but not limited to:
>
> As illustrated in Figure 1, all guest user space programs share the same fd of /dev/kfd
> and the same kfd_process, and the same PASID leading to the same
> GPU_VM address space. Therefore the IOVA range of each
> guest user space programs are not isolated,
> they can attack each other through GPU DMA.
>
>
>   +----------------------------------------------------------------------------------+
>   |                                                                                  |
>   |  +-----------+      +-----------+      +------------+      +------------+        |
>   |  |           |      |           |      |            |      |            |        |
>   |  | Program 1 |      | Program 2 |      | Program 3  |      | Program N  |        |
>   |  |           |      |           |      |            |      |            |        |
>   |  +----+------+      +--------+--+      +--+---------+      +-----+------+        |
>   |       |                      |            |                      |               |
>   |       |                      |            |                      |        Guest  |
>   |       |                      |            |                      |               |
>   +-------+----------------------+------------+----------------------+---------------+
>           |                      |            |                      |
>           |                      |            |                      |
>           |                      |            |                      |
>           |                      |            |                      |
>           |                   +--+------------+---+                  |
>           |                   | file descriptor   |                  |
>           +-------------------+ of /dev/kfd       +------------------+
>                               | opened by QEMU    |
>                               |                   |
>                               +---------+---------+                   User Space
>                                         |                             QEMU
>                                         |
> ---------------------------------------+-----------------------------------------------------
>                                         |                             Kernel Space
>                                         |                             KFD Module
>                                         |
>                                +--------+--------+
>                                |                 |
>                                |   kfd_process   |<------------------The only one KFD context
>                                |                 |
>                                +--------+--------+
>                                         |
>                                +--------+--------+
>                                |     PASID       |
>                                +--------+--------+
>                                         |
>                                +--------+--------+
>                                |      GPU_VM     |
>                                +-----------------+
>
>                                   Fiture 1
>
>
> This series implements a multiple contexts solution:
> - Allow each program to create and hold multiple contexts (kfd processes)
> - Each context has its own fd of /dev/kfd and an exclusive kfd_process,
>    which is a secondary kfd context. So that PASID/GPU VM isolates their IOVA address spaces.
>    Therefore, they can not attack each other through GPU DMA.
>
> The design is illustrated in Figure 2 below:
>
>     +---------------------------------------------------------------------------------------------------------+
>     |                                                                                                         |
>     |                                                                                                         |
>     |                                                                                                         |
>     |       +----------------------------------------------------------------------------------+              |
>     |       |                                                                                  |              |
>     |       | +-----------+      +-----------+     +-----------+    +-----------+              |              |
>     |       | |           |      |           |     |           |    |           |              |              |
>     |       | | Program 1 |      | Program 2 |     | Program 3 |    | Program N |              |              |
>     |       | |           |      |           |     |           |    |           |              |              |
>     |       | +-----+-----+      +-----+-----+     +-----+-----+    +-----+-----+              |              |
>     |       |       |                  |                 |                |                    |              |
>     |       |       |                  |                 |                |        Guest       |              |
>     |       |       |                  |                 |                |                    |              |
>     |       +-------+------------------+-----------------+----------------+--------------------+              |
>     |               |                  |                 |                |                            QEMU   |
>     |               |                  |                 |                |                                   |
>     +---------------+------------------+-----------------+----------------+--------------------------+--------+
>                     |                  |                 |                |                          |
>                     |                  |                 |                |                          |
>                     |                  |                 |                |                          |
>                 +---+----+         +---+----+        +---+----+       +---+----+                 +---+-----+
>                 |        |         |        |        |        |       |        |                 | Primary |
>                 |  FD 1  |         |  FD 2  |        |  FD 3  |       |  FD 4  |                 |   FD    |
>                 |        |         |        |        |        |       |        |                 |         |
>                 +---+----+         +---+----+        +---+----+       +----+---+                 +----+----+
>                     |                  |                 |                 |                          |             User Space
>                     |                  |                 |                 |                          |
> -------------------+------------------+-----------------+-----------------+--------------------------+----------------------------
>                     |                  |                 |                 |                          |             Kernel SPace
>                     |                  |                 |                 |                          |
>                     |                  |                 |                 |                          |
>     +--------------------------------------------------------------------------------------------------------------------------+
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |        | Secondary   |    | Secondary   |   | Secondary   |   | Secondary   |            |  Primary    |   KFD Module    |
>     |        |kfd_process 1|    |kfd_process 2|   |kfd_process 3|   |kfd_process 4|            | kfd_process |                 |
>     |        |             |    |             |   |             |   |             |            |             |                 |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |               |                  |                 |                 |                          |                        |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |        |   PASID     |    |   PASID     |   |   PASID     |   |   PASID     |            |   PASID     |                 |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |               |                  |                 |                 |                          |                        |
>     |               |                  |                 |                 |                          |                        |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |        |   GPU_VM    |    |   GPU_VM    |   |   GPU_VM    |   |   GPU_VM    |            |   GPU_VM    |                 |
>     |        +-------------+    +-------------+   +-------------+   +-------------+            +-------------+                 |
>     |                                                                                                                          |
>     +--------------------------------------------------------------------------------------------------------------------------+
>                                                                                                                                    
>                                                    Figure 2
>
> The relevant reference user space rocm changes could be found at:
> https://github.com/AMD-ROCm-Internal/rocm-systems/pull/78
> https://github.com/AMD-ROCm-Internal/rocm-systems/pull/110
>
> Changes from V5:
> 1) change upper limit of ida_alloc_range() to KFD_CONTEXT_ID_PRIMARY - 1
> 2) in set_debug_trap ioctl, check whether the target kfd_process is a
> primary one after checking validity of the target pointer
> 3) in set_debug_trap ioctl, check whether the kfd_process which
> the ioctl is processed on is a primary one
> 4) in AMDKFD_IOC_CREATE_PROCESS ioctl, place filep->private_data
> and related code in the critical zone that protected by kfd_processes_mutex
> 5) add Felix's reviewed-by tag to the series except patch 8,17 and 18
>
> Changes from V4:
> 1) rename process_id to context_id in struct kfd_process
> 2) remove primary flag in struct kfd_process
> 3) reject set_debug_trap ioctl request when
> the target kfd_process is non-primary
> 4) other than default 0, assign context_id 0xFFFF to the primary kfd process
>
> Zhu Lingshan (18):
>    amdkfd: enlarge the hashtable of kfd_process
>    amdkfd: mark the first kfd_process as the primary one
>    amdkfd: find_process_by_mm always return the primary context
>    amdkfd: Introduce kfd_create_process_sysfs as a separate function
>    amdkfd: destroy kfd secondary contexts through fd close
>    amdkfd: process svm ioctl only on the primary kfd process
>    amdkfd: process USERPTR allocation only on the primary kfd process
>    amdkfd: identify a secondary kfd process by its id
>    amdkfd: find kfd_process by filep->private_data in kfd_mmap
>    amdkfd: remove DIQ support
>    amdkfd: process pointer of a HIQ should be NULL
>    amdkfd: remove test_kq
>    amdkfd: introduce new helper kfd_lookup_process_by_id
>    amdkfd: record kfd context id into kfd process_info
>    amdkfd: record kfd context id in amdkfd_fence
>    amdkfd: fence handler evict and restore a kfd process by its context
>      id
>    amdkfd: process debug trap ioctl only on a primary context
>    amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   8 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  10 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   8 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  90 ++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   7 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |   6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  61 +----
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 -
>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   4 -
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  18 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 239 +++++++++++++-----
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  39 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
>   include/uapi/linux/kfd_ioctl.h                |   8 +-
>   14 files changed, 304 insertions(+), 200 deletions(-)
>
