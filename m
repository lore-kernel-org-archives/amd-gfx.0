Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77962606A32A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YM0CRM/M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F7010EA78;
	Wed, 11 Nov 2026 15:29:31 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58D710EA70
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 15:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3DiI6DpxAnbJEy4c5YastmF9JiDqocSWdJwmu/r4ViiombncRZdkCybFVw0qYWFAVWfjr84p14Q9xdmiT0PGcO7GVpWakWZDejVjsC+a90YIlatcfbvCOyIoLXrtFj68dWgmWexI33dXcHKzXRGG80dfs0MSFpj/CBlujBbI2JHANH7WQHGOcwUanEv7qE/0m2z8utdSRM9eEdZ4TJOulj+7VWQrzjfpelEEOucQ23LC/Mev7eFApC8zMGvSSI+AOKT+fFNL1xjGx2ccdOvk+Ri2MQVMXVmAAgVi5Bd28FZMSo4daKF+9ipAvVgi6fbdTerVK0X4U8KL0ANnkQe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h6c+EnwjN0yLLsJJzxM/p5y5WNZud47Eizc5/TiVpM=;
 b=ia1QlcWf5nCzq8da+MI0F1E0H2x88xpfCHOzGcZVLmuMFk9yRW6Q0yykBK8FZrOd35faE2lLwPTUg+1c76iAYX4D4EuDXXC8piwra7feRyGAXysF6iZ0MASzxKQ19huc7e3BQZWRejxiXAP314frBm5jIcjMnIZil17SrUhnLJqKqPdI3MqafPn+TFpHkv6l+q/5IkrJK2wK+Ab0rEX6z0QiKUqGOJLxrInvo45crGCVi06U6mrXair/w6QGzeJ49gKjPdF6KtXTnnhRY6oo5AVEMRzXgK2WtMAjxyT3oINcgAfX0D9JXIuwOd5S3nEgep8uYj0B41HaChVtP9yhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h6c+EnwjN0yLLsJJzxM/p5y5WNZud47Eizc5/TiVpM=;
 b=YM0CRM/Muuk/Zk3Gm5+NmRxcJGyEWU+aU85Q45N4bc+BzyBA1hU+jDcEiDZ94YUvT1JAI3RF8QsvY7qcAD7QCXwV6OExOQbAxvJaIwkd1OgOOxCYx/7iWAYAun+HgW+I1hVOyN9/9of3BuQkSWtycJe/59v3JLbMLuWVJFDrIzc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 15:29:15 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 15:29:14 +0000
Message-ID: <b58f2e4a-f0ee-4e71-a2e1-4b9e1da6b68b@amd.com>
Date: Wed, 11 Nov 2026 09:29:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Select the firmware signing scheme the PSP
 reports
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261109165009.763473-1-mario.limonciello@amd.com>
 <CADnq5_NVNFZ6id_KCnbR6Y0AZBDyLP=K4t0qVTXj=_3DaMaNAQ@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_NVNFZ6id_KCnbR6Y0AZBDyLP=K4t0qVTXj=_3DaMaNAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:610:b3::35) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: ae214f2b-8326-4066-6034-08df40088ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|6133799003|4143699003|5023799004|11063799006|10067099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: /4r5fJ5HaU28Rh6HT8zKZB/wFaKseAvCzjIIels1D8lSIoWtzsIMbnFTZpehyubbqEhGG9xBylsrFWp7+E902ftqEgD2PvPYLWvfAQ9u+hue1by7vM9Rjb1FmGODvomBqv/0Hl3Gyko2ehrM0uL+//jcZuxB+sCDWgxrDW4GxQCLuzxNIn8Sb3HthO+lQoAsYpaOZE6Po5e5TFHW7hDD/Cl2ymhu3y+f7GQuWJ6EZkKPcqysvOzp5Nmf+zSDiAiyAOEA5w8/a4wzHDQWfZ5uRBI3/e4kOuUWpN4+3w/N9Oy/bZu+ECHQuMi2GH22mjKHeBTqq9LQ5seDNw0jhx2PsYj0RVNqoT+WkeMIZo29Lz/VgjiFGChMkL142yOCt/p3Jtxp02gWF4O9EI7cLbaOGmA1hR1Rc/qTAl4zL0uRO+KxMtmdmFCiXtG0WuTK5zZXyzMdJRWUioLSrErcHRgHEEEUpi6+aaR/ZzZBojcvENVJByMONWaF0ekO/fQpWiJhTH4jzMibCkQyyAvjmEAr8Rzl2e6zanBpWoTRHuukJhAyt79j3OS4O2THIc8gI9gT2Hz8/eFr+eYBAE2J2cHaP5Yetj59ZMTm9LctQMTKcGDbRRueBd8BwOwIP9Rfo0aDgitts3YDFWzMlaFZhAeZtRdiiif4stKyul/Vp+NGajY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(5023799004)(11063799006)(10067099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3FTM1JCRkJjWXFseHR0WjByeWZkQ0VIVzQ4OVVROHoyaEpzc3ZLZUxyWk5P?=
 =?utf-8?B?ZFNZUFZlbkc1dWxtMmduWmdSRFJ3bEpiMlBzU0paT1F2VUs3WVRhU2JJUDk2?=
 =?utf-8?B?UnBWa1hKd0hZUzZYaTNFeGZFK2hYc1lxUTJVUjBQZk1SS3NiSG5RNnlxKzhF?=
 =?utf-8?B?dUdkQW5DWnN4Q1hvZ1ZwS2RiL3p4YytYVG5zUitDekFNRlI5VEZCbXROQU5l?=
 =?utf-8?B?MGdpZTMvN21kaHNxVzZKdFpDeEVxelVCcFZRdnRvZGx3YVZmOWlLSkllekd5?=
 =?utf-8?B?WlM2ekNvd1FVWW9XdHVTQXpxZ1RZL1BaQTE5VkZMN2FKTzJVMkErTnY1NW9Q?=
 =?utf-8?B?SmRsVXc1aXBHWFd2ZzhOeHFaN2k0TnJTQUxoVHJ5VHAzcFJZNlhud01wQTZt?=
 =?utf-8?B?TmkyQW9iMHBKYVB2RFBTWjlHSjNaT3NtVktaemY0VDNoTHJURGw0R2FZeDBF?=
 =?utf-8?B?M3ZkSFNuVW1vQTdoVGVMY01DeDBJTmx5enVzSUNGWTRxZWJGWVlMREFHWWZk?=
 =?utf-8?B?M3I0QnhTRGZHY3NSWkc1dDMwY3oybmVScGpFWmovdjZPMHhMb0VLSkJWVVFR?=
 =?utf-8?B?dUZvUFNFU0t5empnS0tYNkk5ZEhGQzI0YWZzNG9TRFhLemVkZXdRN2xwUFdt?=
 =?utf-8?B?eEgwejVnNjg2Vld5cGg0L2FTVGh2LzF6dDJBRWJvUmpFMEZLTUt5N2E2NHBv?=
 =?utf-8?B?enlNT3VDRFBielhvbzZtWFRZVHlwNVMyVzAxZkZTSW1rRU5CZXFldG9KOFZn?=
 =?utf-8?B?U0J0ck1PQjNTZisrZzQ1clJ5aWpJdmRvcUVES3pEM0RFbkVCZDZWZXF0Y05M?=
 =?utf-8?B?MFVXaTdQNTZrZWJIRWNJYkpkWHRFYmpJMitOM0RJSjRKS2NkU1ZSYzQrN01u?=
 =?utf-8?B?b2dmcWxNZjBBODFKYXNPQnF3QVl4SXdQdDhBaFpkbmh3bW1ub3lOSEEvUS9x?=
 =?utf-8?B?UkpDc2RLc1J3UW5naE9YKzJWeXBkZGQxTjQxMlg4WEdacUhtRFJZU2M4c3p5?=
 =?utf-8?B?WkEyQXJmQ3VneUhWd1RLUEZaRVc0ak5vcEtqTkQvUkR3VWlVZlpRQXdHd284?=
 =?utf-8?B?aC9VSEdVRmR1empydERtVGFueW5jQi8xK2R0emJvOXZ1emVSeDgwa0tJR2RG?=
 =?utf-8?B?QUhwS0o5RXpYV3dSODJ3cGlaQTV6TVJUYzFoSUwybHF1OG9kVVd5MEF6UDRF?=
 =?utf-8?B?YWV2QkR2NmJMcVdGdVFYNXdTbCt6WHZhL3gyODBHeFkrMm9ONDVPN25STjVG?=
 =?utf-8?B?WHk4MkpUcDJ2S3UvL29KbTNNT0NMZEtFUkF0WlRtM05iMEtxWVJWSC9iMjNk?=
 =?utf-8?B?aGlRWE5ZSkMrc2lTYnovazdwZG9aaStNeXZFOHF5bE9CT1VRZkdxd0xmTGZT?=
 =?utf-8?B?eldRc3M4TWJKZ0ZiSjlEVFNpd1FzdTNadlBob0xHQzMvR04yTHJXMjJwVTYz?=
 =?utf-8?B?V04xWkJPWGwvSllhclJybWdRRE5OSjRyVHhXSWNhQ2Z4UENiUDU1cXRaaTlu?=
 =?utf-8?B?c2M2QzRzL1gxZVdEK3VQdWd5WGxsR2VLVTg3bVVOM3RQeVlISEkyd2FVR21r?=
 =?utf-8?B?a1B5RncxWUZyYUUwaUtvTUFlV2RrTHlUalY0NGJTTW9EQkZpQ3c3WGRIQUNl?=
 =?utf-8?B?SFlzbktZbnErNm5QTHhZME9MUXk5cnhNMmRhVk5MTnRkbVNKZ1FDSWVrQ2h3?=
 =?utf-8?B?Z3VNWHlGMThDVXltZXFDNEZvdXhOU2liWGU1R0I4WERQRVNidklSZ05vNHpV?=
 =?utf-8?B?Qlg5UW9mQWxkYVdJOElCRE9mSXYzQ1lWL2ZwUnZjd2U2c0pVSWRnL3hHRHNR?=
 =?utf-8?B?Q0ZJQytWcXlUOGRrMUUvbHptZHV4aEVFa25GQ2wvOEUwa3FOUXVGeE1Cb3p1?=
 =?utf-8?B?QTVZaW9JSmNNazlrbmRaK3I5NFVMZ2FvTHBBQnZOWituSGt0enhRMWlFZDF2?=
 =?utf-8?B?MnlnMTBUclI4anNhRTBodHBXemxDZzZnb2lIQTJrdmRZVlo2cVg5VFdSdWdB?=
 =?utf-8?B?YnlmemhGVHFnWHVPZXE5dElsbkJRaFBsWWp3S05YOEl3Vno2LzVLRHhqaEVO?=
 =?utf-8?B?Z012NllhaGxOSkVZdFVvS2N0NERkcHVlU2EyRXo0NGdJZUp0U1l2T2JIWUp2?=
 =?utf-8?B?RTZhb0d1dGQwYU51STliYXZ5UWlBWThpK3gva3ZTcjF6SzdGZ2F5OUNpQitp?=
 =?utf-8?B?bnk5d2Z6WUxNZWxieFFEeXhjU1QwVnVtNFpuRVc5aUZVNU5nVnNpa2lCbnNI?=
 =?utf-8?B?eHRsRmsxVitiQTdtOERnKzU2WHpwZzZ3Y005VXBMMEdNMGZOWlFXQUhpQ3Zx?=
 =?utf-8?Q?j1MMlfnjI5a9tz+FG9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae214f2b-8326-4066-6034-08df40088ae7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:29:14.6947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aklVm2qjrQpMvb7sJ9ka4wgzEgN+aEvDxvEUgXqauQ2pBdv/PHoyGAojZmwQOr+cKIWzQVJ6Nep4gidb8ZP9rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 08:44, Alex Deucher wrote:
> On Mon, Nov 9, 2026 at 11:56 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Some platforms ship BIOS with either a default or an alternative trust
>> authority, so firmware for every IP must be signed with the matching
>> scheme.
>> The PSP advertises which one is in use in bit 6 of C2PMSG_63, and in bit 28
>> whether this is a preproduction part, which needs firmware of its own.
>>
>> Add amdgpu_psp_init_fw_variant() which reads those bits through amdgpu's
>> own MMIO, and keep the result in adev->firmware.sign_type and
>> adev->firmware.preprod next to load_type. It is initialized once, after IP
>> discovery has populated the register bases and only when firmware is loaded
>> through the front door (the PSP). Only MP0 15.0.0 reports it. For all other
>> ASICs, SR-IOV VFs and an inaccessible register (all ones) the defaults are
>> kept: AMDGPU_FW_SIGN_DEFAULT and not preproduction. A preproduction part
>> that also reports the alternative scheme is not expected, so warn about it
>> and use the default firmware.
>>
>> Firmware for preproduction parts is named with a "_p" suffix before the
>> extension and firmware for the alternative scheme with an "_l" suffix (e.g.
>> "foo.bin" becomes "foo_p.bin" or "foo_l.bin"). Production parts on the
>> default scheme use the plain names. Do the substitution centrally in
>> amdgpu_ucode_request() so it covers every IP that loads firmware through it
>> (PSP, SMU, DMUB, GC, IMU, MES, SDMA, VCN, VPE, ...) without each loader
>> having to care. There is no fallback to the default file: it would be
>> rejected anyway. Declare the variants of the Medusa IPs with
>> MODULE_FIRMWARE() so that initramfs generators include them.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Cover PSP 15.0.9 too.
>>   * Cover MODULE_FIRMWARE declarations for more files.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 32 ++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 25 +++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  7 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 ++++++++
>>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 37 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +
>>   drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 +
>>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +
>>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
>>   15 files changed, 143 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index c170bf3b61281..799a76e1cfe77 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2098,6 +2098,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                          amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
>>          }
>>
>> +       /* Needs the register bases, and must be known before requesting firmware */
>> +       if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
>> +               amdgpu_psp_init_fw_variant(adev);
>> +
>>          total = true;
>>          for (i = 0; i < adev->num_ip_blocks; i++) {
>>                  ip_block = &adev->ip_blocks[i];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index c0ed3e24b6840..4f060666f12a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -403,6 +403,38 @@ static uint64_t psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
>>          return pos;
>>   }
>>
>> +/*
>> + * Which firmware the platform needs, as reported by the PSP in C2PMSG_63: the
>> + * signing scheme and whether this is a preproduction part. The defaults are kept if
>> + * the ASIC doesn't report it or it can't be read.
>> + */
>> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev)
>> +{
>> +       bool alt, preprod;
>> +
>> +       if (amdgpu_sriov_vf(adev))
>> +               return;
>> +
>> +       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
>> +       case IP_VERSION(15, 0, 0):
>> +       case IP_VERSION(15, 0, 9):
>> +               if (psp_v15_0_0_get_fw_variant(adev, &alt, &preprod))
>> +                       return;
>> +               break;
>> +       default:
>> +               return;
>> +       }
>> +
>> +       if (alt && preprod) {
>> +               drm_warn(adev_to_drm(adev),
>> +                        "Preproduction part with alternative signing, using default firmware\n");
>> +               return;
>> +       }
>> +
>> +       adev->firmware.sign_type = alt ? AMDGPU_FW_SIGN_ALT : AMDGPU_FW_SIGN_DEFAULT;
>> +       adev->firmware.preprod = preprod;
>> +}
>> +
>>   /*
>>    * Helper funciton to query psp runtime database entry
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> index 975d123593588..9b04e51f589ff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> @@ -631,6 +631,7 @@ int psp_ta_invoke(struct psp_context *psp,
>>
>>   int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
>>   bool psp_is_xgmi_ta_supported(struct psp_context *psp);
>> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev);
>>   int psp_xgmi_terminate(struct psp_context *psp);
>>   int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
>>   int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> index d2ce526dd95cc..eeb056dcad2c4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> @@ -1527,6 +1527,27 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>>          snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
>>   }
>>
>> +/* Add the suffix of the firmware variant before the extension: foo.bin -> foo_l.bin */
>> +static int amdgpu_ucode_set_suffix(struct amdgpu_device *adev, char *fname, size_t size)
>> +{
>> +       const char *suffix = ".bin";
>> +       size_t len = strlen(fname), base;
>> +
>> +       if (adev->firmware.preprod)
>> +               suffix = "_p.bin";
>> +       else if (adev->firmware.sign_type == AMDGPU_FW_SIGN_ALT)
>> +               suffix = "_l.bin";
>> +
>> +       if (len < strlen(".bin") || strcmp(fname + len - strlen(".bin"), ".bin"))
>> +               return 0;
>> +
>> +       base = len - strlen(".bin");
>> +       if (strscpy(fname + base, suffix, size - base) < 0)
>> +               return -EOVERFLOW;
>> +
>> +       return 0;
>> +}
>> +
>>   /*
>>    * amdgpu_ucode_request - Fetch and validate amdgpu microcode
>>    *
>> @@ -1555,6 +1576,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>>                  return -EOVERFLOW;
>>          }
>>
>> +       r = amdgpu_ucode_set_suffix(adev, fname, sizeof(fname));
>> +       if (r)
>> +               return r;
>> +
>>          if (required == AMDGPU_UCODE_REQUIRED)
>>                  r = request_firmware(fw, fname, adev->dev);
>>          else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>> index 7c809692807fc..a77758c07be23 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>> @@ -571,6 +571,11 @@ enum amdgpu_firmware_load_type {
>>          AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>>   };
>>
>> +enum amdgpu_firmware_sign_type {
>> +       AMDGPU_FW_SIGN_DEFAULT = 0,
>> +       AMDGPU_FW_SIGN_ALT,
>> +};
>> +
>>   enum amdgpu_ucode_required {
>>          AMDGPU_UCODE_OPTIONAL,
>>          AMDGPU_UCODE_REQUIRED,
>> @@ -606,6 +611,8 @@ struct amdgpu_firmware_info {
>>   struct amdgpu_firmware {
>>          struct amdgpu_firmware_info ucode[AMDGPU_UCODE_ID_MAXIMUM];
>>          enum amdgpu_firmware_load_type load_type;
>> +       enum amdgpu_firmware_sign_type sign_type;
>> +       bool preprod;
>>          struct amdgpu_bo *fw_buf;
>>          unsigned int fw_size;
>>          unsigned int max_ucodes;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 6c12d8aa3c769..1df2725d31e0c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -66,6 +66,8 @@
>>   #define FIRMWARE_VCN5_0_1              "amdgpu/vcn_5_0_1.bin"
>>   #define FIRMWARE_VCN5_0_2              "amdgpu/vcn_5_0_2.bin"
>>   #define FIRMWARE_VCN5_3_0              "amdgpu/vcn_5_3_0.bin"
>> +#define FIRMWARE_VCN5_3_0_ALT          "amdgpu/vcn_5_3_0_l.bin"
>> +#define FIRMWARE_VCN5_3_0_PREPROD      "amdgpu/vcn_5_3_0_p.bin"
>>
>>   MODULE_FIRMWARE(FIRMWARE_RAVEN);
>>   MODULE_FIRMWARE(FIRMWARE_PICASSO);
>> @@ -95,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
>>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_2);
>>   MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
>> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_ALT);
>> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_PREPROD);
> 
> Are there really 3 different FW variants?  I thought there were just 2.
> 
> Alex

There are two for production parts and a different one for 
pre-production parts.

After pre-production parts are no longer in use (for example CI migrates 
to production parts) I'd like to drop them later.

> 
>>
>>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>>   static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 5d068a9d9c72c..3d82cfbd14f17 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -134,13 +134,29 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_p.bin");
>>
>>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
>> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> index 09dc01a425d13..a409911939d38 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> @@ -44,7 +44,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_p.bin");
>>
>>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 60b27278a598b..e9778f950738a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -61,7 +61,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
>> index abaa40b6def90..148d62e68225b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
>> @@ -32,11 +32,19 @@
>>   #include "mp/mp_15_0_0_sh_mask.h"
>>
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_l.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_p.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_l.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_p.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_l.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_p.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_l.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_p.bin");
>>
>>   #define regMPASP_PCRU0_MPASP_C2PMSG_64                                         0x4280
>>   #define regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX                                2
>> @@ -108,6 +116,35 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
>>          return ret;
>>   }
>>
>> +/*
>> + * C2PMSG_63 bit 6: 0 = default firmware signing, 1 = alternative
>> + * C2PMSG_63 bit 28: 0 = production part, 1 = preproduction part
>> + */
>> +#define PSP_V15_0_0_FW_SIGN_ALT                BIT(6)
>> +#define PSP_V15_0_0_FW_PREPROD         BIT(28)
>> +
>> +int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, bool *preprod)
>> +{
>> +       u32 val;
>> +
>> +       if (!adev->reg_offset[MP0_HWIP][0])
>> +               return -ENODEV;
>> +
>> +       val = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_63);
>> +       if (val == 0xffffffff) {
>> +               drm_warn(adev_to_drm(adev), "Unable to access regMPASP_SMN_C2PMSG_63\n");
>> +               return -EIO;
>> +       }
>> +
>> +       *alt = !!(val & PSP_V15_0_0_FW_SIGN_ALT);
>> +       *preprod = !!(val & PSP_V15_0_0_FW_PREPROD);
>> +       dev_info(adev->dev, "PSP firmware: %s signing, %s part (C2PMSG_63=0x%08x)\n",
>> +                *alt ? "alternative" : "default",
>> +                *preprod ? "preproduction" : "production", val);
>> +
>> +       return 0;
>> +}
>> +
>>   static int psp_v15_0_0_ring_create(struct psp_context *psp,
>>                                   enum psp_ring_type ring_type)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
>> index ebd612103526f..2915ddcfff312 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
>> @@ -26,5 +26,6 @@
>>   #include "amdgpu_psp.h"
>>
>>   void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
>> +int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, bool *preprod);
>>
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index 4845588c4c247..2586d49f1e940 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
>> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_l.bin");
>> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_p.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
>>
>>   #define SDMA1_REG_OFFSET 0x600
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
>> index c92c5fc59aeb9..cefb8d739faf8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
>> @@ -31,6 +31,8 @@
>>   #include "vpe/vpe_2_0_0_sh_mask.h"
>>
>>   MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
>> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_l.bin");
>> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_p.bin");
>>   MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
>>
>>   #define VPE_THREAD1_UCODE_OFFSET       0x8000
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
>> index 0ea8f9a582ccc..b28d67b4e70aa 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
>> @@ -62,6 +62,8 @@ MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
>> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_ALT);
>> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_PREPROD);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
>> index df3e776c1ad14..219e9c0427441 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
>> @@ -61,6 +61,8 @@ int dm_init_microcode(struct amdgpu_device *adev);
>>   #define FIRMWARE_DCN_36_DMUB           "amdgpu/dcn_3_6_dmcub.bin"
>>   #define FIRMWARE_DCN_401_DMUB          "amdgpu/dcn_4_0_1_dmcub.bin"
>>   #define FIRMWARE_DCN_42_DMUB           "amdgpu/dcn_4_2_dmcub.bin"
>> +#define FIRMWARE_DCN_42_DMUB_ALT       "amdgpu/dcn_4_2_dmcub_l.bin"
>> +#define FIRMWARE_DCN_42_DMUB_PREPROD   "amdgpu/dcn_4_2_dmcub_p.bin"
>>   #define FIRMWARE_DCN_42B_DMUB          "amdgpu/dcn_4_2_1_dmcub.bin"
>>   #define FIRMWARE_DCN_60_DMUB           "amdgpu/dcn_6_0_0_dmcub.bin"
>>   #define FIRMWARE_RAVEN_DMCU            "amdgpu/raven_dmcu.bin"
>> --
>> 2.56.0
>>

