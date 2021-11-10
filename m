Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4388261211
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4388261211
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A696E1D7;
	Wed, 10 Nov 2021 16:34:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A916E1D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 16:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDuQw1hr1doulExf1nBcA1GkhHNuWo+K1dnznyM3AjoShP9PZfY27W5UXs2TdO5LCvGMoVpkhP6DIpaClN/5RaGcxCQmWicM1m0+o2Pwktl0v7o7FrEhi5dwicqWYo7vWuhGx+wmdu/4Sb0AXrd2v2CLnTN5wf3kNVwhvzza9xUTPpHlT/we8lETtQ1JE+IZwnoTzRO5geXnK5ZAqnDOcSWY+UFO3NF/h+3ODGsK0E31d4x7VmMY75xmY63UeBnnp12UsYaDIcCDAZH8Me0fhUnVDlIAhxdz0xyqw3cUUvmfowXvAl0/7nT95uXxutAQrjcF4LcOmazscD+6CvfRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZCfJtOp0iC+rQlm+IPnxuykau8DhR0Jt3frtJ/ozjE=;
 b=aBXeOOkyz7kBkwnI+XUwvjrRMRj74tziLEMClRZkgw3oBucOaoWxDLlsq3N9149aaaORaB7xl0p8DPKuE+mEgzboh5R4EN2PqVbdMUzXdmjC2Sw0LU6/u7o/wU4yMQIAVqMxmGcQgvKz1MgwVtdnP2RPqPKLJPPvdkYXNJccUVxXkbYKrJxr8BZwU2GYCveb/kR2+MtxYmxaOyJ/cPDjAyKlaPVQHYsbiEqmrPn5Ohigl1dXy5RSDNzFMtuokrY27a/AT6Z/aVURPoaqb+62DIoanTwmxM9qq+HCSfWnj6q36DV0IUmBVDpHsrRLDrgPPCBZThmMeDVv4i3caERd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZCfJtOp0iC+rQlm+IPnxuykau8DhR0Jt3frtJ/ozjE=;
 b=3qBicrBEcus/7I7482ktUeFCb1p1yRT+gxinhZ4veqa/Z9eEPHMnTgRjVzeiKiLlzsi/ediHbTQ/5/msjQqcb2FUB4qXBG4Rk4hxG6cr0/GdgQ9rQ86s8rgKvOx0Waw6MeI70h/AAzomtNE5fPLN+q90MQHAJ6QHVMSEkhmjah0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 16:34:06 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 16:34:05 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211110023052.1872623-1-Felix.Kuehling@amd.com>
 <48473282-292c-508a-1a4e-42359c421f01@amd.com>
 <dd7f5e89-338b-c331-829e-5fba0594a0cb@amd.com>
 <DM6PR12MB39307C2E18445AA344F9930F97939@DM6PR12MB3930.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2d6f7194-bf4a-4bb9-b751-fe80ecc4e55b@amd.com>
Date: Wed, 10 Nov 2021 11:34:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB39307C2E18445AA344F9930F97939@DM6PR12MB3930.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::27) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Wed, 10 Nov 2021 16:34:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbbf56af-4913-4851-5d5b-08d9a467e98f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5032BEE6BB81E2AA29A6CD5592939@BL1PR12MB5032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPkxYU8nUKwlzyW/gGains2u2AwpXuSsJMqzL0evSS9C7+eUFbCJZYwq8jgOR7QBdoaRidPAhnXhjnLRZd5ckFOviirTn1e8iin/LaO/tcByNlBPpGyUKjUncY/kpdDXRD18G9LsWz7GM6mD+ye1vx7tlTtkldG0A43KoGjJ0nAhygEwrfEVLucDmcpl83H3DhthU4FEZW4M2+rgOxrOOzvzYYTyk8fFFsXQ9wPZD5uCfnnorSNblOGutOHKYXPAJboA6RNl5M0Bv/oc08/17PCxIHLKG10q3pfi/qVUDxHpWSPnOLYeTCOYevnzLPX+aw92jjVsYuawjad5SWo63BDTgL+7UI82/ne2FdAv06bMdGxERY4KuLq8LAQ7LLvG0ACl/J6szwshdpCQwhtIBCzDPpvAcbO0slEQHj2jq3Ye6NYuFgl8Euls7Jgephyh6jU583Qb1DBmvgelOABTTqHSHh8Ykfzr1KmtTmqTkxSf9O/G28IpY6tXXZWx2zuRy9hfc5n2HwYu2oMGSMRFYMAwAamoniaStguPhQCjjkrzHvYBfXfN27shoyubQksMgML7oBgkcD00ZWbZg2gbaXRt7djowwPtqqVIQgaY0AqpUSEQbDy+WD9RsXeA/ecP3tKcdaWC1+zRF3L9YKxEI2WjBO+Wg8oyM2lbg9jcHHt39MpmOo23GDFxPZTMj9JhSlmZridKMIqH3RhawA2h9DC5LiRf/akT3bIl2Ve7hRIwNiwKPh0AGqJ1FXbHBup2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(31686004)(86362001)(53546011)(8936002)(110136005)(26005)(5660300002)(8676002)(31696002)(16576012)(316002)(186003)(508600001)(38100700002)(83380400001)(66476007)(2616005)(956004)(66556008)(4326008)(66946007)(36756003)(44832011)(4001150100001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnUwbXZvTjZvKy9MQzhHNVlLWjAwU3JBZThxWWF3b2p1K2JBbERHVFpJREYv?=
 =?utf-8?B?YXJ3RXdyMTJweHo5ZW9kVDFXNEtaaGRrRjJsOGR4WHdnd21uczdMTkozYzNu?=
 =?utf-8?B?bDdwVzhXTEpDWnFITTdIMlVzd3Q3cDJORFNCMk1HNHdOejhnMW9FYmVVeThw?=
 =?utf-8?B?bm1weVI3LzBxalRXYUJEWUV3ZzZMSzQxOVVGUmY3VWpvN2xoMUNuMmY1dm1l?=
 =?utf-8?B?S1ZUT3VaWmVDeUVrc1BFOWoyNUp2cWZ5VTF5SHErOE1xeldjOElmWExudjUv?=
 =?utf-8?B?YURyZ2FUMTE4b016MU43bGQ4SDB2WkZCVmdlUmp4L0pRZlFKZ0tpZDd0OFRW?=
 =?utf-8?B?MHl0elZ2dll4SDRiMGdXRTBCalR5OWFtWVJLVmFzYkgzYTRFcCtrVDBsdGx6?=
 =?utf-8?B?NXZmOGRMWVlWNmJmUnJWbWlkaGpTQ0tWMkNPdytpdk5iOHlvb1VBaFJKOTZz?=
 =?utf-8?B?dzVHc2I1djhBZ3JUS2lXR3d0RUpLR0tydTdSbEd4TUZ5MzhlRnJkMkRzU0JX?=
 =?utf-8?B?bEF1NUFYZXQwVnFob2NOMjNhbHRFcFBpb0xOY09FTlRzNnZZaUV3d2hhTzVw?=
 =?utf-8?B?YkxrUElCL1NPb1dweHZNYXBobUlqZVpVbUg0cXNJUmxhb2liSTBWQVFlNTlW?=
 =?utf-8?B?dUovSysyYnlnZHJKR2VHYUxjVjkzcHlmdUkzMTNEOFVpMm1LZzl5c0orOVFB?=
 =?utf-8?B?RDEvcXNiajdJdXAybHlqNHlJTkRvUld3MmtLUlh0M1FpMUl1UWJWNWZ5Wnk1?=
 =?utf-8?B?UW1BajFQbStXWXp5WlVXdHhIaklscEJqSWdaLzlVWWpRamhSRnlsakhnOERh?=
 =?utf-8?B?TkVmaC8wZEV0NXIrekVKVkIvcmRvdU9wbk9LZXZTa0d0NDhZbTg5cGIvUWFu?=
 =?utf-8?B?OXFySlkxTTJxWFNhMlk1SHhGT005Z1VZSHUxMDcxdmRFbUFiWis2QWNQRE0y?=
 =?utf-8?B?R3lqSVRwVW11UTlWa3lZSnlFTU5DclRQbmFjbnZtRnFMUUxLZnpJRHZEMHgz?=
 =?utf-8?B?Z0I0UlZ1NzZyeE1idjNQS0ZqbXZidGFRS0FITFhCTFptZHJyWmhyS3lqdTJy?=
 =?utf-8?B?YjBGYnBRQTZmZHB3blFpT2p0Yzg0Qm9DUVJCK1FCdy8zQVBwY2JxTGg2RGJx?=
 =?utf-8?B?VENCaVh3TUJVNEluWmROQWpqcm9QQnJpSVlUT2lKcVcyalRWNmc3L3U4L0VZ?=
 =?utf-8?B?WEYrYU11S0x3QmFhWU5NMjhaQ0IyajV2L2pkN1htdi9UR2svU1p3UDdIU2Ry?=
 =?utf-8?B?bE1FSUhHRGhDVDdNaVZ1NE1mQUduVWNaZHdma3pqeWZGaHR0SXdzQ2s5U2hm?=
 =?utf-8?B?am9DRFBNSkZzWXp3ZzhNZmdYYkpyYjY1djYxOC92UlR0VFR6OWEyMzJxTkJx?=
 =?utf-8?B?d20zd2w1U3lVRHhLYi9wVlpzV2ZNMUMrcDV3VEFONlhkVlpPeDhaNVZ0RWFl?=
 =?utf-8?B?d2grb05xYS8rdHArcThRQkFTaVhpRjJLOTFKSVVLZVB1Q1RjNUdoQ0VDS0Ra?=
 =?utf-8?B?Q0dJamRlU2pleitvbThZNU9VejQ4RnFwRlE2MW40Mjl2bEpKMUNZbVhmSkhE?=
 =?utf-8?B?YlRBaVVJY3diamFpbFM2c0lFTUFmc0lIK0Q5em1oZ1JwVHVaTmVyKytOeTJH?=
 =?utf-8?B?OStoQjNOVWZCUFo2NnlRR2dubjh4UkxZdHZaR0NmcG03ZkhDVXF6eVZoTys5?=
 =?utf-8?B?UWw0dGlxRWNBa1pINlJOK2RicFFXWnpkanI0clo4c0JobWs5UVAyMDlUamxC?=
 =?utf-8?B?aWg1V210UEJjQ3ZUYVBjbGQwM1NaSFQwQkFOdXZ4VFFSSWoxN1J0TzlVb21t?=
 =?utf-8?B?M2VadWF5VHFHZTBtRXpBeUkvSDhHOUZrSnpwdlV4NnZtTGdCc3EwbjVFVmh4?=
 =?utf-8?B?a0tzalVSSXUzbDBzME9pODdVNFdNVGxQZkdORFByMWtCVTdySmF2MzRUdjZM?=
 =?utf-8?B?M2NGZ01JZ1dNMzBBY0VONHFsa3pRaVh0akZZbjJOMytZTG5SR0lKTTROck5Z?=
 =?utf-8?B?S21aTUtYcG9xWGg2cXpMbzgwOFJqNU90aWRtbmxQOUFPcnJnVG54bk9XNW40?=
 =?utf-8?B?VFAwSGdBdC9UWnRZaVVRSlZPQ0hjNnd1QXpFekwrMW90RXB4SSttNmRXVUlT?=
 =?utf-8?B?THc5dENBSU1aU1dXWG5uSDFZNmRnbmVsWjltTXR0UWdqcFl0MS9YZmtXZkhN?=
 =?utf-8?Q?3tELoWMETzh0VGlYRVVKJAA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbf56af-4913-4851-5d5b-08d9a467e98f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 16:34:05.8870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvzv1aVWHsLwJ3weim4WplxSJvDkgUDdTGU9XQ3G59UwFwmFMof0V9OTb5PentZqqtSYlniCvix4MdCMVZnEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-11-10 um 11:11 a.m. schrieb Lazar, Lijo:
>
> [Public]
>
>
> >(... && !amdgpu_sriov_vf(adev))
>
> This kind of closes the door for all versions. My thought was - having
> it in the same function provides a logical grouping for how it's
> handled for different cases - VF vs non-VF - for a particular IP version.

Except that's not really true. There is still common code (setting
adev->rmmio_remap.bus_addr) for handling MMIO remapping on VFs in
soc15.c and nv.c. I'm not comfortable with duplicating all of that
across all the IP version-specific files.

I also think it's very unlikely that a small IP version bump is going to
change this logic. So I'd rather prefer to keep the code more general
and conservatively correct.

Regards,
  Felix


>
> Thanks,
> Lijo
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Wednesday, November 10, 2021 9:27:22 PM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Zhang, Bokun <Bokun.Zhang@amd.com>
> *Subject:* Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
>  
> Am 2021-11-10 um 4:14 a.m. schrieb Lazar, Lijo:
> >
> >
> > On 11/10/2021 8:00 AM, Felix Kuehling wrote:
> >> Disable HDP register remapping on SRIOV and set rmmio_remap.reg_offset
> >> to the fixed address of the VF register for hdp_v*_flush_hdp.
> >>
> >> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 4 ++++
> >>   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 4 ++++
> >>   drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 4 +++-
> >>   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 4 ++++
> >>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 4 +++-
> >>   drivers/gpu/drm/amd/amdgpu/nv.c        | 8 +++++---
> >>   drivers/gpu/drm/amd/amdgpu/soc15.c     | 8 +++++---
> >>   7 files changed, 28 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> >> b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> >> index 4ecd2b5808ce..ee7cab37dfd5 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> >> @@ -359,6 +359,10 @@ static void nbio_v2_3_init_registers(struct
> >> amdgpu_device *adev)
> >>         if (def != data)
> >>           WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
> >> +
> >> +    if (amdgpu_sriov_vf(adev))
> >> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> >> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> >
> > Wouldn't it be better to do this assignment inside
> > remap_hdp_registers()? Return with a comment saying no remap is done
> > for VFs. That looks easier to manage per IP version.
>
> I was considering that. I felt it was clearer not to have that hidden
> side effect in remap_hdp_registers and to have the explicit condition
> (... &&  !amdgpu_sriov_vf(adev)) around the remap_hdp_registers call in
> soc15/nv_common_hw_init.
>
> Regards,
>   Felix
>
>
> >
> > Thanks,
> > Lijo
> >
> >>   }
> >>     #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT        0x00000000
> >> // off by default, no gains over L1
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> >> b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> >> index 0d2d629e2d6a..4bbacf1be25a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> >> @@ -276,6 +276,10 @@ static void nbio_v6_1_init_registers(struct
> >> amdgpu_device *adev)
> >>         if (def != data)
> >>           WREG32_PCIE(smnPCIE_CI_CNTL, data);
> >> +
> >> +    if (amdgpu_sriov_vf(adev))
> >> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> >> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> >>   }
> >>     static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> >> index 3c00666a13e1..37a4039fdfc5 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
> >> @@ -273,7 +273,9 @@ const struct nbio_hdp_flush_reg
> >> nbio_v7_0_hdp_flush_reg = {
> >>     static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
> >>   {
> >> -
> >> +    if (amdgpu_sriov_vf(adev))
> >> +        adev->rmmio_remap.reg_offset =
> >> +            SOC15_REG_OFFSET(NBIO, 0,
> >> mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> >>   }
> >>     const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> >> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> >> index 8f2a315e7c73..3444332ea110 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
> >> @@ -371,6 +371,10 @@ static void nbio_v7_2_init_registers(struct
> >> amdgpu_device *adev)
> >>           if (def != data)
> >>               WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0,
> >> regPCIE_CONFIG_CNTL), data);
> >>       }
> >> +
> >> +    if (amdgpu_sriov_vf(adev))
> >> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> >> +            regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> >>   }
> >>     const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> >> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> >> index b8bd03d16dba..e96516d3fd45 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> >> @@ -362,7 +362,9 @@ const struct nbio_hdp_flush_reg
> >> nbio_v7_4_hdp_flush_reg_ald = {
> >>     static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
> >>   {
> >> -
> >> +    if (amdgpu_sriov_vf(adev))
> >> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> >> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> >>   }
> >>     static void
> >> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
> >> *adev)
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> index febc903adf58..7088528079c6 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> @@ -730,8 +730,10 @@ static int nv_common_early_init(void *handle)
> >>   #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >>   -    adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
> >> -    adev->rmmio_remap.bus_addr = adev->rmmio_base +
> >> MMIO_REG_HOLE_OFFSET;
> >> +    if (!amdgpu_sriov_vf(adev)) {
> >> +        adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
> >> +        adev->rmmio_remap.bus_addr = adev->rmmio_base +
> >> MMIO_REG_HOLE_OFFSET;
> >> +    }
> >>       adev->smc_rreg = NULL;
> >>       adev->smc_wreg = NULL;
> >>       adev->pcie_rreg = &nv_pcie_rreg;
> >> @@ -1031,7 +1033,7 @@ static int nv_common_hw_init(void *handle)
> >>        * for the purpose of expose those registers
> >>        * to process space
> >>        */
> >> -    if (adev->nbio.funcs->remap_hdp_registers)
> >> +    if (adev->nbio.funcs->remap_hdp_registers &&
> >> !amdgpu_sriov_vf(adev))
> >>           adev->nbio.funcs->remap_hdp_registers(adev);
> >>       /* enable the doorbell aperture */
> >>       nv_enable_doorbell_aperture(adev, true);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> index 0c316a2d42ed..de9b55383e9f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> @@ -971,8 +971,10 @@ static int soc15_common_early_init(void *handle)
> >>   #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
> >>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >>   -    adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
> >> -    adev->rmmio_remap.bus_addr = adev->rmmio_base +
> >> MMIO_REG_HOLE_OFFSET;
> >> +    if (!amdgpu_sriov_vf(adev)) {
> >> +        adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
> >> +        adev->rmmio_remap.bus_addr = adev->rmmio_base +
> >> MMIO_REG_HOLE_OFFSET;
> >> +    }
> >>       adev->smc_rreg = NULL;
> >>       adev->smc_wreg = NULL;
> >>       adev->pcie_rreg = &soc15_pcie_rreg;
> >> @@ -1285,7 +1287,7 @@ static int soc15_common_hw_init(void *handle)
> >>        * for the purpose of expose those registers
> >>        * to process space
> >>        */
> >> -    if (adev->nbio.funcs->remap_hdp_registers)
> >> +    if (adev->nbio.funcs->remap_hdp_registers &&
> >> !amdgpu_sriov_vf(adev))
> >>           adev->nbio.funcs->remap_hdp_registers(adev);
> >>         /* enable the doorbell aperture */
> >>
