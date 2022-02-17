Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117AAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 05:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750A210EA20;
	Thu, 17 Feb 2022 05:02:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FCA10EA20
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 05:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azMHZHJkEuOkWvyeiNvP1MrSA3jygq8WfbkFE8xKf3PfsY9xFfSuJ/eByLyXFUgJyqRjH5FwuF7HxI0nPsIE1//PUuXGXdCY0LkZ/TMvrZjY9dHH2pphnF3451pLy3HKlU6t7xGCNM8/OqQ2fsxkRWpERqk56gDeS6JxnB+vYL2itPpEZVPPe1gnfOdHeLs4CL4NUQ9vo1aSY/c9ejrhyZvVekcfgsYaTcj+P1eRyqi8iiZy6GqNRLAqamnfcBfhRxNgmwrs5CF8jGyhjj9Go/SlM0L160vFWtaYIjkWVVUu6nkTXejgHnP7m6v0q7XpMHdtWg2l7q7R4R30EjVM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l0hGCM5Ad1dwRwz/4pHxZSlPZFRzCCXgh6bXeR8rpg=;
 b=Ut5k8uf6aFhpdNPlpCTRgfvmc8nCWn4ghf03fQsYGx+UY/OXRVNP+wwBEgZLmznf+z1P+5+V+WVenhCEWH7VrQA0e6VydcGro7pylXh8T9laNRJVzvKhQnw6+/BdqXQLp2JPeKfHZJMI38z30x+hUo+lZPMZunz96K9v6bpafEPz+z4OaT4XH5HCFxIljp8zOJceEXNYBjA/r1YGkH8C6LLOggMjEO9SQuAZoQiEs4wgm5xsv2Xg7M6p0QcuBA3PvXvxfkzF1LnYdihHScVD+a0DIj+ems6+26kvl/7RT0F/cqb4tH0x31Zzk8uZJJCRJaM3a6p3/AI8QDVqpui/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l0hGCM5Ad1dwRwz/4pHxZSlPZFRzCCXgh6bXeR8rpg=;
 b=NCPCHqZjk+eC+i7jfI4cjjgis3k34AcWa3tvq7xekeEhg9aDxMKsFdeFtNIuCEw/uRCyu8yAQyF+oxWm0+KpRQB0IgvXMx2R2i6Gwei1mgiPEQVEbuuVAJdVMuF7E6oX6L+S83FHpn2jppLmWQ4WjRCtmhXzAogZRXcCgqB7E7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 05:02:52 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 05:02:52 +0000
Message-ID: <e6e10507-5569-46e8-edc0-cbcabf32cdbe@amd.com>
Date: Thu, 17 Feb 2022 10:32:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd: Check if ASPM is enabled from PCIe subsystem
Content-Language: en-US
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220217034608.14733-1-mario.limonciello@amd.com>
 <cec9eb28-a5ff-52e4-8753-5d8ef0a669b2@amd.com>
 <BL1PR12MB5157B914453FD1DCBAF5B5A3E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB5157B914453FD1DCBAF5B5A3E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::33) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6aefe6e-c0f6-4241-df08-08d9f1d2c065
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848E35489F9D3BC2DE87A1E97369@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPfepz+uf//VqjJnFhELSjhE/47lwbGDWEWg36zRYBRY6Aj1qkeJmWVhaHXxnjdb8w+eJ/DQZjKVGbwwwYaUinxdCpxMBskdABC0mJmIVZKezZoAWtrz3qEQbwrf2YrqpeFjjWv775gVS/quubPsLwSljgwJQXiAHm2xCjCAGJqPaSBxJPQqgjYte9IfFpedq32PDka6DA87tyIeoepQC37Tw56wHs/2wyS8n6jI9vRdVOtPcxSBvak5blvS5y0PjPLxjW3l/1Na9I8boiTbijEhj39a2kg2/gTD8NIzFl1RO+3bwmog/4f32tM1N3Q8y/+OCkcSfVXjsBW38fMLDjSPrJECJxnwDQ1sF3jeRC7j/vPQzqOmXtLFMA6T/03I/S1XLryD8x0NDzDz1e4cpceTzK+shIdNJXMpbxDmMyrSG68/y7/N0nqUxFh8RpgsV5AROXACZESTqTyWIhiXBOv2eKO1D/WF74gBbeoQZty/xvULBhGZ/maMjyObqgThDnyWryGymkN+kpZeGNt/HNNkZAh+i+zsaqTS9kjLL65YOue74oQZqMXcm3gSBt/W8Qy9O5V/mp2KMbJGtVRSRYbSnwyzH1328DDJqp11hESDKhAD0ztuknRA6biVR8rnZ/LI9nREBYXg2wxDbMoqqbrCgGSa8LmKgZEyTHpN+P+2AnsiZNj65Cg8e4C5carYGdkoedNEYRmW8HJ4jTYITu+JANPe7REzdj5HqOdUNOWb1EV0O3s/yNMuI3Q2LoVx98v7Om26wJHJ8pgVJZkl8bPO/SUK2fUfN6IyhM8wX/qt+gfhqPhKKi/I+j3gCz0FT2/b+g4XOmAElfqT4RbudA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(66556008)(66476007)(6512007)(5660300002)(31686004)(86362001)(508600001)(8676002)(4326008)(66946007)(2616005)(36756003)(83380400001)(6486002)(186003)(38100700002)(110136005)(316002)(6506007)(2906002)(6666004)(26005)(966005)(53546011)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmZjK0hEVFNlTnB0MnlsSTQ0VkJRM1VlYTlVWG4ydE94c0c1UWc2c3lzU3FL?=
 =?utf-8?B?NHlSTTlRZ3dXcU52RkRqSS93YkJFclV3KzBzMVFkWlE4cDA0cTlDK2Z1NUhF?=
 =?utf-8?B?V0g3alZzZFNWS3NPbFZWMHppTjRYZFdIU3A0OUh5ZTZHeFRKczNBVWM3cVdY?=
 =?utf-8?B?MGlFM1hoYmh0Qjk3eEJJbU9MbkNtM2gxY241K3RSOElhQnpXVnFzaTFpQlA2?=
 =?utf-8?B?aDVCRTBRbWtlQXVnRkdRWFVTMGpyN2N0NVEwVktrdm1BUmppTERVSkpZaU81?=
 =?utf-8?B?ZGRsTEdNbUtBTmlNaG9NdXNiM2VpMFdERHhPVVpZYnl5Qnc5c3pCUUh2MjlM?=
 =?utf-8?B?bmhDUHJUa2tNMk94Y3JnS1lmN0pKa0swR1h5YjRkWGt2d09FWW5Wb0dMcys2?=
 =?utf-8?B?S3lscm1uRVR4V0IrQ1hncVdlQkl5ZW9BczgvZ3BuSXBwNTd1cmdVT1cybHZ1?=
 =?utf-8?B?UlVEenZlWGl4K1dvVC8zamp2RlV6YXFRVlh4d1J1T21LcVVIWGFTeUM5Z3p2?=
 =?utf-8?B?N3dKOFVKUWVuY1NTMitBKy9YZjJSczUzVlA0OFN0NDVNU2V5Y1cyK0J3b2xD?=
 =?utf-8?B?UWo5dXI0Si9keTZXS093VUthQjIrWUp3Q0FHVHUxNTlCeEo5bmhwbnJFalpS?=
 =?utf-8?B?MlpXM3BOekU4OUd3ZDRNVmtCN2Z1WWJnVndpNlNvSEJzenNJMHdTSzJ1TXh0?=
 =?utf-8?B?eEl2dG5JdVdpOVpZRVFIYVhnWElNblgrT1lzajJyYUMvTGQwa0RoSmU5T0wr?=
 =?utf-8?B?dkhJQittVm9iWjV4MFVXeGZoTCtKRXdONjc1M1U1ZWhSaUgrOGEyZWUxSlpG?=
 =?utf-8?B?YVBUaEhyc0tGWVgyeXhvZzlQR1prRDB3MVB5WmFhbGZSOEl2WVExNml1Qk8z?=
 =?utf-8?B?UFArakxPTzl2NnZwcGtteXpQZUU4b1lZTjNjZkUwd3dObkw4TDhabFhoalFP?=
 =?utf-8?B?WHVpZ1NVS1ZyWWIyZ1VidDZPemRqek1aL0UyaTF3cjU1V0xmU3Z6d1pxZWxC?=
 =?utf-8?B?WWVXaUFGR0I3czdHWmF1eU82UEdRZkp1UnFEZHVtY3pxUEN4cVhDNGNxTytt?=
 =?utf-8?B?ZDVEam1oS200bVhHWkxkMENVcXduWkwyeVJMdEhMYW5HMkYrM3QxN05zNHd5?=
 =?utf-8?B?ODNXWllYUHdoYU5FVHRmSXdzOE5KMWZUdU9wZ0VkUjJpK1psYVlTdkVIZGg1?=
 =?utf-8?B?LytjbENMSVlSK3NIVERHSzRCdkNWTkEvTHluSVFHSW5Bd3ZLSzVHaEhGMTYx?=
 =?utf-8?B?MURIalhpVkU0VTJsa2lJc2EzanY3YkFvckNJVDIwQjdtMTUvL05kVkNSN0VG?=
 =?utf-8?B?UHdNNXk4cEhTRGVTY2Zrcm1kckZXbmM1NnRqQlU1ZUVIdSswL1lncGZiS1pz?=
 =?utf-8?B?SFl2T3lhdkdaOGh5b0h4Ti9pNjQvTy9xTkdGemJyN2hUTkJBVXNnV2FzazVh?=
 =?utf-8?B?M2pybFpiaVJsZ0JsVHJaYnFjUzlMOTRVNjVhMmd5b0NKWFlUdWNIVVpXNVli?=
 =?utf-8?B?Z0R3K3BGM0JKZEQwTVNwMHM4Zi9vQXNnd3FlVlhFcTJlREF5c0I0VFNqYjdl?=
 =?utf-8?B?ZUh2bWlCWjhQRUJ4c0lVL2pKZTFMbVVwZTVzNVR3aXQvSXdCeGFRVU1VV3ZJ?=
 =?utf-8?B?QVRqUWd3SUhCL3lwTHV2end5VUE1MGdJTzJySk1VVmZlYnZ1OWRKL0xHVEx2?=
 =?utf-8?B?dTBmZndKV3BDTGlXNk1FaFZNYnVJQU4yelZNVS9sU1luaGtmeWpHTjZVTEd5?=
 =?utf-8?B?RHBXUHdtQXFvRmdpUWZyMHVKK1VOQTJ2QU5kTlBpUTJuMjYvRWlCODJ6Y05l?=
 =?utf-8?B?V2JpYkJjRm5wZVhWYlpKRXVwdWlkSG1TWVdSK3JhNFN4Mm1zbWV3MkhGQUxP?=
 =?utf-8?B?U0J6cXVKSTd3N1AvUnhNaDFwb3c4cjF5TEhFY2FHUkM0SDE5cm9BVFRzRk16?=
 =?utf-8?B?VVZvTzZHazhBejM2bk4raVlBaWhOalZuWmMrUnVyQmlFRmhYcFZYVjhJSERi?=
 =?utf-8?B?RTNXYWRzeXhyNjJuTGQ3Nm5ROUZyZTZoU0JqWjhMbFY4SlVHQkhVbm8zay9L?=
 =?utf-8?B?TWdwN1JITzl3eU1OS3ZQQ0xmSGwyZTIzZnluVmtrWGRrblJhaEMwWEhlWnVu?=
 =?utf-8?Q?0DLo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aefe6e-c0f6-4241-df08-08d9f1d2c065
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 05:02:52.6557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35Cy/B+dxyZGIzlozqem36v1rAI/NP9FcA4FUU/8mp5n+msWmvTgBrcija3Xq8vS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: "koba.ko@canonical.com" <koba.ko@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/17/2022 10:28 AM, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
>>> commit 0064b0ce85bb ("drm/amd/pm: enable ASPM by default") enabled
>> ASPM
>>> by default but a variety of hardware configurations it turns out that this
>>> caused a regression.
>>>
>>> * PPC64LE hardware does not support ASPM at a hardware level.
>>>     CONFIG_PCIEASPM is often disabled on these architectures.
>>> * Some dGPUs on ALD platforms don't work with ASPM enabled and PCIe
>>>     subsystem disables it
>>>
>>> Check with the PCIe subsystem to see that ASPM has been enabled
>>> or not.
>>>
>>> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
>>> Link:
>> https://wiki.raptorcs.com/w/images/a/ad/P9_PHB_version1.0_27July2018_p
>> ub.pdf
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1723
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1739
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1907
>>> Tested-by: koba.ko@canonical.com
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 5acd0473ed01..d2548fab51c5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2008,6 +2008,9 @@ static int amdgpu_pci_probe(struct pci_dev
>> *pdev,
>>>    			return -ENODEV;
>>>    	}
>>>
>>> +	if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
>>> +		amdgpu_aspm = 0;
>>> +
>>
>> Doesn't this disable aspm for all devices even though only one of the
>> bridges doesn't have support?
> 
> At least with how it's a global parameter today I don't think we can do
> much better without a refactor.
> 
> As it's actively breaking people I think I would prefer to get this in as it
> is now (which can go to stable trees too), and then do the refactor as a
> follow up.
> 

There is enable_aspm/program_aspm calls and the check could be in one of 
those places. I agree that for now this is the easier path.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>    	if (amdgpu_virtual_display ||
>>>    	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
>>>    		supports_atomic = true;
>>>
