Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE8CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 06:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADE110E3B9;
	Fri,  3 Nov 2023 06:40:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBF110E3B9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 06:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/yIhwXZZIQ1mjikVwRT0f/3vzUtIy9LrMyQsTNQGNxlkddptA6NLj1WVw81IuJDKpsys7f823FmfOkv/hZu/o3ved/QUTWmEG5q/Bl9PB0FtOS+MLN2RWAjm7MwLzGiad8r6OG0l/yJXy0x+3T82zy6i8mJTAEoYFFVG+2vwdwlENHj1TtB2tJsxEuiR/wbh+ibQo3mxkBKlXM5gAF2JuqR3DYUI0ryhz2+EtiD8SpuUzWEDlXRwi6s0ktYY32raIBqjQD0xlUYvgjkznlQ8yd0AWnqDsZC54HuOKIt6US9ITx4mWTBvLuDvaOoqwKN94PKmo8DtMiajG8B54fyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hk2rq8jXJxiBVF0P2u/2Q2seGEB/xsDTUuyQ4pDzme8=;
 b=OsIGb/mmjsBMqf6N9YXF3PzV5tVpB+l73rfzW8Jy1gsoADC6TgWuBjaIyb3E/DVwRWJPJc2zwZJhWbtTrX4dkVIPxnmx83yqImxBo7ZAgSxzHsonx/ArWCIZlEeF2hA8JPYfOR5DRopdcQEjxmLoTWRQnCJ/NyqqahnLrdWUzlVE176KBxErUwEzVO0D/EJ/V2oJbyIYTVQtkl8GWKCj1VBwMi6F3hy/fZyk4jggFYDEKE2cnYoXbZFR4sr8iHxiYzJ2KEGMDlZrcj4VAhbv3TSJUDtFay2MPs1dT/WaV/I3pHpmAdZLleBa8moi7kazg8ghVsH4W/fW22n+acNg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk2rq8jXJxiBVF0P2u/2Q2seGEB/xsDTUuyQ4pDzme8=;
 b=Yfni+5fZICAdzXmMMovU3K4pWes1GnqeFkkbFp4FOqQaBAZUcrKQVF7mOzn1szmsCNWK9BohUV9qNV5K434TN5HilJEEGfxzQBQc+6y5UopN+DhZatMkQZ5E1ulogm5j077xHWKag/k3uTXtAPToJF12TjaPhb/Cvghx8cXT2Jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 06:40:05 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ce36:81fc:9c50:c892]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ce36:81fc:9c50:c892%6]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 06:40:05 +0000
Message-ID: <513b2282-2f88-d837-ff37-6bd04641e833@amd.com>
Date: Fri, 3 Nov 2023 12:09:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/4] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3
 (v4)
Content-Language: en-US
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
References: <a69f99f0-881a-1b52-1e29-4cb6b2bc1994@amd.com>
 <20231102150427.12978-1-victorchengchi.lu@amd.com>
 <20231102150427.12978-3-victorchengchi.lu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231102150427.12978-3-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 72eeca71-ca8b-497e-cb1c-08dbdc37b59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTKdDVJ5/mfV+6gnWcvVDAcOLBtjVBRgYuJ6guYROAioV80u+98N3YSi2oV5ZQ0nPZ/8CACn5lOvnjVu1WvxHh/DAhlowiMkYCKr9gOP8qlddx5RBCO0Cgx9pjBaL8muUWXFnzzoX/U03Pcsl9H3ioF7mjhHiINF1LCYZvxn6O0+hy+wZxCeoYlQI/v93/P2mYlth6Ob4OdyXU5yjyLwBoNNZQAgkMB7OnapsSP6dvqdBA8y1QVFKcVnq/wx94+XLsVKX7yt73CWy0GBrOge2tONKlg8rF2anwnCGE+JnMDNjF3cPBNp8RMSYdQTV1AskzKavDLA0mx//QtLTxMiosAPf1cgjLBsobqnISwL4kjU8Rvjsy8XfRpnmi0kS8MtRvw6WfO8bJ2WTGH3br9LA0ZD/SuKnUsAc5Awi+yaF+4j54AxN9R1cCdES9ylqg/4bz/I0vxIy7dIdHMjhoUbRGIbfXV2B1cq4GVmMddeihOjErgaqJI/TRwUNDsi6tuZ0/ac1MFSUSUKChf0HOtnc3I3nRe7OfJzWqTgh4KIODVq6kafSEkO6mHNeWxNs/BZ6LmMCYR3ZtLM0rUsShBu+BI08MQmQUafqZX3EXAXO+oduApIgSksz/2fbAaAeBlun5b+2k/odqBZKW4kEfa0sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(66946007)(66556008)(66476007)(316002)(36756003)(31696002)(86362001)(38100700002)(6512007)(6486002)(83380400001)(26005)(6666004)(53546011)(6506007)(2616005)(30864003)(2906002)(478600001)(41300700001)(5660300002)(8936002)(8676002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09DbE9iMXlid3h0WWtpMEZwVnNQWEE0a3FYYmY2RWdxY3RySmk3N2lGcmJ5?=
 =?utf-8?B?UDczbXdCY04xYktuRFg0ZHhkdlJkL2Rpb25qeTIxWnJaRmZ1eUFaSGNOT3I4?=
 =?utf-8?B?SjBwOHY1NTN3TXM4WHVJRDdGR0tZVkdveXJuMHZ5UkdNOGdMR0VQa0RYWXZN?=
 =?utf-8?B?T2pCS0x3Q1lDa3E2Q2tZZW8zWTBQekhCQzlUcTBHUWoxcVJvRzdNdmdlR3JY?=
 =?utf-8?B?amY5THFFYTBYcUxyNnplTElQWXRYSGtzcGxNQkdBcFV4QlZVbzh5UU4xQUpT?=
 =?utf-8?B?SStiL3ZaaTVEL29LUkJ3WWtWVmRtRHdHNXJaeStDd01JYjBIbkQ2M05DemZu?=
 =?utf-8?B?NGdqMWpkVVlzMHYvelFFWG03aWFUeVYxbXhmZ0FIakJrSy9URTNpcytTUUJt?=
 =?utf-8?B?cE1qL005RHdMUjF6WlQvaldaQWVMcm42NHNGdCtkeis3V0c2Mkk4TUJGbWxB?=
 =?utf-8?B?eUFxSnh4VzdYVnl2SnNGbThMQksxR2NNRHYvdG9uUktRNUxKSDBLVTNWVzhH?=
 =?utf-8?B?VHkrakdWb0l5d0JWVjBxWGhma0tmSzkvUW1KY01LN3JzOVc1T3NLaEVTUW53?=
 =?utf-8?B?K0lENzV0a2p4cSs0R2E2U0FQUmhhbmg2TTZUQUNrTzdQUWRneGVPZTJ1eUJ1?=
 =?utf-8?B?Qk1KSmxJRnhOdm9VREt4NjdEWXJaUDEySHhZb05KcDhVOGYwNmY3K1pkZGtC?=
 =?utf-8?B?ZmxoSmtma1d3VC9zZlpYNlYzUWVmS0hiS1NuZ3lzVkR3QlpvYjduOEgwMEZI?=
 =?utf-8?B?STJZcmpvRFRjVUhXM3ljZ0xuRnJnZnY1VXkxL2dzdHFyM0ZGYVBwV2xERVRk?=
 =?utf-8?B?SnMxazRyWlc3Q2VtWXhYSmdmN2Nmc1FqWGNmSWZvcStzK2tUWjA5NTFSbldk?=
 =?utf-8?B?cUpURVpYRzI4NXdpQzFjeGtlaDI3dmljOXZjckZON2ZwSnVqTm8rTzRPNFd1?=
 =?utf-8?B?RmRrRFFYbEZKdUJ4aWtuRm14LzQ0ektlbitXQ0ZqaWNDNzhzVnBBOFFVZS8v?=
 =?utf-8?B?ZWtjMG9iMzJRT3pMZ3lNVGdyMEJuSXpnSExGYVcyOE9uSlZZZkt0ZUJOUFZ1?=
 =?utf-8?B?dFJnRklaS1ZNR1FGOHhsZno1SVVMZEJhQ1FNWXpTOXJuOFIzeCtiZlAvZVFy?=
 =?utf-8?B?cncwN21sZ0ljU2xXZGpmbGRsQjQ4b2JUcjZQUjRXZkJiQ09hZzZWMWFwUDdL?=
 =?utf-8?B?ZTNhUTVudEtBWlRvVHJHd3pwbHVhaTJuR0VUS3JGV0FvQnRsMkdMNEdDbDk3?=
 =?utf-8?B?aHJYRkE0WjRHUFR0c3JYdDFmU05xQm1JZll4UGtDRGs5ejlzdi9wdkxJdXRN?=
 =?utf-8?B?azgrM1M0aVBFblBwRzV6TEZZQW5MdTA0NWdEOVdSSFdIUG9zbWhaeCtyOTV6?=
 =?utf-8?B?R28rNS92YkkrUGpCanF6bkdoblYrNXVBVGRSTUJUWjcwMEYwa0tEVlptZVpx?=
 =?utf-8?B?bmNRbStsS0ZteW16a1RDbEs1UzJ6OUxiRytzOGhiWmRncllBTjdVaDlHUEI3?=
 =?utf-8?B?TUZRQVYwdnQwUkNGejdBNzVyTWpjQ3o2aS85SGpyVTBuREtPcW5RRDFjc25z?=
 =?utf-8?B?T2lxUDNQb01zNHo2Z3psKzlXR0JWZExySmhVZWRJTlljUVBrRDFSUEV3a0cr?=
 =?utf-8?B?RklUTXZsUFBoN1IrVmlTM3lON3hFUU1DWlVrbW93LzVyN2xpUm4weEFHZXRB?=
 =?utf-8?B?MXlNQzZKOE02bWV4R2s1WXJaUVBSNkpEemNlN2NiQklJZWxqOVpOSzJXcmJ3?=
 =?utf-8?B?blU2UGMxaDlZUUlYcWhXdElHbEhENVIwR0o4QUlGcXpTTnpMTmg3bVJBZ0Vs?=
 =?utf-8?B?UG5aNVFYaHdRWStiYjUrUmVvMXVxSnlINkMxTEFxYXRNMFlicnk0Nk0zcWlo?=
 =?utf-8?B?VXFlVCtORFdUUTh1MXUvekF5UGR0NklhaDRHdmJRMllmVG9SczhjZkFYT1k3?=
 =?utf-8?B?d3VldWtLVDJBR3RhVVFJcjNWai9GSGRlRHBYUUUxeGV5eG9JeU5vaXltYjhi?=
 =?utf-8?B?TXJuM0FVNGFwRkhJWGRXeDlqRjFkd0gwSi9WaGVIcE5jN3I0Z0M2YWNTR0JZ?=
 =?utf-8?B?T2d2TFdQMUgrUFlwUTdYcFF6TDI0dFZ0Nm1PL2lhSUlxVnhlZ0VTRWo2Q1NT?=
 =?utf-8?Q?OLbowo1+0LPBeunKwA+xtgv4P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72eeca71-ca8b-497e-cb1c-08dbdc37b59b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 06:40:03.7346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWV55T7sjc0ssGotahSzgelBgFHVSJBC5MyO3CzG25aDn4ZWFAw92mgt2y0aurhF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139
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
Cc: davis.ming@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/2/2023 8:34 PM, Victor Lu wrote:
> amdgpu_kiq_wreg/rreg is hardcoded to use MEC engine 0.
> 
> Add an xcc_id parameter to amdgpu_kiq_wreg/rreg, define W/RREG32_XCC
> and amdgpu_device_xcc_wreg/rreg to to use the new xcc_id parameter.
> 
> Using amdgpu_sriov_runtime to determine whether to access via kiq or
> RLC is sufficient for now.
> 
> v4: avoid using amdgpu_sriov_w/rreg
> 
> v3: use W/RREG32_XCC to handle non-kiq case
> 
> v2: define amdgpu_device_xcc_wreg/rreg instead of changing parameters
>      of amdgpu_device_wreg/rreg
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 13 ++-
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 91 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  4 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +-
>   9 files changed, 118 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 43c579f5a95e..e8dc75a3ff44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1162,11 +1162,18 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   			    uint32_t reg, uint32_t acc_flags);
>   u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
>   				    u64 reg_addr);
> +uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
> +				uint32_t reg, uint32_t acc_flags,
> +				uint32_t xcc_id);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
>   			uint32_t reg, uint32_t v,
>   			uint32_t acc_flags);
>   void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
>   				     u64 reg_addr, u32 reg_data);
> +void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
> +			    uint32_t reg, uint32_t v,
> +			    uint32_t acc_flags,
> +			    uint32_t xcc_id);
>   void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   			     uint32_t reg, uint32_t v, uint32_t xcc_id);
>   void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
> @@ -1207,8 +1214,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
>   #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
>   
> -#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
> -#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
> +#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg), 0)
> +#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v), 0)
>   
>   #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
>   #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
> @@ -1218,6 +1225,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
>   #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
>   #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
> +#define RREG32_XCC(reg, inst) amdgpu_device_xcc_rreg(adev, (reg), 0, inst)
> +#define WREG32_XCC(reg, v, inst) amdgpu_device_xcc_wreg(adev, (reg), (v), 0, inst)
>   #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
>   #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
>   #define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 490c8f5ddb60..80309d39737a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
>   	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
>   
>   	for (reg = hqd_base; reg <= hqd_end; reg++)
> -		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);
>   
>   
>   	/* Activate doorbell logic before triggering WPTR poll. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51011e8ee90d..9285789b3a42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
>   
>   	for (reg = hqd_base;
>   	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
> -		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);
>   
>   
>   	/* Activate doorbell logic before triggering WPTR poll. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9a11dd1b686e..c1a439bfde14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -74,6 +74,7 @@
>   #include "amdgpu_pmu.h"
>   #include "amdgpu_fru_eeprom.h"
>   #include "amdgpu_reset.h"
> +#include "amdgpu_virt.h"
>   
>   #include <linux/suspend.h>
>   #include <drm/task_barrier.h>
> @@ -473,7 +474,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>   		    amdgpu_sriov_runtime(adev) &&
>   		    down_read_trylock(&adev->reset_domain->sem)) {
> -			ret = amdgpu_kiq_rreg(adev, reg);
> +			ret = amdgpu_kiq_rreg(adev, reg, 0);
>   			up_read(&adev->reset_domain->sem);
>   		} else {
>   			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> @@ -510,6 +511,50 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>   	BUG();
>   }
>   
> +
> +/**
> + * amdgpu_device_xcc_rreg - read a memory mapped IO or indirect register with specific XCC
> + *
> + * @adev: amdgpu_device pointer
> + * @reg: dword aligned register offset
> + * @acc_flags: access flags which require special behavior
> + * @xcc_id: xcc accelerated compute core id
> + *
> + * Returns the 32 bit value from the offset specified.
> + */
> +uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
> +				uint32_t reg, uint32_t acc_flags,
> +				uint32_t xcc_id)
> +{
> +	uint32_t ret, rlcg_flag;
> +
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if ((reg * 4) < adev->rmmio_size) {
> +		if (!amdgpu_sriov_runtime(adev) &&
> +		    adev->gfx.rlc.rlcg_reg_access_supported &&

Missed this in earlier review -

rlc.rlcg_reg_access_supported flag is set unconditionally in patch 1. 
Then baremetal path for WREG32_XCC will take this route which shouldn't 
be the case. I think original usage was through amdgpu_sriov_wreg() 
which has the below guard.

         ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && 
adev->gfx.rlc.rlcg_reg_access_supported) ? \
          amdgpu_sriov_wreg(adev, reg, value, flag, hwip, inst) : \

One way is to set the rlcg_reg_access_supported only for 
amdgpu_sriov_vf(adev) case. Baremetal doesn't need to go through this.

> +		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
> +							 GC_HWIP, false,
> +							 &rlcg_flag)) {
> +			amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, xcc_id);
> +		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		    amdgpu_sriov_runtime(adev) &&
> +		    down_read_trylock(&adev->reset_domain->sem)) {
> +			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
> +			up_read(&adev->reset_domain->sem);
> +		} else {
> +			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> +		}
> +	} else {
> +		ret = adev->pcie_rreg(adev, reg * 4);
> +	}
> +
> +	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);

This trace is for the original device_rreg. Please remove this here, and 
also from wreg.

Thanks,
Lijo

> +
> +	return ret;
> +}
> +
>   /*
>    * MMIO register write with bytes helper functions
>    * @offset:bytes offset from MMIO start
> @@ -557,7 +602,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>   		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>   		    amdgpu_sriov_runtime(adev) &&
>   		    down_read_trylock(&adev->reset_domain->sem)) {
> -			amdgpu_kiq_wreg(adev, reg, v);
> +			amdgpu_kiq_wreg(adev, reg, v, 0);
>   			up_read(&adev->reset_domain->sem);
>   		} else {
>   			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> @@ -598,6 +643,48 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   	}
>   }
>   
> +/**
> + * amdgpu_device_xcc_wreg - write to a memory mapped IO or indirect register with specific XCC
> + *
> + * @adev: amdgpu_device pointer
> + * @reg: dword aligned register offset
> + * @v: 32 bit value to write to the register
> + * @acc_flags: access flags which require special behavior
> + * @xcc_id: xcc accelerated compute core id
> + *
> + * Writes the value specified to the offset specified.
> + */
> +void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
> +			uint32_t reg, uint32_t v,
> +			uint32_t acc_flags, uint32_t xcc_id)
> +{
> +	uint32_t rlcg_flag;
> +
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
> +	if ((reg * 4) < adev->rmmio_size) {
> +		if (!amdgpu_sriov_runtime(adev) &&
> +		    adev->gfx.rlc.rlcg_reg_access_supported &&
> +		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
> +							 GC_HWIP, true,
> +							 &rlcg_flag)) {
> +			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, xcc_id);
> +		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		    amdgpu_sriov_runtime(adev) &&
> +		    down_read_trylock(&adev->reset_domain->sem)) {
> +			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
> +			up_read(&adev->reset_domain->sem);
> +		} else {
> +			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> +		}
> +	} else {
> +		adev->pcie_wreg(adev, reg * 4, v);
> +	}
> +
> +	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
> +}
> +
>   /**
>    * amdgpu_device_indirect_rreg - read an indirect register
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c92e0aba69e1..60ae4bfdc7f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -929,12 +929,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>   		func(adev, ras_error_status, i);
>   }
>   
> -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id)
>   {
>   	signed long r, cnt = 0;
>   	unsigned long flags;
>   	uint32_t seq, reg_val_offs = 0, value = 0;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
>   	if (amdgpu_device_skip_hw_access(adev))
> @@ -997,12 +997,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	return ~0;
>   }
>   
> -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id)
>   {
>   	signed long r, cnt = 0;
>   	unsigned long flags;
>   	uint32_t seq;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
>   	BUG_ON(!ring->funcs->emit_wreg);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 7088c5015675..f23bafec71c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -521,8 +521,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
>   int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   				  struct amdgpu_irq_src *source,
>   				  struct amdgpu_iv_entry *entry);
> -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
> -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
>   void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e179f022c428..82762c61d3ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -943,7 +943,7 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
> +bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
>   						 u32 acc_flags, u32 hwip,
>   						 bool write, u32 *rlcg_flag)
>   {
> @@ -976,7 +976,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
>   	return ret;
>   }
>   
> -static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
> +u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
>   {
>   	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
>   	uint32_t timeout = 50000;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index bb436d41b4ca..ca13ae70e87d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -366,4 +366,8 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>   bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
>   			uint32_t ucode_id);
>   void amdgpu_virt_post_reset(struct amdgpu_device *adev);
> +bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
> +					  u32 acc_flags, u32 hwip,
> +					  bool write, u32 *rlcg_flag);
> +u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index ce2a9876369e..9afd43276ab2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2738,16 +2738,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
>   
>   	switch (state) {
>   	case AMDGPU_IRQ_STATE_DISABLE:
> -		mec_int_cntl = RREG32(mec_int_cntl_reg);
> +		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
>   		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
>   					     TIME_STAMP_INT_ENABLE, 0);
> -		WREG32(mec_int_cntl_reg, mec_int_cntl);
> +		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
>   		break;
>   	case AMDGPU_IRQ_STATE_ENABLE:
> -		mec_int_cntl = RREG32(mec_int_cntl_reg);
> +		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
>   		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
>   					     TIME_STAMP_INT_ENABLE, 1);
> -		WREG32(mec_int_cntl_reg, mec_int_cntl);
> +		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
>   		break;
>   	default:
>   		break;
