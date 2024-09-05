Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4071CCD5BAE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 12:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53B510E886;
	Thu,  5 Sep 2024 12:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BfjEHdqU";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8148810E886
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 12:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfmHSK2pg9t9OV3+Yw7X3ps6+Pp3HYekmZCmSWYuZPWE1X9RLhwyiCrH+0iNIzva6fQFKY86ll/8MdbcPBpp8wNBPmURo0GRAp2iR6rND6HjoR3+noKxHlGl1mrva3Pl2RizlV6iGM0Ler50qzxXRkeD5acGd+GSu7zKB8ihx0sNseuKLc0eAEoIkxZpEQconDEXOD8z8uaT93HBnH6cu/6NSmp8vlrZmgPnjjYv+8Ur9Su02sOJHgH/JqGdoLMtfNpNZoUHtkBwjX/6+FG/jO0MJUMuSQRwf8+6h7RX4WAS93ioQc8aDE5ey4HaB5HAHv+OJBPs+9pBqjN9cH8j+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3WLqRvw062JZCsuB6Ga8dxVxgQpfIjTmqOr7wbt5Bk=;
 b=ylbRvKL2Wvrypw0PjYETOS4AWnI7XFc20YeyF0HuPUB9ozscqt9q7zPSTYTlO2ivYq9k+2MfmJzMSafxg7w2VdAmgL+guDMmlyj4HepMwEsPg/aIP5Txo65BRGzQcK2ez6G40LjbmyL19SCi7oJ6isre0dWYqT6dcoJWbvLrIa6ykr30c+5eYrJVGggZnJZzBoiSLPUgNq9fceYeE3z68Mf7qIvraU+uEm8rskJqi9KBwtyEzz8qGk3DFvJyx53swpeo/Uo28vcIYoBO7xf7lEhsU8Ju9D0vruLqLLu+HnnDXsB9VVTR3gTy718OgPDNVf5Gp60v61V2wU1fmRUDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3WLqRvw062JZCsuB6Ga8dxVxgQpfIjTmqOr7wbt5Bk=;
 b=BfjEHdqUYlLA31av8vLeMvLqFL2jn550DJHkotpkB/iGOVyZ7+WhbMpUA6R1J5wEm1nK7QeCmwlqh/eS2y3gT9bx79VxgzVdaAtujIxp/aDEDEAnfESqB+JAhIEdLJo2pSu6cc+HFyAOB3As3Ad02wjqDAD+x+LGx1nY/fF9Z/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 12:40:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:40:16 +0000
Content-Type: multipart/alternative;
 boundary="------------wYZ5xnJFt4BItxcDX40ZEbMY"
Message-ID: <b693de66-ecbb-4270-b52b-341a9c69cbe5@amd.com>
Date: Thu, 5 Sep 2024 14:40:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence
To: "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Prica, Nikola" <Nikola.Prica@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>
References: <20240905085841.18189-1-Dejan.Andjelkovic@amd.com>
 <c93d6652-08fd-40fb-a629-d52bec489ede@amd.com>
 <CO6PR12MB54412BC4A08D1335062D28C4E79D2@CO6PR12MB5441.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CO6PR12MB54412BC4A08D1335062D28C4E79D2@CO6PR12MB5441.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: eec615f3-593b-4eba-a219-08dccda7e51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L09mVHVZZUIzU3hkUzdBQkx3N29Zb1c1M0l5cyt2aFlPblN4bEdaNituSzNo?=
 =?utf-8?B?cVZXK3VPdDZxVXBRcUpLRHdEU3E5MDNTTWUrMmY0YlNuYitQZ0lKQ3NiTmtj?=
 =?utf-8?B?ZUttUFo4ZUx1SGg0VEdZR1ArSGlod3ZRRTR2MmxyNjRaTi82MTZkOUM3OGRL?=
 =?utf-8?B?R1JyM0lKK3h3bjFXbWNPREhYWi8xZURvdXFHMjRBaU5Vb0R3aVRnZGY2cG94?=
 =?utf-8?B?NmV6Sy9GRFcyV1BpbFRRVHA0Y2pwdTFZaEFzbnJmRzl0cTV2c2xIT09zT2po?=
 =?utf-8?B?Y0VVeEhocERkWHZvQWFPcWhQRmNsWnhIVTJNcTlHNk9MSzY1blRKM0JVUmoz?=
 =?utf-8?B?YzAzRXhxTGZ5VzlnVVVJdWd1V2I1T0pleSt1eUx6azdXZUo3WlhkakRuaXEv?=
 =?utf-8?B?UkNZSGR4WExJUzFBYVluVk1aK3BCRUZqMWJUUSsrelVPQi9RNlFCSXRBblEx?=
 =?utf-8?B?YmMySm1jakpwbzVNSVJPMUhOcnlIUm91RFBkaWZJRWkzR1B4UFFxemlaVlNO?=
 =?utf-8?B?SndSSDlFRGNTTCtZNDBwMitOS3ErZ0lDRlhNL09TSzdRQThRTlBlaGIwTGVx?=
 =?utf-8?B?eFNRYkdvODhhTTREalVJZ2x3V3lVbWR3TDlBMlJNZncyN1ZESTdyVnkzSUVR?=
 =?utf-8?B?YUVYOVd3M0hZREh6STNDUGQ1S0pNL2pGMk9XeVhoM3d3dE00MGtJUkVocUYy?=
 =?utf-8?B?V1NOSDRHeGNuRk9TUjEwdjZvYWY1SmVuSlB1L1I2dE5QaGRMSjlOZlNDUkFK?=
 =?utf-8?B?N1hRWTZ6czBHNEtlS3ZqNmthdzNkRWx4UU94YjJSNjVYa28yNHF2TGJRYko0?=
 =?utf-8?B?T29kS3lmejRBWnZRa0tGQ3pOOW1kNmVLazBtZjNkMldpSnUxM1RIdldVQTJM?=
 =?utf-8?B?WHlRb3NYVlJQV0RUTWM4WlQ3c2RWMXgxQzgyVUVZbzFZcG93ejhVS0hra1Bt?=
 =?utf-8?B?c1Bta1Vta2ZIR1ZscVFVYVpRdHg2d1Npd0dsdlp0SUMzUFpyazQreStpNUFn?=
 =?utf-8?B?N2JlSWswWVkxeS9ZdWZGOG1QY2Y2anAwZmhLN3ZnVTd1dmJyYlJCbGpTK1g1?=
 =?utf-8?B?NnZOcWFOMVBrc3ZGRWpYaGRoMU9xVzJ4OWJMV1BWbHRsRmtabllrZFgvRlJ5?=
 =?utf-8?B?NEQ2MEloUUVnQWM2b2RoQnovSnMzSVhuUW83VU5iRWZCcFlWc1dqQ2k3VkNk?=
 =?utf-8?B?UXdnSlZsOEJMUWQyMkhJdDFpMURoSytaQkNwS0JldXMxb1JFVEM0SktjRDlX?=
 =?utf-8?B?Y2FwODNmOXpDT296VVJ2VjJNVHdyNlFKMEgraXJGUlRmZXp3cHZRMUNueTBW?=
 =?utf-8?B?ZGFQUWRZMU40WEE4ZXJuSnRMY2hoK3p5OWJ4bUtlT3drWnk1R1BhRThkRlor?=
 =?utf-8?B?MGdZRVNjcnRBR3JmeGJzYkFINytXMlgrM0pJZlF3TThvMVJUN3FQU0R3ckNU?=
 =?utf-8?B?WFZiQW1ob2hsY0gwYTI1a3RRTHJxeUF1QjBGUGQ1ak5qSFRuWVRsVTVKSWx6?=
 =?utf-8?B?UlNwSnVMT214cEVNWkd1OGZnazduMDlDTTNZOVpCeUFJb3NuVU1LdC9vQ1pM?=
 =?utf-8?B?bG5FSE1ERWEwN0ZYdmtBYUNsWi85aEVRR3dQdUJYZW1uWW5JWkJpcXNVRHU5?=
 =?utf-8?B?T1JBSUN1eUVoVXIxSWhBQjNrZHhJRUdpTEFGR3hmTzNPS0xhVjIyODZIeVN4?=
 =?utf-8?B?Y1lhNDJMZmZnRzRlVmc4QVRtY1VrTVhmM21GZ3Bra3p2RHVjSERlR1RkYk8w?=
 =?utf-8?B?T2gyaVE2RitrNGlTc3h5L2hsa1JReldoYkszMkNwckZJV2lGRUhkVUdJdGNv?=
 =?utf-8?B?WHZtKzlndTlsK2xDdWh1dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdmaUNuUUE2T3JURVUyRWFYR01nbGxSWHNSajRBRVhjWjZVVWQvZWpvYis5?=
 =?utf-8?B?K3N0Zk9xTHlsMkdnM1pNb25XMUJUZzgyMXdFZGVpRzNQNlloODJmV0hnbFRM?=
 =?utf-8?B?ekV2WHI5RTZZandVci9KaWp1TWNqNHV1OUEyc040YVF2V0prTTFIZnJscGdH?=
 =?utf-8?B?MDFnNHZldjI5ODIzT3BneHUrcHVLWjFvUDBVVEFYZmlnZWMrRWFZY1NodTc3?=
 =?utf-8?B?d1doMFBtWUNGWnFHeGpMdjV3L3E3b25Pb3ZQUW5NcjRWRHhHRzUzYlJjY01t?=
 =?utf-8?B?eDFmTUlrZ3gvMHZHS2VmYjNDS2xsZGZMOWdObUFuVWMwMWZVY2s3QzI1L2xs?=
 =?utf-8?B?Z2dQV3NsY2N2UW9GL2VQcHdzVTh1Ky9hSXpsUW5RVy8yT0xqWUl0VzFCNnZC?=
 =?utf-8?B?RTVlNWhJdzNVWVdjQWxSTlJ0ZmdnYzQrd3ZYTnRjZ21MOVFMamFSS0FOVis3?=
 =?utf-8?B?THFQZmVBUHdPbGdvRVBpWFVSWXBuSnVXWkloSGluV3NVcDZjYWZLbCt0cFo3?=
 =?utf-8?B?a3NTYUpqOHY4YzJITy9GM00xSnlqRkt0MkRGV2tWakdjYVV0LzVHTWFacDAw?=
 =?utf-8?B?bnZqM2xkcjNrZHF3R0FaNGltVkNFNkZiQis5cUZpRk1wRnJDdmV5djAxYllS?=
 =?utf-8?B?YUE3OWZKeHVrMmtUMWtmdW9rVDE2Mm45SUtScFNGWFpQNWVJSmViQjdsM3oz?=
 =?utf-8?B?d1FaSmpvQzhBcEhnTmJQTlc2eVFUTnh3NlByaTdHamVGRUVJR3Q1UUE4VlZZ?=
 =?utf-8?B?dGV6eThTUEZwUjZrdGtrSVF6MW9WTW5pbU5rM2hJYnJRcTNhWU9VcVZFaVgy?=
 =?utf-8?B?VkljcktRaU44ZDg4eUowcnhyYmxaVGtiaXg5THY0QTdkNHh4R0d4TmhKWW5z?=
 =?utf-8?B?Yis2Ny9saHQ5bkthWFY3WWRsN2w5V3JxMEt4K09lYVpkZGVhUkYxalo4QUtH?=
 =?utf-8?B?RDVwbDdROXdEdVBDQmN5M2Q0NEVIcnkwVVo4V0VlYmp4dWpVSDJFdnJwc1VN?=
 =?utf-8?B?V1BZSFJ2QUhFbldON3FFS0tMVHJHV1RCVlBOdjUvL1k2UHpOeVRiWUovcEVV?=
 =?utf-8?B?TXNKemU0K1dxZzdUKy9XcVNHQksvWFFka09Ud2FycWpqTjdMQUJJZ2ZSSW5k?=
 =?utf-8?B?NCtXbGFSeTEzVGx1enFEdWxvdGNtbVo0UHRuZXFSSVZaSVlGUEsvMDk5R09K?=
 =?utf-8?B?S0RQWWxDaHFVM1pBYzBRR2MvQituNVUra0J5WEFiRHdxODRmT0ZXbkd1NmE5?=
 =?utf-8?B?aldKaDY0RE52QkpCVCt5SU1tVmxJckluK2d2NGt2YS9Xa1M1WGh2UEs0VWJa?=
 =?utf-8?B?eDBudzljR0ZtbERUbi9Jcms2TFJCeFZuRnJQOUhyR081dHBzeUxnOVhSNVlP?=
 =?utf-8?B?cTA0SVBFVjRocWNuQy8xbTFhRHZuQ3pYdzNzU0VqSHoyaE1laVBEU2JBS3cr?=
 =?utf-8?B?UlNXUXlHQmRmdnRFbGtraURxTzVJRGhBZmpET3ljbnJFTTFEdzg4d3RTMG5w?=
 =?utf-8?B?K1ZKQTRvZ0VUUHJEUkVaUU8wWWRTSVRDVGhxTjYxN0dKaXoyOFNJSEdCNzhh?=
 =?utf-8?B?dW1RcE9mTFkvbGFXUGtzT1lzQ2VRRGVBN2RhZ0VRUllXWlBWM3MyaVdJUENq?=
 =?utf-8?B?ZmtOdzVTMHIrTVNib1diNytzbFczTXppWGJEQTlXc0dIMmdKS29zekhpdTZS?=
 =?utf-8?B?QlZONEJtOW5meHQ4SGpCWkx6ZTUvcEJwV0Ivbkh4SzNFOXd2WHFkbGp4R1dH?=
 =?utf-8?B?bGVUOXFkSThpL0pDQ3JjWVlmb2lCSThIVCtYVERhNmZrU1BGelhSWUgxZUxV?=
 =?utf-8?B?eEVVeEdaS2FaSmluRmhZUlYyQUpjWkpUZW9IVG1PRVE1amhiU3EyNmZ6Tksy?=
 =?utf-8?B?R2xVUit3ZENFTUNTM1J3djZiZEV4bVVKUE5pTXAxSFE1UDB0M3dlSWZrL2RT?=
 =?utf-8?B?NDdLcFdDb1V5ZzVlbmYwMG1tb0tzdkJxQTY0bDhmcitaSGhaVm53S1lJTnNt?=
 =?utf-8?B?dEFQRlNQbThqbzVJVGZ5RWc4UGUwVHYwT1pHTVZ2UUc0c3JSMmhIcjl2WnZR?=
 =?utf-8?B?dWRhR1ZZRHllRWYzWml3eGdReUE1T2NkcjJUK0gvYWhlZiswT2d6L2hCdkpu?=
 =?utf-8?Q?hy4TD3yGTOAI/oEo/DK9/CJPM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec615f3-593b-4eba-a219-08dccda7e51f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:40:16.8180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r2JIWpMMnU2f4s6znWgF/qTMQDplw6cB55Wku4udXPGorYxT5C6TRB8cYyLoBPf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
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

--------------wYZ5xnJFt4BItxcDX40ZEbMY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Well that explanation doesn't seem to make much sense either.

What do you mean with TLB flush is occurring prematurely?

Regards,
Christian.

Am 05.09.24 um 14:38 schrieb Andjelkovic, Dejan:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Hi there. We're running into a page fault issue that's very easily 
> reproducible on a SRIOV environment when using SDMA for page table 
> updates. Going through mapping logs and trace files, it seems TLB 
> flush is occurring prematurely. Changing the usage to KERNEL 
> completely stops the page fault from occurring with no performance 
> impact, which was confirmed with extensive testing. Looking through 
> amdgpu_vm_sdma.c, namely within amdgpu_vm_sdma_update when waiting for 
> PD/PT moves to be completed, fences are iterated with KERNEL usage 
> specified which are then added as a job dependency.
>
> Best regards,
> Dejan
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Thursday, September 5, 2024 1:17 PM
> *To:* Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Prica, Nikola <Nikola.Prica@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Raise dma resv usage for created 
> TLB fence
> Am 05.09.24 um 10:58 schrieb Dejan Andjelkovic:
> > When using SDMA for PT updates, a TLB fence hooked to a buffer
> > objects dma resv object with usage declared as BOOKKEEP leaves a
> > chance for TLB flush to occur prematurely. This will lead to a page
> > fault. Raising the usage from BOOKKEEP to KERNEL removes this
> > possibility.
>
> Well that's complete nonsense. The usage model is for implicit syncing
> and not even remotely related to TLB flushing.
>
> What exactly is the problem you run into?
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index f93804902fd3..8efc2cf9bbb0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -928,7 +928,7 @@ amdgpu_vm_tlb_flush(struct 
> amdgpu_vm_update_params *params,
> >
> >                /* Makes sure no PD/PT is freed before the flush */
> > dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> > - DMA_RESV_USAGE_BOOKKEEP);
> > + DMA_RESV_USAGE_KERNEL);
> >        }
> >   }
> >
>

--------------wYZ5xnJFt4BItxcDX40ZEbMY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Well that explanation doesn't seem to make much sense either.<br>
    <br>
    What do you mean with TLB flush is occurring prematurely?<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 05.09.24 um 14:38 schrieb
      Andjelkovic, Dejan:<br>
    </div>
    <blockquote type="cite" cite="mid:CO6PR12MB54412BC4A08D1335062D28C4E79D2@CO6PR12MB5441.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Hi there. We're running into a page fault issue that's very
          easily reproducible on a SRIOV environment when using SDMA for
          page table updates. Going through mapping logs and trace
          files, it seems TLB flush is occurring prematurely. Changing
          the usage to KERNEL completely stops the page fault from
          occurring with no performance impact, which was confirmed with
          extensive testing. Looking through amdgpu_vm_sdma.c, namely
          within amdgpu_vm_sdma_update when waiting for PD/PT moves to
          be completed, fences are iterated with KERNEL usage specified
          which are then added as a job dependency.</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Best regards,</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Dejan</div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, September 5, 2024 1:17 PM<br>
            <b>To:</b> Andjelkovic, Dejan
            <a class="moz-txt-link-rfc2396E" href="mailto:Dejan.Andjelkovic@amd.com">&lt;Dejan.Andjelkovic@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Prica, Nikola <a class="moz-txt-link-rfc2396E" href="mailto:Nikola.Prica@amd.com">&lt;Nikola.Prica@amd.com&gt;</a>;
            Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Deng, Emily
            <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: Raise dma resv usage
            for created TLB fence</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Am 05.09.24 um 10:58 schrieb Dejan
                Andjelkovic:<br>
                &gt; When using SDMA for PT updates, a TLB fence hooked
                to a buffer<br>
                &gt; objects dma resv object with usage declared as
                BOOKKEEP leaves a<br>
                &gt; chance for TLB flush to occur prematurely. This
                will lead to a page<br>
                &gt; fault. Raising the usage from BOOKKEEP to KERNEL
                removes this<br>
                &gt; possibility.<br>
                <br>
                Well that's complete nonsense. The usage model is for
                implicit syncing <br>
                and not even remotely related to TLB flushing.<br>
                <br>
                What exactly is the problem you run into?<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                &gt;<br>
                &gt; Signed-off-by: Dejan Andjelkovic
                <a class="moz-txt-link-rfc2396E" href="mailto:Dejan.Andjelkovic@amd.com">&lt;Dejan.Andjelkovic@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-<br>
                &gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; index f93804902fd3..8efc2cf9bbb0 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; @@ -928,7 +928,7 @@ amdgpu_vm_tlb_flush(struct
                amdgpu_vm_update_params *params,<br>
                &gt;&nbsp;&nbsp; <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Makes sure no PD/PT is freed
                before the flush */<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv,
                *fence,<br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                DMA_RESV_USAGE_BOOKKEEP);<br>
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                DMA_RESV_USAGE_KERNEL);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; }<br>
                &gt;&nbsp;&nbsp; <br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------wYZ5xnJFt4BItxcDX40ZEbMY--
