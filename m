Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9BBC83F1D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 08:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B87910E0C1;
	Tue, 15 Jul 2025 08:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0n2og5D";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC53A10E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 08:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNcsF7NfUNnnDcPYu2jjVMChAhA9m8VI2XNMmWxbInYI8N9TDa0F+P3wD5zdO2oSs0Y+oZljaubvTKIHYAfD1CYa+Fdr8X4BEsf1brXknv1DGc1hVR4BjZ4AYbMlM3dUMf7jrFKtWBKFafuD3fFJD31z7LsWnqhqm/SEv4AY5oYvo0TwEKsZmELLDkltb+H/lyBsXCjHdL5TDrYNl9CLGiuMoi5q2NkSpe5lYJNon26g8Nm2U7bJgAhuaHYBdmnjxtF8CDBLLSnhm8FrMqr/TNTIqTF/3YBtT7jz5BStsEIf6s/cO1ZR+CnfvhT8UMhJlAEon77QoCwraxbiZrNhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxDCb5sfF6KOAQCf8/0XlREW6HA0IfdVb23uXWCflWY=;
 b=PyNMqd1KfVC//ZIPVeII2+pgzoeDX44opyOqmXbjcUHzn/d+9UdRwODppqyLzmf8NCK/S8NmTS7Xh53Gb+FEA9mToO2219NTA04cauWL8uy+C8CT8OAP2FLQklP8o8nH94BrqpwGmXbLw78NroBaY0jF7K34cLXQSrw/nr6rS16NxO195FuOuqzCEPxGCFmkNG1NNCmoOvtTLKv2oMdmzrV2ypPDRxjR5WCIS7nAa1bZf5gp18pVO2sS4/NTbv7nE134NzRYCBHao5J7tjdmz7kqLIX/2dFWh+31LVXzuMrJ9djtJu5Z7/+nTf3aSP+lWT/irs6Hfst/PkuoyM1O8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxDCb5sfF6KOAQCf8/0XlREW6HA0IfdVb23uXWCflWY=;
 b=F0n2og5DHt3J0Sq0y4vBTr+7V+a5mE1/PYuxz8ERZKT1EW3uTf7OoM9/Y87CdJoiVxNm/47TRJQae/gYKniCFcNHKRSkibmT22U4vkhMup6uCFYNtQJwoQkFd4JKYjis5vpiyuykzX9C2DBjNZvKUp76boIRtEMfEqxGZjiGx8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:49:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 08:49:30 +0000
Message-ID: <c6fb3051-a182-417b-9e20-0b1fae6dc81c@amd.com>
Date: Tue, 15 Jul 2025 10:49:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/11] drm/amdgpu: rework the userq doorbell object
 destroy
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-3-Prike.Liang@amd.com>
 <064e192d-feb5-4772-b947-d1557f83a7a2@amd.com>
 <DS7PR12MB600518AE6EC29FDD741B825DFB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB600518AE6EC29FDD741B825DFB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d11f37-ec68-4d33-23dd-08ddc37c8314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bW9aMXVkZFd3YVU5Z3BMWU52UldWRjlVSEo3bXFDbXdrczZuWW9CdFM0ZVlD?=
 =?utf-8?B?NGtZM1hyeXlTMzlPVVVxcmRnU0JHTE4zbHQwVHhDMmlxalEwaTdvRCtRZnYr?=
 =?utf-8?B?Y0J4Y0lIVGszOS9zZDlqM2hFbkxGK0ErZ2Jjbm9VNUVTd0R5Y0RhaEFuNXhq?=
 =?utf-8?B?TUNVdWErUm9UV3FabHUvc1Z3V3FtYTRPMWtLbktUbXMvZ2t6dzh4bXUvRlpm?=
 =?utf-8?B?Y01iL0cwZk1KZWN0RHdwbHlUMnRXTE1iUk54MmdWMlB5cE9PaXFLMEVINExt?=
 =?utf-8?B?ZlRWZS9ScUh4bW0vbUE4V1dPNHJhUmRnWlNRZlY5Si9kT1dBQVhuZXdUOGwv?=
 =?utf-8?B?VnVrT3VEY0J4YmJTRzFsK1RHeFl1ZG9PN3h4dU5zYUtjV2FRSmJiRnIvOTEv?=
 =?utf-8?B?TGpQdGZGb09ub240eUlEWGRpVllUVExNbURkRm85eGxDVjlrcFBrRDF5YVlo?=
 =?utf-8?B?WmNEdVphQjArZ2lMMXBzejMxbzlJMDc5ZkZlTmVLcUk0dU9UUnhBWk03djZM?=
 =?utf-8?B?OUd6ZjUxRmpOelZNcHRBUlA0NFFjcjYxRllFenRRSmJ6bWs1QUNhWDl2VFRG?=
 =?utf-8?B?RlVpbXlDbUR6WEl3bHZxYUpNQXhDQ0w3Y3dRd3FYUS9nZS8wYlpFUkQ0Mjkw?=
 =?utf-8?B?T01ISXo2VUhncDBVT1pINTJFZDREWm1zQ0t2bTVGZTJhazg0RmxTMDBFMUR2?=
 =?utf-8?B?aldlTi93ZHBwTjVSL25MR3RmOFpoRzFkNFFkbkdBS0hOYmdrNzZvbnBiZ2Fo?=
 =?utf-8?B?VmZJYWY2Y0V1Ulo0em9PWUFiaWxZUCszMnF5eXd2blhMQjVpV1MwU2huWkFK?=
 =?utf-8?B?bkJTMVVNZktCUW5xS1pMWUUxMzhtaWhxaWhwZkR4WW9vWi9lT1NKR2lldGpq?=
 =?utf-8?B?aWE4M0xxUWtzbEdRVzZZYTQvOE9LWGU0L0VhNVp2cFAxbzZCY2hFQnl4UmFJ?=
 =?utf-8?B?T3lzNE1pWnlRQzUwRS9jRURSSytqQ213dnZ3UjQ3SThtOUZkZm5PTHR1WWVL?=
 =?utf-8?B?emdjbjQyWmJxdzZkeWpRTnhYcC9lQVVIbmZtRncxY3h1NURPL3FNREtXNWNw?=
 =?utf-8?B?czF6UXlsNWpDQ1NhRUJ3WlhtSGFDWVJkRStzZmVrRW9lVU5PZWFBeTNHR0VB?=
 =?utf-8?B?eVYxVFF0WlZYcWJHK01DOGxjVVZqNUpBSHh5cUdGSENBT1hiaVZwMzFXTTEv?=
 =?utf-8?B?Q2J5d1VVblNUeW9DTHcwbHJPaE53cFhJRnYyYjVoL1JTbThXd01qM3k0YU4x?=
 =?utf-8?B?SEVPR242MEV6MlVMQmd3N2pCTXVKQTJOemtkd0dyZmR0bmovMnRVL3B5WlZh?=
 =?utf-8?B?RXBoZFhRUWRQbCtJS2VLM0RycUNlc0p5bU85TmNocHVoVHdFSWpUWW92VWk4?=
 =?utf-8?B?dU8vOHBtL3lPUy9UdHo2REcrZ205d0VmZHYrdUNGbWJwbDhVeHFRSTgreS8x?=
 =?utf-8?B?dU1QNzBiMGEyWVJrSEFUZlhObzVUcGRRR0FLeDM4KzZNekVDQmc0d3NMWmlJ?=
 =?utf-8?B?cU8vTGNQUmdxNFVZbjFiL210OVZvZVgrbFpoRjlha0ErMUZNWGN1KzhOVERI?=
 =?utf-8?B?ZWQ0RVA5b2lCYXR1eWM1Yk5DaGdsUzg2STMxQWtaNTJEU3RFMmNydjNHSndV?=
 =?utf-8?B?dWxFRjA0RWprakUxV3RHelNERmtJS01mOWNMOWpMSS93QldLeWJBVjdvT2ox?=
 =?utf-8?B?Ty9nbERtY2gvUDZObGZwbVQrNVlaanNhSFIycHdXOGx4UGdob1lxN0NvVklJ?=
 =?utf-8?B?cHc3ZTlxZ2lMcmFHSklZRVpITFk2bmdpV1hvR01Zb2czbUlQZWRGTGt2TXNF?=
 =?utf-8?B?M2dsK1U1ZUFkdElZWkFMdDI0M2hjbURMVlI1eERFVENaSUVLMTRNdS9QVnE2?=
 =?utf-8?B?OHhXQU5SY1lCekx2K1cwd3pzUXNONVF2NWQrWXJRZFV3UitOWjB5UkxzeXNE?=
 =?utf-8?Q?g9AoPA+b87c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW13aGsycytvSExESWM1dm1jbk5FaFpQd25PQWg4MzZVR1BpY1pIWVJ6ZzFl?=
 =?utf-8?B?UCtyRS9qUHM2K0hjQ0dvM1l0V1p5WS9nYzNQdUFRbFFuRE1zU29PRXByT0pw?=
 =?utf-8?B?K1JnMnNzZ1VvS3BrWUp3TXp5TnFvQjc2QW4vV1RaVTNSTzdBWnNrdzdIT0py?=
 =?utf-8?B?WU1UTkE5NmlsRHNWOFhZZWhEaXVQSWl5NlZwV1hBemhZckUxS1pmU2h4ekZZ?=
 =?utf-8?B?NjNHT1JJMGQ4Zk1NRm1KTjhZTFROcGJnbHplcGNzUW9uQkdqSi8vMiswb0hj?=
 =?utf-8?B?UzZpTWJ3a3lDRU5pRHlFd3N4NmFoN09uUFVQTTNBMWVxVkRsRHRmNmhWVWdG?=
 =?utf-8?B?Ky9ZbUJ0UktDV1IrU0VCdVRSc05acXJKVEkvWU0yQ3c5dFZKVjBPNXIvSUg5?=
 =?utf-8?B?eXZuUGZLS1JBSDcrczFiaDJqd3NoYVpRbjUvOUZoTGszeEdUT1VXL0E3OWxz?=
 =?utf-8?B?c2NHMzhtK01pSWZSWktZRFZMVnVnbUlhZnhnckhqY0NaNVZVRHM1d1VRRHl1?=
 =?utf-8?B?YUJwNkVHRDF2Y295NzJMOW9oZWdWN3Q1ZFNnNFE1eEdWeCs1ZzBYNDlRb1E1?=
 =?utf-8?B?cXFGTHdIa0NtVVF0YXRMQUhyN3FJclFZMEtJNzliZDVIdU1mc0RwYkk3UEdu?=
 =?utf-8?B?OTR0ZWFWdzVTZ05FUGhseEo5c2dGNDhmU0dXWHcrenRsMWNPbzREWmwycVRR?=
 =?utf-8?B?YVdyTmkxdGs3Z2VFTVlKN041RDhrdUUwQWJoUHRtbXpHY0dHWHdVYnlVRzZO?=
 =?utf-8?B?ZEVSck4zbHFIUVpSR29OZmhMdmo4L0lmQjNjYm5KTUtnQXFVdTBULzFzUDV1?=
 =?utf-8?B?aFZIaVl5WG9nd2Y1ZzVKSWhodGFDd1RaanB0M3IxU2JpUVhOelVBODZleGRL?=
 =?utf-8?B?QW1ZeEJ2TEdJZDFIWHVnUmlGUmN1TzBNU1lrN25KR3ZlZGdqQ0NmdG1QNXRK?=
 =?utf-8?B?cXFrd0M0aUlja3ExM2RzUGtTMlFkWmphbnJod2lQZmZieHVOTGh2UjlDRjE3?=
 =?utf-8?B?VDVVWUl1VjZ1OGFzelpSQ2poVmE4dEljNE5kKzJSenhzVnJJOU9tWHRrN0h4?=
 =?utf-8?B?dU92K0Z1S0pCVHN0d0htSHd2bjU0aUVVWU5vdGNySWxiUXdaU1NGNU1IcjlC?=
 =?utf-8?B?MXNYb2dFMVdLL2RGUDJicFk5S2JUZWxiSWhuTDI5YXdyS3BJb0t0STAzQlNW?=
 =?utf-8?B?ZUREWXNZTGIvV2ZabDZrd3lSaWE4TWtNQW5rQ2o3QjlGNDFNZTRDVFE0cStk?=
 =?utf-8?B?aVJZTWRQTzJsMEFBYzNObXBNRDFzUUVPejlwd0wzUTJleVRXU3hKUnFDZkJD?=
 =?utf-8?B?bjU1ZGpwSWNsMzhNU1JkRUF5NFM1cEVOMlNKNENkOXRGWWFHUWNIQjJBeGs5?=
 =?utf-8?B?aXNoRytWMHNjR05lQjlITkpHR1RyTTBHeDc4MklycUN5R1VrVkJTM1NnTmlF?=
 =?utf-8?B?VmZjd2JhbGc4VjBVOHE4eVJKNEFxbGs4aUFHSGZxODhmRmljN2ExeWdpZ0o1?=
 =?utf-8?B?YktrVEh5cHJPdFk1dW1aQ1dzMHZzRUVJaVJCNWx4alpXL1N5QlRIMi9MdDd4?=
 =?utf-8?B?M2QxUHprRmd6YXRqaEUxOFF5d21iRU9yTmdLRkM1Yll0OThxS0N5YXRhaFBz?=
 =?utf-8?B?V0RvREc3QUtDcUg1clgyU0k5eEd0VWc3WlZydG9uNWh0cVVkZTM0U0J2dzB3?=
 =?utf-8?B?Tmd0YU93ZHFrM3BVRVpBT1dTK2JyZm1oWHcwMDdNaDVERmw4Mm1yc1M0R3cv?=
 =?utf-8?B?VnNyMDlFK2VBUzZlWUtTdDNZTE9ub1BTcWJqQk1XVUc1eWlSL1E2YUt5VUpU?=
 =?utf-8?B?RG5RaHBHZ2xDUExObWZzZTJsc29XSlhkOThkVEFWeU40Lzh0TFdGMEE3NGZQ?=
 =?utf-8?B?eVBlbjdsUUFyOS9kK1EzVzU0M0VnRnZwUm0yeUhZd0orRFZVK3VKc1VacXdv?=
 =?utf-8?B?UVljdVUwREpYRlNtYUl1cVRpYTdXelBranY1UDhtQU5kZjJqcU84WFcrVWpY?=
 =?utf-8?B?RDAxMHMxZXNJbFpBNHNPdHdEQ2I0aVhmTzB0ZkNmM0FKVDVJVkhhSEdCbUdB?=
 =?utf-8?B?ZEcyZ1d4ZHlISFBDb3NadHZWa2dBemZ1L2ZhVGVQa0pvMUpVdW8wRWprczgw?=
 =?utf-8?Q?ExRTVUxAhIA+fBGnsr/rxjE9g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d11f37-ec68-4d33-23dd-08ddc37c8314
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:49:30.0479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1MOeGqe72h5vtebeAM2dKWVKfMZn7oDfmQowqnBzLxi1H+BqZ4hXsjarK2LSJyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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

On 15.07.25 10:07, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, July 11, 2025 8:01 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v6 03/11] drm/amdgpu: rework the userq doorbell object
>> destroy
>>
>> On 11.07.25 11:39, Prike Liang wrote:
>>> This patch aims to unify and destroy the userq doorbell objects at
>>> mes_userq_mqd_destroy(), and this change will also help with unpinning
>>> and destroying the userq doorbell objects for amdgpu_userq_mgr_fini()
>>> during releasing the drm files.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 6 ------
>>> drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
>>>  2 files changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 3d2a7f8946cf..15e833b1b3e3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -312,12 +312,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int
>> queue_id)
>>>             return -EINVAL;
>>>     }
>>>     amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
>>> -   r = amdgpu_bo_reserve(queue->db_obj.obj, true);
>>> -   if (!r) {
>>> -           amdgpu_bo_unpin(queue->db_obj.obj);
>>> -           amdgpu_bo_unreserve(queue->db_obj.obj);
>>> -   }
>>> -   amdgpu_bo_unref(&queue->db_obj.obj);
>>>     r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>>>     /*TODO: It requires a reset for userq hw unmap error*/
>>>     if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) { diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index 1457fb49a794..15aa1ca67a11 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -336,6 +336,13 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr
>> *uq_mgr,
>>>                   struct amdgpu_usermode_queue *queue)  {
>>>     amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
>>> +
>>> +   if (!amdgpu_bo_reserve(queue->db_obj.obj, true)) {
>>> +           amdgpu_bo_unpin(queue->db_obj.obj);
>>> +           amdgpu_bo_unreserve(queue->db_obj.obj);
>>> +           amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
>>> +   }
>>> +
>>
>> That makes no sense to do here. The pinning isn't done in mes_userq_mqd_create()
>> either.
> Yes, but the doorbell BO is pinned by amdgpu_userq_get_doorbell_index(), which is still
> Invoked during userq BOs creation phase. This patch wants to free the doorbell object like some
> other userq objects at the unified place of mes_userq_mqd_destroy().

Yeah and exactly that is not a good idea.

The doorbell object is provided by userspace and not allocated by the kernel like the MQD.

So destroying it here makes no sense at all. You are most likely messing up the doorbell reference count with that.

>> In general we should avoid pinning the MQD in the first place, that buffer needs to be
>> fences instead.
> If here not pin the userq doorbell BO, then will the doorbell index be changed when the doorbell
> BO is moved?

Correct, yes. The doorbell index needs to be updated on each resume of the userqueue.

We haven't implemented that yet since we weren't sure if the MES FW could handle that (and because the eviction fences wasn't ready at that time).

Regards,
Christian.

> 
>> Regards,
>> Christian.
>>
>>>     kfree(queue->userq_prop);
>>>     amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);  }
> 

