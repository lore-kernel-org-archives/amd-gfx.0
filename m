Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4D9C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 16:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B70510E5E8;
	Tue, 23 Jan 2024 16:19:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC06110E5E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 16:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXYDRdBRwi1u008xvN8MxDkiLxleoGxlz1z6B1c9+BAQ8fYOPhq98I/fEMtjUosfLc6zMP13EtzTPaHqFn3hdt51yxq8eJZWbqXzSgUuy/qFOhCVo1RC/AD103mq5df1ceIuf2kSZw5MCSDZKmd14Xb/6dSorSOSprQZAkiAzYrl9w3lHQRjwnY5aHPWLSrsnph9CglTeFgdw3FgvOQMHxLCJ1vsdt/hFdHfxMTcN0hiu37CYLmCoH3i/I2Ad7xKVLF41/HRynEbsHJ8cPYGBk5Pt2YgqaozpqqXEY2i8QQM8kmzAXULcML+gIVdjoxAo4HUwMzsfb4LGQmGfj0BEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9vCkxoGEy9X/DZlWha18pJWS1Dvocwkv6ngflvbQWQ=;
 b=ct+KlvpJICQEKZ3caTUoQmtvmW1Pt4I+TNroQQe/paWXNpQE0QwIeyqgtwwhosvWK9PWhHWTNzCUtXi48jij9L9ano/IAEukhcMKEPd6F1coZV5vgScsPJJw/6ITMP1fjqlUZxdDwckGS53EXdpyI5AbpaWC3/bWko98qxkY7OPXKbaN/EbLxjNgBqWHHWMOxrvJ28Yx6ru9Cd+Xg7W1o+XQj97w09G/rTL7OElkm2KUONsm0YcBe0ciZlDq98eYpN5xGcCip9Zw7W9z/NerOF+hSI03nzCQ3mJlmzB3iGzHHeWUulkaI34cpMC7ErERTsx85P8yturm0v6x6Ks5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9vCkxoGEy9X/DZlWha18pJWS1Dvocwkv6ngflvbQWQ=;
 b=ojtkY+y0YCcH+V6mLrv7kgoSd0cotZv2zy4zzWWLHUtM/2vlPxJXCzyt9Scb0rkSdWshTvMayGj/yC1VqVyW9urVtNt0osoemt6ZEDMYSCKVmdnQHKjCMls8dsvQCP+jBy69JOCEtWDsePAxscC1TwrLyZariqIPmjP3OXuSuUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 16:19:33 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368%6]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 16:19:33 +0000
Message-ID: <45f7662f-8fb3-4605-abd0-0600a160fc62@amd.com>
Date: Tue, 23 Jan 2024 11:19:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Expand and improve AMDGPU documentation
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::44) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: d342a117-bb2d-4dbc-c699-08dc1c2f15a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyizCb8Hc8Vjfm7+x5Opht+i/aCoUX89DYdJvlEmy7kWZfmw/DacCwlFGY9tCTl5EgC3nLitWDvKy9j658ez8NxGRySYUogwOvSW5AdopmgfZFuiXHwxqxToi1v8kw+thgKVAYYZ6TiQfRc8rAza0THSU1l30AiwMxyc1sJ4uekw9PMzsEKhpOfq3QJ/IXRlOuqoG6Je6hM+/DYx6tPpJmE30s9acNgykm/8eYxZMjLV0bsM7d/cB0gEEzUc64SgAE+rWWVDbOu/35QEJQcBHo9hyTB4OTImLtC1V+C6tdx39B2SQgRN5K4TITptrqpgzFVbQ2DRB/6Nj0D+GAwaM5/UGKHOTq8uZfuI2fbEE3fvYoJyOM+j9GerTpfwevRpOqra5AwKaWK14egh4mIuXlpzF3MWcv1/8jouMSuzXB0I0ZL2Ta/ege3aeuIJ+aNJjeXFaZ6XlCTp/JjEVKv32dt0cyPsQx7LZm9wxpxCrj0igfLQH2cFDvDckhDT192mHI2clDSBUQv4prcy7WPVOCmwraFdGFVUDSwRd7kiMJeW+SOLu7+yRb8/26icECF6Ri2miOt72IAJ6ZkjmvBIwCnwkTctqgDU07pMLp+SSlDC5H6y8wkKmwHM2krOnnZWTVhDOsgQYo0loEgDd0FDkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(5660300002)(86362001)(31696002)(36756003)(41300700001)(110136005)(83380400001)(31686004)(66946007)(66556008)(316002)(53546011)(6506007)(66476007)(26005)(2616005)(478600001)(6512007)(38100700002)(8936002)(6486002)(8676002)(4326008)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFdqWGsvaG5CUWp1MytyV1ROTnRtMnlpZ0JNZ3ZzUUhWNUMvaDMxYlpyaDRj?=
 =?utf-8?B?US9sKzIyZ0JoMWxOaUs2T05MT3lhR2dUYXVmWVlkbG9zbG9oOUdUZkUzVElx?=
 =?utf-8?B?MENoamFJaTg4M1Z3ODNPWkxYS2FEZUJjTnpvMUlvdUNzYW1xWUw0RHFDRkJI?=
 =?utf-8?B?Z28venlobWZZNkpsSHI1c3FuaWw2WFkyOHRudkEwam5BdFY4NU5YcXFQaC9K?=
 =?utf-8?B?aEhaTHdjSXVzWFlNaUlRSEVHMDVpYVZMcHNpODlyTE5NU0toaU4vbHNlOXE4?=
 =?utf-8?B?bllpa3VGOE9hK0hEbUFjZ0g2V2NPdzc3WUVjQ3ZtTEYxbTJEcElyb0w0a2g1?=
 =?utf-8?B?SGJzK1B5RG1GWG1ITzd4YmkvSG9SV2JkRld2N1E3YXVKRTQ5UUQ1bkJhSnhS?=
 =?utf-8?B?eko4ajJzWlFyd0paVnJKaFo1ZDhNREgxUlAvSGVjOFhBbTAvTURJU0VETTFm?=
 =?utf-8?B?Sm1lQkNXOGhJMlYzUkRqU3ZtZm9VNUhUUkg1MWRhcmdmWkkyR1hwczdVUW5m?=
 =?utf-8?B?b3hJSllLMnlpTlR5OGlIbitRZDJScUpXMmNYWkpGYmUyVmF2cXphVG9INEVr?=
 =?utf-8?B?UXQ1aW84RERhZk5WMy9aREwzam01MUtkTVlhY2kzVUJVdTZDbERxRUJRS1g4?=
 =?utf-8?B?TFozKzJEZTMvOWNjNkwyaEJQUTBSc2JYMXpUbTlFOWQ0UTFtbkdmT3crL1JN?=
 =?utf-8?B?dEQ2TUdVOGtHaVIrcW03Tk45bit3V0FrRkRUWU4ybkpLRTlMSCthYzlOL05V?=
 =?utf-8?B?WmRkaHdnamJPQ0xXU3NkanY3NWg1RU9DdHpvejNCd21RdzJyS3Q0R3JSVXhu?=
 =?utf-8?B?YnYvcFlaRUdOTWpDNXZEczNUYjAwMFU2U21PL05DeVlsT3ZkWjF1QU1rNjVt?=
 =?utf-8?B?cytJKy9WK2hmQ3FYK1FYRUtaUGo2OGxhSEltVzNJc0FTc05MaGg0Y2g5OVB0?=
 =?utf-8?B?d05abVcwTHJvTkxOejBUQlJkMnlPNTkzRXFwcjZ3K25jTElEZ1J6bDVCSVh5?=
 =?utf-8?B?L3VsT2JDV2xEQXFEZVcvVlZwZ1RIdGdqdU1lYTExczJtTktqQXRRTGR6Z2JZ?=
 =?utf-8?B?ZldCcWdZcStRU1NVd0ZndnBMMlB2WDJIc3B1UnVhbk41eFpLMzBYZHVZa2VM?=
 =?utf-8?B?aHlJT2IxaVhXTjRROHIvcFoyQjVFY3JTcmQwSmZLYWtHQUtDekxpbXJFN1Nm?=
 =?utf-8?B?bXRvdGZFS0lpblRGd2lvWWx1ckl0TlBhOW1LTW9XZURZVmpLUXFiczhOL01n?=
 =?utf-8?B?dE5udGgrOHFlMXpod1VDRFMvVlNlNW5nTkZQaVFWdGlKY0Z1K3dtQ1VPS3Z6?=
 =?utf-8?B?eHBsdHAxOE44MWNOTG1FdjN6d1pMaG9hWXZCSCs4aXdxSWczVy9Oc3grMmRO?=
 =?utf-8?B?aDUxZUNsVnA0NUtlS2ZOTkJSb05JQ3Y1S2hEdTRhYUFndW1mWnBzaDBSMURj?=
 =?utf-8?B?U3JYcUFLWWNYUHMzY3BaazFzWDZ1MXVLS3E5SjU1cTJ2QjRQUXI1TTRmVlN0?=
 =?utf-8?B?d1lLOWRkeE1jUDdaaksyb2pTRVZ2NFRJOCtWcy9DZG1JOVJXUGs2Ukl3L09H?=
 =?utf-8?B?c3VlMHg0MjBHd3VDRk5jYkpJdG5lU1o4aHFvdWI3TGNWWW00eGk4V3NxeEVF?=
 =?utf-8?B?MnJZVmZsd1BlY3ZSVnVWY3phSlFOdytHMHc2MEVHQWV2SmNUOGJybnpUbVJ6?=
 =?utf-8?B?Uy9hejdyWGUrcENqUDNQT0g1TVU5cDdzL29CYkZBbzU0UmNLR0JxaVlzL1Jn?=
 =?utf-8?B?aGRTYlQrR21Kc29ZM3RYNUkzRE1BUVUyS2t3QXpYeFJJaUtkUG1PeHcyOWhs?=
 =?utf-8?B?Q2cwa1JKQXJNUUlWZzlLM0JFNjJ4a1JxRHZXZ2N4bGdLb0tFeTgzMEN4MExZ?=
 =?utf-8?B?VzJLb0N2NW1HZjFEbEJTcWRJd1o5c0JUc0M5Q0EzNGk0R0hDeEpBS2RCODdG?=
 =?utf-8?B?ZTdJUlZLMlduS1o1MU90TzYvV3JNTWdxR01pMGlFa3dZWmo4YWlrdlZCOE5v?=
 =?utf-8?B?d2Vqd1RtUDBSc1VTMW41bUVPMnp2WUpYaVAvaVVtQ1pRaHluRklrL3FkZUZp?=
 =?utf-8?B?Q2VLNWpHOW5yYlpEdkR6ckZQbTB3K2ttMGFZQ2QwVkM2VVdBV2tVUnZ3RFQ0?=
 =?utf-8?Q?t0LRvRtQVfWG5xNVbBeeD4Z+C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d342a117-bb2d-4dbc-c699-08dc1c2f15a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:19:33.2792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVB0krDmNDMqmFLM7K8cdiI65Ss7rgkbm6oJbmgUSzHkFBNQgk6OHiSyO5mgI8Od2BP27Wo6CdXu/Y2lV36YMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/22/24 16:24, Rodrigo Siqueira wrote:
> This patchset improves how the AMDGPU display documentation is
> organized, expands the kernel-doc to extract information from the
> source, and adds more context about DC workflow. Finally, at the end of
> this series, we also introduce a contribution section for those
> interested in contributing to the display code.
> 
> Changes since V1:
> - Remove unprecise information about the DC process.
> - Expand the contribution list.
> - Rebase.
> 
> Thanks
> Siqueira

Series is:
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> 
> Rodrigo Siqueira (8):
>    Documentation/gpu: Add basic page for HUBP
>    Documentation/gpu: Add simple doc page for DCHUBBUB
>    Documentation/gpu: Add kernel doc entry for DPP
>    Documentation/gpu: Add kernel doc entry for MPC
>    Documentation/gpu: Add entry for OPP in the kernel doc
>    Documentation/gpu: Add entry for the DIO component
>    Documentation/gpu: Add an explanation about the DC weekly patches
>    Documentation/gpu: Introduce a simple contribution list for display
>      code
> 
>   .../gpu/amdgpu/display/dcn-blocks.rst         |  78 ++++++
>   .../amdgpu/display/display-contributing.rst   | 168 ++++++++++++
>   .../gpu/amdgpu/display/display-manager.rst    |   3 -
>   Documentation/gpu/amdgpu/display/index.rst    |  78 +++++-
>   drivers/gpu/drm/amd/display/TODO              | 110 --------
>   .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   6 +
>   drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  26 ++
>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  13 +-
>   drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 250 ++++++++++++------
>   drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  16 ++
>   .../amd/display/dc/link/hwss/link_hwss_dio.h  |  10 +
>   11 files changed, 560 insertions(+), 198 deletions(-)
>   create mode 100644 Documentation/gpu/amdgpu/display/dcn-blocks.rst
>   create mode 100644 Documentation/gpu/amdgpu/display/display-contributing.rst
>   delete mode 100644 drivers/gpu/drm/amd/display/TODO
> 
-- 
Hamza

