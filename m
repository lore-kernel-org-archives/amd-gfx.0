Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFEFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 15:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80BB10F179;
	Thu, 19 May 2022 15:38:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C4A10F179
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 15:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRKDsbawX5YGjqCK8gSWRLwzgr41JtjYDJpU++IMBlSKkPyYIOd6Fp4shykpPh8owRRTvWdaDObY1/HRf8l8vFTslBcnoVk/Az245Qy2or3xLziZlOUSV9CX4xnmg38Xb8TZuVrWzbxv6pHXjLxeWYlJfYSuXd4KsQdSkknRh+qHSZsuaNVrY1O7bU7SQvb9lfDV3W8XIBpalPa5ZtAWC2Yhj3L7GN3UUr4Xll99JQgJBwu2PN7tgalS8ZLlD7koSh35RwPRsN8bXzTd8qKv9SHDMu11EuItH1zqeXlL85covjrDgFNmMLFRZzHiZfQHaKFyTkndU9v0SMQaPKGZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tslbCjoM1fq3JTmvIlEn3UbAhBQnCefE2xPptmmu7eY=;
 b=nZxXFCYrIJ09bGSbokUHVegq+mtgM7nTZxYOMdAOxRJRLWl5WWP6RtWgZIXFZuvAbKK4EkM+kkr4Yyix+3ESPTVHnJgJBJMQRianAKn2PrOM9nblGFlsIIl/OG84J5yrRoq5babWzg/LmAQUdaEHlSiK14q+GwmZvhNXtcf/zWuuIs6QHPWDeK9g9fOxCivyI43L5DaSawU/ugtzm6/wJmxdwjEtcGSHXz2AGrAh8CMlR3OaVziRJDsL16KOlGDTHEgm66DBmJ4zzaWzNECCJqB3RgBuEOVWw5VFQaRf1rWOkt0MvBip6af8oxwoAaIPVDkBJfKLnv57MOy0Ffs+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tslbCjoM1fq3JTmvIlEn3UbAhBQnCefE2xPptmmu7eY=;
 b=CyDkPdd4gksR5dKzWSsXBqc4jBcR1Q05HGBFNKwX8Rj82cGb1PH+wNRhYioLTC/NPfolzB7Ji/VlUemg3DHERxxmXxCGvwc8oHbXQ55LGhToTOCCmuQaGpPXGcpIAmTid/oE9/GVWKVZ6/vJzwmo2V9NkvBy7NKVTtvwUUARzgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 15:38:11 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%7]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 15:38:11 +0000
Message-ID: <0ef7ca35-f06b-7658-0b0c-93312cc306e4@amd.com>
Date: Thu, 19 May 2022 11:38:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
Content-Language: en-US
To: David Zhang <dingchen.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
From: Harry Wentland <hwentlan@amd.com>
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022701b8-5132-444f-5c15-08da39ad9478
X-MS-TrafficTypeDiagnostic: PH7PR12MB5855:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5855CED4438C0E70EB3C2E3D8CD09@PH7PR12MB5855.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmAspkVCzLNGVo9trjjjaBx7JUO+0Nl6B+273Zd9I8bgcJpgEQ52f7FfwfcI0Nio3YTnVaR0ub/j9YntgGLcZMe7kIBm4HSv+CzRdbGEou7R+idZRBITstc81YNoHvubgBd8+PVwXb33cLgqoB6QXNwh5FURhIfwAmgNDF6qVYEDU3L02ObOqVhs3jCqu+nUzKqo7f62Ssnlv+mhudAwpZNXCqGZ7bsro9Od5d7z9TlHPecfnBULO9Eb70x4ba0JHEBD09c/jn+31r4FND1oTlwVn4bZ1fXWl+uF63cuvAig+lEFAat0Ct/3NCdZjiEYCsiiJJmFDIhxNizzahTWPzQynluOQ4S27PGIZllweBM9PfJBQL3jE3lq/sW/cURga1GzadO5ENHKXRbQ9WKijmf+Bajd4b0tb051d5GBPf6U+aVjcMjr8/wpL7FAKw0WzBUCei1ztXJJfsWf5lQK2Pfdd5zCZQ5Au+nrOy+MRAdJAVVVxeBT2S6C1FVAnhaf2QnUk2X8INUA+GTGoDlXauASdPk5Y4C4c7sQMBuv6c++ODogKx1iZhZCX7T4xGXg8hNtCc0xq6yYKSkaejk/kUd/HDpmQhNpHWONyR0XXkv0GIEBZOyNuRh6HPjOjsMtNN9qEhql60oTgWbc1DrPBD1o4I2qff5jzQE5lLA8n9k0F7nWw9y5UhoebacRUsV20/krfRy9O1Wx+PS/usRJReY8Cvz9nrVcQrIWRbiYge4zMWiXmtjnh0gy4VjIguyT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(508600001)(66476007)(2906002)(38100700002)(66556008)(66946007)(31696002)(6506007)(2616005)(186003)(8676002)(83380400001)(316002)(4326008)(8936002)(53546011)(6512007)(26005)(6666004)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXY2bU94V2YzOUlaRmUvMFdxM3VxZ1ZXYU5XVjl5bnoyUXB2eDZRdVFEOWZ2?=
 =?utf-8?B?Mi9QTmFLdWFuNk1FSWxwd05Jd3U5c3l0SEUzVSt0amtaekkyNXljMGpWSDZI?=
 =?utf-8?B?aFNwSGFmdHFvSllTcElzMlo2V2VaOWZYZUUwTWpXVmtubEV0OUFhY2hXZXhw?=
 =?utf-8?B?R0hwZmdzRGptSVRncHBrNXJOVGRzaCtHZEVhRW9tMXc1SndZNEt5YzJyMGc3?=
 =?utf-8?B?bTdYT3RPQmtSTUxITktvZXFSNGRDSDJxYm5IQURGQittYzJvUzhOZWF2OStH?=
 =?utf-8?B?ZDRFUXgxdzVLYXhselFvZWdaOWNraWEvUzhCSjZSL2lCdCt2aHhyaC9JYzFv?=
 =?utf-8?B?MU5LNnNiRytsOU9YeHBRSWlVOExjRXRlTm9FWXZGMWU0TUtpRWU1ODRCS2Mv?=
 =?utf-8?B?YlJ5QW9WSWRHTHBDdnE1N2NvUkJFdkNpUGwvZHJ3dnh6WDB5MTd2UVJpS21O?=
 =?utf-8?B?K0pYZVIvLzVkN1dlVjZPdGpRQWhHU3lrcFNEeEZHVnJ1MW5MQlFrNlJEMm5M?=
 =?utf-8?B?a01uZFRCTFFGWlpOTUVXNDJZVlB1c3R3WjY0OFVmbllpYVRaNElkbkdocDkv?=
 =?utf-8?B?aGYxSTN6WHJ1TmVYUGZSOThKb1hWWWltdU4yYnB1OWZxUGdFaVFMMmUyM3ZD?=
 =?utf-8?B?ZThwRDJRNjB3dXhIZStnT1p1d0lTcUlvUEZFZHh4c1F3c3Y2enh5TEt1NERJ?=
 =?utf-8?B?ZDJnTjBWUkd5NW1xSnNTaDZyMHFMaWJMVWRac2duSU5hckRTMXpsUnpnenc2?=
 =?utf-8?B?RHE4TWZmTWdOUEhKUXpDMjRLVUNPM0ZmNXBpbFJyRm1rZHdkUXdQMThVaUlJ?=
 =?utf-8?B?WUdXZ3ZMT1AxTWZlVkdKb0tKeUQ4TnE3Vk9hcjVGVU5qWE04eXdtUUZtcFNL?=
 =?utf-8?B?NnJQZytzL09henBacWJMWUs2RUFHS0VzU2ZZNFRDZG55YjVhT1RoQ2N3dWlM?=
 =?utf-8?B?MkZ4Sk1hbkV6VTc4RFRDaUhXUVZncUlRTzdGV05PakR0UFFXdWFlcHJHdlBk?=
 =?utf-8?B?b1JCc2hoT0J0QmtCN3ZqRjVMM3RMZEFLSG5DZjU1V2J6WGw2NDZVbW5zK1B0?=
 =?utf-8?B?NlV6ck16dXBGYzNEYnJFbjU1bzZzaWFpVzNoK3VDcFpIY01wL2tTbXUvVGRS?=
 =?utf-8?B?OWhVLzBMeTJ5VVU5MGp4MFBWTDBxVjlnWVRvRElpZTlEK0NqOStjejJ0Z1F3?=
 =?utf-8?B?bE5nVkNHcmhRK2puSXV3aC8vYTJ6OTJUZ3VOcXdyR2h1dk1wc3V3WVNUYXFs?=
 =?utf-8?B?eUd0dWZKTWhyT0VqcGtPUG04ZXBiVjFUbGcweTR2dHZPaTRtVTJSUExyeFVC?=
 =?utf-8?B?YzBZN0NZOWt2UEp0NXRnRzhQN2cwZVNPSk4rcE1aYVVjOE55UEl3YTUyeURF?=
 =?utf-8?B?Nk04TXo2MndvOXVoTFRyN3YyK3NBN1lKOTF5MGZZSkx3QUpJSHlKZjZXb2Fu?=
 =?utf-8?B?dFZkT3BGTVhJcEVkUmV4TVpUVjJJd1plbk8yN2JIVXNwQXVxdk8vWGpaUy83?=
 =?utf-8?B?UnczVElHRWgxUWxwSC94b3VPTlN0WXhJZzRmYVRWNFlxNWY2VzBxZUF2SlFm?=
 =?utf-8?B?MmVUY2pQTldoUlZERFBhWTRXeXJEZ09GS1A5MTB5T0xZRHgzWjJ5TzUva1RN?=
 =?utf-8?B?dmRleFJSM2NEK3hrTjhib0d3NHZLdzBMdnBZOW44SXZaTkgyemxGbk1YNEFR?=
 =?utf-8?B?M1BZNFlRMTYwQW5CSTFHcHBqT0lIL2FUR2E4TlNhQVFaOTAybkVQQk1UV3No?=
 =?utf-8?B?ZzNHVHFKYkJZVHhhM1dRZ1g1VGcrL01XRTVmcmxMazJYV3JsM05DdmZaODFH?=
 =?utf-8?B?Tm41ajZSMEdWMWh0SHczQ1pyZUpiNzFIeG9nRUhlZWdrQVJHSU54aUtjVHhI?=
 =?utf-8?B?MGRwekFNRnI1Y01Sb1NWcnhYdnNLNTU4enZnQ2szNEZSWC8yUzhDOTgraDUy?=
 =?utf-8?B?MytFNEl0OS92K1ZuL1dzYmxyOVA4WThvQ1AzZjQ2ZUIxUWtOUzZ4VEFIL2lH?=
 =?utf-8?B?K29jc1YxRGVSTmlEK3FxYW5BWk9DK09xbFlha0NLSzNOdmtuQ3FPN1U0eTdZ?=
 =?utf-8?B?NEFFcFBLWEIvUmJuZUcvdjBMdHhoVmROTmZmV1k4SzF5Skcva25id3N3elRM?=
 =?utf-8?B?QS9JK3RrRUoveExBczJyNk5pZ1ZwUmovclJLaFdXdDlEZFBPNkNXWCtuSWc1?=
 =?utf-8?B?VGdpQklzTEhlZ0RwT2xvYU9JZUlQY3VIdWJmN0Z0Kzl1VHFHMkNOODFXeVk3?=
 =?utf-8?B?dnVQK3RmUlJPbFJjYWg5bE8ySHJEZDI2UXJHbTVTWm9qbXFOWGhqSWlUUkVD?=
 =?utf-8?B?OHNXbnlWZERLM1F3YjBRLzdvMmsyMERSWFVzVmxoemxSalFVcFdBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022701b8-5132-444f-5c15-08da39ad9478
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:38:11.2355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LDY1T4EypSmpgQce+Pof9KsyweLzYJzGUXZBoMNAagQoQ1JgTNog+BCv7iv/cQvovMMdXkJtLTSpMgh5lcWjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patches 1-18 are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Patch 19 needs a bit more of a patch description.

Harry

On 5/10/22 16:44, David Zhang wrote:
> changes in v2:
> -----------------------
> - set vsc_packet_rev2 for PSR1 which is safer
> - add exposure of AMD specific DPCD regs for PSR-SU-RC (rate-control)
> - add DC/DM change related to amdgpu PSR-SU-RC
> 
> 
> David Zhang (18):
>   drm/amd/display: align dmub cmd header to latest dmub FW to support
>     PSR-SU
>   drm/amd/display: feed PSR-SU as psr version to dmub FW
>   drm/amd/display: combine dirty rectangles in DMUB FW
>   drm/amd/display: update GSP1 generic info packet for PSRSU
>   drm/amd/display: revise Start/End SDP data
>   drm/amd/display: program PSR2 DPCD Configuration
>   drm/amd/display: Passing Y-granularity to dmub fw
>   drm/amd/display: Set default value of line_capture_indication
>   drm/amd/display: add vline time in micro sec to PSR context
>   drm/amd/display: fix system hang when PSR exits
>   drm/amd/display: Set PSR level to enable ALPM by default
>   drm/amd/display: use HW lock mgr for PSR-SU
>   drm/amd/display: PSRSU+DSC WA for specific TCON
>   drm/amd/display: add shared helpers to update psr config fields to
>     power module
>   drm/amd/display: calculate psr config settings in runtime in DM
>   drm/amd/display: update cursor position to DMUB FW
>   drm/amd/display: expose AMD source specific DPCD for FreeSync PSR
>     support
>   drm/amd/display: PSR-SU rate control support in DC
> 
> Leo Li (1):
>   drm/amd/display: Implement MPO PSR SU
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  21 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  54 ++++
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++-
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   5 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  23 +-
>  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  64 +++++
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   2 +
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 +++++++++
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
>  .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 ++
>  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  21 +-
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 +++++++++++++++++-
>  .../amd/display/include/ddc_service_types.h   |   1 +
>  .../display/modules/info_packet/info_packet.c |  29 +-
>  .../amd/display/modules/power/power_helpers.c |  84 ++++++
>  .../amd/display/modules/power/power_helpers.h |   6 +
>  21 files changed, 887 insertions(+), 19 deletions(-)
> 
