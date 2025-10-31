Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAD5CCF9F0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 02:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B6C10EAA8;
	Fri, 31 Oct 2025 02:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LlQmxXUt";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACACF10EAA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 02:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjNwlhBzzvT1kZy8cNWZrTsPuH0I0HZoC/PKHuap6eLUShOMib/mQ3xcD0oti9VvsOeefNX6NSHceasFSuyMk08WHa3dTHjWUmkCx8glFvWIVtQAMdeBaR8Zn3o+sVlnGV+Ga2lrou6h+0+ZL2ls+X0PMlDVaA3rdIvIruOZghRabsDKue7lbzD6eNIZ9K66kxCm0Av8bDqyp7l2xyjO6xZZOBFGCaUMgywd+N1lGILzEA537absRe4TabWy2LjtbcnKHOCiZ+OEB8XvLoq6PO4ltZEX1eZHrWP8JjVBr1sDT1VUVUqSIgTWAadcJaL/K3QPsW+fNw4pyGBYmULE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocP2CwR01jhktVd5vSJo9mBkYcqh32d+qGLYIlmQmiE=;
 b=U+uQQ9r4JcWp7XIA84jO44FKWEU7j5dK0g1Xd9z+77tqs9dUKcOMqIUV2Bn7Ur9g3W9qI8V9iOF42o4NRxiv6QzyNrrE/YgIhSQpZfvCRcllrrx2RSY4N4AvQutREfhuoi6B7kZBcWgZnJHFj7gCV/KnVhPh8hl3kJEqtvU3HhgsZjpKTM3dC82514xz8y/VYpP44YmJfEBr8eMt3Lqi2BCHF2WyPdsRqR9dcj4nQiiTijG4/WsepULhoTRF4OqD3Qjk08X6fhVwaByqa3JRnOvyIhrr46YjVC909pPSP48DxpVigQQM4dFz3OLrJVdXvg6B79dh3jvlp+9950GB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocP2CwR01jhktVd5vSJo9mBkYcqh32d+qGLYIlmQmiE=;
 b=LlQmxXUtAP6lfweR1vkQsIkdzgePO3bKcPNxrNhFmaiNQc1BY8Azpr+1CV1DJxgSdthYFO1Rn2iELQz9yj0LCk+IJM5tNspm3CQWWqVXMpG33u1n5RTHycmvyovTDP8dXrAvHM18wCPjAmVnRxA5bEsvXyDklKvfFD4nuiDf8+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 02:46:52 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 02:46:52 +0000
Content-Type: multipart/alternative;
 boundary="------------2iEcclunxtYTxG8Ct5TeP1J4"
Message-ID: <0f9ae20e-0e0b-4b59-9d79-f291ec4ef7c0@amd.com>
Date: Fri, 31 Oct 2025 10:46:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: implement per process/device pasid in sysfs
To: "Kuehling, Felix" <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251030034536.11356-1-lingshan.zhu@amd.com>
 <24133b30-07bb-4ff3-923f-02d5a421fab6@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <24133b30-07bb-4ff3-923f-02d5a421fab6@amd.com>
X-ClientProxiedBy: SG2PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:4:7c::23) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 62015e23-db6d-4659-115a-08de1827bf4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGN6aGovSzhUdjZGTjBOdW5jdVdHZDJobHJyYVVMdEpON2VyNmlHekxKTElp?=
 =?utf-8?B?MTVOK1JwWE5OcUlOeklsVkovQTliV25qMmtUTHMzUm5JY0czTHRERmd5bjdX?=
 =?utf-8?B?eVlIWGVjVy8rb1BzSGtIUXQwNkpuN2llOHg0bDFwY3hRYmNqbi9GWndNUFhp?=
 =?utf-8?B?dUtjOHlhNlBla3piOVdWcnlRcFJlTmhMelY3ekZVN0JDaXNRMFJyVmtjRzR5?=
 =?utf-8?B?Zm1oYmVSYWJwd0xKaUZCa1RGL3hmUFhQV1I1ejk2UElZb3BUSnFHeFhtSnlm?=
 =?utf-8?B?a2R0M1JLNU81Z1kzenRVSjhncHFvRDE0ajU4ZzJqTGhhSFNzSlhpQ1puRFhS?=
 =?utf-8?B?bTlzSTkwTnNHd25tcnlReDAzaU9EVXFNcWJrTmdWNElDL1pSdUt6MHoyRzRa?=
 =?utf-8?B?M1ZyM01kZkhETnRlc0Nvc0xhYjlCOElWUmczWTVtSW1KYlNReWExTlRTOGpr?=
 =?utf-8?B?Y0JXWFRJZkdNVHhrS2hXU2I0TEJjUVg0QTVsWjhMZTYwQUFJT2pKUHFOM1lt?=
 =?utf-8?B?bXF2czdqMFNBNndxSlVTWGRTYlJ1MXVQVlVjMERGU3VPd0NhaE4zQ2NTbTJl?=
 =?utf-8?B?SjMzcVJ2M0gwUERHZU1pdlNaYVpzWTJpWUNxWnB4UWx5WDcveFZQRWtVYlJU?=
 =?utf-8?B?YlVrYmUxTEM2RThKZ1ovaDgxY1VMR1BwZS9JMHdwNXpYSjluRW54TmhCWnI5?=
 =?utf-8?B?REYvT01veDJ3bGRIT09IMUdnUUZVV2h1OGF1SVNubEw4bHBzZWFYQjM4ditH?=
 =?utf-8?B?V1RZelFTMi9DZmw4dVVwNFJxRmE3SnpDUWpwM3VXcWpSSEtIQjF5M01wOUMx?=
 =?utf-8?B?dmZ0aGx4amZFeGpPNXhoNVc0anVFbHQzQWdITE1heHloT0RjaXNoTXJTNjJJ?=
 =?utf-8?B?dU1oL0dhK1VJdFJBRmphNXV4R3o4U1Fvd0E4emxzaWRwUGpybm43OFVvRXo5?=
 =?utf-8?B?Mm5Ib1l1MDhQK2ovMGkwWThYMDIvWVY1azNxeGxIZnBiQzUwSXVySmhGenBj?=
 =?utf-8?B?aDNxSS9SeHZzb3djbEg5aGpRcHFxOEFrcE93RU9HbjhOaGd4Q0pnUktCYmI4?=
 =?utf-8?B?dFRyMGVKKzFLTjF4WFRmUkxaRmdhU2t2NE1CekxpK0FnbitabkRlaUdiaWhQ?=
 =?utf-8?B?VXM1RXJJRjNqNWFwOFJNZi9NelVlRUV6ZU5LOGZpTnhsaTBDVVgxMHZjYjRV?=
 =?utf-8?B?aTRaQm5TYURtV25nSWlhVHZ5N1V4M1pCQkxJQm9GdWFKaC9MN3Q4ZG5zc3Yr?=
 =?utf-8?B?c0tPWmViQUdvRjFkdXRyb3hYN3UzaDRwb05leEF2d3JhWkVUMWVXMlEzNmcr?=
 =?utf-8?B?czNmbEkzN0kxVWVnYjNnQVJoRTM4ajNhc1dlOWx3aHlTbktwcFZQVFFuaE4x?=
 =?utf-8?B?ZGtRbkVWdFUrR2RjRWpZdzZxbmtSRmQ0TGYxMy8ySUZkYzY3aUYwVlo1MHNW?=
 =?utf-8?B?bWtuWm11Mk01L3VsNVJVLzlSZmpqa0tOQ243NThtN004STRpWGNnYjNSTlMw?=
 =?utf-8?B?ZWhBOXJwdEl2Vkp4WC90c2lzRWhKbUtXZzUzaDdRa0wyU3NkNzhGdG1tSGJv?=
 =?utf-8?B?eGVodkMwbVdkN2RNZTZVRmtFQS9Nc1R5eml1OUJGMFc3TGFXQ1F6T3FoSGdG?=
 =?utf-8?B?cGtvN0xtZ204SkxHZVg5N3BYck1FZSt2Zk56QURMNUF4bzVIOXpkWWVwc3Ux?=
 =?utf-8?B?ZzhNS3ZIb0llVGZJeFpDRDBkUHF4UWh2Sk1pS1Q1d0J3NTlKUEtLSTR0azh6?=
 =?utf-8?B?bFNrbW9SWUtzNDdkbFgzRmZ1SUxYQ2hJcEpWWk82bC80MGFydDY4MkU3dGc0?=
 =?utf-8?B?TWptdGIvOEFvSjk2OEtlNENLQWZKVFBaNlY5UFJWRk1NVUtkNjArVW9hV0o4?=
 =?utf-8?B?Z1pKbHN6b3RXWThvU2pPV3BIRFN3RXRQcWl5OXZQbUJPc3FDaCtFaUV3NFFm?=
 =?utf-8?Q?CjT88mQ2pir7tKyxno81BHLU2zXzR74s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjlKaVhqQjE4c2hKTVNyRXJ4UCszNjRPVGw5S24zNW9BT3Vha1ZQQkRBWmtz?=
 =?utf-8?B?RmxDRmVZWU41UThGTHN3MnFmUzB3dWhWR1l6MEZEUzVGYlVKb2Q0VjZpdnIv?=
 =?utf-8?B?amM1ZG1GUzZ3b0tQak8xRHZObnlGK1VoL2lmVUwvVUhxZnVPOHBTY1hxclpx?=
 =?utf-8?B?dGlwNjJGMG9xWWMxYTRmbVFiVnZSaDk4d3dwbW0xYzdnK3J2NlVhVVkraXpR?=
 =?utf-8?B?SDRwUFY1VmRwZndVSXNTRmMzTVJGODBrcTdmeXd3U2JXcTE4bEZJZzNYcGY1?=
 =?utf-8?B?STAyZFdxQXVPY3V2bnRUSWxDWWNxa1BvR1Z4Z3hWMDNnMUFOWmN6cnBFa0Ji?=
 =?utf-8?B?TS9LWWRZblBjaHlZOEh2VmMxazJHRkVLSzRxWjJySVpSTW9tQVFWUEhvOXdv?=
 =?utf-8?B?MTJwQVlGNlQwd2trNEJ4cE1QcVU0d2N0azN4RTN6OXo3WG5rdVZZMWgzWWg0?=
 =?utf-8?B?aktOVUNMdERDOXZRL0lBR1dDVFFHdk1BdDRzZW9saXRWeVNPVmVzalg0ZUFy?=
 =?utf-8?B?Z1ZIaEJTSXQxSlJxQkVzQldXQ2cxSUZkaGVNOERjdkdsQnRzNkZBMDZDT0pS?=
 =?utf-8?B?K0tVUzBaMzAraVJoUDBESzJ0VktpVWpmRFoyNkxjUjJpbEJ0QnBzZGtEMm9R?=
 =?utf-8?B?SldvTXFySDBWU0NlQ1puY2RPZ1JhQ3oxRmdURzdzbnJpZ05TcmRIVWg5ejRp?=
 =?utf-8?B?dXYvOExYbktXRU0xaTNWU3UrdEJBejc3NzNoQmpZNFdHemorTTcrSlpIVFFH?=
 =?utf-8?B?NmUzcVRSL2VwRXp0blVXOTJ3ejlEcS9wTnJPaGFncHhTNEttM2o1U2g0MHBv?=
 =?utf-8?B?aDNVZ3lGSExCUkpKWlRab3RzRXEyaG9zd1JRV084RzJxZ1IzeFlQbnBQZnVl?=
 =?utf-8?B?bVdUeElZYjBnOGF0bGoxUENoaWUwQ25aUVhOWkZGMkZPQXowWjdsSTdnTzNo?=
 =?utf-8?B?V2ZhS1NpakRrM1BzUzFzTE5jM2hqRGcyczhDUDN0M3BQL1V3SmlnZW5NUnhi?=
 =?utf-8?B?elFtS2llMllzMG9STnB6YUtRNTBiTmFTbWlIeElmNGpiWWlJUmZCcW9Mdmkv?=
 =?utf-8?B?MjJxTVcvMzhxbTBWbDFvQmRCb0I3VzUxSzhPNHh6OGtOelBqZStoMitScVZ2?=
 =?utf-8?B?WkZONkRRZWMrbVpTUFRxUDYwY3ZtZWFncTg5dHBHSmpGWDNXYkRZdUk3aXZ3?=
 =?utf-8?B?ZlA2MzRBTFo4cGxiMjRPcVJTTjk5WlZXSm9vV3FTdmMwQ0txVXBOWWsvYkdj?=
 =?utf-8?B?V2VMbm5wRUMxMkJVVlZiMkdPaHZtY2xGZ2R2WEdvMloxOG9GdkJ2blFSTC85?=
 =?utf-8?B?M2VqRDBxZk80ZU1vWXgrMDYzV3ZIMTBkd2dxd1ZZSXZqdDBlWlZkMXNOd2Zr?=
 =?utf-8?B?WklFQnBwSHNiaUV6Q290aGtsM0JVQnE0cFFSbHpETVhRbEd0dmh4d2F4NndZ?=
 =?utf-8?B?MjFCczlWTStialV0bjU4NkUyeU9lUEtzZk5YN1Q0WlUvZG44c05xd1lRcXIx?=
 =?utf-8?B?Z2o4SE45RElaZlBxcytralJCL1I3ZC9EMkRjV0ZnTlMyVldhTWhjdmY1RmZG?=
 =?utf-8?B?UGlxVmVYZ05pWjAwN0liQStoRG1PSTF5SlM1SjhyOXhoaXJnV2U1cHQyekly?=
 =?utf-8?B?VWJPUExnN1dDT3FSajdOVEYrUmpBdk0rbHhUcTBtZVh4UmIvZFlpdDFzZFAx?=
 =?utf-8?B?WlRKRG9Nblk5RW9ETnZlK3R1cFhPdjJKM05TemxIWERvcmZST1IrMmUranhp?=
 =?utf-8?B?YVplaExaRTVWR0V4VmdsbFA5cHBPWVRJM2c0THdtaWp0eE4vZmJjZEJmWGhl?=
 =?utf-8?B?N3JWVG9sbDRpV3VKOHRoZVhBV3Jjc0dCN2V5dW4zVlBwM3VGM2hvcFhSTW5S?=
 =?utf-8?B?MWl2NHY2NkJoYWsyZjVJekR5cU15OFVrcjhyMjdhSVhnbm5KaFlPYlhWalJJ?=
 =?utf-8?B?T1MzSjZuODBXYm5PaU5icnB3NkdsbFd6a3d5ZHRWeVU5S3dmRDVNSkh2UFI3?=
 =?utf-8?B?Sk93a014b05wSUNETlp5ZnFYdUtzUnBQTFI4SGdPOWpsaFlQWEVDQWFqM3NI?=
 =?utf-8?B?ZjBmL1hnQjdKVnJFOXNFRXhVeEMvNnlFQ2Rnd2pMYVMrTmFDVDlXMUJaNkNT?=
 =?utf-8?Q?1yBDsvzoyoCGsW0e0HUfvufwu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62015e23-db6d-4659-115a-08de1827bf4e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 02:46:52.7053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5653pLdeo7DWVsdGtBHny6A4ffZJlexg3nzSC7xfffNqCQH/+LDZ6YPg+hfRmXqbccQqQjJtcOWKQBhEjxaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

--------------2iEcclunxtYTxG8Ct5TeP1J4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/2025 11:05 PM, Kuehling, Felix wrote:

> On 2025-10-29 23:45, Zhu Lingshan wrote:
>> The pasid is a per-process-per-device attribute,
>> therefore this commit implements per
>> struct kfd_process_device->pasid in sysfs
>
> Does anyone in user mode actually need this PASID? When we changed the
> PASID allocation to be per-process-device, we changed a bunch of our
> dmesg logging (and I think debugfs files, too) to report PIDs instead
> of PASIDs. So there should be no good reason to know PASIDs in user mode. 

Hello Felix,

This patch is to fix current buggy pasid in sysfs which is hard-coded 0,
if we don't need to expose pasid to user space, I think we should remove it from sysfs.

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
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
>>   2 files changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 70ef051511bb..6a3cfeccacd8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -864,6 +864,8 @@ struct kfd_process_device {
>>       bool has_reset_queue;
>>         u32 pasid;
>> +    char pasid_filename[MAX_SYSFS_FILENAME_LEN];
>> +    struct attribute attr_pasid;
>>   };
>>     #define qpd_to_pdd(x) container_of(x, struct kfd_process_device,
>> qpd)
>> @@ -983,7 +985,6 @@ struct kfd_process {
>>       /* Kobj for our procfs */
>>       struct kobject *kobj;
>>       struct kobject *kobj_queues;
>> -    struct attribute attr_pasid;
>>         /* Keep track cwsr init */
>>       bool has_cwsr;
>> @@ -1100,12 +1101,6 @@ void
>> kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>>                       int handle);
>>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>>   -/* PASIDs */
>> -int kfd_pasid_init(void);
>> -void kfd_pasid_exit(void);
>> -u32 kfd_pasid_alloc(void);
>> -void kfd_pasid_free(u32 pasid);
>> -
>>   /* Doorbells */
>>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>>   int kfd_doorbell_init(struct kfd_dev *kfd);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index ddfe30c13e9d..24cf3b250b37 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct attribute
>> *attr, char *buffer)
>>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct
>> attribute *attr,
>>                      char *buffer)
>>   {
>> -    if (strcmp(attr->name, "pasid") == 0)
>> -        return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
>> -    else if (strncmp(attr->name, "vram_", 5) == 0) {
>> +    if (strncmp(attr->name, "pasid_", 6) == 0) {
>> +        struct kfd_process_device *pdd = container_of(attr, struct
>> kfd_process_device,
>> +                                  attr_pasid);
>> +        return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
>> +    } else if (strncmp(attr->name, "vram_", 5) == 0) {
>>           struct kfd_process_device *pdd = container_of(attr, struct
>> kfd_process_device,
>>                                     attr_vram);
>>           return snprintf(buffer, PAGE_SIZE, "%llu\n",
>> atomic64_read(&pdd->vram_usage));
>> @@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct
>> kfd_process *p)
>>        * Create sysfs files for each GPU:
>>        * - proc/<pid>/vram_<gpuid>
>>        * - proc/<pid>/sdma_<gpuid>
>> +     * - proc/<pid>/pasid_<gpuid>
>>        */
>>       for (i = 0; i < p->n_pdds; i++) {
>>           struct kfd_process_device *pdd = p->pdds[i];
>> @@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct
>> kfd_process *p)
>>                pdd->dev->id);
>>           kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
>>                           pdd->sdma_filename);
>> +
>> +        snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN,
>> "pasid_%u",
>> +             pdd->dev->id);
>> +        kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid,
>> pdd->pasid_filename);
>>       }
>>   }
>>   @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct
>> task_struct *thread)
>>               goto out;
>>           }
>>   -        kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
>> -                      "pasid");
>> -
>>           process->kobj_queues = kobject_create_and_add("queues",
>>                               process->kobj);
>>           if (!process->kobj_queues)
>> @@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct
>> kfd_process *p)
>>       if (!p->kobj)
>>           return;
>>   -    sysfs_remove_file(p->kobj, &p->attr_pasid);
>>       kobject_del(p->kobj_queues);
>>       kobject_put(p->kobj_queues);
>>       p->kobj_queues = NULL;
>> @@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct
>> kfd_process *p)
>>             sysfs_remove_file(p->kobj, &pdd->attr_vram);
>>           sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>> +        sysfs_remove_file(p->kobj, &pdd->attr_pasid);
>>             sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
>>           if (pdd->dev->kfd2kgd->get_cu_occupancy)
--------------2iEcclunxtYTxG8Ct5TeP1J4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 10/30/2025 11:05 PM, Kuehling, Felix wrote:</pre>
    <blockquote type="cite" cite="mid:24133b30-07bb-4ff3-923f-02d5a421fab6@amd.com">On
      2025-10-29 23:45, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">The pasid is a per-process-per-device
        attribute,
        <br>
        therefore this commit implements per
        <br>
        struct kfd_process_device-&gt;pasid in sysfs
        <br>
      </blockquote>
      <br>
      Does anyone in user mode actually need this PASID? When we changed
      the PASID allocation to be per-process-device, we changed a bunch
      of our dmesg logging (and I think debugfs files, too) to report
      PIDs instead of PASIDs. So there should be no good reason to know
      PASIDs in user mode.&nbsp;<br>
    </blockquote>
    <pre>Hello Felix,

This patch is to fix current buggy pasid in sysfs which is hard-coded 0,
if we don't need to expose pasid to user space, I think we should remove it from sysfs.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:24133b30-07bb-4ff3-923f-02d5a421fab6@amd.com"><br>
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
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 9 ++-------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18
        +++++++++++-------
        <br>
        &nbsp; 2 files changed, 13 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 70ef051511bb..6a3cfeccacd8 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -864,6 +864,8 @@ struct kfd_process_device {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_reset_queue;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pasid;
        <br>
        +&nbsp;&nbsp;&nbsp; char pasid_filename[MAX_SYSFS_FILENAME_LEN];
        <br>
        +&nbsp;&nbsp;&nbsp; struct attribute attr_pasid;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; #define qpd_to_pdd(x) container_of(x, struct
        kfd_process_device, qpd)
        <br>
        @@ -983,7 +985,6 @@ struct kfd_process {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Kobj for our procfs */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj_queues;
        <br>
        -&nbsp;&nbsp;&nbsp; struct attribute attr_pasid;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Keep track cwsr init */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_cwsr;
        <br>
        @@ -1100,12 +1101,6 @@ void
        kfd_process_device_remove_obj_handle(struct kfd_process_device
        *pdd,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int handle);
        <br>
        &nbsp; struct kfd_process *kfd_lookup_process_by_pid(struct pid
        *pid);
        <br>
        &nbsp; -/* PASIDs */
        <br>
        -int kfd_pasid_init(void);
        <br>
        -void kfd_pasid_exit(void);
        <br>
        -u32 kfd_pasid_alloc(void);
        <br>
        -void kfd_pasid_free(u32 pasid);
        <br>
        -
        <br>
        &nbsp; /* Doorbells */
        <br>
        &nbsp; size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
        <br>
        &nbsp; int kfd_doorbell_init(struct kfd_dev *kfd);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index ddfe30c13e9d..24cf3b250b37 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct
        attribute *attr, char *buffer)
        <br>
        &nbsp; static ssize_t kfd_procfs_show(struct kobject *kobj, struct
        attribute *attr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buffer)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; if (strcmp(attr-&gt;name, &quot;pasid&quot;) == 0)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%d\n&quot;, 0);
        <br>
        -&nbsp;&nbsp;&nbsp; else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) {
        <br>
        +&nbsp;&nbsp;&nbsp; if (strncmp(attr-&gt;name, &quot;pasid_&quot;, 6) == 0) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
        struct kfd_process_device,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_pasid);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%u\n&quot;,
        pdd-&gt;pasid);
        <br>
        +&nbsp;&nbsp;&nbsp; } else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
        struct kfd_process_device,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_vram);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%llu\n&quot;,
        atomic64_read(&amp;pdd-&gt;vram_usage));
        <br>
        @@ -662,6 +664,7 @@ static void
        kfd_procfs_add_sysfs_files(struct kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create sysfs files for each GPU:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/vram_&lt;gpuid&gt;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/sdma_&lt;gpuid&gt;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/pasid_&lt;gpuid&gt;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = p-&gt;pdds[i];
        <br>
        @@ -675,6 +678,10 @@ static void
        kfd_procfs_add_sysfs_files(struct kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj,
        &amp;pdd-&gt;attr_sdma,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;sdma_filename);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(pdd-&gt;pasid_filename,
        MAX_SYSFS_FILENAME_LEN, &quot;pasid_%u&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj,
        &amp;pdd-&gt;attr_pasid, pdd-&gt;pasid_filename);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -888,9 +895,6 @@ struct kfd_process
        *kfd_create_process(struct task_struct *thread)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(process-&gt;kobj,
        &amp;process-&gt;attr_pasid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pasid&quot;);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj_queues =
        kobject_create_and_add(&quot;queues&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!process-&gt;kobj_queues)
        <br>
        @@ -1104,7 +1108,6 @@ static void
        kfd_process_remove_sysfs(struct kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;kobj)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;p-&gt;attr_pasid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_del(p-&gt;kobj_queues);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(p-&gt;kobj_queues);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;kobj_queues = NULL;
        <br>
        @@ -1114,6 +1117,7 @@ static void
        kfd_process_remove_sysfs(struct kfd_process *p)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj,
        &amp;pdd-&gt;attr_vram);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;pdd-&gt;attr_sdma);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;pdd-&gt;attr_pasid);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(pdd-&gt;kobj_stats,
        &amp;pdd-&gt;attr_evict);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd2kgd-&gt;get_cu_occupancy)
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------2iEcclunxtYTxG8Ct5TeP1J4--
