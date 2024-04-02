Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D89C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 08:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C4910F63E;
	Tue,  2 Apr 2024 08:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dg9FXEOU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2092.outbound.protection.outlook.com [40.107.94.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7425910F63E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 08:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhki0xakIieHpljKY25n5o1wr5VRw4kRKMyKMK648FK7JrHpPpumMfUIobQ4tIrcd6xzBA26tHYctAFahBdJ8D3vGuKBTXHqPri3YocHgHKt6GCBKJQj/QDUXtvyQsbYHUwH8rqIUBOz5RxRYP4VYEeDtGu7Hbiy8Wsp790HpbTF2TbySXwoI36NWsr/MkKl0zAH/yXWHF3mzNe6QzR5ZrC7Ng2Fp4E/fZiA0xKJ5XlGjbjVfIpSc8jgocFCxDsapFH0YVq8T1kNiCLWrOh3QWfLQ+zy8iIs4zEbaIkk13jBiWwgpb4qiN6d8oXTbVF+rkgVh1DPch1vQ+eJHTUGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn7BkTm0I8HmtvZNvE91b1Es3jyJ3RPhqARxkdQG3kU=;
 b=dCNrOpxUqcQmsmp0nhA72lMO7e+TY/OHP92qG7PTQN7ldaTLASV/ZIhkpVfXyNPtbM4enC4/4LtIvXxyFIUsEhnpuYms6TgUQn2CD5kYQ0aaXh8niMOs+LFA4VVSEirIAsRIqeaLWz6JHKYBgcOY2f7Ha8fHWUEPYkkfFkuVOnd8+lUD2n0vEaKhYPYY5t5XXwG9NBEb+6S5+De0+M/roKngUDWyxy0eP+PGr0v/2chWUcckMYZPXck2sdbm6mTnenkxz4qXjTuxhqKETEZwLwz2sP/Q62SbUqH4OTmzl7uKEgcFtxryWE2zVWPJeiDGEtHasTPo70KOfdGFNqkIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn7BkTm0I8HmtvZNvE91b1Es3jyJ3RPhqARxkdQG3kU=;
 b=Dg9FXEOU9Li1N+K4DE/22KKNtdMzylVweCpm5cUsDZNwmozW9PwAvHUlBNwuLKc4IxUeGLP8GD2Xbh5Y/aYP/ZHqFozg6Ey/U8Fqa62K8GweWdYCh1gAecG5UEGqDiF+hkVdC1bz3mHaQ84D+jETohZhTE07Zyt00/bJ0yr4Bss=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 08:14:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 08:14:03 +0000
Message-ID: <1fbcd7b2-d152-4931-a7c7-2cc82ff9b543@amd.com>
Date: Tue, 2 Apr 2024 10:13:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear set_q_mode_offs when VM changed
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240402063737.2935698-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240402063737.2935698-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7772:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +T0h/Mcc0BzKjA+SJGpjiHp117PZkRr+15TNWFtSBP96LetkaWRB6igyTWhKJMzdvWaPrcB3+86GN6ZHzgvLrj9oM95geRKg1C+AodH4PyEiYvWTcnR6ok/MX0nJOTAAoQ9rC+D/wsw18OQcdvwghjJoJaTfcdNZR8FDZfEfjb4M9GUtVL63UCPpJu4/9+MqJKoyFX0b9UFGHUnPd5U471JsUhXm6oxsiaKhLdQdZCG0Cg/f9WebjMkAsA9sgHXpzZ+hebQoHSkfmHyY/SpL9SxVnoRzYfBB6x9A6K+8SFr3REuTuCVYkov0Pica28S4FxdgPVbhg9j5OC3sClu1ZRZfE2dsqJsgqs9obIN2XsoMF2jf6rzEvdfm+16JTEGMALmdgEzd6EiY0qXRlgDGbuZblZcuMjthf4YPRbKRFgMg8fzPhUJFqI6Urovot0SsZzUdo+d5GqklHAE8TVS+Gb9QLMwvVplfG9spRuq5AUUydn7Up9EN4+jIVCzUt4C0TK1Uuk5dVf3pTe0DBwihwzhvBJ9+y4+r0pJ8icfxbar347K8CeImGR/ugmiIFKaRBYvO4/UjbC6ccnmdnbtl95QpNGzbrUVRLsQZ28ZBYbtVbu3PeAyr68xiuhpXZ3qtLFiRUyNAX3+WiGC4C7J5NZlXczrGCc88XNQOLZMChak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkpaR2E5cUtzQ3ZuUWxoVXNQSmtwNUY5cm1oTE1EQU1rRXhqaE9MQktIZGhW?=
 =?utf-8?B?dEhVSVVKMDFPWlpYRVhOcUhlTVRKODVjWTlnYWVUQWxUNmlEMTZHQmNFOWpv?=
 =?utf-8?B?eXZNYzhteUFlZmdPVzQraThOeDlzYmgzOUlrVHM1akUva0R0VzFXVTI4R0Zq?=
 =?utf-8?B?eDdQTkp2WFd1TE04L0Zhd2pPK2JyQXVyY29yeHpyV3pkWUlkVW5meFlsRUJZ?=
 =?utf-8?B?N3gra0s2RXlxd2tOZU5nd0hUamN0Mk1wNU4vNHJxZnMrN3VhazIzSE1lYTFj?=
 =?utf-8?B?ZXpZK0I2L1A2aTdCeGZhWHpUUzFwdEphSmxkanZSMTBwTHZvbUJqc0svc3Bl?=
 =?utf-8?B?dkZBemtHT096azBZWFU5T1ZIcnphaytEQ3AyQU8xRmE1azJaOWh6d2IzUEhy?=
 =?utf-8?B?QjIvZG9DNTQ1N3g0ZWNhUnY0RVZldHBvNklPRzk5RHRZVnFXd25QT01MZG5Y?=
 =?utf-8?B?Zk1scGt6L0ROdWI0cGt1ZmJUaTZFYU5meUVtMXgyWitFNkZxMVVFckQyd2Ny?=
 =?utf-8?B?OHBlcTh6QjMwTHJYUzkrc1hKZ1dRNnN5RndhUFdlUW9GakpEd0I1Vm9PZCt0?=
 =?utf-8?B?ck03b3lkWEZVWFJxSk93dlVmWFJEa3dHSFBSWVAwVWdDbW8xT3N0L01VR0p0?=
 =?utf-8?B?VnFKNnBjU1VxeHNCM3FybmJHcmFQRDY4M0hraGNZWDc1WS9haE5rNjZQekVx?=
 =?utf-8?B?aDM2SkZsWHp2bFlFb01lTEV3RnhPSDJHZFByZUpMOXpzWkRMMW5aWkNnUHBM?=
 =?utf-8?B?WnVDOGRMSk9PQktEN2JzdGVzMkZpMVNmR2lET05Sdi9GeFpveDY0M0Z0SFAw?=
 =?utf-8?B?QVRBYk10QlFMVG9ML3kveFlhMzVSUVhRTWYwZzRUUXpuQ0pJa1E4QW5OditG?=
 =?utf-8?B?c2plZ0ZqUTFCZ0ljQS9rVXRhL0tkVExYT0szNEJaTERqanpWdlV3QmJ4Y2FF?=
 =?utf-8?B?UGNiTWpuMUtFS29oWWpEK3NXcmhlRENjRFRhWHJTbEpjODFNd3Y0cm12dkhy?=
 =?utf-8?B?b2NaZnoyNmExMTE2YnBvdmJFSmIwYm4zb2tCeDh4L29uakhNcHFnVVVPYUdx?=
 =?utf-8?B?SXo5b1FmUjVPQXlacFlsaWNmbWl2d0pRTWdKYy9yVHdVcnNxdFh0WEdGbXNp?=
 =?utf-8?B?VEpBUzQwUkNsTmR5bW5pOHJxMi93Nko0S3A1TmlwaWRVaXIxQU14S2NnamZw?=
 =?utf-8?B?R1VHVUVONWNTak9iQitiTkd0SmU5WStha2c0Y3ZmU2RMVWswOGQxUTNtczNn?=
 =?utf-8?B?Slh1aTRYZFA0enpPU2h0eTNab1FkVGRjTUhYczJ5MytFU2t1eUtQaFE1RUhQ?=
 =?utf-8?B?cTVZZVhlTUp5SG95R2NqL1NEeFo1bW9JWGZ6N2Z5NWI2UUlkVVVLcWw5MUpl?=
 =?utf-8?B?RjJ1T1paOXVaQkVFWnpkUzBQQlZBRElwS3dGbXB4WHVtbnVab1Nnd1YzSGRG?=
 =?utf-8?B?ZkxKTk5sbzBBYmRlZ0pCRHV6SC9pdUdDRk0vUnB0MXlQU3V1MHRpV1IvWFRa?=
 =?utf-8?B?MzlBTU9odjRVNmZEeUl0WWRlRjNlalVuK3cyR2IyM3FKbjU3cU5iUVZBWU0w?=
 =?utf-8?B?TXFEWnlDOHhQTERIVkE1OVczMEpWVnMrRUlFOE9GREJGZFQrcnE4UWRjWTRZ?=
 =?utf-8?B?WCtzaDdyQUV6dEdsZVE2N1dmQkFSa3NyUE1acXp2UmxoaDNlTVdrS1BzWVor?=
 =?utf-8?B?K0UxdURYN3BXTlZIUG5RaW9PRmdjT0F1ZndJYTlpZUF5THZCS2MyQllmaFl1?=
 =?utf-8?B?eTFIOHN6M2RlTjdCNGx0aG52akNoVDU0SzFkVFFxbnhnaHRrdUhtRnFxcXRM?=
 =?utf-8?B?SVRwbmN2S0h5QzB0cC8vNEZHWkpUOUVnS01jWVZ3TExFcURYYnJjaWwzWDhR?=
 =?utf-8?B?dC8wUFdBUFRjMzEraWFQdnBRYTc0RFVXNTFDbUtpRVlQT1FpanpuWk1DWWZt?=
 =?utf-8?B?UU9HclE3a3paVVR5UnJPNXpmMCtFOXNYNWFVWjhUbFRJRlI4cHk0TTh3WE0r?=
 =?utf-8?B?bjNjUXRydW5tL3cwdzRueTNCTmRDWkRDaE5hOC80Z2FLSm5LOHh6RHVGbS9E?=
 =?utf-8?B?c1J5SVF2ZEdoS1U4TGRYWngxajV5OUdqTUFLMXFYYXcxYzVjMFAvNXlPN0tu?=
 =?utf-8?Q?BOvcVtc5oxN5X3Yfi5GefZkOc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8876d3d9-1da4-4c3b-2622-08dc52ecdb66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 08:14:02.9397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WayWlUQT2v3F7HqRFfjAguPTdBxrae9WrT8Re0nXXzfw7hjNUbm/aRcnAA2ZPu5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772
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

Am 02.04.24 um 08:37 schrieb ZhenGuo Yin:
> [Why]
> set_q_mode_offs don't get cleared after GPU reset, nexting SET_Q_MODE
> packet to init shadow memory will be skiped, hence there has a page fault.
>
> [How]
> VM flush is needed after GPU reset, clear set_q_mode_offs when
> emitting VM flush.
>
> Fixes: 8dad9c062355 ("drm/amdgpu: workaround to avoid SET_Q_MODE packets v2")
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>

Good catch, yeah it probably doesn't make much sense to execute this 
after a VM flush.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 7a906318e451..c11c6299711e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5465,6 +5465,7 @@ static void gfx_v11_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>   	/* Make sure that we can't skip the SET_Q_MODE packets when the VM
>   	 * changed in any way.
>   	 */
> +	ring->set_q_mode_offs = 0;
>   	ring->set_q_mode_ptr = NULL;
>   }
>   

