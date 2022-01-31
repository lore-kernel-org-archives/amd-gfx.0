Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C50FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 15:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A0010E2D5;
	Mon, 31 Jan 2022 15:11:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CD710E2CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 15:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEXFSJ5+wk81IZf2qQOGSRc/TRPoSoibpDYIvkVrnvbpwFI5lWroz71GpFbCeyPxach67M8srkCmzXU5h5hjsc7VxyQAmnvJq/pfNdY662jNsG0qLIn9137U20jkhf7QjcZvmODfdwlm0uhJFXn0DOrf/HNE9zKz+d7XiLcIGYNRkAdL8cUz888Xvh3TOXdMAyY7/ifb10gQKzoGsMVfhFn2BmmJypy1cVeuXjC2PRM927eGAAEOGEkPWQ5d3CFQ93315p5T4jqbwGdnVJPz/+FifZEuwDMr24L8J0u+Fe41aMFx9I+RSNBvsC3PGGsuuEDHA9DkoSUhREGmmXw1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwgDm8zNIfn3OY/CrbPS79DJrI1fsDEgfdFM3bIBBh0=;
 b=PL+mdz8ueeEHnF0BDXVsqp8YhCBwnV8GIH3gV+FK+7n3ND6aeBZNtyOx9xkclwv77H14gf2KFIt1tObhbC6Q1MB0T/biJYropTQjBSNoYSkhT03bMXvUO4l6rrXKuDQoJ5QLVKTtXj1C1RTXaOXIOmnFr44ni8BxXBTR/4ektGCClCbPC0tKOoa4SwFRyCCWILnoua6XJtWtAFAi6OL1xKWfG5D+dmg/YHRmYykZOqvfbdyaWSoq/aw9EWYpFmwwdJBd6hY3Rnlu56C3pvBb0yDCktS1ReUXv0hDaDFuj/XC+FgzVaJfY7ARRidJbyU2BqGhyfY1IEr8kUjG1+fHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwgDm8zNIfn3OY/CrbPS79DJrI1fsDEgfdFM3bIBBh0=;
 b=kUaDYyjuPb9iTrBan7jmP0WPJ3shkv5oC8LNEVSAYZSWHJfc1vY583C0pvuG2trbrN5XfWR1xq8FHATUQlQP6RkMgcWWbmgld7zXCJJHHzdz1RN5cm5LgpR+gc2r8NPg5BUde66H7y3kcK72PWAEWIKxPzyGwRrmrAR9JSvq2Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1309.namprd12.prod.outlook.com (2603:10b6:300:10::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 15:11:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 15:11:50 +0000
Message-ID: <a38eeeb8-0103-de62-405e-01a26fef75bd@amd.com>
Date: Mon, 31 Jan 2022 10:11:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: use unmap all queues for poison consumption
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com,
 john.clements@amd.com, Jay.Cornwall@amd.com
References: <20220130073832.17226-1-tao.zhou1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220130073832.17226-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f309ae34-09ad-4261-ae61-08d9e4cc018d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1309AA29A3380F00B311B3EB92259@MWHPR12MB1309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3xhMXlsjixA/wof5DchfByXJKrfNlpYmSxdqqhL7AH7Hlty+9VasUyAriENJHzccaFXLZKJwS41vsL+jI0OeZ30emLHwFZbGbs09GEDYaDiB9ZRxGUkpzQBQwLxCZUDj6Y1oq0we2fuPFqBIVp0iAObTj0NTHb+vyKr6/x/cxRV6CwDCTy3nYAxN9pQ0qd4P9ZKnM96zPa0tzf+I6earP2k4jWBnNrbOZkzY3lF7VBK40vjUm9HJbiWSiivXXJdVYVpJ+/cjgkbyeTg30oGytPhZ3M0a2Xs/GdNoS32l/koToRK6LhDS4lIyjtttDNmN+oaupRHkUetDVjmJ2x/yDujeFG9fv87soKd130rIlXcFjJIfXjrML07XMHlMnwWo2gBsIdiSXHQRxH1hBZFwSlFYdL5KqsYjoH5CBOQymQsXaiG2YU0Dw+TbFd4vHgbWUsiDnEZA7Jrl7uMeQNt5j0ooBRMgVcTs+djrO4zZQc2Ii/Tql6dpXIpamT1y253AlK1APQAxK+6A1c9nayT9yeyzFfRX1Ngv0Zk7ftTfniABoM8noVg/Edkkicd2IaCdlzh0kD3viie/UcxOlBz7w1w7VAm1gGSLNKBDPuhQshhw+GAnDhl+OpZVSR4wuPAltcFO4ctMAzcqG5vwkHuPAfwZBezXbGTVwcugyNTj4+enPmW8fOWFCI0ayde/mOtwPffdHvhYSZfuv6rfcMxx3VPpKOdELHEZCFEinj2GnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66946007)(8936002)(66476007)(31686004)(8676002)(36756003)(6512007)(316002)(508600001)(6506007)(38100700002)(6486002)(66556008)(6636002)(2616005)(2906002)(26005)(186003)(44832011)(31696002)(5660300002)(86362001)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHVMSUN6MVF1cXM4NzN2UktBL1BUUDBrdSt4NXJremJxdnBWb00xQytabzlC?=
 =?utf-8?B?WW9pdGtlVW8wNHVlWEpqd0M3eURPeFBoZXpDRUFkRno2MlNLYkRPSDJXQ0E3?=
 =?utf-8?B?TFFFanJHOTQyZUxJVE1sbDJYZ3IzSVpGNm4wUyt5dTZLVjVrdnZwZlBwendB?=
 =?utf-8?B?RzA0QURuaGh2Mms3VVMzNXJkQ2Y2TEZsN1hhUVQ2bWVhdDZzdlowNXlWVGtV?=
 =?utf-8?B?cC9XVzJyTU5Sam9NSnIzZDZqc0RTRHM2d1diNkxwZE05cjBsNHB2N0tNdXFP?=
 =?utf-8?B?KzBSL3IzYW9BWFczSHhvSVN3bWVxOEdsY0R3c09GbEhYMU1acEd5ZUNvaUpi?=
 =?utf-8?B?TWxHZnZ1cG5qWFpCWnRNS0NtK2tFZUhEZjhPUVpvc01TaTFGcVNpQXYwcWtF?=
 =?utf-8?B?Q1lTaXEvY1Q2UUxtNkhmOWlGT2UyMmRScjE3d0Jod1hrajhEbmh6MlZxUXBn?=
 =?utf-8?B?bk0rQWUxRWQrRWhkSmVpYjRBYUVBUVFPOFRLcmx3WlhIMFB0U1Z1aUVLYjZ2?=
 =?utf-8?B?UXYxVGZrNmszWFNiYXJWbUF5UWZ6by8zZnBMeXE0NnYrOHBRT1BEM2Rodkth?=
 =?utf-8?B?THVxMHRkWnQ5Qi9XVUd2OG5lM3F2eS9PcEtteU1pd1V0TGFyeGh1RDlCUy9z?=
 =?utf-8?B?dmhtbURvTndtWDRJUHNET1pNQVMrRVZYWDgyMnNTUm4wK1BBV3d3bHJFTldt?=
 =?utf-8?B?UC85cVlaMGFFZ2x3bHNzTzhlSGVOaDhiVC9aeVVKc3pWUDFuUkltZE8vRkM1?=
 =?utf-8?B?c2M0TzRsekd1ODlsVW9OcTYxUXpzSTNIcFc2SnJnei93R3lwSlV5YWZNOGx4?=
 =?utf-8?B?TnFZUlJUQ0wyemMvNUI0MFVHZytQMC9oY3E2VFRmcVRpQmhwblN1NnpvTjRO?=
 =?utf-8?B?U1ZRbFgrYy9ZdS80Y1hEMGV0MHR6NWg1MmNibDk1V0pWTmNjT0dUd2lBYVJy?=
 =?utf-8?B?UFJQdXdUNFR4YVpNTkQ4RkFOUFBjUzVaNC9rcHcyQ0NKL0ZmMGNtaS9Kd0tk?=
 =?utf-8?B?SWE2ajE1d0thaWgwNE9SVkFvZDJkS0M5S1ZpdGtpczF4SzFQSFk1ODZ4Nmcr?=
 =?utf-8?B?dHp4WlF2TFJTbDg0OUgrc2lYc0w2NEErMmVYek0zR3R6MWtBbGRSZG9vTlJt?=
 =?utf-8?B?c1h1bDFMcUJhYkpPZnlGQTl6ZFdDaUxTVFBQUFNieUJFTUgrcE5lYjBURXhY?=
 =?utf-8?B?R2FOWVNyYVRjMDRTNHprcW55Umx3WXd2eFI4Qld1SDdUdzZoaGJmRXljMkMr?=
 =?utf-8?B?NEJIdVB5bkVZTGMwWmR5V2U3aU02QXdJbk1QbGYrV1h5KzBOUytDSWpKbWJu?=
 =?utf-8?B?WURXWG1GQnR4K2Z6SE5KcTNWZUVjSzZPdEg5aDlXVE1TaC8yMUFtdkpDcWpj?=
 =?utf-8?B?Nk5hMkUxZW9IOXJWaFJYZkpXZThGU1JGd1U1SmZxZ1hyaTVQM3N6ZDR5ZkJE?=
 =?utf-8?B?TzdrVFl5OWFPQXdNZ1J4d1g0R29DSmY0Wit1eC9iMWxOdDNVUHk5TTVoaHF3?=
 =?utf-8?B?cGdDZkl4aCtTdGovNW5ydCtlcFFjb0ZSZS9Pa2IrRVJPM3diZ1pEdWo1emo0?=
 =?utf-8?B?Nk1VeGtUemd3R2pQcWhYOFRCTFU4NnRCdnZRY1JMU1FvSjJoRytkOG5raEp6?=
 =?utf-8?B?VGdUQVFDempWdGlKQlhPOXorSWxUaVNsOGVmYm1IQnRoMUQxbk1tcVdZc2JN?=
 =?utf-8?B?MWt0YVJWYXJmUklIMVZKQXk2ZVJVK2xmZzMveEdtdE5jdjlwekk5NDAyQUFL?=
 =?utf-8?B?WTRreE1TRGdVR0U1M3NQbU5pRS93TVVYbjFxSmJQSCtDV250cFFxeDhXT0ha?=
 =?utf-8?B?dDNZTEpBTzhNWHhsK0RTNUlkeS9iWnZBWG5WUE53bVpQTExSVStvUFBKMzRi?=
 =?utf-8?B?ZmFzVFdWTldmTnR6bDVhYWd2V2I4dkp5R25CMEpoblRVMk5VS2V1UCtVelFQ?=
 =?utf-8?B?VTFheE9zNHM4WmNjb3lDMWN3NXJOSTloYnZVSWgvM3BzbkxHNW1laWVoaGw4?=
 =?utf-8?B?TU9RV2VjeHdTMkZhUUMva2NlUzV6TlVERDlRZVJBWUNabWk1cFM2L2VLNGhy?=
 =?utf-8?B?MkM0TzNSVVlLNzBrQXFzYS9DcUY2SzlDVG16ZjdrczczSlIwQ28yK2VNeFJD?=
 =?utf-8?B?TmNURHh0ZGlQMjhxei81RnZBcjZVSE9NakM1cVovNHBaN1Fwa2VYdzhSeGNB?=
 =?utf-8?Q?WHyyI/nk6SIqDqK8zB5Ov/I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f309ae34-09ad-4261-ae61-08d9e4cc018d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 15:11:50.4377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUygX/4FHAz01AZB4eOTwNom+qc9ZVMDR86G9K1B0bbaR2d5cTlSCFQf/WTOsmn0zZux/E+El7Ai1BMDHLTc6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
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


Am 2022-01-30 um 02:38 schrieb Tao Zhou:
> Replace reset queue for specific PASID with unmap all queues, reset
> queue could break CP scheduler.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>

The change looks reasonable, based on what kfd_process_vm_fault does. 
But the function name is now a bit misleading. Maybe rename it to 
something more general, e.g. kfd_process_mem_fault or kfd_dqm_evict_pasid.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e8bc28009c22..dca0b5fac1db 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -109,8 +109,7 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   
>   	switch (source_id) {
>   	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
> -		if (dev->dqm->ops.reset_queues)
> -			ret = dev->dqm->ops.reset_queues(dev->dqm, pasid);
> +		ret = kfd_process_vm_fault(dev->dqm, pasid);
>   		break;
>   	case SOC15_INTSRC_SDMA_ECC:
>   	default:
