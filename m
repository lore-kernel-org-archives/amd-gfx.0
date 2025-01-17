Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C3C02185
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 08:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1429910E2E6;
	Fri, 17 Jan 2025 08:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V/aOBJYl";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A30F410E2E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 08:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/e4hWEIwjLK0MC7UYK1nx6u0QLlkD/Eej7QpiN8R6cS6hbu1aEoDr0j/2yh3V/YNgaY4u2dg/ZZwSWyZAtn22tQkNwVmtjhnFYqXkED7ZUN9AX/9QxLc547KeLwu7PnP8aXgrO/gRacsA6m/IOdzrj2K8D47/NR19p9jDlPO2795v1LaZs2djLFKSngcJDRIHrd2ENSmbYtovksZ67TmbatYuSB3covQDVLgvDaKQZ6IGVYnj7dJLGBcQc8cas2D74/OJMY/fSUCyHxOJQRfaSFaHX1jCmBgnCpuTNU+7pbH9yFOszHoFHY2L4PUMxYirlp4pAaq1mJshTS8B1Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfLUTq5yqkHHiq3nbUsJIy0ygNdZysrop1guH05gYxk=;
 b=Kb/U01es3A43Pu3ddtMUAA9ZLkufvFyUyai/XaVrU1A5LsBQyrc2iqhZpecEtsrfdarkuBLSDLLZVFa1K6hSC7SqycdzAD7NFVdP40rDOE+0fOFW2HeH/vq1n74SZSQzH1KEJbcr33WUHw5KpPlKOe/wuvfONNG1vua76ppWS4rPPRbfK6JrZV/kZuAK5gqZRPYLA5cJe1auuxsz9nRkOm8lZgyA+iRy9yXfGaFi8HlyaPI/RTcvLKMGNZnoiylCqVN7VE/+Y40+9FRaSwffL8qQaYe4MWygVAO91StnqpFkwAWwi9k4hmMLqdMj0acUfoBEZYKYH4nPeuAUMQN9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfLUTq5yqkHHiq3nbUsJIy0ygNdZysrop1guH05gYxk=;
 b=V/aOBJYlRDBjv6T+TipZ3gHw9S+KEm5cGjpeIV9QgE9LOw6PqwxAQInfP7dq7uTSmb4z+TZJrblPnWwZPAibJ276RS3zZVGOl8O3JZd8Cqy2CFoNlDQ4eY2kIi4VUyj02J4em7bQObI0blEMLVoQTgicUlpyj8HrNe1Cs3Om7Ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 08:45:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 08:45:45 +0000
Message-ID: <7c890f79-64e9-47e1-a18e-0a3e156b497d@amd.com>
Date: Fri, 17 Jan 2025 14:15:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 08/15] drm/amdgpu: make IP block state machine works in
 stack like way
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <4f627f06fab99e7534f590dfa16f1db13b16f7ea.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <4f627f06fab99e7534f590dfa16f1db13b16f7ea.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 1691a1ec-b5e1-4ce7-3d2c-08dd36d354f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dS83NG5rVE43ZGVhNGttemV2bWVOTUJCOVZVeVhsMXRybVp1eFdaOW9OWVY5?=
 =?utf-8?B?ZVhZVlpQOWVzRXFWeFZJNjRaamI2R3NnQnk4VmdOMmszanZ5KzJheTR5Nmli?=
 =?utf-8?B?N0hFa3hNSDM2RDFZVFB3N25VMmFlb1dHa2hydGhIZUdPUWwzSFVuSzdhN0ZH?=
 =?utf-8?B?REVCaWhhVlJycGZ3RXIxS2pXNmg4Y2FFMDVsOUxPOTFEbGxjMTFIbnJmbzBC?=
 =?utf-8?B?MVk1dW9oYTBpWUxxdmF2UXIvUTdqYkFXaWNIVGRaekthZVJnZEFsKzBoaWJw?=
 =?utf-8?B?d08vRWI2SFJqZU96TFZDbytkUEhoOU1zWktKYWxVaWEwQktmRW0xSEdxQkxu?=
 =?utf-8?B?SW9xZmVlRUdpeEFLMjdhUEpvdURLZ2IyOEU4dXBHYXFndFpFSzFjZU00YlM1?=
 =?utf-8?B?S0ZaWEpySkd1ZWI0dmZjNmIyV3RuL3p5Y3h4MEJ4WUljWGtSSmZNTVlWRnNO?=
 =?utf-8?B?L1I2Mk1nSWZNajdqZm5ZUEkyRHUyVlNNTm83UnZueWt2Y0E5WXM0RTAreStr?=
 =?utf-8?B?ZEhTL3Z5Y0tQcUl5bHNWR2h0dDJYNis5VHBPZEJoTElKZFFOS2tOSE93UGxy?=
 =?utf-8?B?YzEzUmsrS0NNa29OaWVpdTFFeXk5ci9zVGFYQXRBMG1RRTUyOE5DTDJEbm90?=
 =?utf-8?B?cFJxWVp5dlUzT09td0xHWXZzajQ1VEcrS21xNERLNkRldzRaWWFsVW1IeWpq?=
 =?utf-8?B?bFgyU3c5djNNcGsyT3NMdEFsM0VMKzR6NXdMWUVwUUw2N29PclUzN3JRVDBI?=
 =?utf-8?B?NVNsZ1VWUGNnT2dkOHBIUXhvaG9CNDBka1kwQlY3N2FEVkF5clgxZ1QrLzg4?=
 =?utf-8?B?UGpKQkhjaGtEVEJOL1dGU2ZrZHZNNVYxSGdIY0ZLMDNJQStvcXJjSG1ET1pC?=
 =?utf-8?B?OTRGWUVZaUZZaTBXRGphbGRFNVB6MmY4N0UvS3p2L056L1dDcUdycU5mMVB2?=
 =?utf-8?B?bWdEd1ZxMUdQWGJTVWRlSzRoNnRuMWVWZ3c0dlRnS0pOVVYvZWszYXNXU2VU?=
 =?utf-8?B?Z3ZPYWx6V1d6WEVhQlRLbW51MStlOVpBL2tWcGRudHlzanByRGRyTUViODk5?=
 =?utf-8?B?ZDlVeVE2RU9MQVJoUEZ5ZVhFSHJPQlpsUUgzdHhmZzQ3WnlkcWxNaE9OUHZz?=
 =?utf-8?B?cUlvcEtESHRMVlRvTnVoRmtncHFMMHRaSzY0OTBKMzhyYS9WSWFRM202OVRW?=
 =?utf-8?B?MGxuelhyb0YrL1BLNXdjU1NVeDZPK2tEeS8xaDY1bEQrL1V5WlY3dEJIU0U3?=
 =?utf-8?B?UnRkY0JGcGw1S2VVT0tCUnRyMTJCWkQ4R1BOZW83Qmg5b2VVU2o5RkV2Y2lH?=
 =?utf-8?B?MkVSc2doc2lvQWE2TDkvWnFDWWRZQllWSHZtSFVEeVRBenJwc2J1M210dWRK?=
 =?utf-8?B?a09OWWh6dkdYb2I0ZDdjVXNNYWJiTTVPNmdMZ0lBb1BWT1lHNFU3ell0SnI5?=
 =?utf-8?B?UEJGeGxhTVJad0FoU1lCU1h1RVg1ODkzcWV3QXkwUW55aVBUOGQvTEcybGRO?=
 =?utf-8?B?VVRoQVFyU3QzeS9QSWR4eUtxVzJQSFdrRjlObkhTT1VIMlN3cVQwV3M3K2Ji?=
 =?utf-8?B?a21MaUZjcnZ5dEQ0NjE3QmhMNnVqbTNkREtYeHp5cHg2OWNGUXZUMTM1dis2?=
 =?utf-8?B?RFhoczZiejd3Ym03Z2UvRlRObFZOekpJU2RyNmh4c3FIS1hqKzBpL0NsRDNq?=
 =?utf-8?B?QlQxODNBMzN5QmFnYnBQVWxDVUI3OEVxUkt3L0dRaEJ1MG03WkJsSUpQQkFB?=
 =?utf-8?B?ZC9neGduSzQreEI3WXBwYkM0cGlocUxlamdhTGlON08vNGRpV0FONHRxLzdl?=
 =?utf-8?B?Q0l3S2RZa0NMK0NoUUQ0TC9NaGw5bFYvSFhZZFJiVi9pcUpueWM0M2dLd044?=
 =?utf-8?B?YldXR2pFSlBnYlVlUmN2OCtPbXhlVFFsUktRWGNQK1dkNEZsV1VUTFplWVc1?=
 =?utf-8?Q?pTkvPl8XGK4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3J3Tm95bVNld0MxUGdkQ1Z3NU9SUkxnSkVjVUwxb2gwMkttRW1FZy84U1l6?=
 =?utf-8?B?NVVtK0lwNThPcUkxTlY1TTVneFBjSDk0a2U0SWU4MVRySnYxZm9OQTZ2ZjRz?=
 =?utf-8?B?M3BubFFkZTdnaU5mY2pnWUhLNTBTTWEwdnJRLzBhYXozUzgvOXpBendkd255?=
 =?utf-8?B?SDlITTJKNHpDZDdYNk5ncXJxVENFcTJidzE1eStlOG9qaERySU1ibUlyQ21D?=
 =?utf-8?B?T01XbVVFbzdMZmZWUUphaFhwQzY5RDdJdnJjdTVOa3A4SkRtUXQ5a0RhMjJG?=
 =?utf-8?B?L0NBTUtjMDdTM3A4WERFR01MRHpITjBlUTlUWHNNUUdiV0ZNVzJkOU12dTBG?=
 =?utf-8?B?Q2pJNy9yRmc4N1FiQnc0S0U1WUE0Y3BSWitNQ3kvRTJaay9IUERaU2wzOTI3?=
 =?utf-8?B?RStCeDV2MG80MFB2WVJ2Sno4N0RSWlpqNjlEaTZHQ0doWWlPYkIxd2Q2Nm1T?=
 =?utf-8?B?NjF5ZVNJd0RJTGxycGNFZ0NudjZTWkx1NFNmczdWUnU1QndsdkJtY2hZS01w?=
 =?utf-8?B?SE9pSnNpQm5tVGUzME1UZHVzRm1vckUrY2NwQWRPTEc1dzBtS29pZnV5KzZp?=
 =?utf-8?B?UTczNXhNWk1yaTlUMjZWNCtFK3MwTXJySWJOUXkzTUpSM0t2dTM4SkhuQ1do?=
 =?utf-8?B?NVRrV01kc3UvZmRVVnJBYUYxTFJUTGx0R01KUkQ5anFFZjVMYVJhVjhTdVdK?=
 =?utf-8?B?TUFyZXpSTDluL2xVc3BUcjk2U2lCaTVNZmNaclZDNHRBZHYySFFpRkJHaUg0?=
 =?utf-8?B?amhjRWlRempaV2s3Q1FiZTU3Z1JwNHQvSE5rejNiWmdLYmNHUmZzUi9vR1BR?=
 =?utf-8?B?bVl5b0k3VG11WUVnb1lxQmdOZlFxTGZCVUlGbUNWcTdyb2VzZzRDQkw0Vk9L?=
 =?utf-8?B?anloa2ljNkdIUlVZWDU4OXVJeWMrUkJYRTU3aUVwMktweXJHTE9XT0xLd3hV?=
 =?utf-8?B?QmpxRUt3SCtCaU1KMlJOM1pBQ2gwQXd5Q2lsdGthSkxydnh5Vk5WY3YxaW14?=
 =?utf-8?B?aC9qMnoyQ21vRUphN1lIRUo2MEdMZWN4Rmt2K1dxU3VkSmUyQm5EWFlzUkY2?=
 =?utf-8?B?K0dhbllEYjhSK1ZLd0ZTMHZHK0c3UzRFWFlTOW9OT0QxdmxPYnFaZ1Zqb0s2?=
 =?utf-8?B?aGU4TTdabjJxRXJmM1dYSHNZUG43UlBZV09MdG9yWnpJbzZuVUdCRU9uUDBu?=
 =?utf-8?B?T3laV2RzVTFkVnVGV0YwWDJhZ09Rd3pLQjRLaFdnU0VhaS8yaEE0d2w5Y2da?=
 =?utf-8?B?d04yZ0hWWjhIWnBOQnN5ZzUyVUxmQm5JS3dCZW5iUGZZZnhvTTRzYWdaSXcr?=
 =?utf-8?B?U2d4b2YyVzA2SlNadU01RGJGZzZrVlBBR0cxSTJWSmxhcVY2aVVKTWIrQ1lP?=
 =?utf-8?B?Q3IrRENwNlNZbWI5Y1A3K25kWldqMUFlUExDWXJ6aWhHZzJjTFZuQzRLSGpa?=
 =?utf-8?B?VEFMMzNEbjAxY2xHbitiRm1OQ2tBWWhlYlJteG0rSDVTcks3MDRwOCtiTkVX?=
 =?utf-8?B?M0F5cGtxcFBXRFc3aVRRamlzY3dHTTkzSmp2Sm5aVHc1OEVTcGxTamtIVzYy?=
 =?utf-8?B?SGpydm96UkZBaUE4R012ME1PdkVxTklVQmVlWEhubWVLM0k3UkFQYjgrdVZj?=
 =?utf-8?B?bG1GV2FBVnBIeXhaaThBbVZqR29vbmZBRVdYZEU2L3p4a3BFdWhzWVMwc1Bs?=
 =?utf-8?B?S3d1SHVUUmdhcjFuNXc0NWNUd3FjQnpXZmllRHh2UE1HRkhZZkpodFkwUTFz?=
 =?utf-8?B?Rm5FNkJUYWc3MGlkQUMza0tuMWVkRW1MWDBNOVgyRGQxSUhlL1VMMEdOUUU4?=
 =?utf-8?B?Q3dxZ2dLZ0NMeTQxYm5WbTQwRFVsT2ViSWNTQXg1RjF1Z0xSZk84SlFoVXNa?=
 =?utf-8?B?OGIwTGk4Y0ZqYkU3N0JwUy9Mdnc5OWJoTjRMZTZESzhkVTZZYUh6L0Y1NFQx?=
 =?utf-8?B?NzA5dUQyaG1Ld1ZKcXpSalVNdEp0UGEya2V3cERDVWNYT21jeG15NGl2S096?=
 =?utf-8?B?eFRnRUpGTzM5ZVpaWmlXL09KQSt4OGkxT3RDMTMzZUlPakdWVm5xY3lXL3Nv?=
 =?utf-8?B?VFVuaU15YnJtOUgxSjBiV0RQcnAwbWlnQ0NQeTRPYUNBZExBZFFITkI5T1Nv?=
 =?utf-8?Q?VoSbpsOI8o639a3+X7crw5RdJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1691a1ec-b5e1-4ce7-3d2c-08dd36d354f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 08:45:45.1146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9456oj65L+inASlMMLdA6awkX4X/6iJjisO2TmfKfc2cXA3W0I7WYNyzFizQbcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> There are some mismatches between IP block state machine and its
> associated status flags, especially about the meaning of
> `status.late_initialized`. So let's make the state machine and
> associated status flas work in stack-like way as below:
> Callback	Status
> early_init:	valid = true
> sw_init: 	sw = true
> hw_init:	hw = true
> late_init:	late_initialized = true
> early_fini:	late_initialized = false

Changing the state like this is confusing. The intention of late_fini is
to reverse the steps in late_init. It's straight forward read like if
the ip is not late_initialized, no need to late_fini. This is making
that complicated.

Thanks,
Lijo

> hw_fini:	hw = false
> sw_fini:	sw = false
> late_fini:	valid = false
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6cbd19ad0fa5..6b503fb7e366 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3376,6 +3376,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>  			DRM_DEBUG("early_fini of IP block <%s> failed %d\n",
>  				  adev->ip_blocks[i].version->funcs->name, r);
>  		}
> +
> +		adev->ip_blocks[i].status.late_initialized = false;
>  	}
>  
>  	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> @@ -3445,15 +3447,14 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  			}
>  		}
>  		adev->ip_blocks[i].status.sw = false;
> -		adev->ip_blocks[i].status.valid = false;
>  	}
>  
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> -		if (!adev->ip_blocks[i].status.late_initialized)
> +		if (!adev->ip_blocks[i].status.valid)
>  			continue;
>  		if (adev->ip_blocks[i].version->funcs->late_fini)
>  			adev->ip_blocks[i].version->funcs->late_fini(&adev->ip_blocks[i]);
> -		adev->ip_blocks[i].status.late_initialized = false;
> +		adev->ip_blocks[i].status.valid = false;
>  	}
>  
>  	amdgpu_ras_fini(adev);

