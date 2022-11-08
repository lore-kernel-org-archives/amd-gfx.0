Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C703C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 16:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22AE810E4C6;
	Tue,  8 Nov 2022 16:34:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4BF10E4C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 16:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao2JPNCwwCo1KA3M66E2+ag7jDxXFHwE+Oz/Wa69OFe8mhQuVfnNlA9DB7aIhv2BJdsSC7oPywsHhsx5w5dD9o+CGwRjgPFsTsfz+rDzf6/3D6okj7ejKKHawOxR+BMx9TGXJet+k3zake4/NMCCI//DxupelvPiQ3kkytpm1SOtLqjaQOEpT8TkSXP14TpXSPp0HGYIS4pAhwBjHxGcAIxDC8IFbFVNaop1DfRznJ3tM9LDaS7sckrDYboNPOjxxxslaiyzDRGpxOL1jBNO0GmJnoc2rO8YrWuU1ZD7Y7YXr2u7HHUH2wnGkSYCS+3BVqNJlrg9IbHb7JOzqnDo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNWdyA/o0o9xN5TzXvmfNeVjKNn6KrkYS6ijRdMaEmE=;
 b=haeqbsZVlMWkS99BWG4YpAZ+1Nnyyt2k7wwYDCHeGPUdc9ieEXJqUwq9nKhiBTaG79Np3fmxMJpIzyw5Nd0YZxhsWEpKwcLCrkCapBetoVRBeYZ5GfrkmHon+JDs/843KHHQtTP7Gpmt/kYbt0tRzN3sj6KeqeFqeJLXc5TnDXf+07VrKk84hkmGayOEHNjZXiA5AwEm3wx4Kdu5lTXIkyQqC0irKbeRXO2E1otXsSfYrS7zkvYIOx6CV5mLPeuUbznOFpgVNS7aTzHTyU/DeO2GEHT4WrBJbEl2hZX8zt8kvJX2To9byDikADQtKHergvgWe1jaxWlGxqPthA1HkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNWdyA/o0o9xN5TzXvmfNeVjKNn6KrkYS6ijRdMaEmE=;
 b=k4uie+L/jlya6rYENGBTluy6mvlj5uC12epGBqzvyjWqD2Ec5sxZ14XhsajCkMNVP5SXpngBC1yzxE+N0bsx+UFttjxtvuJZWhJS4f1Vm2TgEOwWhVBmuwZr9Bk5iNouM8x033SwMPeGJXAhBogh7DEgko72bOHUv8JqOSwL+ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Tue, 8 Nov 2022 16:34:01 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 16:34:01 +0000
Message-ID: <a9254f52-3462-8a69-3b6d-9f8035bc6899@amd.com>
Date: Tue, 8 Nov 2022 11:33:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Bokun" <Bokun.Zhang@amd.com>
References: <20221108103236.8777-1-Tong.Liu01@amd.com>
 <DM4PR12MB61343BF910630C9BA31F8916903F9@DM4PR12MB6134.namprd12.prod.outlook.com>
 <444456c6-b66b-615a-f340-a5867073a496@amd.com>
 <DM6PR12MB49587BC1D9F0C46AC8646073813F9@DM6PR12MB4958.namprd12.prod.outlook.com>
 <c8b8b0ad-96b6-9ce6-8391-26f0189c758f@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <c8b8b0ad-96b6-9ce6-8391-26f0189c758f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::35) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa5beba-751f-4554-3e32-08dac1a70ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VUTXB22Czh1XwChVDfe2/uha/fI+bLZDB+PEoELJOsZcS4tb1fME8mYFnKYgoOHDRc0wVU8pSTbGdcj3smwFs4qfHSYEEhEn17LznX+OE6DtXguiFCIK+vab+zNQjHQG3mrw2YppQVlABoTgHBZVHalt/lREdtVu7xIy0eAGjgPC5VjItQZWsLuw4/7H7rC1Ic1OFtiTwATIR42QJOp/4zJ5btaLsZp7OHot6c+HHEfS6noTsvwYti7CdK7wxlNA77I8qHHjAlk3Cqa2/auFq+m4tybwhdEa/uxen/yRreoVqKVXBDEByeWyAn2k37Num8i0eBskMI64jiZAOKBT92c80ciWZPw+eX/VXid3KJAxPxOhsbOQMbagFIEX/mmFaUhSJtqQSnbd9aSjNB9s+AAxoZv2MwDKn2HkqJQIU+nsn6pifh24He+d5HXaeJBfVyyIyV5uCndN0jCkGvvwO26TsNtlRLmeEMEUM/hZf/XnvLq8RwFCU8rUd5Ms6Ux/No8b+RYVN6hrTvDP/Y01JvMnYY+yalbT9jnbxQsNLlRUG8YPIaXbFZSoAMwCxLerrXvNVuaQTMK3H0UQ6kRKbmGZ3YOKKJbZls+lfaRN4KSkLLFGBKNK7ckKfUY1ehCsgdzR0CXImjBsUoxM6yi9N6KoeG3+DWncRR9W6cjYFMeSCvj3U5MNLUU7lG30BeBYQBzxH70PcvED8gv4RujQbkJnQbns1E+IWpvNq1YA3NLIOnpl4eK+OIFzESoyxj7ORgj9XrmIrxw4F9ddPJBRGMY0O6Nc1dAO9A8loX179c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(8676002)(66476007)(6636002)(110136005)(54906003)(30864003)(6486002)(44832011)(478600001)(83380400001)(36756003)(8936002)(2906002)(5660300002)(316002)(66946007)(41300700001)(2616005)(26005)(6512007)(186003)(66574015)(53546011)(31686004)(4326008)(31696002)(66556008)(86362001)(38100700002)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1JSdDVOcml1TyttMkYwTk5rRklDME9aMW5VMk82Y29Wb3hNSUhvMnZsQ3Mx?=
 =?utf-8?B?UlNERHkxZnkveEJwSEd0dENaL0pvR0paQTNqY0k5RENTRmx2Z1ArYUFaa0hk?=
 =?utf-8?B?QjNZeXpjMVJGQk4yWExvQWpJTUpobkRMMy9wenVlcTNNRUFmU1J4Y2hHK09i?=
 =?utf-8?B?am5nQ3RGVXg5U2xjV09oUElWbm05eHFydkREZTg5WGZQUWxGZG9yd3YwRWpt?=
 =?utf-8?B?Rkh0RTZxNThNSzFscG5xakVhMDAzTk1oVzZVQzB3VzloM3Rsa2dqdDJOUVVT?=
 =?utf-8?B?U0syZVNETWtJOEltS2Nqa1NzVTNEOGlKQklBR2tvVjZMeUUvMHhvbmhEWW9u?=
 =?utf-8?B?VTZiWERsZ1Vsa0ZncFNrRC9wTHdON1AxZ0NHZERXM3ZMK29la0xFL0dQK2ha?=
 =?utf-8?B?MzRGb2M5VHQvaGRiQnAzZjRxOTNlNnFmbWI5M2VSUVpXY2t0d2hZdC9hOU9o?=
 =?utf-8?B?aTZJeS9GU2UwbC8wVEl1UG5OdGlJR3pqV0hjSXlHWUp1alh5NktkOUo5Nmhw?=
 =?utf-8?B?bkJGb05nTEtHZUo0ZW9sZGhpelUvWTF2SkszMzhnRmRCTEJFbmtaZWwrdHF4?=
 =?utf-8?B?TVhST3c5L29OeVFpZllDeGpJM08wOUY5N3BzWGdwQWZVeWRGcmZqb1NhSm9R?=
 =?utf-8?B?SG9IQjZXcVZGNkMrQTQrWlNtZUhxL2JGNzNaQUtuajExL2FxU3RUUFJGV3V3?=
 =?utf-8?B?YkhyaGROZFNnUWxpSzVueVFwZmRCQ2dVK29RRnRwV2QrcDVXTU5QOFo2d3pR?=
 =?utf-8?B?U0lZREtFSUhuc1owTWhFVUR0V3p6WmF2M3NTK0tPQ2tRV1l2OWk3STN6enNp?=
 =?utf-8?B?M3oxdFMxd0cyOEF4MVkzcVNLZzJJTERqb2hIblRkSjBucExDSkxsb3dUZ1BN?=
 =?utf-8?B?R2FjZHNmQ3J6Vmh4WENydFBFUjEvS3ByZW4xMGRhUnV6aHVsOW9DdWVhYUE3?=
 =?utf-8?B?LzQyaVNzWUk5a3JzQXJ0TlhJcExMRVRBYjZVbFlKbWduRWVrajB1bG5KWXBE?=
 =?utf-8?B?Q1BFOWlyU2s3ZnBwamZLKzlvSjM0WlFrS3lnZnJ6OW9VUmFCdmJDaXJSOFN6?=
 =?utf-8?B?N2ttb2kwN0ZSejBaMEoyTWRIRnVHbmxXUSs2Vmt5RHBYUVpyVGJhQS96U1ht?=
 =?utf-8?B?c2diMUppZVhTQUVzNTc4US9nVk8yeE9JUFluM0hNQmtVbHVLM1YxdkVYQ0VJ?=
 =?utf-8?B?b0xsc0ZEMzB2VStBaWpyRUVHd1lpd0VGQzJVNEdPNitZNllSaDZ0WG0zRkRO?=
 =?utf-8?B?ZEp4Um1PY0FNL1NVeHpvY2NldDc4N0RHMXpNZ28yZVJYSGFOVkVpc3k4QU03?=
 =?utf-8?B?N0dTdDlvZUxxSWFxNmJaWnlEV1JvWHFlR2FQR0Uza3EyN1BiQ045MGg3QjVm?=
 =?utf-8?B?Y09rQUF1d3RFdjN3VTNNMWFWQmZ5VERGVElNcWRPNGJ2c0k3Z2ptdmIxcElX?=
 =?utf-8?B?M2FxS3ZOeGlhNzFwdXhlL3Fjci9ZUHZoeTgxSTNvVlpQcFVwUTFCRmUzVkhT?=
 =?utf-8?B?ZGJPa0YrcUF4anM0S0dlbzBOWkhSbTEwNmJDYXRjQ0tBcUhYb2ZUMHF6Wkkw?=
 =?utf-8?B?VUJKVm4ydkVyTjJqM01hbGVtNmhSZHdzZ09tNkFSaXdXMjJ1ZkZjVTNpOFJo?=
 =?utf-8?B?TmphcXJtTVhWMlpGdThLZkNjVWJnUmFrUXhxUUJ1U3VLdHpXVFVGN0JKb1Nl?=
 =?utf-8?B?ZWJjUXY2RzNYaTNwemVPazh4MktKR3U5N2xjNS9VY2JHYU1vL2RVeDllN0w5?=
 =?utf-8?B?Rmk2WWUxK2JObzY0RG4wM091NjhrYk1pNjFCT1NRNlkvRUZxTHEyMSt0TGZm?=
 =?utf-8?B?TDVOZWl1Z2lVbDZVU21GdENQaHZ0SGM3WWsxbUpsMlJiTmx0UmRpWHZMZFpx?=
 =?utf-8?B?TEU0WmpmSUVHK2dmSHNScWhacG9RbkZSeVNRUDNFaGFtSERxRDQ0R0dFaXZ6?=
 =?utf-8?B?UHl5akgxZmVTdnAzTmxLWDlJa0RQMWF3dmNCZjJkQWc4UTlvM1gxRGZBN1FL?=
 =?utf-8?B?VGw3aVRGQk1ZYkRSYmthTjhzR2U1bk5wQnRnRGR4MkZNaTFjTndOQUdRUmRM?=
 =?utf-8?B?Z2dLZGJmb0c2M2hlcFJxRjZ3UlFlTXJLT2hNaGFlZkVORk1DNnEyNGovd3l3?=
 =?utf-8?Q?+8VY+nbO7XTnrLYTeckE3n953?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa5beba-751f-4554-3e32-08dac1a70ae2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 16:34:01.4988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uk/8PmkBN++0lH+Pn+C0kpTYVXVi9llRNeSlf1OH/7EenDZwXX1Az+CGbpvTRD2n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Sohail, Rashid" <Rashid.Sohail@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Applying this patch to amd-staging-drm-next, with checkpatch.pl enabled, generates the following output. Perhaps those issues should be address and fixed.

$git am ~/patches/tongliu01/\[PATCH]\ drm_amdgpu\:\ add\ vram\ reservation\ logic\ based\ on\ vram_usagebyfirmware_v2_2\ -\ Tong\ Liu01\ \<Tong.Liu01\@amd.com\>\ -\ 2022-11-08\ 0532.eml
Applying: drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
-:10: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#10: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:105:
+static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
+		struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,

-:13: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
#13: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:108:
+	uint32_t start_addr, fw_size, drv_size;

-:20: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#20: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:115:
+	DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
+		start_addr,

-:40: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#40: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:135:
+static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
+		struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,

-:43: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
#43: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:138:
+	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;

-:45: WARNING:LONG_LINE: line length of 88 exceeds 81 columns
#45: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:140:
+	fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);

-:48: WARNING:LONG_LINE: line length of 94 exceeds 81 columns
#48: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:143:
+	drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);

-:49: WARNING:LONG_LINE: line length of 82 exceeds 81 columns
#49: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:144:
+	drv_size = le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);

-:51: WARNING:LONG_LINE_STRING: line length of 86 exceeds 81 columns
#51: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:146:
+	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",

-:52: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#52: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:147:
+	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
+		fw_start_addr,

-:57: WARNING:LONG_LINE: line length of 82 exceeds 81 columns
#57: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:152:
+	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {

-:64: WARNING:LONG_LINE: line length of 83 exceeds 81 columns
#64: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:159:
+	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {

-:85: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u8' over 'uint8_t'
#85: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:178:
+	uint8_t frev, crev;

-:109: WARNING:LONG_LINE: line length of 90 exceeds 81 columns
#109: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:181:
+	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {

-:112: WARNING:LONG_LINE: line length of 94 exceeds 81 columns
#112: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:184:
+				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);

-:114: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#114: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:186:
+			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
+					firmware_usage_v2_1,

-:118: WARNING:LONG_LINE: line length of 94 exceeds 81 columns
#118: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:190:
+				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);

-:120: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#120: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:192:
+			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
+					firmware_usage_v2_2,

-:149: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#149: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1595:
+	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
+		NULL, NULL);

-:168: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u64' over 'uint64_t'
#168: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1633:
+	uint64_t vram_size = adev->gmc.visible_vram_size;

-:239: WARNING:LONG_LINE_COMMENT: line length of 113 exceeds 81 columns
#239: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:709:
+  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.

-:239: WARNING:BLOCK_COMMENT_STYLE: Block comments use * on subsequent lines
#239: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:709:
+/*
+  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.

-:240: WARNING:LONG_LINE_COMMENT: line length of 112 exceeds 81 columns
#240: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:710:
+  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.

-:245: WARNING:LONG_LINE_COMMENT: line length of 132 exceeds 81 columns
#245: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:715:
+      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)

-:248: WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 81 columns
#248: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:718:
+      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)

-:249: WARNING:LONG_LINE_COMMENT: line length of 102 exceeds 81 columns
#249: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:719:
+    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.

-:257: WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 81 columns
#257: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:727:
+      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)

-:262: WARNING:LONG_LINE_COMMENT: line length of 99 exceeds 81 columns
#262: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:732:
+      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;

-:263: WARNING:LONG_LINE_COMMENT: line length of 134 exceeds 81 columns
#263: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:733:
+      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )

-:268: WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 81 columns
#268: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:738:
+      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)

-:271: WARNING:TYPO_SPELLING: 'dirver' may be misspelled - perhaps 'driver'?
#271: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:741:
+      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
       ^^^^^^

-:271: WARNING:LONG_LINE_COMMENT: line length of 104 exceeds 81 columns
#271: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:741:
+      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area

-:273: WARNING:LONG_LINE_COMMENT: line length of 94 exceeds 81 columns
#273: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:743:
+      driver set driver_region0_start_address_in_kb =  driver reservation region start address

-:274: WARNING:LONG_LINE_COMMENT: line length of 97 exceeds 81 columns
#274: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:744:
+      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero

-:275: WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 81 columns
#275: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:745:
+      as the reservation for VF as it doesn’t exist.  And Host driver should also

-:276: WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 81 columns
#276: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:746:
+      update atom_firmware_Info table to remove the same VBIOS reservation as well.

-:288: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
#288: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:754:
+	uint32_t  start_address_in_kb;

-:289: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u16' over 'uint16_t'
#289: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:755:
+	uint16_t  used_by_firmware_in_kb;

-:290: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u16' over 'uint16_t'
#290: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:756:
+	uint16_t  used_by_driver_in_kb;

-:295: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
#295: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:761:
+	uint32_t  fw_region_start_address_in_kb;

-:296: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u16' over 'uint16_t'
#296: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:762:
+	uint16_t  used_by_firmware_in_kb;

-:297: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u16' over 'uint16_t'
#297: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:763:
+	uint16_t  reserved;

-:298: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
#298: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:764:
+	uint32_t  driver_region0_start_address_in_kb;

-:299: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
#299: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:765:
+	uint32_t  used_by_driver_region0_in_kb;

-:300: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
#300: FILE: drivers/gpu/drm/amd/include/atomfirmware.h:766:
+	uint32_t  reserved32[7];

total: 0 errors, 25 warnings, 20 checks, 281 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
scripts/checkpatch.pl found problems with your patch.
To disable its check, run your Git command as
(unset GIT_CHECKPATCH; git ...)
$_

Regards,
Luben


On 2022-11-08 09:04, Christian König wrote:
> Yeah, I mean the code looks correct.
> 
> It's just that style problems are usually pointed out by automated 
> checkers, especially things like dos line endings.
> 
> So get that fixed and we can push it immediately.
> 
> Thanks,
> Christian.
> 
> Am 08.11.22 um 14:49 schrieb Chang, HaiJun:
>> [AMD Official Use Only - General]
>>
>> + Bokun to help addressing the coding style problem in MKM side.
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, November 8, 2022 8:53 PM
>> To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Sohail, Rashid <Rashid.Sohail@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
>>
>> Hi Esther
>>
>> well there are a couple of things which you need to address before getting this merged.
>>
>> First of all the patch you send out uses dos line endings instead of the unix line endings. Not sure how you manage to do that, but please use "git send-email" instead to avoid that.
>>
>> Then your patch contains a bunch of white spaces after code warning which checkpatch.pl complains about (after ignoring the dos line ending warnings). So this was clearly not properly checked with checkpatch.pl.
>>
>> Then the kernel coding style usually says that with a multi line "if ("
>> the next lines should start after the opening "(". In other words intend with tabs and the whitespaces. I'm not sure what editor you are using, but there are standard settings available for basically all large editors which does stuff like that automatically. Please try to use one of those.
>>
>> Regarding the casing of the values it's a good argument that you only move the code around, but the general coding style is just extremely questionable. The defines should use the lowest necessary integer type.
>> But it's correct that this should probably be part of another patch.
>>
>> Regards,
>> Christian.
>>
>> Am 08.11.22 um 11:40 schrieb Liu01, Tong (Esther):
>>> [AMD Official Use Only - General]
>>>
>>> Hi @Koenig, Christian,
>>>
>>> Refined as your comment. By the way:
>>> if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT))
>>>
>>> This part is the old code, I just move it out from the original function to shrink the function size as your comment before. And now I just removed the first uint32_t since if remove both will cause "warning: bitwise comparison always evaluates to false". And I tested the code after removing the first uint32_t, the code works well. Please review the new patch, thanks.
>>>
>>> Kind regards,
>>> Esther
>>>
>>> -----Original Message-----
>>> From: Tong Liu01 <Tong.Liu01@amd.com>
>>> Sent: 2022年11月8日星期二 下午6:33
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
>>> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig,
>>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
>>> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,
>>> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
>>> <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
>>> Subject: [PATCH] drm/amdgpu: add vram reservation logic based on
>>> vram_usagebyfirmware_v2_2
>>>
>>> Move TMR region from top of FB to 2MB for FFBM, so we need to reserve
>>> TMR region firstly to make sure TMR can be allocated at 2MB
>>>
>>> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
>>> ---
>>>    .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
>>>    drivers/gpu/drm/amd/include/atomfirmware.h    |  62 ++++++++--
>>>    4 files changed, 192 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> index b81b77a9efa6..032dc2678d7c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> @@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>>>        }
>>>    }
>>>
>>> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>>> +             struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
>>> +             int *usage_bytes)
>>> +{
>>> +     uint32_t start_addr, fw_size, drv_size;
>>> +
>>> +     start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
>>> +     fw_size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
>>> +     drv_size = le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb);
>>> +
>>> +     DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
>>> +             start_addr,
>>> +             fw_size,
>>> +             drv_size);
>>> +
>>> +     if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>>> +             /* Firmware request VRAM reservation for SR-IOV */
>>> +             adev->mman.fw_vram_usage_start_offset = (start_addr &
>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>>> +             /* Use the default scratch size */
>>> +             *usage_bytes = 0;
>>> +     } else {
>>> +             *usage_bytes = drv_size << 10;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>>> +             struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
>>> +             int *usage_bytes)
>>> +{
>>> +     uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
>>> +
>>> +     fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
>>> +     fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
>>> +
>>> +     drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
>>> +     drv_size =
>>> +le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
>>> +
>>> +     DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
>>> +             fw_start_addr,
>>> +             fw_size,
>>> +             drv_start_addr,
>>> +             drv_size);
>>> +
>>> +     if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>>> +             /* Firmware request VRAM reservation for SR-IOV */
>>> +             adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>>> +     }
>>> +
>>> +     if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>>> +             /* driver request VRAM reservation for SR-IOV */
>>> +             adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>> +             adev->mman.drv_vram_usage_size = drv_size << 10;
>>> +     }
>>> +
>>> +     *usage_bytes = 0;
>>> +     return 0;
>>> +}
>>> +
>>>    int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)  {
>>>        struct atom_context *ctx = adev->mode_info.atom_context;
>>>        int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>>                                                vram_usagebyfirmware);
>>> -     struct vram_usagebyfirmware_v2_1 *firmware_usage;
>>> -     uint32_t start_addr, size;
>>> +     struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
>>> +     struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>>>        uint16_t data_offset;
>>> +     uint8_t frev, crev;
>>>        int usage_bytes = 0;
>>>
>>> -     if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
>>> -             firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>>> -             DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
>>> -                       le32_to_cpu(firmware_usage->start_address_in_kb),
>>> -                       le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
>>> -                       le16_to_cpu(firmware_usage->used_by_driver_in_kb));
>>> -
>>> -             start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
>>> -             size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
>>> -
>>> -             if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>> -                     (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>> -                     ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>>> -                     /* Firmware request VRAM reservation for SR-IOV */
>>> -                     adev->mman.fw_vram_usage_start_offset = (start_addr &
>>> -                             (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>> -                     adev->mman.fw_vram_usage_size = size << 10;
>>> -                     /* Use the default scratch size */
>>> -                     usage_bytes = 0;
>>> -             } else {
>>> -                     usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
>>> +     if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
>>> +             if (frev == 2 && crev == 1) {
>>> +                     firmware_usage_v2_1 =
>>> +                             (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>>> +                     amdgpu_atomfirmware_allocate_fb_v2_1(adev,
>>> +                                     firmware_usage_v2_1,
>>> +                                     &usage_bytes);
>>> +             } else if (frev >= 2 && crev >= 2) {
>>> +                     firmware_usage_v2_2 =
>>> +                             (struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
>>> +                     amdgpu_atomfirmware_allocate_fb_v2_2(adev,
>>> +                                     firmware_usage_v2_2,
>>> +                                     &usage_bytes);
>>>                }
>>>        }
>>> +
>>>        ctx->scratch_size_bytes = 0;
>>>        if (usage_bytes == 0)
>>>                usage_bytes = 20 * 1024;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 585460ab8dfd..4a73cb314086 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>>>                NULL, &adev->mman.fw_vram_usage_va);
>>>    }
>>>
>>> +/*
>>> + * Driver Reservation functions
>>> + */
>>> +/**
>>> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * free drv reserved vram if it has been reserved.
>>> + */
>>> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device
>>> +*adev) {
>>> +     amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
>>> +             NULL, NULL);
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>>>     *
>>> @@ -1604,6 +1620,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>>>                                          &adev->mman.fw_vram_usage_va);
>>>    }
>>>
>>> +/**
>>> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from
>>> +driver
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * create bo vram reservation from drv.
>>> + */
>>> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device
>>> +*adev) {
>>> +     uint64_t vram_size = adev->gmc.visible_vram_size;
>>> +
>>> +     adev->mman.drv_vram_usage_reserved_bo = NULL;
>>> +
>>> +     if (adev->mman.drv_vram_usage_size == 0 ||
>>> +         adev->mman.drv_vram_usage_size > vram_size)
>>> +             return 0;
>>> +
>>> +     return amdgpu_bo_create_kernel_at(adev,
>>> +                                       adev->mman.drv_vram_usage_start_offset,
>>> +                                       adev->mman.drv_vram_usage_size,
>>> +                                       AMDGPU_GEM_DOMAIN_VRAM,
>>> +                                       &adev->mman.drv_vram_usage_reserved_bo,
>>> +                                       NULL);
>>> +}
>>> +
>>>    /*
>>>     * Memoy training reservation functions
>>>     */
>>> @@ -1771,6 +1812,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>                return r;
>>>        }
>>>
>>> +     /*
>>> +      *The reserved vram for driver must be pinned to the specified
>>> +      *place on the VRAM, so reserve it early.
>>> +      */
>>> +     r = amdgpu_ttm_drv_reserve_vram_init(adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>>        /*
>>>         * only NAVI10 and onwards ASIC support for IP discovery.
>>>         * If IP discovery enabled, a block of memory should be @@ -1896,6 +1945,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>>        amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>>                                        &adev->mman.sdma_access_ptr);
>>>        amdgpu_ttm_fw_reserve_vram_fini(adev);
>>> +     amdgpu_ttm_drv_reserve_vram_fini(adev);
>>>
>>>        if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 9120ae80ef52..339838675b11 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -92,6 +92,11 @@ struct amdgpu_mman {
>>>        struct amdgpu_bo        *fw_vram_usage_reserved_bo;
>>>        void            *fw_vram_usage_va;
>>>
>>> +     /* driver VRAM reservation */
>>> +     u64             drv_vram_usage_start_offset;
>>> +     u64             drv_vram_usage_size;
>>> +     struct amdgpu_bo        *drv_vram_usage_reserved_bo;
>>> +
>>>        /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>>        struct amdgpu_bo        *sdma_access_bo;
>>>        void                    *sdma_access_ptr;
>>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h
>>> b/drivers/gpu/drm/amd/include/atomfirmware.h
>>> index ff855cb21d3f..c0f56ae653f0 100644
>>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>>> @@ -705,20 +705,66 @@ struct atom_gpio_pin_lut_v2_1  };
>>>
>>>
>>> -/*
>>> -  ***************************************************************************
>>> -    Data Table vram_usagebyfirmware  structure
>>> -
>>> **********************************************************************
>>> *****
>>> +/*
>>> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
>>> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
>>> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
>>> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
>>> +    if( VBIOS/UEFI GOP is posted ) {
>>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
>>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
>>> +      driver can allocate driver reservation region under firmware reservation,
>>> +      used_by_driver_in_kb = driver reservation size
>>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>>> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
>>> +    Host driver would overwrite the table with the following
>>> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
>>> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
>>> +    } else {
>>> +      there is no VBIOS reservation region
>>> +      driver must allocate driver reservation region at top of FB.
>>> +      driver set used_by_driver_in_kb = driver reservation size
>>> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
>>> +      same as Comment1
>>> +    }
>>> +  } else { //( NV1X and after)
>>> +    if( VBIOS/UEFI GOP is posted ) {
>>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
>>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
>>> +    }
>>> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
>>> +      driver can allocate driver reservation region under firmware reservation,
>>> +      driver set used_by_driver_in_kb = driver reservation size
>>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>>> +      same as Comment1
>>> +    } else {
>>> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
>>> +      driver set used_by_driver_region0_in_kb = driver reservation size
>>> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
>>> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
>>> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
>>> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
>>> +    }
>>> +  }
>>>    */
>>>
>>>    struct vram_usagebyfirmware_v2_1
>>>    {
>>> -  struct  atom_common_table_header  table_header;
>>> -  uint32_t  start_address_in_kb;
>>> -  uint16_t  used_by_firmware_in_kb;
>>> -  uint16_t  used_by_driver_in_kb;
>>> +     struct  atom_common_table_header  table_header;
>>> +     uint32_t  start_address_in_kb;
>>> +     uint16_t  used_by_firmware_in_kb;
>>> +     uint16_t  used_by_driver_in_kb;
>>>    };
>>>
>>> +struct vram_usagebyfirmware_v2_2 {
>>> +     struct  atom_common_table_header  table_header;
>>> +     uint32_t  fw_region_start_address_in_kb;
>>> +     uint16_t  used_by_firmware_in_kb;
>>> +     uint16_t  reserved;
>>> +     uint32_t  driver_region0_start_address_in_kb;
>>> +     uint32_t  used_by_driver_region0_in_kb;
>>> +     uint32_t  reserved32[7];
>>> +};
>>>
>>>    /*
>>>
>>> **********************************************************************
>>> *****
>>> --
>>> 2.25.1
> 

