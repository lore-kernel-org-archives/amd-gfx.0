Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA2CC83F0F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 10:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51ED10E5E7;
	Tue,  8 Jul 2025 10:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dFvjmO+A";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A04110E5DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 10:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B24+dZBh6eD/ug2TH3YNFc8darfF4YCz9PpjRMAG0KcDsj663rfqTxYIoe0lxLPk1GDT66x4O/zNuy4YT7/+QUBnoneHLEriN9ZMDZ0k/2nfyrdaSdDlodNb8PmWZQ7lRyriBv4CyNtgM/HaEIm+hjN7ial14Hp0hxdefcFhQh9z3UYms4fDPnllRaxJYSSW/p12WNExMYZ1N9vM3j7gZMvWkUTQPx2POcNiW6GrH3JOBwuosSy+a4W4wYpRo0Eop2N0RpZq5o8oIaWnl8yVPWPf7mM4aGqJENnggrMDI20kMzvuMdP4noLPM6KfHsCniwOSjJNp0HR7/fj9iTj00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNsYbpx5NWj29demu5M96LD1jPnaKIKjPGQfKOTEIDM=;
 b=Qkjbk76l8o/SAikZcf7j7qBRVZXrO8WXVc1Ifpl1Hngo5FsdbX19/tBf6//x6qZPjdW9Pha0cmH87zlMQYIZvvngugWuuLE0ULWQWE0hxW8fHCIgVI3ilqfVL9+hqCk/Wsy4UoNZyMVogGslx0WnP8BgFaIiaNlZ8w3pyVknhyST4ZCvs679GUHbSREkwDCsvXj6Nlnq5k+i27kXtbHEouAMOvh8gWb+wXUQl57MHl8ZHUZQfZOVNU5KKrW0xlvVK2jYYd8GCD19InB/yUCADqhFu5dptkqPU7yKTLcD7qNz0kmqIsjl8eV2yZpAvA4pdjbj8O9vXXXsw/Ad/urnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNsYbpx5NWj29demu5M96LD1jPnaKIKjPGQfKOTEIDM=;
 b=dFvjmO+A5HvAmFyom3pBxq6eNe1asirYnWq3GI4eSG8Gdx1s65uTNlDA8mBUW94FKCURq9/WCkZ3CVQkHg3nBCSqQuXzsoK/n/SYbqRlr/XYOxbcJPNK8LzsBM1k87kJmOaTx4n9JErwTWPzRIGy6Kp5GrIix+epdFoNLxL5oeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 10:18:32 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 10:18:32 +0000
Message-ID: <23d72128-1e51-49ea-b9d8-c4739ba9321c@amd.com>
Date: Tue, 8 Jul 2025 12:18:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
 <20250704103308.1325059-8-Prike.Liang@amd.com>
 <ec6cded3-daa2-40c2-91bf-4686e8a03e7d@amd.com>
 <DS7PR12MB6005768B9C3E32317F7F8779FB4EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005768B9C3E32317F7F8779FB4EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM4PR12MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 280e495b-03a7-469e-8346-08ddbe08ca70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFR3ZTVPZVVic2ZZQk93UEpISG1jTGEyMDRFQzdDcm0wY3d1ZnZhMmVXb0J2?=
 =?utf-8?B?Z0ZKOXEybWtsNWRNYnFmYzJQM3RaSmJoVEU3aWNxUCtxa29Td1VEVThmNEt3?=
 =?utf-8?B?WjRZYlFGWXhOeDJuRDBNMUJhZC9VQk9lRzRBZFRIVnZ2NHFON3MyM1pqUDV6?=
 =?utf-8?B?N3BLSktmZk5DNzJBR0ZDb1VjeGhjNi8vNGN4Wm9KNW9OcW1DekpiOE1XTkcw?=
 =?utf-8?B?VVp4MUpzMWk2TVgxR3RXNnZSVUJqS3JSZlNGaTk0QnFKd2ltMzFqa0YxZ0VV?=
 =?utf-8?B?aHg2Vng2NDVSVVZpMmp3WnZpd09jRVJEU1Jtd1A1Wm14K3NnMXIzOFgvaW1w?=
 =?utf-8?B?RFYvQ0tRSmRuV2s5eUVCUGdXTDZEUDVzUi9nVlZMa3R6amlhd2xnN0EvanFw?=
 =?utf-8?B?REZzVDVwUjRFQU5lNlAzNzBjcjA3YkNIeXdCaGNsY2Mra3dJWFdqUUJtaE5U?=
 =?utf-8?B?TFBkR1VaWGtMUmp6OXFSUmp2ckNmb0M1eW82M3dTTjltcFZtWXFBRHlxM0JQ?=
 =?utf-8?B?WE83Nm1uRS9teHMxajNNNTlQL0ZML0hxeXh4UXVjMnU3M3pBZzM1TlE1MmlI?=
 =?utf-8?B?QW9QdC9TZ1ZoNHpuM29sRVAvUDBNNEppazAyRUV6ZWZwNnJmQ1B0REVvZkM4?=
 =?utf-8?B?SjlqSkVxc1R3b29YaXBnVTVacmpWMEN3clpodC9DdEFYRVpYVnJ5c3ZhSmpP?=
 =?utf-8?B?MlA0S1NTWWpWVFZrdUVMV284cjBpd2N0NXhCRFZPREhSQ0wvcnRhL3NRaHBx?=
 =?utf-8?B?WjlVTjVYeDI2Vk54c2t1UUREbDlIamlldzZBelI4RzdIbkZXS1V4MjhuZnN0?=
 =?utf-8?B?bVlxTjZUbnZjdFIyT2FCa3JndS9ld3MwUFI2NThNZTBYRlByTGhEYUxaMThI?=
 =?utf-8?B?UXhKY2xVNzgvRm9mUVN6cjI5SXZCR0V1V0pBMjdHaVFNMWlqQks1RVBaSnNE?=
 =?utf-8?B?RnFjNmpPNC9NNk9rbllMSjl1YzBIaHFoUHg1THZUS2ZPbnBOLzVKYUhXVTEz?=
 =?utf-8?B?Vkw5Z25DWTFRU08zV1FweGdUWnhzcHF1aDJqMVppV3V1UE02NVZVVlJJdW1S?=
 =?utf-8?B?ckFJNytxRml5Tkk4ZXE2a0xvTWxFSmJHeUpWcURkb28rSDJTSWJmM2pOMzRJ?=
 =?utf-8?B?ZGcyRStDb2pnaDVySWpldmo4UnVISzNIZm83MndBMzNwUkZmVXpCZUovN0lO?=
 =?utf-8?B?cUlHRDVSUnlhWURmT1l2ckgzTEJLamNhWWRkZEtlY2JaSzZ0NDBSSzJMbG9m?=
 =?utf-8?B?K09CRjJlN21uLzREOWJPamFTWjFvWVpQSFgrT1NTZnJma2JBYjFDbVdKbFhQ?=
 =?utf-8?B?cTdCbFdrSnhDUjFNL3IydHplZ2NhUllwY1l3cGYzclExeitzelpCM1J0UE5m?=
 =?utf-8?B?bzdFOUd5SGppL1hsZWp4RzQzMDVvTTBBcUYvZzFFZHhXRy9peGJRVWRhMUcx?=
 =?utf-8?B?SUMrRGl2dE41ZHhxdzIxOGl2bG5pZndsQm9jNmVyc0Uzdno3NGlQTzhRVWd3?=
 =?utf-8?B?MktKdXJYeERNWTUwWjBvM0E5YzhWZ3lkKzJiUzArcjVOOE9XZWoxdFBWTjlO?=
 =?utf-8?B?QWo3YmN0UysyN1RPNU9nRCtuVVNDMXJXOUlDeDdBcVRhZXBlM3ZYVmFGZE5P?=
 =?utf-8?B?M0hNQ0tFL3ZRbWZUdjgzZ0g4N1VoMjBBUE9yUUR6b0pCcnc4cWIwemwvanBG?=
 =?utf-8?B?Y1psWVZmNzZuUmt2VHlIcmI2eUNoYlkrTVliV0tGQmo0ZnJLbXlmZEwrMkNq?=
 =?utf-8?B?U1NuZmtlanNocElDOC9wSVZvV0t6MFZyb08raWhhMGVVeUk0YXNwU1Z3ZVJY?=
 =?utf-8?B?OWRXd3I1UUF5NzNCRWt6b3F1MnVUSHhjZ3l1elI4TFYxaFJadUJVbzhrZDRt?=
 =?utf-8?B?eldiN3JXTEFBN1ZmN0hWQS9GMTkwRk42K2pCc2JVYjNRdU1xajdCNkYxTG13?=
 =?utf-8?Q?VORyRmum2FM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFRBb3ZSOG51ck5VT1JnbGo3ZUo0dWg1M0xRR1dqV09hTnh4Yms3SUZHNGxB?=
 =?utf-8?B?ZlVEdTQ1b1pzSEk3Wk9Jd25OQU9FZW1PckJMWUVvaldyWUFLYVFpVCtnNWlG?=
 =?utf-8?B?SUp4OWdOaFpzN0NCclFDRGY4L20rdi9mL3p6WHJjZmFiRlVvaUNIaUd5ZFFa?=
 =?utf-8?B?MjM1RVE2ODdoTDJRKzNkaTBCbXdPak5WdFFOZEZMdXFLMFRJdHFMUlZLRmw0?=
 =?utf-8?B?T3kvdnFrYTAzYlhRQ1BpWTVxejFmKzJBbkp1RElta2JEdytCZnM0cU9odEdT?=
 =?utf-8?B?eGhIc0ZyMG1rMkpIeUVDanpVdS9jbDlnenVyUFl0UVhkZTU5Z096MkFRNWRh?=
 =?utf-8?B?R1liSDgxTDhObkp3WEpxRmgwUEVJeFk1SDM1M1hqVG1NSWZzYnZQUWUxWUx2?=
 =?utf-8?B?ZTB4L2RaTTkraFFoMi93ZkVaUXgvRHIwZVVJbXNJemp1UVo4UzVhZThZMnhp?=
 =?utf-8?B?dytIaTlYa2JkcVVPeFRpNWVTOEh3bFdVQlhaUW9BZzJhZU8vR0ZXcGJyU0t4?=
 =?utf-8?B?ZTlYbFFMRDlWVzhzV0lVc0JNOHNzVUpUTzhHaUVYRnRjSnpkOHlxdG5PMW94?=
 =?utf-8?B?TWVpbUZVRHZuNjlCZDNjSHdBSlR5S0VCeVlIVlFhWTdRZkdaWHpaQXZpdjJT?=
 =?utf-8?B?Q0FjZldoaERVRjNBY1NzVU5ITnNJVVpiNld1UkkraXMreTd3N1dqR2YyRUlK?=
 =?utf-8?B?dEpuRk9mOUtsaFFCVzlCWXNPWStzOVJTeHdzVlVJM0xmb3dYeTdwRWhyRHcr?=
 =?utf-8?B?U3FHTGtxMVc3YUo4T2lmbUYvdVc5bm1sRkZVdnFGT004UFlPTkszSG9LalJH?=
 =?utf-8?B?VWxsa0VWUWp1UWtkMk9oQmVIQ1pMRG1QTkUyditUK3YxbHY2cVNlRE9SUElp?=
 =?utf-8?B?czBzcGU5U3BXcXc4Mk9TRjl1VWpsbnpjNWZKTnJIZnFVT0RScElzUlhhTHdK?=
 =?utf-8?B?WVdCM2V4YWVxYlFpQnl1N0VaMEVBK2VHQ1dac1lybm1pdGZqT0xXRTJSaWNW?=
 =?utf-8?B?bllZU250MDNmSXQ0K3hJZHBWK0d1aWZqM2ZRemFQLzVQUTROdmh1eVRJVFNp?=
 =?utf-8?B?QlFkVm5ldVNNbU15bisrRmdudWdBeVo2d3hNanJZeFpub09aRWdWVnFWUlZp?=
 =?utf-8?B?NWZpM2RXbG9Ec1BjZ1FkSUFXQSsyMHdENmlPUHh5YUtCUWxVeVZBRXphN2FI?=
 =?utf-8?B?Y2MvQnhTY1ZlbjdIWGo0RUJIQjQ4VlFma21WNzZrN1RsNkpYYTFUUlBoYjFF?=
 =?utf-8?B?dm1FaE1iNmVwU0ppcFdHaElxNmN1T2FrUGZBMmt3MUdzVEhoTW5valUrVGMx?=
 =?utf-8?B?MUJJUE1BMElJRnhCMVdmOVFnRUdyZlBVQ2F5NHpDMGV0UG9MOWZFZEtVS0Mv?=
 =?utf-8?B?V3lsbnc4V29vWUtsbnRmQ1BJL1AyYllrVUtaSUlEdncvKzdKcFVtWm03Qm5W?=
 =?utf-8?B?VmZneEl4ajQvamt2UHplUUNrZGdWcmRoMDJlM1RBQW9QaDZGdHp3ajB2M3Fr?=
 =?utf-8?B?NW42R2NGa1lhYWRtZkJXai9SYjIzOUVRajZZWWg4Z3A5bGlYcGxrMmdTSmRl?=
 =?utf-8?B?U3ROclVUU1BKUy81ZVlLdCtDNXZvRkF5MC9mTFBGQy8rRkZaeEF1OGdKSjY1?=
 =?utf-8?B?a25WZFNkS25OV2UyZ2NKckpvcnc5cjZueWt1cm9Qd0RETnZwZ1BYN0VpeCsr?=
 =?utf-8?B?Q0owVWpTbWNhc3I5SXhVdVVpdU82MlZaaGdVR3JKZzZ6SzJYazlPR0UxV29I?=
 =?utf-8?B?RjRwMVVJYUtyaU9uSnU4SkhzN0ExVTNBK2pJU2hidnorT1N0MGFKWm9uMkg1?=
 =?utf-8?B?aWxka3k3VFpKRGg3TktlVkJyejYwakxRcHltaFBJeXkvNTA0RHJ3Wk11VEky?=
 =?utf-8?B?cm9JdVBnQkJTZ2hQN3d1bTBmbGZTRWlsS1R2ZjdveVovc0Q5WFNENWE5Yytq?=
 =?utf-8?B?THQrbDJxTi80YlJGNitkQ2JBRGpJWGNRMkZXM085QkdncnRnZmg1QkVzZ2Fw?=
 =?utf-8?B?ZGl3OEFROUZueUJxTkJvZkk1cjhtcklKUWxNM3dsMDlPYk9ZbC9KMjBseDV4?=
 =?utf-8?B?eG5meFVnMWtKbHVESXFYdkNIeC9LL2oxMXlocDkzbGlwRHlVUFpMbnMxVytQ?=
 =?utf-8?Q?qYjYNaeJzB+17ASbvRuhPlFhw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280e495b-03a7-469e-8346-08ddbe08ca70
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 10:18:32.4384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrOXc+FJ+8nMQNleJzVSwVFztnE33DwXgdPLkzZw/iUNMyke41R2DqAL71gWaeYy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552
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

On 08.07.25 11:28, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, July 7, 2025 5:43 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v5 8/9] drm/amdgpu: validate userq activity status for GEM_VA
>> unmap
>>
>> On 04.07.25 12:33, Prike Liang wrote:
>>> The userq VA unmap requires validating queue status before unamapping
>>> it, if user tries to unmap a busy userq by GEM VA IOCTL then the
>>> driver should report an error for this illegal usage.
>>
>> Clear NAK to the whole approach.
>>
>> We should never deny unmapping a VA because it is used by an userqueue. This
>> can cause a rat tail of problems in userspace.
>>
>> Instead we *must* suspend the userqueue when the VA is unmapped and deny
>> resuming it.
>>
>> I think we can do that by adjusting the usage of the eviction fence for the BOs used
>> by the user queue.
> I'm not sure understand correctly, do we need a notifier for the userq VA unmap event
> or at amdgpu_vm_bo_unmap() directly invokes a new function of canceling the userq restore work and marking the userq state as hang to avoid further using it.
> Or only do the userq VA unmap check at the userq restore work? If not, could you give more detail on this solution?

I haven't fully flashed out the solution either.

What we need is a) that amdgpu_vm_bo_unmap() waits for the eviction fence of the user queues to signal which suspends the user queue and b) that the starting/resuming the user queue validates the VA addresses they use and makes sure that the eviction fence is publicated.

This way the queue never starts or resumes while the VAs are not valid.

Regards,
Christian.

> 
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  9 +++++++++
>>>  2 files changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 30838e5279bd..221292b6417a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -281,7 +281,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr
>> *uq_mgr,
>>>     return r;
>>>  }
>>>
>>> -static void
>>> +static int
>>>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>>>                              struct amdgpu_usermode_queue *queue)  { @@ -
>> 290,10 +290,14 @@
>>> amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>>>
>>>     if (f && !dma_fence_is_signaled(f)) {
>>>             ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>> -           if (ret <= 0)
>>> +           if (ret <= 0) {
>>>                     drm_file_err(uq_mgr->file, "Timed out waiting for
>> fence=%llu:%llu\n",
>>>                                  f->context, f->seqno);
>>> +                   return -ETIMEDOUT;
>>> +           }
>>>     }
>>> +
>>> +   return 0;
>>>  }
>>>
>>>  static void
>>> @@ -509,7 +513,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int
>> queue_id)
>>>             mutex_unlock(&uq_mgr->userq_mutex);
>>>             return -EINVAL;
>>>     }
>>> -   amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
>>> +
>>> +   if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
>>> +           drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy
>> userq\n");
>>> +           /* For the fence signal timeout case, it requires resetting the busy
>> queue.*/
>>> +           r = -ETIMEDOUT;
>>> +   }
>>> +
>>>     r = amdgpu_bo_reserve(queue->db_obj.obj, true);
>>>     if (!r) {
>>>             amdgpu_bo_unpin(queue->db_obj.obj);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index f042372d9f2e..c8cdd668a8f2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device
>> *adev,
>>>     struct amdgpu_bo_va_mapping *mapping;
>>>     struct amdgpu_vm *vm = bo_va->base.vm;
>>>     bool valid = true;
>>> +   int r;
>>>
>>>     saddr /= AMDGPU_GPU_PAGE_SIZE;
>>>
>>> @@ -1949,6 +1950,14 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device
>> *adev,
>>>                     return -ENOENT;
>>>     }
>>>
>>> +   /* It's unlikely to happen that the mapping userq hasn't been idled
>>> +    * during user requests GEM unmap IOCTL except for forcing the unmap
>>> +    * from user space.
>>> +    */
>>> +   r = amdgpu_userq_gem_va_unmap_validate(vm, saddr);
>>> +   if (unlikely(r && r != -EBUSY))
>>> +           dev_warn(adev->dev, "Here should be an improper unmap request
>> from
>>> +user space\n");
>>> +
>>>     list_del(&mapping->list);
>>>     amdgpu_vm_it_remove(mapping, &vm->va);
>>>     mapping->bo_va = NULL;
> 

