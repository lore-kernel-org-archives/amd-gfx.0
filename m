Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A927AC5516F
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Aug 2026 01:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184D510E255;
	Sat,  1 Aug 2026 01:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KukwHiPb";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5222D10E255
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Aug 2026 01:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIHkJ42cmg7UyZqfPRqQu7lKbG2oF6ERmdbs9hwTGB+sUGpcYTh4kXwfRTa6xmuob4RdNmQ9y8yIyDGOx15ij4zbsywCFJ1ntaHQAttQVjzhH7SyE/pnM/oW1r4CgIc/vDHQtk5FIPdvxPu31W+RFNEXPE0V6YG2HGGRT3KQDRg6oMRT7S5gDxSir0UHJ6fY6dcmpzre+Mt4P2rzNS6xqc95g/fTaBk3gPjYgR+4C4WL5b5+SK6yMwOmOHe3a7W5fsWpcb+HuV8qS8PyXg+0PA7cwgHTccwme8v3CPvt6BlLDmzvowDfcz1ckSZcNL3DcdV2EJ/QKp/q/QksL2phRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op6ITws8szveLUNBYJthZsEnaiB6E8JamnDeJ4S+KDo=;
 b=d1bmBA7V+NsI1OR6dKTF1CH1xjkfYEQbXGT1qD1ACHYvKSnt4NtU51uzFl1Si3R+xZ3rn9g76C4sEZlO6gzJGQM2v4WdiemtN/J2UjKuMG2lpSCfyk98d/XLlBtzf6iCOx/sxzVTvM91O0AcxhWQ+qSS61yYNsO1d4omichl48h8V+tboCattFiHADcbcyJ1h7cWqUFxLY/tWFMQMSTE26zwIz51GoKLnJFmOGoOqK0yIq3zk+ixT74ODVCHKRo1XmWv6ZJnoxbp4uIKbeyR3682FMwoUrrZMgUliDd/K8BiQmKmv6RXQi7hJkDX3vpqd0vnDKklFeaHyiKspQ7b0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op6ITws8szveLUNBYJthZsEnaiB6E8JamnDeJ4S+KDo=;
 b=KukwHiPbBa2cpLsr493Y4TV14pnfvIFLj603zrnp33D3AbBJqgelPY5j1W2kcV9MPaXt2kz3lisUPVNPSs9t4JFW8EjMvsemzzthM5xGQwREdQFZnwNhT2ZgpKT2zQDuK1IBG+6Mpaq+OEgInkjqzHaXhxTiISP1K5O9Pt9Mg1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 01:41:16 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 01:41:15 +0000
Message-ID: <68c132d8-bcae-4e61-ace3-2b9242aeb8c7@amd.com>
Date: Fri, 31 Jul 2026 19:41:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/amd/display: use a separate helper to
 translate degamma curves
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 Xaver Hugl <xaver.hugl@kde.org>, robert.mader@posteo.de,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260623160112.1636801-1-mwen@igalia.com>
 <20260623160112.1636801-4-mwen@igalia.com>
 <6a705b70-dc0d-42de-a18d-cbc1a4698f71@amd.com>
 <690771f2-d540-4e8f-a450-6a1f00b8df9a@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <690771f2-d540-4e8f-a450-6a1f00b8df9a@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0371.namprd04.prod.outlook.com
 (2603:10b6:303:81::16) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 40399ca4-9469-4cb7-ed16-08deef6df9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|4143699003|11063799006|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: M4psCZhtGHVCy0oS9VsQ6VthMeWfXLmphXO1XXmPhpdwT8niPbOo8wERbYWEETj1PsGpX5CU38s/913YJAxvWYimdDBHmNJFNXB+qCzTwwM1deD2NSN++oStA2tbYJTb72oq8UPxFajWfi4lyHIcRzzQ7t60lM1hNyBVduBWqmGpNet2DEJ0QL79rfWR6lMMEuqQESlHnT1FO+4fR2gpznZ14ck6URLpCV/wIrcCGa/vWWMzsRuc/OCtIV358VCJomE7qSdKKe928UB8nAfbFy03lTNnfHXdRKli02xFnVFKOA1M69daUSYTPpPtvUdpqIw4EdRC6VZYmDIEee7Z94ZlHWGjjMFnhMbXPRTki/k48u0ijuGPdFJt9+R62if2hx4JyegjT4fKvNRNK9AhXmjBTvcAhiiyIGPwFLll+KoL+9BXpSBlwTp//TpWC5ooJOcnFNrnzeFWE7ZvddSh81jweX5Hb7rsqDq+HjE5374ccLWL7ZUqbuRMSGH4J42u6n/VyUd38uybL54kAIzP59X68XbH57QqdkXTSrz1aX+OBi91qZfUMC1KLYQ+obc0Si0ujAL9KKxHqoq4lLePoZ/+yyUXCYphhqiQXJP4ix2ak5pvzHor6dU8ay9bZ+MJ/iFVLJUMTjOi61uC9FpPqwwgrR8AFoRP9a2Fdp+WCMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdPK1ErUk1DYnhBZnVDcjZFUERic3dDMWNud2dRMUd6THBRemxEeTFYaEk4?=
 =?utf-8?B?eHR6ekxpWDMyaFZVVUp4a2xzd2NOcnM4ajkyNTBFbmhoZ1l0TzlqK2s3UHFW?=
 =?utf-8?B?WXczeUI3aTlnQVhpdEpJUXJEejB4eUlBSis0QzREMFVGSVg4TFpsdEFGNzU0?=
 =?utf-8?B?dlZidk50ZHVuajZyRVlLaXVQZGdnVVNNdk9yd290ak1Bb3RXQmI0L3dWZGdW?=
 =?utf-8?B?OGlJbVJ5UlBNZHVhYzNiMHhsOFhXN2pjNG1oOGRyM0J1V0lsazc4MlNtakhL?=
 =?utf-8?B?WW5VNDNSREp0WEV3U3k4NnNQc2FoNGRmeTg1RWNUeWI5WXlEbHVuNmUzMXVU?=
 =?utf-8?B?Z25DcXZhQ1lhWTNkSnl0UjhWMmlYbnhHMU83czBhakZYbVE4MHBJUkNSOHFR?=
 =?utf-8?B?enp4aE41dGZnTHZodUhKNDlxQURBMHgybTEya3NOdWxKbzRKQXhPdmZYRjBM?=
 =?utf-8?B?LzdOTWRtRmpwUkt5bkxFZUdhN24vRHlFK3RXNzBDVHNjWklCRzFnVWpCTFRm?=
 =?utf-8?B?OE5jVUU4TldYZTFuZkJWYzZaRWZUK2NTM2VyZEFIU1lUQkFQRlVmWGd3dGJC?=
 =?utf-8?B?bG15Rk90a2xSd291bE5Ib0VaSXN5SnYxWHBIbU5IUys0VzZKQnZSZ3dZRWlO?=
 =?utf-8?B?KzJOU2Z4Ky9nWmVMY280MXdaTzN4VEUrbnQ2N0ZLRis2K2lCSnZPdkdLMzMw?=
 =?utf-8?B?QlZFV2ljQnBvMlo4NU9sUzVreVp2SGVDcWNZWEpweHZjUmxrbXp1ZHltUjJU?=
 =?utf-8?B?K3ZTaHEvUXpoaGlnTjJMUFdMZVF2N2JabVZSNUd6WEdOTDZQTlJsRFN5ZWFU?=
 =?utf-8?B?QVBDaWFaNXQ3akdVMXBBOEpBTDg3c29pRklzR3dlT2MrV05obUV4aXdvaFdt?=
 =?utf-8?B?VCtxRmVObnMxN01LbXB0S3c0OGhnYjVYbW9SVFk0YytkYUJkcmNuTnRUbTVu?=
 =?utf-8?B?SzdGS3VIMFltcUU4am5VaURVR3RpcHd6blJ0ZWJsQjZ1UUcxTnZxbzVtUGtn?=
 =?utf-8?B?MGJybXdxTGk5UmdDcnhVa2Z1WDIrbGxxdHRpQkwxVDl4cDJoVmNqbkt5ZlQr?=
 =?utf-8?B?cVdMWjZYWFZGODRoVHovM3pMSW8waXZmKzZDUE40SHlnZjc1NUE0NHpQTTRK?=
 =?utf-8?B?N0tYNlVXTFh4bytnaElhSXQ2bU43WVNCbTlwNVpSVS83cUp2enNZOFloSTFz?=
 =?utf-8?B?SldFaXJXdjBlYU1idEpEaGtLKzlqVVdsY0ZYLzhWRmM4T1dhMGZtcFpYaEtt?=
 =?utf-8?B?MGhVeHR5bExKMmVtY2pPcW1zMUd0S3htVWNrd0xYUW5yTlFETXZZendFQXhy?=
 =?utf-8?B?QnVtM0o5eTVnV3FwL1FwOGNtVmtWQXE2Qmd5UVdhNmxWb1M0bGhiUHFGRUZZ?=
 =?utf-8?B?UGJKSnp6Z2VpL0dSTE5XeGxHTXdCRE1tdklzb01BTGxxR3hUQ2RPMW9jRklm?=
 =?utf-8?B?Y1lRNzdDclcyYy8xbXZRVXcwb2ZrODZsdGc5UUJJM2VFQWZNSytQQlgySXVG?=
 =?utf-8?B?MjVJTzFBWTBHWnRZY2FoWkc0OGw3R1BCVldxYWRrb2xOZktFOEIzalNGbk40?=
 =?utf-8?B?Ti82V2lRQXl4TWh0TTY0SUxMbFZtaVJiK1NXUkNoRXBTOG80Ky9lb0x6aVJU?=
 =?utf-8?B?cFh2N0F2U1pzWkEzVUVUaFRYT1BTdnhtMWtMNkZ2KzBhQkJ1a1NrTXV6QUNY?=
 =?utf-8?B?R3NSM3BYQ3pBSXNMNE94dlhQU0xtS2VnRTRsQWh0bll1N3NsSFdJelVXQUR3?=
 =?utf-8?B?NzlYWHhsVENFM0d2VS96SEMrbHl5Z1FBSE5wSkJiWTFPNG9EWlVxaDhzbUp2?=
 =?utf-8?B?cHRGNmlDRllTL1FadU81R0h3bGtWT0pTb1c1aW9wbnJMR09TNHVNR3NQbG9n?=
 =?utf-8?B?MEFjYkg1dzhWL25xWDZzUGpMSEM4aEU3Nys1MFZVdFQ5QzNOWEcvWU5TcEJj?=
 =?utf-8?B?YytjcWNmMFZVcXR5dkVvY21jMUU4RkpaQmlWemRKQ280eitTZ3BSWEl1VFFH?=
 =?utf-8?B?eWNKdUl4alpSSzhXckRlb3ZWU2xiZHdrVXN3aENZSEoxMTNsTlJLaVRlSHU4?=
 =?utf-8?B?VkJOMjhSSWlMZ092TTltQmowU1ZRRUpVeGZuZWU5RmxlSnJzVlVRZXFmdTBO?=
 =?utf-8?B?cGxqSkhnWTlqcnRaOWhIcDNEanIyeEpYY3pGbDd6cWNYRWVkNUwzM2UwZlFK?=
 =?utf-8?B?VFVBbThOdFpHcmNRbEtLRXd3VXF1YU9KNVhLb1RvYUxnNHNjMmVIanBSZ3Ft?=
 =?utf-8?B?VnQzamYwRDZRK0gzSGd4cytGVi9sSzBrcUd5ZWhTS3ZLWE1Wcm0wNllVV1dC?=
 =?utf-8?Q?Yys2gsfqHFyumNCLVG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40399ca4-9469-4cb7-ed16-08deef6df9ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 01:41:15.4382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csX2D7PMPYOF76BznfKiswANs/oaX161GnurNtzrvEquiSDv9lgpa0iBh82ov0fm7olokTurcc/jAZsO9S4ZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
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



On 7/23/26 07:29, Melissa Wen wrote:
> 
> 
> On 22/07/2026 20:27, Alex Hung wrote:
>>
>>
>> On 6/23/26 09:58, Melissa Wen wrote:
>>> In newer DCN families, there is no hw predefined curves for shaper,
>>> blend and regamma. When userspace sets pre-defined curves for these
>>> blocks, the driver uses AMD color module to program predefined curve as
>>> LUT. However, it was using the same LUT segmentation for EOTF and
>>> inverse EOTF by using the same color management helper. This is causing
>>> banding on blend when PQ predefined curve is set. Besides that, degamma
>>> predefined HW curve cannot be used with subsampled 4:2:0/4:2:2 formats
>>> as it affects the linearity of color space in which HW scaler operates.
>>>
>>> To mitigate banding when using the blend block and better support
>>> subsampled format on degamma, use different translation helpers when
>>> linearizing and delinearizing.
>>>
>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>>> ---
>>>   .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 11 ++++-------
>>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c 
>>> b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>>> index 1340f673ec3b..c2ea25927765 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>>> @@ -493,11 +493,9 @@ bool dcn32_set_mcm_luts(
>>>       if (plane_state->cm.blend_func.type == TF_TYPE_HWPWL)
>>>           lut_params = &plane_state->cm.blend_func.pwl;
>>>       else if (plane_state->cm.blend_func.type == 
>>> TF_TYPE_DISTRIBUTED_POINTS) {
>>> -        result = cm3_helper_translate_curve_to_hw_format(
>>> -            plane_state->ctx,
>>> +        result = cm3_helper_translate_curve_to_degamma_hw_format(
>>>               &plane_state->cm.blend_func,
>>> -            &dpp_base->regamma_params,
>>> -            false);
>>> +            &dpp_base->regamma_params);
>>>           if (!result)
>>>               return result;
>>
>> The above change broke two IGT's kms_colorop subtests (tested on 
>> DCN3.5) as below
> 
> Hi Alex,
> 
> Thanks for pointing it out.
> I tested with DCN301 (all tests pass) and DCN321 (same failures).
> I'm a bit curious about this difference, probably some differences in 
> precision, etc. I'll leave that out.
>>
>> =====================================
>> Starting subtest: plane-XR30-XR30-srgb_inv_eotf_lut-srgb_eotf_lut
>> i 2569 j 0 shift 10 mask 3ff comp1 3bf comp2 3ff, pixel1 3bfeffbf 
>> pixel2 3fffffff
>> [79.216137] (kms_colorop:10824) CRITICAL: Test assertion failure 
>> function colorop_plane_test, file ../tests/kms_colorop.c:281:
>> [79.216143] (kms_colorop:10824) CRITICAL: Failed assertion: 
>> compare_with_bracket(&sw_transform_fb, output_fb)
>> [79.216165] (kms_colorop:10824) CRITICAL: Last errno: 38, Function not 
>> implemented
>> Stack trace: not implemented
>> Subtest plane-XR30-XR30-srgb_inv_eotf_lut-srgb_eotf_lut failed.
>>
>> Starting subtest: plane-XR30-XR30-gamma_2_2-gamma_2_2_inv-gamma_2_2
>> i 15390 j 0 shift 10 mask 3ff comp1 398 comp2 3b8, pixel1 398e6398 
>> pixel2 3b8ee3b8
>> [81.747233] (kms_colorop:10824) CRITICAL: Test assertion failure 
>> function colorop_plane_test, file ../tests/kms_colorop.c:281:
>> [81.747239] (kms_colorop:10824) CRITICAL: Failed assertion: 
>> compare_with_bracket(&sw_transform_fb, output_fb)
>> [81.747256] (kms_colorop:10824) CRITICAL: Last errno: 38, Function not 
>> implemented
>> Stack trace: not implemented
>> Subtest plane-XR30-XR30-gamma_2_2-gamma_2_2_inv-gamma_2_2 failed.
>> =====================================
>>
>> The root cause is from color delta increases, as also confirmed by the 
>> following IGT POC change:
>>
>> --- tests/kms_colorop.c
>> +++ tests/kms_colorop.c
>> @@ -182,7 +182,7 @@ static bool compare_with_bracket(igt_fb_t *in, 
>> igt_fb_t *out)
>>                 return igt_cmp_fb_pixels(in, out, 1, 1);
>>
>>         if (is_amdgpu_device(in->fd))
>> -               return igt_cmp_fb_pixels(in, out, 13, 13);
>> +               return igt_cmp_fb_pixels(in, out, 70, 13);
>>
>>
>> Is there any concerns on reverting above changes (or this patch)?
>>
>> Note: I am looking for early feedback because I have not yet tested on 
>> other DCN hardware.
> 
> Reverting this patch is not ideal because it addresses an issue on HDR 
> Ori game on gamescope with external HDR monitor for DCN301, DCN321 and 
> also DCN35 (IIRC Matt has verified the issue and this series in this hw 
> version).
> 
> I think the possible solution is making 
> cm3_helper_translate_curve_to_degamma_hw_format() take the same segment 
> distribution for PQ/SRGB to any pre-defined TF or LUT.
> Something like removing the if/else clause in dcn30_cm_common and 
> applying PQ/SRGB distribution to all cases, as below:
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/ 
> drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> index 66fe7f313ea3..1b4ce77fdd91 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> @@ -332,6 +332,7 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
>          int32_t region_start, region_end;
>          int32_t i;
>          uint32_t j, k, seg_distr[MAX_REGIONS_NUMBER], increment, 
> start_index, hw_points;
> +       const uint8_t SEG_COUNT = 9;  // 9 segments, segments are from 
> 2^-9 to 0
> 
>          if (output_tf == NULL || lut_params == NULL || output_tf->type 
> == TF_TYPE_BYPASS)
>                  return false;
> @@ -343,31 +344,12 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
>          memset(lut_params, 0, sizeof(struct pwl_params));
>          memset(seg_distr, 0, sizeof(seg_distr));
> 
> -       if (output_tf->tf == TRANSFER_FUNCTION_PQ ||
> -           output_tf->tf == TRANSFER_FUNCTION_SRGB) {
> -               /* 9 segments
> -                * segments are from 2^-9 to 0
> -                */
> -               const uint8_t SEG_COUNT = 9;
> -               seg_distr[0] = 0; // Since we only have one point in 
> darkest region
> -               for (k = 1; k < SEG_COUNT; k++)
> -                       seg_distr[k] = k - 1; // 2^(k-1) points per 
> region; halves as k decreases
> +       seg_distr[0] = 0; // Since we only have one point in darkest region
> +       for (k = 1; k < SEG_COUNT; k++)
> +               seg_distr[k] = k - 1; // 2^(k-1) points per region; 
> halves as k decreases
> 
> -               region_start = -SEG_COUNT;
> -               region_end = 0;
> -       } else {
> -               /* 12 segments
> -                * segments are from 2^-12 to 2^0
> -                * There are less than 256 points, for optimization
> -                */
> -               const uint8_t SEG_COUNT = 12;
> -
> -               for (i = 0; i < SEG_COUNT; i++)
> -                       seg_distr[i] = 4;
> -
> -               region_start = -SEG_COUNT;
> -               region_end = 0;
> -       }
> +       region_start = -SEG_COUNT;
> +       region_end = 0;
> 
>          for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
>                  seg_distr[i] = -1;
> 
> I'll check if there is any side effect on gamescope with this change 
> ASAP, but I don't think so.
> 
> WDYT?

I tested above on
  - DCN35 - issue fiexed
  - DCN401 - no issue and no regression.

Does it pass DCN321 that you mentioned abouve?

DCN301 doesn't use cm3_helper_translate_curve_to_degamma_hw_format() so 
it wasn't affected.

The changes look good to me, but let's ask @Wentland, Harry for review too.

> 
> Melissa
> 
>>
>>
>>> @@ -554,9 +552,8 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
>>>       if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
>>>           params = &plane_state->in_transfer_func.pwl;
>>>       else if (plane_state->in_transfer_func.type == 
>>> TF_TYPE_DISTRIBUTED_POINTS &&
>>> - cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>>> - &plane_state->in_transfer_func,
>>> -                            &dpp_base->degamma_params, false))
>>> + cm3_helper_translate_curve_to_degamma_hw_format(&plane_state- 
>>> >in_transfer_func,
>>> + &dpp_base->degamma_params))
>>>           params = &dpp_base->degamma_params;
>>>         dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
>>
> 

