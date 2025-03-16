Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF98C282DE
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Mar 2025 15:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE3810E198;
	Sun, 16 Mar 2025 15:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N2v8POcI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7689010E195
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 15:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMnOpZa1cOKit8lRldk7zakvQaquEzCc7huGnsk+ZjpxwA+8X97N3PpjUd14ml9g/LFownvzeWC6RSgLQDTfTWbB8WUT7G9FhwEc9wPFtJZU7SIkvDGcyXSBHmd3npDNh+VamXUz5OTiMFRWS9P1C9IPap+QaVku+AgjTZND+i30shLsy3SWjDMXh/lWozVKTYxlwqe7fWXWaCNRkfAjuEKcdaFNjh8NiVwr47QG1lvPPoMZuS9NtX0n4W4fDGrPYiasxH4LbefQcYFjkD4NWSuiZCiUihFgYNiMmEdxyzujO33pl7/1NSFHZn0yZFUzaF7CG8DOe1VGycNI+by4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLrYNtu4C+wVcWV2Fdb8ZCo+GvNaLq87FC2SEvRF2xs=;
 b=MgKWCVw0ykl3pyrPPnoxmBF+lD9dyKU8mgy0CVjoHhW5gUxkKQ30ntHrw6FnUGYy5zoLDAXY0SuVMrmUFAsfhI23p6qzPMZxfXSqGLzkZjbSj5wvYhtyioNj511BLauCxSglMBqHI+O2BOsyWmz8Tx84DdhTRtl7XTu4ZtZOL7xIpHHpgRoHvy/6fG1TydiAOqTSvPDkNkpFiZFgWRQ12CeaoZnC/jeT4fahzDMP3vNCRZNNdhzZvKEZ6fBZwobECIRX+nE+APE9Q7moCcAOExGb98naLw9Kr3pkHzaCW9R899Udadw7SQS+qDuYOexdCSD/+il2lPP9P9s0zlZ4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLrYNtu4C+wVcWV2Fdb8ZCo+GvNaLq87FC2SEvRF2xs=;
 b=N2v8POcIy0rrYINOvQ1pwuQqKqb0NGJ8Ko060kKwb08/OZ9zhArgqzxw+IWmz3VCf23KInyG809iCYS6Oc1vORr0SonZPm2hajckdyOd4AAkExZsiAg5G85kbKj9rCE2Z+7WhIkk4xbxOUv80n8+CmdulqbPE48RekDtj0r1THQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Sun, 16 Mar
 2025 15:43:19 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%3]) with mapi id 15.20.8534.031; Sun, 16 Mar 2025
 15:43:19 +0000
Message-ID: <76b1e78a-d1dd-4866-ae65-61e70281929e@amd.com>
Date: Sun, 16 Mar 2025 21:13:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Wait for pte updates before uq_resume
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Koenig Christian <Christian.Koenig@amd.com>
References: <20250316153635.1181513-1-sathishkumar.sundararaju@amd.com>
 <20250316153635.1181513-2-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <20250316153635.1181513-2-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::23) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9e8390-69c1-4d1e-1dd1-08dd64a14667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmdSdGlCRjZYbFY0NmUwZVpibmQwdzN6NGNhN2U0cDl5YUc3UlBFb3FyeDJE?=
 =?utf-8?B?KzBLaVd5aERET09oSjd2eUJITm11RHo3TTFoc3J1a1VvRHVIM055V1JNVlM1?=
 =?utf-8?B?cDlZRzNmWE84Q3RZdjBrcVp2Y1c5UGxOMUJSTjRBK0dPeGdMaEUzZDE2Q1h4?=
 =?utf-8?B?QW1vTFZhcjZ0clpVRU1RTlp3SWZUMm5WaXRpZDkzbUo0N29UeGovaTJHN0lV?=
 =?utf-8?B?clFwR0xXK1ZXVmw2a3kzYll5M1FFRG1TM3pKbVYybVNRVDZBMjZGbERGMFZP?=
 =?utf-8?B?R1p0WW5JWFJwajlFOVJ4enQrUlJ2aDN1c2ZocXErUUhpQmIzc3l3V3FtcU9L?=
 =?utf-8?B?WDB3QjRYTmV4RnhQaHpEVjN0c3Jwd2d1d1JTazFKKzJNMUp2aG8xQWhZSVBM?=
 =?utf-8?B?eFhXcXBvU09yUGVCclNxVnZMWXEwVnQ3N04yMjVLZmoza2RsSHJ0akN0cnN6?=
 =?utf-8?B?Wlp2RnJNQXUzZk9mVkpiV3lTUjlXVmtSRnNWQnNIT3hjMmgyRlM4UmxaVlQz?=
 =?utf-8?B?WW9nL1V0ZldFMDREZ0czaG9CckZhUUtKLzRCMkVpRjN3L1E1T1NzTUdXVE9Y?=
 =?utf-8?B?TTYxWDgzSzhSTDl0UFViRU0wazdsUXZoVllrdDdWdUxFTEdQQkxhUXhoNldK?=
 =?utf-8?B?NEtDZVBuRS94cEgrdktWWTIrNmptSkZBdEpXWTlvdk5PcitMd0lKWHBWTDEw?=
 =?utf-8?B?SXVoUlVuNkF4TEFIcDBVZXZOaW1vTDZlRmNDSGpqelgxRCtKazNLZERBUzdX?=
 =?utf-8?B?L3lsUXRrbDZ1TjgrTHl3bkJjYTFkTmZmWW1CallJY09aQWYvMjdQMGtSdUlQ?=
 =?utf-8?B?YmhyVHU0REJJYVZiYW9rTmpuMTF5Q3pvRnh3UzlLZktVd1VMSE5kT0VWU3ZR?=
 =?utf-8?B?UExRSkEyNzlDSSs4cW40ZUhaVXJRcEhVY25TTHNVSWR5Z21MM2tVc0M2S1Jq?=
 =?utf-8?B?T0ptYjB2MjN4bTQwVjI3TGIxUGtyR3U1d3lGTm54SDV1U2tZQytjNkthOEg3?=
 =?utf-8?B?SUJ1dFk1ZTMyMnAzY3pxbVRNR1ZMM3djV3N4RnBmMVBBSTlzT2I5QzMrYWZx?=
 =?utf-8?B?NmxULzZiQTJ5UUZiQVJFNFhlWDFjMHoxV0w3N1BpTHZTU3NYQUh3ZlNoWmM0?=
 =?utf-8?B?NzNISmdrMkJSN1ZVZTcvK2wveFRzMHZKd205dG1KcmNQZE5zQldCTUFHOGE2?=
 =?utf-8?B?N3BCeXNnbjZvUEtQTHBtanhLcXN2VDYvMXYyd2diVU5vQWFCVnlVd0s2MUI2?=
 =?utf-8?B?bDNXUVBDRHlXR09WVlRhTCtwMDBqdFhzUDZPMzBoVlFxRDd2ck9LVjNoWnIz?=
 =?utf-8?B?enROSnBROUFYbHZucUI1d1JHOFhwRkdoSktzd0hKVFZCdjBoeDg2R2wxbEFt?=
 =?utf-8?B?MkgwT3hSOUtuWm8yV0R0WmRPeFIwQS9LbUJhQ3JXcjlmWU5rSkpQZzdxYWFt?=
 =?utf-8?B?SVdIR29tN2RidGVpcnhSU1NDRnVoOVIyWnJJWS9uczJPc2Y4aktya3ZHR1FK?=
 =?utf-8?B?aE5hK1JJdVNZVXlDbXo1QmEwcXlhcU51Q3VlOVI5ZGZURVg5WlZJNS9td0tO?=
 =?utf-8?B?SVpsZHhkZXlSZzFLMVkwWHkrenM5SCttWGg0QXJUeFo2RDRZM0dDWHp3Ymx6?=
 =?utf-8?B?eXlsc1NuNUtnUkhvaXBYKzMrRWVmVVd0Skg4NlZwUnZQc0NjSjc1QU9ma0pS?=
 =?utf-8?B?R1pRZlhkZFdFbW9RN2gzV2hIdEFmSkFsb29DSEhSRUxTT1VlaGVvMG1LUHVl?=
 =?utf-8?B?R1JXVEJ6Yll6b1dKYWFQd1piSEJBa1ZvR3VaQlZ6UFIwcktOL3lSaEhrTzlC?=
 =?utf-8?B?SzRCYzR5ekdVL2FRbEoxc2ViRm5HUlc5UXdNSmxiV1VSTlMzRit6RUR0TnNI?=
 =?utf-8?Q?nU75XdkeiM5fd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHRZdjB4QmpUcCtkZXRvNm96cjQxdzh5Nnd5UmlCYzBubjdxblptYUZ5WVFv?=
 =?utf-8?B?S1Flc21rZHcya3VLN1JTb2pTS1hlUlBhQXNEem9YUzl3d3FjdDIydkt6ZDdn?=
 =?utf-8?B?dzdYQlppZWJrNmpMZmVGQzRHeVNvbTF1Qy9MU2xmLzh6QUUrMFVvZlNEV0R1?=
 =?utf-8?B?OU9ISjcxRDd0WEpENENtbkZRdUdMVW1hOUFHaDFpV0kya3piSXIwWnRRekR4?=
 =?utf-8?B?NnNNSFBmbXphRVdyY0UyMUtRVzI3dXJOcmJhcnpzdDQwZDUrWTZmYlJmRkF3?=
 =?utf-8?B?czIyaWM0OUtmUkpyaGF5c2QxSmlDRlNNNWxRSmpCOXExS1pMc3ZXbkQwZlRR?=
 =?utf-8?B?cDljU1R1MVhsWnh6bHI1VUtkL0NXbGpxUjM1endVTkpjcjJzM2lMK1VzbjFV?=
 =?utf-8?B?N1BDeUtiUWRieUgwUEpjZ1VtV0ZzQWc5RWdQZzdWWlJxdzhJQ0JqSWZ5dnEw?=
 =?utf-8?B?Nk0rZU5URkMrakZ1ZzlpdytYTllFUTNlNnRaWDVhdlQ5RHZ3eVY1dTYvSDhp?=
 =?utf-8?B?NlRNRVo2U1M1ckxxUzBWU3BKbnlkdnBsK2s2OHBIV1owYlRiQSs1bDZwclFy?=
 =?utf-8?B?QUVkYlo4cUl6clN5ZzBETk9jQ0tIblQzcWhkSENNYUp3WitvZFkweDdrYTRk?=
 =?utf-8?B?dHdRaGFGbjFwRFA0VGlXYVIvRkhGYjVxZk1iZHdKTy9HaURnbGdYZVdGVGxt?=
 =?utf-8?B?VTVOdlV2K2RvakNMS0hBVHZya1NESEdENDIyZ3JwQi8wTTV2MVhTRDlTK3pR?=
 =?utf-8?B?K3RkZXBwODFSbXpWdDM1ZGhTN2NFQlIwazNrNCswaXk4V2dvcW5lbVFTb1B1?=
 =?utf-8?B?UkZDdWxTRnZHL0ovSUtuOUdHWGx1R1FuUG5ySU9KOGFjaGtFekpHQXZEZU5r?=
 =?utf-8?B?VndmZWlOcjRUcGYvbVBWRjFERloyTnBOQWhIb2pqNVlRZUJrMFY5TXdialVs?=
 =?utf-8?B?Z0JyS3FtL1ExT3d0R1g0MXQ5cG5ubHhuS0QyVnVwdWJ4VENrZkt1T2IyZkVx?=
 =?utf-8?B?WWZaZnJycjBBVE9DYW5Xa3hZeFZrUU1MOUs5NWFvd2tZdUpoVExCRG15M1Mv?=
 =?utf-8?B?NE4wNjVkMUNJQ0tVak1Sd2lMdERqRWlXQi9hcnlqL0hsQVVrVDFpK05rU0Uw?=
 =?utf-8?B?MU8zb1lwT05ERDhaQXB2a3A1OUd0MjdIVjk5ckJtenlsMUZwTmoxaHBpeEU1?=
 =?utf-8?B?aHFEN1BpeGVnRjMwQ1hOcmxYS3FxUk5yWUZGOXBnT2tGLzVRSmVLdjJhTklK?=
 =?utf-8?B?M29CbVJKWVdGSUdIay91ODBETDNiZ1NHZTU5akExNzVMdVkzalEvTFJhaGJU?=
 =?utf-8?B?VTZ2Wlg0aGk4NDN3YlVVQUxjZFk4QmJ6UWxPNGMwSkJYT1V5ZU1zSm9DRnpE?=
 =?utf-8?B?TE9kUkZic2dIRVF1UjhPdmVEenNLdm5WSk1mb2ZWZmFrSkt2MlBmYm9TaVpv?=
 =?utf-8?B?bUwxbkxaaDE5M201cTBvcXVSMEgybEI2bEJ2UkRNTkFjNXVmR1E5M09KZmQw?=
 =?utf-8?B?aktiQ1RORlBUN0tIUUlDc0lBZ2M2eFpxdUc5T2RtbHA3ZXZ3Y3U3SFBSbVFC?=
 =?utf-8?B?cER4R2NrTFJRdDc5akxBOERHU285Y0xqNmJXS0UyRkFUTkRPYVBPcGlnY3dO?=
 =?utf-8?B?Z3JacDd6bTdPeXNJUFNkN3BlaUltVnNSQzJUNTNFemZTakMyV0huazNRZytR?=
 =?utf-8?B?cGxmWFlNM2ZjYU5BN29DTWZRU0t4UlFOODlMK0hxRWdZTDF3ai9Nci94c3Qr?=
 =?utf-8?B?ZWwyTlFxNndZRGQ0QzdKQ1hWR016NkhMcjQyajVIM0ZyZWY3Ni9mclQxeE1Z?=
 =?utf-8?B?QlhDaW9oVWJYVjVXRmlQdGFoR1lnclFaL2hXaGNNaXFvMHFqRG5SclJ0cXo4?=
 =?utf-8?B?aUh6SlRkNkY1eVhjK3laVUxtTEg2anpDeUFwbnpGUXRMY3dPbnpHRTJRakFU?=
 =?utf-8?B?YjhMd2xwa2VRMHBGbE5LREYvNTh5dk1GSFBtOHpIUWs3bzN0ZTRBUGJ0TGVv?=
 =?utf-8?B?dmpBZ2JpU3BjT09oZEtyYnZNRWkwbWxyaURWYXUrR0JVWGtWbUtya0d2Y1A1?=
 =?utf-8?B?RUVXQ0M0NEsyY3FFRm9PZ0RDcS9MSkxNRkovQXBaMTVxd0poZG1CNWt4ZHhZ?=
 =?utf-8?Q?4z/0QlXaXxDRysdMBh1rOmeY4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9e8390-69c1-4d1e-1dd1-08dd64a14667
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:43:19.3261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RSWmEaS1XlZJE/A4afFB9MxYhLTl0o8qx3cgGnzOy40x+OUJUXHvT1YNnoF0nvM+0UsN46Ipqfb2XfXIbLOuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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

Please ignore this, will resend an updated version.

Regards,
Sathish

On 3/16/2025 9:06 PM, Sathishkumar S wrote:
> Wait for vm page table updates to finish before resuming user queues.
> Resume must follow after completion of pte updates to avoid page faults.
>
> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
> amdgpu:  in process  pid 0 thread  pid 0)
> amdgpu:   in page starting at address 0x0000800105405000 from client 10
> amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00A41051
> amdgpu:      Faulty UTCL2 client ID: TCP (0x8)
> amdgpu:      MORE_FAULTS: 0x1
> amdgpu:      WALKER_ERROR: 0x0
> amdgpu:      PERMISSION_FAULTS: 0x5
> amdgpu:      MAPPING_ERROR: 0x0
> amdgpu:      RW: 0x1
> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
> amdgpu:  in process  pid 0 thread  pid 0)
> amdgpu:   in page starting at address 0x0000800105404000 from client 10
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index f1d4e29772a5..4c3edd988a05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -541,10 +541,23 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
>   static void amdgpu_userqueue_resume_worker(struct work_struct *work)
>   {
>   	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
> +	struct amdgpu_eviction_fence *ev_fence;
>   	int ret;
>   
>   	mutex_lock(&uq_mgr->userq_mutex);
>   
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	ev_fence = evf_mgr->ev_fence;
> +	spin_unlock(&evf_mgr->ev_fence_lock);
> +	if (ev_fence && dma_fence_is_signaled(&ev_fence->base)) {
> +	/* Wait for the prior vm updates to complete before proceeding with resume */
> +		dma_resv_wait_timeout(fpriv->vm.root.bo->tbo.base.resv,
> +				      DMA_RESV_USAGE_BOOKKEEP,
> +				      true,
> +				      msecs_to_jiffies(AMDGPU_FENCE_JIFFIES_TIMEOUT));
> +	}
>   	ret = amdgpu_userqueue_validate_bos(uq_mgr);
>   	if (ret) {
>   		DRM_ERROR("Failed to validate BOs to restore\n");

