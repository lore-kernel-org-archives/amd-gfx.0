Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3C9CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 11:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DD810EBB5;
	Fri, 10 Oct 2025 11:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yNlROhyD";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AE410EBDE
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 11:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/gy1PzXK7PuJvJ4rPvIXE4ovozVMOSX3/ggzgoP2GPWVFdMscrX7KhZRiWZhwgT7w4JvsHJz+XbUIzP356u6IyylRhq9K477tupnyKiFGc+D236bOxUlf0tb3CcKUUWv/4o0oAyg9GZs7bBm6gwtKF3hiYCL5sn/tG+zYiSZtqZyXVPY3KY0ehzsekIOy4Cffi+MzFXfOu85o6iMHBBbrIPKQzKq8h8rE6xvoTZdcfrHSjW/izG+5gIJwbGNzFDhNE0B9qGlr1CnSiLQXjaQrJ4jHg+cpVLkNjPZSGo1F6QHSSd/zVflNTWeV7aMcOnNzYyOHLfx9hPU1bKFZ7Rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1o0r7+BPP4BW+RSJPULxPL+eOkhIHbICPAzNAsvle8=;
 b=TEgIUV4Q9MrC8nlwnwyOZ5TUxc9skJSPtC1UV5BLyb9V/zNS3M45BQea8VYJU4EIVrVnSZC4BKCJQdMES5yFJKLf5fwJ+0+WP5f4polwhrYxFtkvuImqcxrVc4A5at3OdUgG3cSz7Wk4glw5vQPJyX298cyZ3TIv9/yY3MEC9SobkB1VeabR4ZXVESw8CIW5Is/U4YuRn9ALNp1ssWayvBfITLh4B28BDjifR3rEDnH4OM9yd7Lo8NXVlmZk6OjAzi8ozTA3L3Whu4hLLZOZ7ZwJmR8cAkWvEN9794pCtycYhG6lXjowXRBGaSsH+rteWz0My/37olTChVmURiLLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1o0r7+BPP4BW+RSJPULxPL+eOkhIHbICPAzNAsvle8=;
 b=yNlROhyDKQ6f3sWXrisPmkXa+P9eE5ZLQuJKaeB3ybaZQ1zsy8GAc7RQtAIynkhNyGHqrn4TJ7cEVYuFWtd65WJlBmm1eP5VKWDK/OjmW5kDfqYsHzELMhFcSF3TQUFL2mgK9vamHBa2PmIB6gbAVuZjngvnhTN0DAOMppMntnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Fri, 10 Oct
 2025 11:37:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:37:58 +0000
Message-ID: <04372c2f-6a78-4245-bf31-853fdd0e4847@amd.com>
Date: Fri, 10 Oct 2025 13:37:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: handle wrap around in reemit handling
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250922213305.3661288-1-alexander.deucher@amd.com>
 <CADnq5_M0XrfEyZjPL8QY5E5-LS=9tLp8h7U2tEPFcMhUs-gsbg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_M0XrfEyZjPL8QY5E5-LS=9tLp8h7U2tEPFcMhUs-gsbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0908.namprd03.prod.outlook.com
 (2603:10b6:408:107::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c73420e-b85c-455a-25c9-08de07f1761c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkpqZk9CdDNQOWtVSnhJM09pQVJWKzJXOTBWaGFlMXNvWElONkk4SkVjYVdi?=
 =?utf-8?B?cFM1YmV2YlQ4WUU3dzJCTENIdVl2UTd0cHRIUzRDNW9iblNlV09nMzI1Tk5q?=
 =?utf-8?B?Q1BnYzBkeVRJQWYyZVcveFdCZjVHMXJNaitKWlgxQS9GNCt5eDhTS0huTUlU?=
 =?utf-8?B?eDNmNmlWMmpYVERNSUQ0KzgvQ1dCeWs1Rm1iVU9ORzk0YVhVblZyUnJHZ0RZ?=
 =?utf-8?B?S1ZWQ1hCcGs5U0cxaExTWmdkeHJZTjZ3c1lRTXdRYkduS0h1cmltTXV5UWFU?=
 =?utf-8?B?Wi9lYTJUTEdNWE9RTHl2M2p2WEtQQ1FlQm5JVFQwWTlIUEpFYkJUSEkxaDZB?=
 =?utf-8?B?RWdzY21UVWxxNHI2U3c4OWN1b2YxYzZvZ1FVWnI5Wnc0ZmFRME5rWjVoZHhl?=
 =?utf-8?B?RVhwZnRWL0lyS3FBeVJGTHhYNXFsL2NpaTAyWCtSR3AwQXlYc0ZDaFoxU3ZN?=
 =?utf-8?B?YzE0WlZYMjVBZGVsMytCYWNnY2JiVlRTZmVlNTgrLzVHaGs4aFZMek13TS9L?=
 =?utf-8?B?T2Z4WUVEeUxaMlJVMTJZMnkzalJhMnBQR09iSXUxY0NzOHNTUmlRbGhhTWZS?=
 =?utf-8?B?bm1JMGRuMmhnRlp0OGRWakQvVVl5enU5TUZ0SEJYdUxmK0NsOWszWmpLUlhD?=
 =?utf-8?B?bG5YdlZkNlRvMHZTVTJYbzV3N0xtcm13ZTIwd3RKWVlXWC9yNklrUDBpZm5m?=
 =?utf-8?B?VHpHdXFxWExveW03UGlSd0pYUFdwaitGdzIycGNEOXZ6REF2MGxQWWtaL1ov?=
 =?utf-8?B?VG5PZ0R0NzZFb294WmtKdE15eHFKUjdLL2tRYjhIdkxpMVhlZ1BKZnpuSDdM?=
 =?utf-8?B?Y0V2bEZ6ZEVIMWh0YkJzeGxINnZzaVFpdEhRcjlmMXNwdFVYNXRxYzRvSXJP?=
 =?utf-8?B?R0tSd3RrTno1WW1Dem9mam1YSmlxVXVuSEczZHFibjR4NzdHRDQ0eXFxN1ZO?=
 =?utf-8?B?YW5XYVRkWnFwbnVKWHExQXRRRjV4UjdpZG1LUWs5V3RaZHJDZ3lLNnJkMFl4?=
 =?utf-8?B?bGI4WmZwb2dJSzJSd25FTDZrUmZaaWhqZzVtTDh1dERGVDhQYTVNSFExditB?=
 =?utf-8?B?c0RyN043N0gvKzVUM0VPNC93cGFicnIzN2ZXODlqelVvcHhSOUVVY1VvWW5R?=
 =?utf-8?B?UTNzaWJhbTZFQVpYMkxTeFdEWS9pN0VlWnBXblV6WEd5Qkc4SldtQko2U0lG?=
 =?utf-8?B?bXM3VVRUYzZzUjBXNzhFdUUvMUZaRms3ekU1UVNnVGd0TEpWcS9RK0JCMnhu?=
 =?utf-8?B?TzFNM29uVUhOSFlWeHlSV3VJY1pLYkZUZUxmb09GU2l1dkZyWlBwbFA3dXJC?=
 =?utf-8?B?aWZYbkp2MExEQWtKa0VQdzM1bVIyR3RMcXdmODNxMnZqbnIwYzhRNzBoTkQz?=
 =?utf-8?B?eHArME4ybW04RjBMZVlpMjFBb1c2a1VIVVNJZ1IxRFNhcDRIdFJ2eVBHOFZj?=
 =?utf-8?B?UmQzVloveUhvNDFBejRoVm5kUEYvVEdpcmF3TjRQR2g1MjN4eXRrSHJCVnc4?=
 =?utf-8?B?Qy9LN1kyckxjcHE4MmZETDd1NkIzeHVWbXBoWE1SK3JteTFMM2VoN2ZqQ051?=
 =?utf-8?B?dGF6eTR6MDNrd2xWRGZ1aXpLOVdESDNUKzVqazBQTkpYM0NnNkRJMm1XMnlZ?=
 =?utf-8?B?akZpSWVzVE9TWll0emN2VGRzdDJKOFlubnJwMWdNWDE0UEI1ekkxK29VNU1J?=
 =?utf-8?B?d3FCeGlWZGpMTXkrVUtLSU9xN0wrNWVLeS9zSHdVeE9ucGNhVGVqd3Uwc05M?=
 =?utf-8?B?TlRQbnl1YmZIQk5Td0s2QXlwaUpMM3B3cVY4bnFIamVMcDZ3U3FDbE9rY3NS?=
 =?utf-8?B?ZXdlRlZpWXdWMmpmZE5PaHp3WGFlMVZ3MkRyUFNiNDQ4UEVnQzFKZU9hNFZt?=
 =?utf-8?B?TVhGbzh3WkxKQ3BSdFc3ZXdiRVhpaEdIdDIwTFlRc3V3MU4zelhTRUNNRWZw?=
 =?utf-8?Q?fktXk7kFIVZYKzOc7prCc+lkOC9Tfypc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2VVTkpPSThRcmxXcFNRUWxPbUpUOTF5SWpJamVYRkhJdEcvcEFhOXNUSTJR?=
 =?utf-8?B?V1BOOXZxS3ZFNE5QSG5uSXp5SS9UN1R1cG5rM0RnSVlPei82NFJjSk1zREJj?=
 =?utf-8?B?TVVMaW5oNVFUaFc0cXZnejEwTjlicjh0UHoyVnZIWjN0N3hqZGdiaXB1QytY?=
 =?utf-8?B?YUh6cFlYS3RtRlNUeFRJSURYbW5OQ21YZG82U0QzN3lBSC9pbW5hNkUyc1gz?=
 =?utf-8?B?em5xUEhwR2VXaUNRcStYTUFHajF0K3VZZ294S1VYcklJRWFBWWw4TkRObmVR?=
 =?utf-8?B?eUJiYUJUc2I1L3kzQ3dHWlVwR2xiTlZGV2lDbzN0cXJEblpLNVc5MGVCL3N0?=
 =?utf-8?B?dGl6cVI1Y2hOZGtSTU5rVFpNdWk1d0ZScnBndDgxenlxV0lmb2xIZmc2SGlv?=
 =?utf-8?B?UVZsQXpOZFBnM1FPYWxxa2c2OW1lM1dSQ1cwVjk5SGhqSVdwampLblJKdHVh?=
 =?utf-8?B?L3czM04zM0VPQ2wxR1IzN01hZWx2UzJIeSt1aVlMOVNPQkF4QmYrWmw1Vkg3?=
 =?utf-8?B?LzMwMy9admxlbjhTUnV4eXNMZ1BZR0FkMkZlOHl5bmd6TngxZSs2Ums1V3ZB?=
 =?utf-8?B?Zy9hbUVNNHh1RkV0K2pJc2gvSEU1RTBXeitleDJQVUlvZzdqRHdabDBqNVhS?=
 =?utf-8?B?TVdObUhudjVkbDJnL3pMcDlaSzMxUnVyWFpGTk84NmNCSFlGVDFMYnFDMEJa?=
 =?utf-8?B?dzZCRi81R0xIUnA2T2Q3MDVnb1g4T2h5UU5EcEY1SnlkOEdxZUNQc09ocWhi?=
 =?utf-8?B?SllxczA3K2ZIaTVnaVczdmE1QytVT0djMFVuQmVwcTdHdVVFU1RyZUgvMkFu?=
 =?utf-8?B?OXA2RjFGQUY1VFhKYS9HaUl6bVgvejc2VWd6R0JheXB2VlNlbVNaQlUvRks2?=
 =?utf-8?B?WUtnQmlTQ2s4YTEwR1lqcytrTmU5d3VoejhvaDBIdlpKUUhVWEF3YkNmaDFr?=
 =?utf-8?B?L01lSnpCMHBoMGxSMVI0Rnc5Z2ZRd2dPOExySFg4K1BtYVNwMjM3eHkvNDVj?=
 =?utf-8?B?dllFdDZDRGhodlBjRG9RZ29vZjhCbjFQcWFiM0Jkd2o3dDFGVUlpMzZLUDVG?=
 =?utf-8?B?MFNES1l0MFMvQ0tlaGlHWEhEcGl6d3p0cm1VM3ZZUjZ4UXVXbEhkcy8xUmg5?=
 =?utf-8?B?NnZ4T0I0ODRPeHFFcklqUGtBbUt5S3gvZGg5aFZaVFRieXRyYWRBZ0VqVk1n?=
 =?utf-8?B?eVZ2Q1RqRzRNVXdjRTRPalR2RkgrUDZ0L3VqWU56ckdSSUMyYmpXRzhIRGE0?=
 =?utf-8?B?aXkvaHFUWWR4WUtSY293ZEo4NS9nakFCNUhwY2xTT01Kay9IR2o2MENlNjBZ?=
 =?utf-8?B?c2dHSnFaNTV2d093TmhPVkNzeTRTbmxDMEVkcUg5czVScnEyNXQyWkh2QUUy?=
 =?utf-8?B?RnIwOUN0WjMyWlJCUE1TRHZ6NlRWV3ZqTzYwSER2NWMzL0pudXRPVTlwSVdY?=
 =?utf-8?B?VW4zdkdwNWxJS1UvYkk3QVZobUJzbUlscS9wNjdWOVV2Q3B4YUdqMmcxVEFp?=
 =?utf-8?B?eWorUFpxK2ppZFdVM3d0TU92eTA3TEE1dUwrOUNzUzdKdmkxSTJ3bi9UbW5S?=
 =?utf-8?B?RzdsS1EyRTNCcmxRTnZpOWFJd0kxRGNOUGZ5WFI3dlplelBBMDdobWV5WFh0?=
 =?utf-8?B?SjV2VE84TEFLM3BGYVRFbEQ4aEZUTFdzSVRQQUsyR1krWlpHanQwRmwzOU1W?=
 =?utf-8?B?c0pjTmF5MUZuY00rM09MUnV2VkQ5bndDVkd2dFVBNXM2VUhFdUV1OGQrN2JP?=
 =?utf-8?B?d3JYS1FBSnZSaEVlLzdXYkZYb0EzY1g0OHZ2d3FzTEE0bno3Q2Z0VUFIblZ2?=
 =?utf-8?B?enU3RzY1cktLU3dUT0I2TExJdVhrSUE5ZERjcTl5M0toc1RlR0g2R2loMGp5?=
 =?utf-8?B?VUlvNEdPL2ZKc2VvRkcwcGpINXBmbGs0UFVlQUdmTXQvakJ3YjYwenZCVDhi?=
 =?utf-8?B?N3h2VTIvVnh2TW1wOXNsSUNPR3owbi80RzUyK2Y0NWw0MGRVTkRpcWk3TGVE?=
 =?utf-8?B?alNPai83QmxWTGt5YzRDQVZZQTFWSkU3RUIzdStWdVl6Wjhxc2Q4a3JmajhS?=
 =?utf-8?B?WkUvc2s0UWNOS1pBWm9LSlFOcmtqWGhvNmY5Q0NHSitqWUF5Q0JiRGMydEdh?=
 =?utf-8?Q?KhDep3tiD3TjIFpppqpivJ4eD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c73420e-b85c-455a-25c9-08de07f1761c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:37:58.7412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xzu7rKpoOlt4X7CuKAGv15a6ux2DelkvUPq00pfZjDS5VdG2Z50JH+LzFrKXb/6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

On 09.10.25 16:28, Alex Deucher wrote:
> Ping on this series.
> 
> Alex
> 
> On Mon, Sep 22, 2025 at 5:33 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Compare the sequence numbers directly.
>>
>> Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index fd8cca241da62..e270df30c2790 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -790,14 +790,19 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
>>         struct dma_fence *unprocessed;
>>         struct dma_fence __rcu **ptr;
>>         struct amdgpu_fence *fence;
>> -       u64 wptr, i, seqno;
>> +       u64 wptr;
>> +       u32 seq, last_seq;
>>
>> -       seqno = amdgpu_fence_read(ring);
>> +       last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
>> +       seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
>>         wptr = ring->fence_drv.signalled_wptr;
>>         ring->ring_backup_entries_to_copy = 0;
>>
>> -       for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
>> -               ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
>> +       do {
>> +               last_seq++;
>> +               last_seq &= ring->fence_drv.num_fences_mask;
>> +
>> +               ptr = &ring->fence_drv.fences[last_seq];
>>                 rcu_read_lock();
>>                 unprocessed = rcu_dereference(*ptr);
>>
>> @@ -813,7 +818,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
>>                         wptr = fence->wptr;
>>                 }
>>                 rcu_read_unlock();
>> -       }
>> +       } while (last_seq != seq);
>>  }
>>
>>  /*
>> --
>> 2.51.0
>>

