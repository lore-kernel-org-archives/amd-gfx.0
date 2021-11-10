Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8C3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D0C610A2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 15:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33D0C610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39106E530;
	Wed, 10 Nov 2021 15:57:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 316BC6E530
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 15:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itLM8xyij3y0eRjvJMQthxPh4MbGYCRIt04MmgaEVKe49XwefFFWpKnNbu2Si1oU0orr93b+UYUf5i6UVoZrRDgDxE2riOgSzFRWx6Vr/bzCsFJ5Ee8Dc1xqS5P6wy6eEOxOge27zHfuOsEd+H3Pz2Yo5o0F1+TOuHEnZs3aKd1BbNiI9Ky3zo1gn0zVVhfMVBf0WrLrj53Y1jKg5o2ReOaxOU/xF+RDK/5FacNvQ/+OED8PWr0AT6kMvdNbmnyxFYGM/RQyBqDIgY+DqHoiPyjVKQX4/3wEJhBlmb3KPKR5gYsMYwloqbr8Re7Oxfxbm9a72egSkdkFJJBrYF1NtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/VEOTlOa2ClyTJrEI7wKXta4zDUc1YH4gayvvdrJoQ=;
 b=iPLrXAKd3/npimV3kOwDMN0bKLKus7T6pmJaPMIw7oW/oFzaNa556k6FMNYEuI8OLpynT3q4FzPLz3Rqg7krPS//+TfZz4jq7sRevhp4fFs5NDIcsJG6krlv8ZO6CCu4qt/LoUuc2wl7bir/9W/4EdDRBcnGuLDSoVSfczIhSJTswVttUWYmXJ/RzOU7jGqVcsdQyy/aV/rrduIw9jwYMksak5SupTRxVjT/2WaLra1fca42empQDJFOy38mplCzTxqfexpgDk9hirYj/RgOKJVwcbsDL86MvbwBIgDHa5Gh9YQ6A/p1KTUvULtOR+rX5MCZw/TyQdvE0JJ8PrrrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/VEOTlOa2ClyTJrEI7wKXta4zDUc1YH4gayvvdrJoQ=;
 b=Gn8qy3bWhaxRsTaR+3DbYbKanzcaBhf1Yox21N2PcvGGml2+zikb4PO/kuEhpoVs2f7yqhowMJuK70NI++GECvZZsVQoKPthVAKeilNTRNosgbMjxty75bpjGQZFJImVEhwdlS/SPvQVFF83RgAYK3C7kL4m8dQyjhcSIi65Kos=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.17; Wed, 10 Nov
 2021 15:57:24 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 15:57:24 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211110023052.1872623-1-Felix.Kuehling@amd.com>
 <48473282-292c-508a-1a4e-42359c421f01@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <dd7f5e89-338b-c331-829e-5fba0594a0cb@amd.com>
Date: Wed, 10 Nov 2021 10:57:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <48473282-292c-508a-1a4e-42359c421f01@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::12) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT3PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 15:57:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cea6719-9002-438e-f3f9-08d9a462c934
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53049C65D767FD5164303FB392939@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4avqr6HH18iPpkfy7dtP4ECvB0K7d4jAqBjo57bVkBFKFk1RyeC7LSx/JZsFoNrtz+KfdOuX1wkb3Db0XUIyAViYhysUc+Kye4nZRNTItjH5DS1YBhA91/1uJX4sy8ucvbFt7ir743CutKw0A1a+aGki8UdqmQIwJCbEPfWF0lZDoNQl/6Bo/yedX+Ibya0uzZlRkpOpqC1qo58fMAGRToeTTsfHCzVsAm6YitT+lrtiiUIFf4uFNxyr1VLOHgoPyOyGePe83uod7gBUICdscYjukPhW1DBKYJztmUvVgzLYF6uawjUlnFC4ITyVTw1EfKBzoqGfcrvcds52COidpwXhI9oCUKRjcM1y359HQ0RWFmrYS/depYCU40mjuNLkKRd8/VBsnRpzzaRtELzqhZzTP+hFl9pjZZFddDGBYvSiJuMpAaWJhVM92ZmkxEYfi06JhA2iF6Fq2RuwwnycTMR4EMvx+yqzRXu0cLYYlQSS0lJhBa3cutuTJUDXehZhk2TWiRM9ezukZnUHqVlZqGY3xv5EwNoSGm2ZlVentAenGhd5ocm4CSFiTgGVGR/WAfoPf/qqt7VV53vTjH816gmimGq1+zsWLkoguKn5NxEbo8viCefrXq8V22GptoHZGO3vZF2dHEM/S08nHJ/mHbblf8sp8Nrhy3DSFm3Vvad+5UiE137Rn8U8QMe9LQBQWGLTnBmk3Y+yTWjCbjWDiO8VT8agfc3jqRx+e8PByAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(2616005)(38100700002)(316002)(26005)(508600001)(956004)(4001150100001)(31686004)(186003)(86362001)(8676002)(83380400001)(44832011)(5660300002)(2906002)(6486002)(4326008)(36756003)(16576012)(53546011)(66556008)(8936002)(66476007)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFhCRHQ3a3hTemxLYTUzTHZhOEp0cDA0d0RlOTR2a1Jhbytqa0xyYk54VEpm?=
 =?utf-8?B?VmxSek4xLzczazN6ODk2M3dtNk9HRitCdHl0aGFUZ0NvQVhVNUx2Qy8rV2pE?=
 =?utf-8?B?TjhjTHM1a3drTWtMM1JyZk5HYjhsR0VkZm0vcVNDT2ppdC8wbUNhWlY4RDNj?=
 =?utf-8?B?SjlaYTQ1RzdiYkZTdHNzUWwweWErSG95cS80M1ZQV0wrY1RnOE5vZm83ck9m?=
 =?utf-8?B?WkozWjFBLytqd09UamorTjNNd0dkN2VvUGU2NmRmZWJJSG5YRnhQWTc2US9X?=
 =?utf-8?B?NDFzT21GRU9RaVNzUEs2SnZaWStRdnZCOFhnYXZpdTBpQUlyeDNvVENjRDBh?=
 =?utf-8?B?M0RUc0cvbW1QS1JobUNmem1lN3BLeElBdkFMWmE0N3ZSZWVoL3pkdkFvL09Z?=
 =?utf-8?B?MVBRQnNnN0JMY3FHSU5hS1VoSm9vUkswSmpSQkJQeFdLYkdRbXRZcVlpQmtC?=
 =?utf-8?B?NWd3ZzZSZXVLTE5YWTZXZDQzV2hHQk9GNDYwUzRTREFKZjUzbm9OWlhZKzg4?=
 =?utf-8?B?b3dMUHAwQmlkektyRlgrTy90L29xbHdiWmEwODBuTStwcnN5Y01VRkF5NS9Y?=
 =?utf-8?B?SGZyZW1ZSXVlZlZWbDZzS21VU0JCRHNXeWx4cW0wVnpjM1ppMzIyTzJxeFVY?=
 =?utf-8?B?Q3dmeVlEK0dSUldTKzhrQ2puZTh5dnhtbEQxeVZ0bzlLVCtoZmsvdVJUUyt3?=
 =?utf-8?B?VDhDU0lGaXlOc01mNE0xMDlVWmw4bnp1bTdaK08yVmt5ZXRGOWFQdS9XaTdE?=
 =?utf-8?B?YTBhZUt0dWJESTQvNitXT0lwV1ZEVjNuWWEzbG9FcXpvMEZiSXUzSXd0RUVz?=
 =?utf-8?B?K0dtVFNrTFk4OTFDM244N21WZWJUTG5GNlU0TzJ0cGkwakdidmlKbytLOUVX?=
 =?utf-8?B?OERVTjlUSHh6b0lKUHJDWjcxekNIT2JPeVFJNENnSlhEczhNL3dSQ2ZIL251?=
 =?utf-8?B?MHg1S1RONSthVi9leFh0Y0RXYWZ3RDlWZ040VCtsd3QvMURnejgwbXJuSGpv?=
 =?utf-8?B?S1gvcmNORjRRWjRSd1YyVXhYTXNpdWVOVlRPN2UwSW1xclJ4RTVwdnlFbW9I?=
 =?utf-8?B?NFliaTVIeFdQNkZFSUxHK0pmaUh2NUkrSWtWNG1XbTZtaTIzYVVYOUIvZjhh?=
 =?utf-8?B?V3Z5TzZ1RnhWN3dvN09UemhlMEI1dGRJV01rb1RuanY4OTl5TitqcVV0MHpL?=
 =?utf-8?B?dGoyWHA0WEU2WS9zaHREbDhUMHpQbGhnNmNoRzIyc0RCS3dPRmVOL2wrU1E4?=
 =?utf-8?B?a1dLTG1XY3hEeENWSjB0NVdCYUk5N1VLRGRUUFR0RGtSRUU0ZkVQR0FPdVRD?=
 =?utf-8?B?R0cwQ2Nja3dWcktqb1VFVEZLT3FQSkJqU1FPT2dUSFFiOFlGYWswRVVBUzhq?=
 =?utf-8?B?NGNIeDIvR1pFZDJOYUE1S1MydUNJQ3Zzdm1Vc0duOVJ1Mm5oQzRPek9NT3cr?=
 =?utf-8?B?N0czMEhpSGpJZlVJM20zMWp6K0lPaG5ucXNGL0g4UnFRMml1UUFKRTJRMXNX?=
 =?utf-8?B?NUMwKy9SNWZKekJXSTJOeXlPVTJielBmVTRic2VhRnd4Z2JqMjNvSFREK0Z0?=
 =?utf-8?B?UTZjZGZrbkp2U3dVYTl2T0M0dmlaLzhGUmdUSllERWVuVXZ0RlQzSkh5OFk3?=
 =?utf-8?B?b2JMQnBRNWFVaGx6cXVuOEJVTGRSeTBadVJGbXhlYVZrKyt6eVAxb1hnREFx?=
 =?utf-8?B?RmhpUU1qUWVvWDk3SFdidDlqaXJnYnNRS3pUOUwzckxiZjB5U1VDNzBIdHln?=
 =?utf-8?B?S2Z3KzFCejdRblRQby85WDE2aUQrSlVDODFKQkFsRXBMOFRsNXpOaXpMUm1U?=
 =?utf-8?B?SjJIV3pNaWNrNTJQWi9UcTA4dTFLY3JZVUhKTDFtTzFRRERuRFRtWGxuaHh4?=
 =?utf-8?B?RWd1NjVva29Vdmg0VzJhSGk3TkQ2QzJRMnhTb3NjSDNHeTErR29GUDFzMG5v?=
 =?utf-8?B?L2Erb0cvUzJtNTIza2laVWdGOEd2eTk0MkI5VVpxRjBqRzRVNHpTNEFET2lQ?=
 =?utf-8?B?UldMZnhxQUhRZXNORDFkM1BNNkQxNlVxZXhGMWxsWXZIeDVSWHFobnFMSGJK?=
 =?utf-8?B?SWs3T0VQaVJkSmlueDZ5VmRLNlVaUHlhNTlocVM1aTN4aVdrR0VWVEdiVk0y?=
 =?utf-8?B?MGJDM3dXV2UxNDRuSVk3UTdHMzdaZ1c1d0hsS2VFd2IweFgrQTduanByQ0RS?=
 =?utf-8?Q?6G5O+PtH4T7/rD/rpahEYxA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cea6719-9002-438e-f3f9-08d9a462c934
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 15:57:24.0321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQfrXNXN4pfiyKNb0a2qERFDI3OSyDwoSyzNi6WtS/GdJHO6CApSjgxjtJoX5pw9ImGl1Xa/eFR5nRuebuovSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
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
Cc: bokun.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-11-10 um 4:14 a.m. schrieb Lazar, Lijo:
>
>
> On 11/10/2021 8:00 AM, Felix Kuehling wrote:
>> Disable HDP register remapping on SRIOV and set rmmio_remap.reg_offset
>> to the fixed address of the VF register for hdp_v*_flush_hdp.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 4 +++-
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 4 +++-
>>   drivers/gpu/drm/amd/amdgpu/nv.c        | 8 +++++---
>>   drivers/gpu/drm/amd/amdgpu/soc15.c     | 8 +++++---
>>   7 files changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> index 4ecd2b5808ce..ee7cab37dfd5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> @@ -359,6 +359,10 @@ static void nbio_v2_3_init_registers(struct
>> amdgpu_device *adev)
>>         if (def != data)
>>           WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>
> Wouldn't it be better to do this assignment inside
> remap_hdp_registers()? Return with a comment saying no remap is done
> for VFs. That looks easier to manage per IP version.

I was considering that. I felt it was clearer not to have that hidden
side effect in remap_hdp_registers and to have the explicit condition
(... &&  !amdgpu_sriov_vf(adev)) around the remap_hdp_registers call in
soc15/nv_common_hw_init.

Regards,
  Felix


>
> Thanks,
> Lijo
>
>>   }
>>     #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT        0x00000000
>> // off by default, no gains over L1
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> index 0d2d629e2d6a..4bbacf1be25a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> @@ -276,6 +276,10 @@ static void nbio_v6_1_init_registers(struct
>> amdgpu_device *adev)
>>         if (def != data)
>>           WREG32_PCIE(smnPCIE_CI_CNTL, data);
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>   }
>>     static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>> index 3c00666a13e1..37a4039fdfc5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>> @@ -273,7 +273,9 @@ const struct nbio_hdp_flush_reg
>> nbio_v7_0_hdp_flush_reg = {
>>     static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
>>   {
>> -
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset =
>> +            SOC15_REG_OFFSET(NBIO, 0,
>> mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>   }
>>     const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> index 8f2a315e7c73..3444332ea110 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> @@ -371,6 +371,10 @@ static void nbio_v7_2_init_registers(struct
>> amdgpu_device *adev)
>>           if (def != data)
>>               WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0,
>> regPCIE_CONFIG_CNTL), data);
>>       }
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>> +            regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>   }
>>     const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> index b8bd03d16dba..e96516d3fd45 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> @@ -362,7 +362,9 @@ const struct nbio_hdp_flush_reg
>> nbio_v7_4_hdp_flush_reg_ald = {
>>     static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
>>   {
>> -
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>   }
>>     static void
>> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>> *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index febc903adf58..7088528079c6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -730,8 +730,10 @@ static int nv_common_early_init(void *handle)
>>   #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   -    adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>> -    adev->rmmio_remap.bus_addr = adev->rmmio_base +
>> MMIO_REG_HOLE_OFFSET;
>> +    if (!amdgpu_sriov_vf(adev)) {
>> +        adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>> +        adev->rmmio_remap.bus_addr = adev->rmmio_base +
>> MMIO_REG_HOLE_OFFSET;
>> +    }
>>       adev->smc_rreg = NULL;
>>       adev->smc_wreg = NULL;
>>       adev->pcie_rreg = &nv_pcie_rreg;
>> @@ -1031,7 +1033,7 @@ static int nv_common_hw_init(void *handle)
>>        * for the purpose of expose those registers
>>        * to process space
>>        */
>> -    if (adev->nbio.funcs->remap_hdp_registers)
>> +    if (adev->nbio.funcs->remap_hdp_registers &&
>> !amdgpu_sriov_vf(adev))
>>           adev->nbio.funcs->remap_hdp_registers(adev);
>>       /* enable the doorbell aperture */
>>       nv_enable_doorbell_aperture(adev, true);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 0c316a2d42ed..de9b55383e9f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -971,8 +971,10 @@ static int soc15_common_early_init(void *handle)
>>   #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   -    adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>> -    adev->rmmio_remap.bus_addr = adev->rmmio_base +
>> MMIO_REG_HOLE_OFFSET;
>> +    if (!amdgpu_sriov_vf(adev)) {
>> +        adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>> +        adev->rmmio_remap.bus_addr = adev->rmmio_base +
>> MMIO_REG_HOLE_OFFSET;
>> +    }
>>       adev->smc_rreg = NULL;
>>       adev->smc_wreg = NULL;
>>       adev->pcie_rreg = &soc15_pcie_rreg;
>> @@ -1285,7 +1287,7 @@ static int soc15_common_hw_init(void *handle)
>>        * for the purpose of expose those registers
>>        * to process space
>>        */
>> -    if (adev->nbio.funcs->remap_hdp_registers)
>> +    if (adev->nbio.funcs->remap_hdp_registers &&
>> !amdgpu_sriov_vf(adev))
>>           adev->nbio.funcs->remap_hdp_registers(adev);
>>         /* enable the doorbell aperture */
>>
