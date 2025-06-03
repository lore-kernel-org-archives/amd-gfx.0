Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4732FC5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 16:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5BCA10E021;
	Tue,  3 Jun 2025 16:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dh0OxEfz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7105610E021
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 16:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CB6L35FTakcqkYRz81SWRmZAcTXKLAsxk+GkNfsannzENfn/LTRpA4G8XbXFMUWhgFK3ORHc0cgaXIJ1vSFvwFzNFQvSVbRVUDYiO7diElQKePWulc69vpt+u6BEkzok3rlF3JCTnDYl7g+dRTW+RemFIla4oePK5DIWMDSKZccNr7m4T8avJXE3OB38WMWhcVdEhX3SjaXcbOV8Ksl6tnREQ9OwJUnPYskrNaFl4BpDLPaT1oABTQIuMTp8zolFmW66B09hGAkdO7+hJW1dg+tnbzx6vm5Zm3mxERND35+44beyeZsD4Ts+t/eVY1+GZxkLg7y+hlhj3zywinzjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/R1msm80Sx6ohPCfw8Mfn0x/NuMSYboWeL8FuyEsq8=;
 b=Jdn59cbcxQPxlrw4DJd2oep7CqnJzE7EByvb+YNKuo1YH/qCOfcuTtp26EAaPLSZjKMSbYlkB8j2vu59AMz5XvsTquHvjZca99rwYhs7Re8/gU4OqM96rLrY6Ipbdw2yoGmyvPAM3PbysDsTqkMZTxrPrHpf1YeCO+0sDRFRbYYMgRzD+z4EamaLH+WWdYEZ5g3tPiE+ttHywfTlR5sFBkjaOME2529ZHGYT7ej+Qcqp0WrG8NHyERt0qDmAuQwhP3T5vc+67jIEAGUjG6TWQYqxEUNfSEnYcIIDLBgnjahuV2Q6qrpAkYHGe5GgPECZ5XVFXnl0Sx5RbmQEwZqg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/R1msm80Sx6ohPCfw8Mfn0x/NuMSYboWeL8FuyEsq8=;
 b=dh0OxEfzJX+n6hQItSkJwtF+05HqK37G5XAQ6DPBBfx62AMf6w27QeA0KFeOh4w9SRpV0LPf24xaAlwS7HRBp0M06KDo+HuLr6NST40oMZoZ5DtAeH4yoixoJP9l24MlrI/DK3fcNJQD38ZhOOCfNO9MXPzltZ82dYfZ25w9DeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 16:26:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 16:26:38 +0000
Message-ID: <db7f6c9b-5ff4-4bdd-a843-d5a39f1a0d84@amd.com>
Date: Tue, 3 Jun 2025 18:26:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: John Olender <john.olender@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
 <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
 <6288c9d8-9a18-4027-ba50-258f837025a3@amd.com>
 <2d3fba88-ed8e-4c3b-8fb4-56633ab0aa08@gmail.com>
 <ced428cb-798e-463e-bdc6-4c01f9562c58@gmail.com>
 <5eab610e-26d0-4dd3-b46d-e61fa44364c2@gmail.com>
 <32880a04-c459-43bc-bad3-424d3b7306fc@amd.com>
 <4b919d57-1f90-48e8-9c7b-5a1814c4a07b@gmail.com>
 <a28a0a4d-614e-4ba6-a8d5-8ab06335f410@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a28a0a4d-614e-4ba6-a8d5-8ab06335f410@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:208:d4::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 601985f7-2c85-4833-d8cd-08dda2bb6a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1FmNGhPSUNmemdyOUFqMXRsT1hPYytjSHdCSFQxa3QyQmZSSFN3c3pHK1Ja?=
 =?utf-8?B?UkswcmpFdUJrOTJGdEhiVW9WcUFaRHNZUlFraHlxVFU3WERXVnovS1dGYWtv?=
 =?utf-8?B?dW5EYkx4UWtaSTNQU2pJSWZ5TWE5NjBVVjNWVnZBNUxzeVlCQkZuRkJ2SDNC?=
 =?utf-8?B?SUhoTTBjbHpnMzRzUEJRUytJV0dPb0dUOXpqK3JwdXQxc3g2MkIyNHBZYXln?=
 =?utf-8?B?UytLQ2hEeHYyRGhreEltS1UyT0s2bE1VVlFLYWZ5UmtZdCtUMFhQaStLWCs0?=
 =?utf-8?B?ZVVCTy93UTJaaFduN2hOMWtoRVRpRS9heDVJMktuZEhDdmRENmNUK2pGWTFL?=
 =?utf-8?B?cXdjYzQyK0RYRzJHOUlPZTgvZUErcTZ0QkROQlF0MkZkWGxMa0IxN0J6UmIr?=
 =?utf-8?B?VmFaNjZrR1crR1cya3kxNXVwSGhTaGlrSGU3QlVWVDAyNlpDNWYvZFNiZ0F1?=
 =?utf-8?B?V2tYMXhBa0YzcVZaUFdBT0ttZnJkQVFUSEVvaTBsSEVnRElEWExzbzg3Ymk4?=
 =?utf-8?B?QkNFQWtiWkFoSENDWmhtemFsVTBCQ1Q3UytUbHYzRC9FZk5EYWl5QVFjTFdx?=
 =?utf-8?B?YVp2cjhndklUYXNROGxYZlczZWl6SkFXSnk2cnZHL1pBY29RTFhrZFZmYUU4?=
 =?utf-8?B?aC9wRzNGem9iWjlkUmlvd2x1SkMvSlYvczVZQVh6Z2E0elJ3dWErRENHWm1N?=
 =?utf-8?B?NU5BTWQ2SjNsYlNOZ2VYK2FHZ2J6YytLOHF5Ny9ubktmZnVNd2dTWUxRY2hq?=
 =?utf-8?B?SVY4VnZxNVM3MURoYUhVaGFQZERIaEJqNHdrOUU3K28xVmFnTHJ5QzlwM2Zp?=
 =?utf-8?B?RXU4M1Z3N1FMd0FjUDcvWmRjWmgvYjB1SzEyU3Y0MlZrTE92aWI2bVNnem00?=
 =?utf-8?B?MWpHbzdHbEJ6S1Q4ZU9idnM2R1NPalg4dDNVTG1CdnFjSmx5VEI0Vmwzbmdr?=
 =?utf-8?B?M3VoNENTNGFMb1RYY1pRMTJZVUp4aGhMTUtNVndraXZMZHdsZnVXbjFKRkhy?=
 =?utf-8?B?WU1OcHR1NGRWMUJ4LzhHSDhvL2sxU1hMcFU3QlNiT210YkZCV0VIb2Qxc3cv?=
 =?utf-8?B?MEZ3d2FNb0l5dWlvazNCeml4bklhVUZkL21SaUl0YWR4eHhFLzM3eDRMMEpO?=
 =?utf-8?B?bW5nd1V1dE1rOUp1OHM3NEp4NG81K3JJYTNCSm1iL09hQTBlSXBib21WYWRR?=
 =?utf-8?B?UTlTQmIxeE1CSXFTdXFOeFpabmdLTWRENktpODl0elRwTXJyVXA1MmVJcmdl?=
 =?utf-8?B?c2F0QTd1Y0ZDb0RFZDUrK0YzYlBmUk5UTVdyMU5RVUVvNVpGUVlyeGY3MkhU?=
 =?utf-8?B?SWkwZWR6YVJRa05OZFhCTEU1WkwvOHF6d2c1UUhiTXdCRFgzRjYraDd1aTJj?=
 =?utf-8?B?Y3kxVE5abEZvVGhObjhtekgrdGd3dWxzZ3ZQdEZ3YUdOdkczV2EwMXYzSGlS?=
 =?utf-8?B?aWE1STVBTTA5dGgyeEJOTTZFMEw4ZW03Zm1jVm5yOGdhWjFnVlRRMlpYMDVw?=
 =?utf-8?B?Zi9rRmkxUDBsTW9JeHd3OVJDT3lYT0kxN0d1eCt4dTJUa2J0eHlWUEx1MnlK?=
 =?utf-8?B?SUpNb1hRVU9DVUQ5RkRxdHZnY09UMXNSZXgxSzdJZzZwSmFIMEFuZ0tkTnFm?=
 =?utf-8?B?SDYvK244Q2krdFJJSkNYTnlOWTVEdUpkZWRQTk1PNllWRVlSMWZRb3IwRmVk?=
 =?utf-8?B?TjVwY1N4RFNuckJsR1JJc0E4QWVpTytuUlZac1BKVlRjOW1pMHZFcm9iSksx?=
 =?utf-8?B?ZlNYS21Ick91T05pUW5KSTVNYWFqclU3SFF2T3UzVkVZMi8rMEFKdkl5Kzdk?=
 =?utf-8?B?QWkrd2N5M0JONGRNS1VsME9zUTNZZmNuMnZEekVKdjQ4NE1rdUkzUXFVUnVP?=
 =?utf-8?B?WHdiZ0hNRURSdStkejFaN2R2Sm9HaFZNbWpxMXZEQ2xWSFFuVHVBNk02WndR?=
 =?utf-8?Q?yfpSYjGDhw0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aktVVkN3N1FXdDkvN0lJcDdxZ3Z2eXgycmNVWUUydkZJUy93bUNtc3dCY2pW?=
 =?utf-8?B?cFJPN3I1TTVvM0V0QnExNlVndWlWa0NIQVkvREhaZG8ybThva3R4SkI4bGFZ?=
 =?utf-8?B?a0JuZG1OclA3VS8rb1A2TGJORWhIQk1RMUJxck9MT3l3SEtXc0NsdDYxY3BX?=
 =?utf-8?B?b2RJVXdxZGxmVmlHaGZIWGlydGt4SjlZWDdYZUFZbXhBdWNXNVNmRytnRWd1?=
 =?utf-8?B?MlhzODNsU0JZQ1NFaUFneXZMZ0xncmtkeGNBU2dCdkp5SHdrY1FhbkVqa1hC?=
 =?utf-8?B?cnVjOWh2VXA3blVEZmo2ZFlSUVdYZ3U1dzJFNjRlaERKZWtYQjlQVm9SdFBM?=
 =?utf-8?B?dmxDUExuQzlsbFZ6THVaSFBocVhpRXdMUHVFMFpQay9lY3Q4MW1iQjlZZzdT?=
 =?utf-8?B?YVFsZ1lrZXN5dk54MzZZV0F2S1h1dUd2ZXJEeW1sWmNKWWYxcVRrTVZCdHRV?=
 =?utf-8?B?QzdFbWVBNTZmV3ByN1hZdGhQLzJ4OCtoS3ZjcTZPcUc0REpWRXVKdGVoTWZa?=
 =?utf-8?B?V0o5MXgvUnlKdGNCeGhDaU5xY0Y2b0RuYnRhNWhQQTJ2QUFnZm9lOThtSFhS?=
 =?utf-8?B?Kyt5aXBxVW5JYWdqQjYxYnBnYW9MeUZreER4bkR6eUNoYWNZcUxScG82SWFY?=
 =?utf-8?B?MWNOSDFuS0ZqK2dpUDNXempwWHd1UHRrUFc0SlZSMWZGWlNsa2NZYmhTSU5Q?=
 =?utf-8?B?VzJxNHNMb00rL1hNNUJPVVlmQmwxUkhzeEpuRWpoMmdGZndrL0k0N0lENXFG?=
 =?utf-8?B?cXpNR3dWa2dxOEMxZWhkVnFkZ1dpMit0dFkvTDBveTQ0REZSS3Bvdi84U2hl?=
 =?utf-8?B?Nm9YcHV6YTFydHZNZm1BbWVMYklLMnlCcm5TbzBKZS9RL2ZHL2VCSThKU1Yr?=
 =?utf-8?B?RU5KV1dzOWt0cmkxbUs2aHkzeEZXRGdKbzU4QU9sbGpzREhCSnArUTJPZkQv?=
 =?utf-8?B?cVp6UXYxVC8yRmdYU24xdG16VlRDZDhIY2lJUzRHYlB1YWZuVGM2Sml2QVR2?=
 =?utf-8?B?RWlUZzRleCs2WC9oc01rM0dWdVZGdTJWcVFadFJGYlYyeFl0RkZxWVp5T25E?=
 =?utf-8?B?dHFNaHFibVpMN3dRL2xkd1BYWEtrT280KzUyYWdvMGlBNzV3dE5IajdQajNI?=
 =?utf-8?B?MEFBQmpQSVBDYThxY3RHc2FySGJWWDJuUWZrMTI2TVpNMklmRWR0bWhnVTZL?=
 =?utf-8?B?R1gweDgrVGVaam53bVMrS2lXQzh1THZWUmdWQzMvOGxOZXAwaW5IVkhKMEVT?=
 =?utf-8?B?RExUQ2EvNnQvVlZHRVRnTE1MOXZEekNUQXBCNGdyUXFxRERjRW9DMU1NSWVU?=
 =?utf-8?B?OE0vOTJEY3EwYVl1bXFFZUtxNmdzWStQQ0w1aU1aV0pJSlEyMWtSV1VKYlM5?=
 =?utf-8?B?ZVN6M29LMHFnRjY4OFkweklnbVJubW1IQkhxNTc1Tm9BclVFbGF4YW5nQTVu?=
 =?utf-8?B?ci9rQzRyUVAvNEZmMGVwZXl2SGE1dUdQTys1NzFHSlhrbGhoWWdseHhDcEpY?=
 =?utf-8?B?MzBuZzlubmZpYlRCWWFlSzMyN2VrQ2FKRVo0WGdreS9rVWQyUHdacnUvZDVl?=
 =?utf-8?B?MzVTVytxUU15MEhLSlRXUmxiRjlCL0poRGkzZjAxM0JRRjI4NnU5TGFra3p4?=
 =?utf-8?B?TGxVSHFTeU5aUnRvZGV3bzZYZkhQclY0eVh6Q2VDWXFQTVpublQvTGxIQ1ky?=
 =?utf-8?B?cURsT2UxV1F3SjIxcFFtTzRaelRVcjlpL2h2QUk4RVZMVTdBRW96WUY3QWFB?=
 =?utf-8?B?dHlBQnZFZkxheGQ2MGRRT2Z1b3VocEpTaUJyNnBJTDdxdmhod1IxaU9HMUxC?=
 =?utf-8?B?c2dFQkFFSWNPbmNUQ1BzQWd1aE53RHFaajhaOTh0dlM5YmQrMkRjTytnZEV2?=
 =?utf-8?B?WTIrdDk5czNBYXJldjJFZUdyOGoxQk90bUUwK3doNGFwaStpVGFVaEZ0eHdC?=
 =?utf-8?B?YzdUOXVkNENmcGxTRjlNbXJWeGRiTVpLQ2xkWmt4Y2NQZDh3Q0dObDFjTVFG?=
 =?utf-8?B?ZXpkNWRZK3EvNGpLdFNOSmhWWmhQN3AxUHl0ajhGVGxkMTVzd1hLbjB0bUgx?=
 =?utf-8?B?TjVxUXBWeGxudUZjTjJ4T2ZPV21OYXB0ZzA4YU1XWUs1MzVXUWJaNkV5NTNt?=
 =?utf-8?Q?lWE58jWizSQHKnVo0poIZAUJ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601985f7-2c85-4833-d8cd-08dda2bb6a90
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:26:38.8187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fVx8WTtvS/1UkeDm0bOdC7Bganz67FSuV3D3Yue0RHAawZIQgV1dGXoFTGhaUnN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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



On 6/3/25 16:34, John Olender wrote:
>>> Oh, that's a very interesting find. Could you try to turn around the way the patch works?
>>>
>>> E.g. instead of forcing the UVD FW into the first segment, change amdgpu_uvd_force_into_uvd_segment() so that the BOs are forced into the same segment as the UVD firmware.
>>>
> 
> I started implementing this and I realized two main problems with this
> approach.
> 
> First, there's currently no guarantee the UVD FW does not cross a 256MB
> boundary.

There actually is a guarantee for that.

FW BOs are always allocated contiguously, and the allocation backend makes sure that for example an 16MiB (rounded up) FW is always aligned to a 16MiB boundary.

So FW memory never crosses a segment boundary larger than it's rounded up size. Without that tons of things in our driver would fall apart, not just UVD :)

  Checking for this and providing a fallback is going to make
> this patch... not really any less complex than the original.
> 
> Second, most of time this is just going to end up selecting the first
> segment anyway.  I'll go more into this below.

That's fine with me. I'm just concerned about that 1% of people where it potentially worked before and we are now breaking it.

> 
>>> That would resolve my concern that this could overload the first segment. The feedback and message BO are usually rather small (4 or 128k IIRC), but the firmware is a couple of megabytes in size.
>>>
>>> When we have other FW and VGA emulation buffers in the first segment as well then that could result into clashing that segment to much.
>>>
> 
> During my initial investigation, I found out that the UVD FW got placed
> in the first segment *because* things were already placed there.  This
> is why adding a 'stolen_vga_memory' substitute was an effective workaround.
> 
> So, CIK is *already* forced to deal with an overloaded first segment
> and, with the inverted approach, will continue to do so for typical use
> cases.  Explicitly placing the UVD FW into the first segment just makes
> this guaranteed.
> 
> I did implement a module parameter for testing that allows designating a
> specific 256MB segment as the legacy UVD segment.  I can polish this up
> so the user has the option to manually relieve some of the first segment
> pressure on SI and CIK devices.

The module parameter is fine for your testing, but that is not something I would accept upstream.

As soon as things are not working automatically any more people will start to complain. That we have a manual work around is only feasible to a minority.

Regards,
Christian.

> 
> I haven't run into a situation where I've needed this during normal use,
> but I can certainly appreciate it being available.
> 
> Thanks,
> John

