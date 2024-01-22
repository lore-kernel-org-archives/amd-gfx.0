Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC97DC47DDC
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 22:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E1010F0AE;
	Mon, 22 Jan 2024 22:48:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC5A10F0AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 22:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEb743SBykM+opUF0xB4rzRJeY1PPrxuFRXymdpULqZKxbKOf0qaUNY7HckMbEzx4AnxQVZIQEkldm5k+ZEqNThpkW8ZJ/L/XHIcRaJQ8AJZbwe8tcXaM86hTAnBqzqTEZOJt2CVQmEAjvS9AInQ56TaO+A8rndwP1Z1EQvwXegpCFPibTgWBjoz29fw1LFHkNKrXJMbpPp/tfqgPUQkfyUJVPYGHndCVQ6OC50kqHMFcqNzpHfieVVSGvcOeca/IDEY1xaL4V8/WGQgZW+1mfHhNy5TsVXiHIBbp+9unY4BIT7nrDuWKwOOy00xhXq3EgKCfKBaYwctksC9L0iTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Wk8JNyZgpjHog7QaqCweMCWxa9lEYcxayG7Dm0MyP4=;
 b=RGj5MPKdf3D39gIgAOsVWISwNGj0HIgR8VEjS3UU7Q4R98bfhWEfJSba7GELpd7ddeDs+njh2QOvn4EfgMa1R4zgs6ry9cw6ipn1hYEnUX02MB85HjCtotylLX+hca6ZImeg/ruyJftloKY98ovEFE6dS2pOHLUfFMsYoddzb1T+hWbubHxaUhGETuniIq6tjgiVCFsRHPiFZjZCfAnvzchNBNTv3chi3BaYQBE3YPqbIQqcSh00dEaQ0O5yjhLTfq7HAJe281B3yFuzsbhsIZLrAfJ6sQXsWr13mZFYSE7zAJZpKIHaWejdRn39WzVoTHPLq6JTZwPGmPRhxmUBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Wk8JNyZgpjHog7QaqCweMCWxa9lEYcxayG7Dm0MyP4=;
 b=Ec8rt6rF8S/nRajrKVBVoWvM6ZFHl+TaXbS+x4pQYpQixdN9QJNxT8gaJBfh15b4CAbZMo1SR+ByGQDOESxxYipRcAeSPWlP15JvwpWLyP2SjwllYLWqy01bkWGeA8lnbTYd8vvLCOewp3i6kWAIohIssRSnaU14amgr96Ay/D4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 22:48:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 22:48:15 +0000
Message-ID: <16f381bf-6ae1-4642-aac2-04920ad573cd@amd.com>
Date: Mon, 22 Jan 2024 16:48:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Expand and improve AMDGPU documentation
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 899fda73-4697-477f-227b-08dc1b9c3803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V61YQ1m2fSl1HD583d4B6DLyuCU13f2XCv0E1LQDvthdZpLJHy3/ZrKp0sKRire3bdE0nDXDPWkiP4HLtMt1seX5ubXwlQ5100ZfOC3h6oy7e+8kaTsuR6SznKPRvfyOI0+b6jgmksnuYnPJLntHwGsDeWJ869tG50O80GG+AfDu3KZfx/JSAOZfQRFuWyRUb9M6lnXmKJRPpzHU2SIirLyrzl+bIlMXaan0XX6fnDZLas+6UM7MeYW/di3/A8dACh06FlNj4jGea4IjpcByshErX8m40akGLdk9wLOYkQG2O+2AzUf3UX4R8iRslCkJHdcLUx+YHyd0F/Q61cguj1ElRRnP5890e0t9qwFiKpMinPXPDh3zri0yXTmYgSTIY8Vz3MGUniP+vkSxmzFsobuXhqKJ9+E4JMgivVm/dLVEr/Vu1KLXN90hSkMxffHlye6qmRziM0z+OIW5FSrzWaD7UgPqmaxsE8Xr1/M9hDSqxrn33W1RlvbIlF1xel27QkRqNtePVCaMfoJlv8zrjRyvhbdwrYPO/39TtXO/cfhPE9UlepXnLqwR+9MejNaj3ttiGCkGH/O8nVIJll5VG/LX+YRx6yuVJ9Y3HLEZX8UDj/FB5IDXgq4/L876pj2nZpAN9Xq8Y3Hb3FoiRGfFsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(6506007)(2616005)(6666004)(53546011)(6512007)(83380400001)(5660300002)(2906002)(44832011)(41300700001)(478600001)(4326008)(6486002)(66556008)(8676002)(66946007)(8936002)(66476007)(316002)(110136005)(36756003)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3ZLZ0xyN2lscml3Nml5Y3ZvVDE5RWplNDhUUGtDVFp0TnMxYlZxTC9uUUpM?=
 =?utf-8?B?WHdQZWNZNTNhSGFvbEF6SThPejFpYWVXNFVHNTVZN0szWTZBamErZThxZ2pT?=
 =?utf-8?B?Z1NCejJkT0ZKSkNpMmJqVTR1M0c5MmdWZG53dXNHY3N0Ky95dmZ1SG9seUhv?=
 =?utf-8?B?QXZjT1llM0JhMUJZeXo1dlg0SWxGVmo0UVFvWUtadWpSWDdaYkw3eHJyM2tk?=
 =?utf-8?B?Y0VmRTNQbFp0eldxSWZQQldqZEJjRmFlcGpzejlLS0JydkI1Z3JBWEduWEpU?=
 =?utf-8?B?MkI0ODJGQmhkcWxkd2FGTG5uNDZDV0xjd01lSHBtRUNGYUxHN1dmNGcxQ2l5?=
 =?utf-8?B?NDg0cnMza1VDSUZnS1JtUHN6bDB4aWhUS3lTbHN2Q3dPYzM5aXRNOFZhR21k?=
 =?utf-8?B?THFwSmtTS0h0dmVkcStVVjZaQ29UWjBmdmczam13VVQzY3pqSnJ6RlU4TURK?=
 =?utf-8?B?RVZkOVlUek5xWjQwVzczR0xTV3BGajAwSHJEOUxiU0lidWhDYUJKL0lrYytR?=
 =?utf-8?B?MzlEYnJDUUhJdGZ3L1JzUUQxZHNOMEYwUExab2NGVzZyeEhlQnBhemtIL1hu?=
 =?utf-8?B?MDJqL1ZiVHdSbWFpN2tmNjc0ZFN2WWtGNS9Ib0FyL0Njempmd2RGcWdZNFcz?=
 =?utf-8?B?SExUYW5sUGZqd1prY0l0SGN3bXV4ZHkwTjlnL3Qxd05nTEJ5NDEvcEJZWmd5?=
 =?utf-8?B?bGY0cS9sSEVlUElqSThCbHFCa0d5YlhqUXI1b01DWTRCVDRXR1R2blBha1Zv?=
 =?utf-8?B?bURNNyt1OGdQb2lHdEpLZHZqSVV2NlNZdDQrdWhPbTNyeGoxY1JJekVBcnFt?=
 =?utf-8?B?eDNDUFhjK253WWlXdGpXaDhRbmVtZmcrZkxUWHlwdkpLMmtZbVljbG1NY1lm?=
 =?utf-8?B?NjdtSG41THJZREtMcC9OeGdnR0I2K3E4MENtYy9LbzN2cjdvcFI0MmxybTVz?=
 =?utf-8?B?c0FJeXNLV2ZwZXlCdWJsMEFENGJITXMvVzZZVG13cjNXSFJta0YxMDJKdlow?=
 =?utf-8?B?a1lGSjB4QVg3UjNhTXVCTExzRnE3dVk1RFRuelphOVh4WkoxMzRvdzU5M3pG?=
 =?utf-8?B?eDUxWnVLaEdpZDJvdmFkWk5JSHh3OHluVDdEVHRLVk1GMFppWlI0R0pYQmp6?=
 =?utf-8?B?NjA1WmxNaHFFZERHV29tY1I5aWljUDE2Vi9UMkZRL0ZGVVNJbkRVb0tTNWho?=
 =?utf-8?B?cE9ZYk9OU1l5ZUpSeTk4amxkTUhrcnE5UmVEdkd1RjM0cXR1QkN2VGYvSnlp?=
 =?utf-8?B?Tm9MZW1IbUpxaW9nUmgxdjlhZmNGTUJRL1dIdlA2NW9JaGJEUEUrLzFBQjJk?=
 =?utf-8?B?WndXYU5MNzFFVUZrZzRvL2dIakh1bnh5Nk9Qb3lTZlV1N0VHMTNoeGpxL3hn?=
 =?utf-8?B?aDE2VHBna3hEWWdOZzZ4VThIejVrMVM2YmlSc2pzaWcwWS9zOUwvL1hSY01h?=
 =?utf-8?B?VmJQR2JLWlY0ZGZiRDBHZG92NW9TRG40SXc3Yi93K0cycGFTZW1mbUFueGxv?=
 =?utf-8?B?KzY0KzkwTFpnMzYwZ0p6T0pRNVBZWFhlMndEcFl2NU93V3lwMkR2NUNZYjZs?=
 =?utf-8?B?RVRYb3Qrck8rQ0JtczNxT1YxQzdTZlM3dVVWQTl3VDhPUjMrcWZEYjFBTU40?=
 =?utf-8?B?eUtmOU5TRitOTVVKZVNMS3NTY0xyd0NCUUljTWl6ZlBic1RSNlVYRkxXQTYz?=
 =?utf-8?B?RUZJRkgweGJESE90bzFLb0JkV3lVbFpoSFF5V1ZmS0k4TG1CRUdHdG02bTNt?=
 =?utf-8?B?SlBtbDNPZTRCUkVtamwwb0UzbmZ3dmIvZzhCbUhWYTNqQTFxQmh5b3hSamZF?=
 =?utf-8?B?NEJEZ2NBVWxjYk5vY3dqWU5qMG1hSzI3czV6Z0U1K0orbXo5TWovb3Q2U2F3?=
 =?utf-8?B?WmovUWJsVlBRU1p2ZzdsL1QxTUVuQXRVRjllY3dTczRja1MzMTJ5ekx1Y1VG?=
 =?utf-8?B?ZXppU21NajdVNjdIdmQzLy9MUTZxaFlxSzNyZng1U2VTYjhNcUMvMDdaSVoz?=
 =?utf-8?B?d2k4UnQ5c1FzQlhObXkxQ2ppQXJwTjVOa3lBam5kZGp4b2dSekh1OEpwVzBl?=
 =?utf-8?B?emdsbEVWVElrdHF5UkVzRmk3VDlzV1BvYkROZ2dTWmhEOEtYSm56ZWZ1bVlI?=
 =?utf-8?Q?HNEIyfAfbxbpD26gu7J5P8qkA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899fda73-4697-477f-227b-08dc1b9c3803
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 22:48:15.0175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJv7CDc6YPxZ6O9nD7SS/E8zhqFiUAXJIMBrcpveyO30fcOgXvF5GpKVTxpy1i1mwZ+SDn6PazYSNHkzP2Xpyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211
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

On 1/22/2024 15:24, Rodrigo Siqueira wrote:
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

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
