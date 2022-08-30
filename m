Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7B8ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 19:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6DA510E063;
	Tue, 30 Aug 2022 19:52:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573A710E063
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 19:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7gPbEjoqb74+rau09FbBZaDJTgsaz1B0zPb5O5lyLQOeFneflr418adgIlZeG+FjF7qy0p14utD9GXVtP6Vd/BntAjOwlynwzZzGrHyd00Xa6FQlizww2JV3PuQWQdon/5FFxztF/vHWOygYQxHABvyrVHmIrZnPsgqJ8CbjWRvFITz1rNDxRasgi3QrQaKIO0NYMFBEr+b8HbRWQkvISJBluUPZSHYEhFg41E8kG82VU/DUoTgFfgJ8Y3R2JjaAbqkTRyxvqq3u5eqF9CIJDSMR17V3viCwP/qnc+SeS6WLSRxBluJ7nKVanZPKUrwkPMcA8lVlzQRwoBtLOa2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdPFGGAYSWSJFW3ZI0U3uzRsK0RTsNGl/qRYsA1vcW4=;
 b=TbwMxVCX9wbQ4t6VHtnXUaBbNkrymJp0QHyYiRuxyJIAopS33hWXDnjVPXiLGamuNUsqVuBFQ/Q93IJPBZWDfTY0Q8tj/HU6ITRzHQgchDqDnq3fbI7NNNI3g/K+rgvfmJ4d0TWpofZ43q3GyCTbMtlZhKons9LD7mm+okjGJBVThPOuoH0EYcuPjPt/86lMfxyX0Ggd39Z6eLjqwgkh80FfuHjkylCbjEPATvvHGkUl17SsyAUCC906rtFJS9zgGeLog8CXUbNXYtsqT9gj+eFA4XMFaqnDDzXtfboZLVPVsQBYxpoT1ydJJVuCnlJiLFMQrYcmj6LeJv3lLGEtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdPFGGAYSWSJFW3ZI0U3uzRsK0RTsNGl/qRYsA1vcW4=;
 b=KSdHLUolOMziTaLWfWzJY9TxeeOcB/nFvAf5//JzaRCjlAFFLrbHPrfeiA0qZNCbPIoo7lvDcckPsSeCltWi9h4YoyMvaVMzTUjbzTXOQAIrQMykHQUHWiifwwOtY33buHefflhRW5wRMhSpI+bBqBejuiOsX22k7riZsV3QfWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 19:52:25 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9033:772f:1339:75f6]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9033:772f:1339:75f6%4]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 19:52:25 +0000
Message-ID: <05030c13-1237-23af-0228-c8df1a41b3e6@amd.com>
Date: Tue, 30 Aug 2022 15:52:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/3] Expand amdgpu documentation
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220811154819.3566210-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220811154819.3566210-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18018f62-df61-42ab-64bb-08da8ac1297f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DguTnayoXzqtbt1rNwMn2HVUKRLd6HrhZ1ZUyPkRT0jVMarwbP5WXZ6bpGLyTc9NkERn+UuBzzPivdhVFZOcWre+ZZLgyffDt/fWCdNJSwCVP1QkyBPmGQVzcnS4TWDzVWqDJ0hnSmfuuU2XIYObv35U0J3yQdwpWXTuy1TQNrsWBJmOE2F/HjN5ba0bm8MOzueseXAHRYca77pDML4vuLvxXZxpaR7NeA7FMpyDQeQfsx5P/tFknV0xMwF7EW6nh3aHlNwJTKRaMBhPdSwRKh5t07jNHZVPHHO9hqtlII4ZJV1Ez04muMGLl2FEFAuZ2TEE4Vv6FzO4YYvCKVoApb0SDzpvdU1HHAmT2ysR8mTtdaLRk33q+7Sbj0FxEjerSDdr7fJ1BhVqm/1ssEz5w7KRuuTcC6MKdYBQUD7ErMl2H9DsqOMYMioIsEpLhr+EY8wb9C8OnxVXflFTAbtFRx69l6st0hU5mEzT6tYMW4MEXXLA5wuYZIe3M23uPdwo6UuPYJDYF5zjYNMjMrqohVX8CJzwLL7YP0qNu8UMJAo5mzCVo5hdFZi9P1EukTrkIoUBeNDyk1C72kqn4O7hf18rhB1QKk5OHKnLkFLrXRU0VGzRFARAhH1GbS5ZzFuxHQFKRC8i0SAwIcL62z0cvE4B4Jy8NRVwv92SHqQHbINx9++Cbw8xE1WCR9+m/SKKvQqIn1TW9NF5wBt8+8hK0pMOmtW/M07nZFKpicigG4mWlLrVEm8hV8FUcwtMcs4pHddW/9MUOsFpx0IP0nuKh+ZPu1WCTpmam12wPVjUNxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(66946007)(66476007)(66556008)(316002)(8676002)(6486002)(31696002)(31686004)(86362001)(8936002)(36756003)(478600001)(5660300002)(41300700001)(53546011)(6506007)(2616005)(38100700002)(2906002)(6666004)(44832011)(26005)(6512007)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdUL3F1NE9JOG10Qzd6YURpa0w4R3FlUTVLNHFoemFFSVA1VU8xWmt3cENw?=
 =?utf-8?B?Z3Riakhhc3NRM2lJRDVmREFLZFQrQzVHV2hHYnVvVGN5MUgxamYzU2x1ckhM?=
 =?utf-8?B?eWx4UU5wQ1o3U0tLRlMxNjVEVDMvaFIwbXMvazZJYmNxdkIrdFhmdkFnamtj?=
 =?utf-8?B?bGVvR3Zhd001U2dQWkdPSmIrdnRCeU84bUFheFdjM2JaNHV0RFMrVllrdXU2?=
 =?utf-8?B?ZWJ2UG1UMkM3ZkdVZlk1VHBQaWl2Y3hDQ1dJaEVLTTJrekRmeUxBWC9iZ3px?=
 =?utf-8?B?VVJ0V0dYOHI2MlNEUDhoNnVSVGZlbDJCaFgwekV6SnBwU2pNUVdQQU9zck5P?=
 =?utf-8?B?ZmxWTTRjdUFoVmVqazRoUFNCbkoyQ29uM3RnMFpFSm1MdDVncDZqK2JVbHdR?=
 =?utf-8?B?M21hcFR0VzBXZTJCK0dUcHVjeUpydGw0YUUyUzRLM0xhLzFtVFJaOVkyVlNo?=
 =?utf-8?B?QnNOVnRkaGtETFZHdndKNTBkOWo5SUFEak1oN2c4QW1TZEpSVTlGL2FMK2h3?=
 =?utf-8?B?aWFKdlh3c0JvOGthaGZjL0YyUUNScVU5QitTamR6ck9ZOUlHK21odytQeHNO?=
 =?utf-8?B?VFZpYkFLdnNPM1dRdjgrQ3oyTWhUd0xGRnI1WUxWazZHTWwxV1VnRFJ5WC9T?=
 =?utf-8?B?aXk2M21FalR1N3MrSnV6S3VJS2JRRHA4cVZTckhEeUttR3pnYkVVb3NYMWVo?=
 =?utf-8?B?cllSRUtoakF4SWh6TWl5U2JSSDV3aldwWXdhVkFTWVYvUytQeit5cWFwSXU1?=
 =?utf-8?B?RWp1Sm1ZYjNJYnZVeWlwMzdwVDlxVXErMkVNbVZsRnlURDFsUFBEQzRzYmt2?=
 =?utf-8?B?cXJxY215OXlacCt5NHdCelhwZFpnbVgxQjM3c2RZckJyQlZiVVc1ZEYzZkJk?=
 =?utf-8?B?NzRGc2ZvZVVYSlJISDBVTExvVHlobGJSdkNRZDRrTStqVUtYVWZ1OTVyd0lR?=
 =?utf-8?B?SjcyME5RL3dZYmttcHR1MGpNK2E4NEpqQkdGaG5DalFXRVhFTTRwZ0hZamFl?=
 =?utf-8?B?ekpXTS9Mc3FFM2NXLzVWVStRL2daaWJUSVBpS050TUhmZ0xqVXhyQUZOVUVC?=
 =?utf-8?B?RCtob0d5dWtKUm94ZTdlWWVHa2RtbGQvV0l4UHI4UWFnby9KbDlLTS9xeFUv?=
 =?utf-8?B?bUE3UlA0Q0FnYjZudExvQnNPMEdNMGI4WlFwRm9vWTM3Wkx0S0xtZ2pIWURY?=
 =?utf-8?B?MFlhVnFGd1ZDbFdGODlVMDBKOTNxSTJPUHAyL2c2dERtc3U5YTA3dXJSYmYz?=
 =?utf-8?B?U2pmdkdmRnRqUFlBbG00MFNnYzBBYmFWN1ZPRndyeXk1NzNiL0RhWU9ZWmto?=
 =?utf-8?B?ODJKck5CV2VwVThhbU4xZ3ltb1lXR2laaDhlUDJnekI2Qm1BbWQrSUZrS25F?=
 =?utf-8?B?YXQzRVJ1eXBiREFSVXVHMDJmOUVXVWZ6Wmc3WVJmWUlLWUdKcC81SEgzdEhL?=
 =?utf-8?B?cnVRWEtPcDhyOStsZVZWTHFpYno5RFdXY0VzOGRSNjRQSTBaUlZIQkgrWncx?=
 =?utf-8?B?STNRcGRONmlJV0EyckkrYk93bGNEVFB2N2NBaUpVTzk5VVVYNFJUK3VBZUQ4?=
 =?utf-8?B?NEcxRmxEMUdycU8wTFNlSHZhOFhHR2hvUm9YdERwMDVKQ2xWQm1xbFg1cnlF?=
 =?utf-8?B?TmxiOXFQa1NvOG9CTVV5cGYyUFdBUUdkUnBPSklEcm1BQnlRY25qeDNQQlJY?=
 =?utf-8?B?R290cisxQ1RvZXh5YkhsZWtaL0R1TEpZKyszS2c1aUZwSGFQb1BQMmlzemN1?=
 =?utf-8?B?QzhzOXlBQmN1cUt3NDVBTmszYkhnNjIzbVNMMnRGZVVocTE3YVJiV0NzYTRU?=
 =?utf-8?B?b2wxaUZYc1djLzdZWVNEUDRFd29OelZVVXJ5MXB2cjM2K3o5WGczVVpaRDBT?=
 =?utf-8?B?UVZnWXZQOUtyeUhuNkc4RGRnbCs4UThBMmJCYVFyeDRIdkZPSWZyQ0hoUTcr?=
 =?utf-8?B?YTJvWVRWZWpSNUd0ZEZUSE5VQk1VWFhwS0RBeTA4Y3ZJeDJrUXowbFJxRzFM?=
 =?utf-8?B?bXQ1YlFFbHRIN0RqVEdHYVh1ejZCcytyK0RWTG5lL1dhNStITzlPayswT1ZN?=
 =?utf-8?B?eG5yeXhGWmsyNTNwdUh0dnlKakVrNFl0WkVFdVdSRlEvM3ViTnltYUhNTXQ5?=
 =?utf-8?Q?T7/s6kZkq79eTiPGCmyE0pqB/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18018f62-df61-42ab-64bb-08da8ac1297f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 19:52:25.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: el3qwQ0xZl3Qv6tmYJ5ZjJI5aehpJA7kyrRJXZ4cDS6xg7lLhFkKHRyYPCzQPqdE60276rXNy+obkwuVVngfjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

On 2022-08-11 11:48, Rodrigo Siqueira wrote:
> This patchset introduces some new AMDGPU documentation. You will find:
>
> 1. A CSV table that maps which component version is part of some ASIC
>     families. This can be useful to narrow down bugs;
> 2. Some explanation about AMD Display Pipeline;
> 3. An explanation of Multiple Plane Overlay, which can be useful for
>     userspace applications.
>
> Since we have some diagrams, I recommend applying these patches and
> building the documentation to have a better experience.
>
> In this new version, I just rebased this patchset with the latest code
> from amd-staging-drm-next, and I also changed patch 2.
>
> Thanks
> Siqueira

This set looks good to me and should hopefully help others when
digging into the AMD display driver.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>
> Rodrigo Siqueira (3):
>   Documentation/gpu: Add info table for ASICs
>   Documentation/gpu: Add an explanation about the DCN pipeline
>   Documentation/gpu: Add Multiplane Overlay doc
>
>  .../gpu/amdgpu/apu-asic-info-table.csv        |    8 +
>  .../gpu/amdgpu/dgpu-asic-info-table.csv       |   24 +
>  .../gpu/amdgpu/display/dcn-overview.rst       |   59 +
>  Documentation/gpu/amdgpu/display/index.rst    |    1 +
>  .../gpu/amdgpu/display/mpo-cursor.svg         |  435 +++++++
>  .../gpu/amdgpu/display/mpo-overview.rst       |  242 ++++
>  .../multi-display-hdcp-mpo-less-pipe-ex.svg   |  220 ++++
>  .../amdgpu/display/multi-display-hdcp-mpo.svg |  171 +++
>  .../amdgpu/display/pipeline_4k_no_split.svg   |  958 +++++++++++++++
>  .../gpu/amdgpu/display/pipeline_4k_split.svg  | 1062 +++++++++++++++++
>  .../single-display-mpo-multi-video.svg        |  339 ++++++
>  .../gpu/amdgpu/display/single-display-mpo.svg |  266 +++++
>  Documentation/gpu/amdgpu/driver-misc.rst      |   17 +
>  13 files changed, 3802 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/apu-asic-info-table.csv
>  create mode 100644 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
>  create mode 100644 Documentation/gpu/amdgpu/display/mpo-cursor.svg
>  create mode 100644 Documentation/gpu/amdgpu/display/mpo-overview.rst
>  create mode 100644 Documentation/gpu/amdgpu/display/multi-display-hdcp-mpo-less-pipe-ex.svg
>  create mode 100644 Documentation/gpu/amdgpu/display/multi-display-hdcp-mpo.svg
>  create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_no_split.svg
>  create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_split.svg
>  create mode 100644 Documentation/gpu/amdgpu/display/single-display-mpo-multi-video.svg
>  create mode 100644 Documentation/gpu/amdgpu/display/single-display-mpo.svg
>

