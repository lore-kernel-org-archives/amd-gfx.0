Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E537CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 16:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C263210E0EA;
	Fri,  7 Nov 2025 16:38:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pxYb6Fca";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B86B10E0EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 16:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfpatZAhWmmYFR+cXhlrtnBCXPzOoV37hdQNTy75uVYXInVZ00DBLfesIeAal7G8GSX1WlaadLEzFjBGT+E7p1mbuDQPBN7SCPvToqxGRaZXfnFYctTre+8tkXpb0Ui9BQkPr8v2l761FZcqISNow8Pxe+yapdEPjv/6Qqtbn3hufeKGAEzkod5LrVksG1cJjdsBusg54tbL6vqVZHpcn1Lz064V2xOU8aodZcfRKTWUOpOUNijnP/FPt4nTJcrUT2XeeKIOj1qC9mDO21HcVoic7svurpaxyOao9NWeL/ohxDK8u7IVxdyZ0uZLgLJvVVuz1uR428BTZaYoSeSApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vMTYIBmiQHC6Kre9p0M6Qtc8QkwiuCg1SUsXWszc40=;
 b=BPWY5rdpGCpfZaGk5xifbMY9SUz+YQcW4MZz/439Wb/B+FtN/Ea06uygR1DUUrWp0sNNcKH2z+oa7Qy/0Alha/gIvZ8gcxP+1kxYATe2sB+W/MJ/Yk9M/fPIwJaRqq0GQGHL4IDzu6ShdNrsXn7bE4Mrxi/HC99ZBEqr+mpT07v7HEXdHsEDFevxe+eT7oSq/gcSRmU1x1u4X7NWbjZwHAeqDPnG0OMLhRJzVtpJsBRB5WCpkWE2p8d8tbe7RjLwzaZfIKpb1HwJDuuzTOVFA/BE0xGau5n7dgdPRI3Qz4Pug+g2JQD87dXiY5KK4BFVEtK09kEAv2h4fAL9Ap0nlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vMTYIBmiQHC6Kre9p0M6Qtc8QkwiuCg1SUsXWszc40=;
 b=pxYb6FcaaYkdTkfZAnBZt69n4YL1ALGlePCiDJcZaPInZImqR+DhsuEMiGQX+TgdpiXD6PX3hJul6JjeL52cSdcdcB1LEqsyxxJ3ag+BuG7RuyuZQlf4k0IZJV4/8SXkVP+eqdV4Ozz7N9/GhEuYMpB+VGHmaDBEWyVwdNizZ9I=
Received: from BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::18)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:38:55 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::a) by BL1P221CA0034.outlook.office365.com
 (2603:10b6:208:5b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 16:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 16:38:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 08:38:54 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 08:38:54 -0800
Received: from [10.4.12.116] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 7 Nov 2025 08:38:53 -0800
Message-ID: <c6c3e2ae-17b6-48e5-af76-dff421e9ebf3@amd.com>
Date: Fri, 7 Nov 2025 11:38:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix annotations for connector
 poll/detect parameters
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Roman Li
 <roman.li@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Harry Wentland <harry.wentland@amd.com>, 
 Tom Chung <chiahsuan.chung@amd.com>
References: <20251107141517.3044480-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20251107141517.3044480-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f30453-db82-46fc-764a-08de1e1c2457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzhycU5uV3NwMVZyRVRxT0xpT1BMY0kyZHlKRVFyclMxZlpCeGhnU1hBWlVk?=
 =?utf-8?B?bCtjdUpmU2FzTmhwNjJ0VlJ0NDNZZ3FJYVFEbjY4ZjE4aGgwZW53ODNZY2Ew?=
 =?utf-8?B?b08waUt0N0liUXg2YmxjTUhYUi9BM05LQjlkZnNLZVZ0dEdkK25MbnpMdjJz?=
 =?utf-8?B?RUFxV2FOOHAzc0tTdGZSSW54WnRXQXltY3g4Y1d1WVlITGwxYklNc2xtSUFM?=
 =?utf-8?B?b0x2WlMxQzZRM3ZvdEhUd3FvNDRMNU5RUTFreWV3N2t0TW1tci9TM2xkWGdj?=
 =?utf-8?B?b3V0ZHRRVjhvc3I4eUxqVGRXckN0WUlTZHJhdm0wb1lRVjRqVDlKWWltOXV6?=
 =?utf-8?B?S0Jwc1lkNW9vMUJoRTlqWWMvQXVETzJSZGJWemdTZXZHeHRWYk4ra01qbXdL?=
 =?utf-8?B?MitKSi9XbWZ2RzNKejhUMlp1dDFXbFprQ1ZOeitsRmNiekpiTk44UjBPeTVY?=
 =?utf-8?B?YnBla1ZKY3FPV1R3eVNzLzNQUUFTOUNNN1c3TkE3T3ZsU0J0YUg5WHltdHoz?=
 =?utf-8?B?TDAvNDE0NExNOEdDQVhvZk1Xem5SbEw1NnNWM0hKTGx2b3JsMUZTNnVtaG0w?=
 =?utf-8?B?di9HZmNDN1B0UHlIcEp1QU1EMHRrdENPeGFxTUtURWNjUHR4SkxzWjJleURq?=
 =?utf-8?B?T09SUzZSSkZBYk1EZHBnZ1ZkS1lEaHhOYVBjN1M5eGFTeGFNM3MvOHVmaVpS?=
 =?utf-8?B?WU1qNmYralJvMXJTUEdyNk1sMHBtZkRNWUhVT01zU0dHb0F3Ym9nWHJORVF2?=
 =?utf-8?B?Q3R5K1FzL2Z1NUR0ZExkN2haMHdDc1BwcFJiQlZ3cnovckNDd0xqYnhRa21i?=
 =?utf-8?B?VFY5VlFrZmtoUkdmLzRLRTN1QVBrV1hTZXh0UlRaOU1NYW0yalgzZ3FaTkFJ?=
 =?utf-8?B?MW5DNDd0L1F1MFFmWnNQbVpLU0dTZGJCTkpML0pGNUNnd210aWpiL3JHL3Av?=
 =?utf-8?B?c05FMjR4bW83UXUralYvSmRhRjZ3ZnV4VFBFZGMrRGVWTlVmWllDejRxQk1h?=
 =?utf-8?B?ZzRRYTdET0hFdlQxSW95R0thZnJkVGYvL0dLRlRzQzFvZ0l4ZjFybFA5elJX?=
 =?utf-8?B?MkpTUWxtazlYVEZpK0JnKzgvWWNaM0oxUHhmRzdiU29xUEtvTk5xcWFobEFU?=
 =?utf-8?B?cTdKQmdiNDVWRTJubUVXQ2xrVGRqdHpQd1RKaWpJOEVkMWFML015YzlVWjd1?=
 =?utf-8?B?c0gxL0JQU0RXMXpOV01HL2k3SWJTbHpROHFBQlJDdTFka3B6c2xjWFNaQWRQ?=
 =?utf-8?B?cTFPaGljNUZML0cxQTh0eDlsV0c5elFPNnNJeWNXSVV4WU9TRm01Uk5wV3gz?=
 =?utf-8?B?N1dzVmV4NUdqdGhOUXA2elcrZFMwZDJQdEkweFg1YTBwRWhtNFJHdng4QVBs?=
 =?utf-8?B?S3IzSkdlN0FUN3k4ZmdoWU0zbUxLNzhGT0N2THNVODZqT1JnRm1nNkFESmpH?=
 =?utf-8?B?ejZDTkljZkFnOWtNbEZ1dGJFR0Z3bGIvL0ZBWDBqOEU4R3J4WEZ5VGVzdEhp?=
 =?utf-8?B?TWZOVVF5eExNaDZpVXB3V2FxUjdLWEY4TWJYY05ncW5YWnE4bmdWWkRac090?=
 =?utf-8?B?bDFxV0hvVEZybHl4VUE4OFNFTDM1R2pZUmlhdWc3OFpzT1NPNjdtL0F4UWo0?=
 =?utf-8?B?eHRxc0l0UmRnQXVQYmEwejBpRW1XWnRZVHp3Q0Fkay90cHQwODByaFFWUjVH?=
 =?utf-8?B?Vlg3UWZnYUt5bEduL1dkb2NraVVLR01hN2xsbzZLNG1pUjg3NFkxcWl5b2Qy?=
 =?utf-8?B?cllwVkROcWRPVFRjSjRxaGlLSFlRYnNNUEY5ZEdodUJFdk5pOUtIR1NZckFI?=
 =?utf-8?B?RCtQK015VGRuYWs2cUgzVFJMMC82S3p4b1Z4NHJnRXJ6SDNaU2V2TGFPYmdC?=
 =?utf-8?B?QTI1dHlMRFZDWTdPUzFuUDYxckNNOGMzQ3FBc0t3NzBEYTZycnMwZWVzT2pz?=
 =?utf-8?B?NEs2VGdHU2ZuM0g2N1lwNmtmMTY1S0RXWjdmMkxxdGlBVXV5TEtWTGNoNWV4?=
 =?utf-8?B?Mks1a2pkSkJ4OE9LZitWazZiZ0swSGE5ZHFadVd0MkM0enp6a2Vjc3hNL3ZV?=
 =?utf-8?B?TGQ4WlAyb2RVWTZBMVpzYUJ4b3NidnZCVENoOWx6YjI0S0FaYy95dW43RG9P?=
 =?utf-8?Q?2sSE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:38:55.0347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f30453-db82-46fc-764a-08de1e1c2457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 11/7/25 9:15 AM, Srinivasan Shanmugam wrote:
> Adds the missing @aconnector, @connector, and @force descriptions:
> 
> @aconnector – This is the DM (Display Manager) connector.  It gives
> access to the DRM connector, the DC link, and hotplug/poll state.  The
> code uses it to check the link, update the sink, and manage connector
> state changes.
> 
> @connector – This is the main DRM connector given by the DRM core.
> Inside the detect function, it is converted to amdgpu_dm_connector so we
> can run DC link detection, either light or full.
> 
> @force – This flag tells the function whether to run a full detect
> again. If false, we avoid heavy DAC load detect steps to prevent
> flicker. If true, we force a re-detect even when we normally skip it.
> 
> Fixes the below with gcc W=1:
> function param 'aconnector' not described in 'amdgpu_dm_connector_poll'
> function param 'force' not described in 'amdgpu_dm_connector_poll'
> function param 'connector' not described in 'amdgpu_dm_connector_detect'
> function param 'force' not described in 'amdgpu_dm_connector_detect'
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ba11421332da..aa31e969b39d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7220,10 +7220,18 @@ create_stream_for_sink(struct drm_connector *connector,
>   }
>   
>   /**
> - * amdgpu_dm_connector_poll() - Poll a connector to see if it's connected to a display
> + * amdgpu_dm_connector_poll - Poll a connector to see if it's connected to a display
> + * @aconnector: DM connector to poll (owns @base drm_connector and @dc_link)
> + * @force: if true, force polling even when DAC load detection was used
>    *
> - * Used for connectors that don't support HPD (hotplug detection)
> - * to periodically checked whether the connector is connected to a display.
> + * Used for connectors that don't support HPD (hotplug detection) to
> + * periodically check whether the connector is connected to a display.
> + *
> + * When connection was determined via DAC load detection, we avoid
> + * re-running it on normal polls to prevent visible glitches, unless
> + * @force is set.
> + *
> + * Return: The probed connector status (connected/disconnected/unknown).
>    */
>   static enum drm_connector_status
>   amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
> @@ -7291,6 +7299,14 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
>    * 1. This interface is NOT called in context of HPD irq.
>    * 2. This interface *is called* in context of user-mode ioctl. Which
>    *    makes it a bad place for *any* MST-related activity.
> + *
> + * @connector: The DRM connector we are checking. We convert it to
> + *             amdgpu_dm_connector so we can read the DC link and state.
> + * @force:     If true, do a full detect again. This is used even when
> + *             a lighter check would normally be used to avoid flicker.
> + *
> + * Return: The connector status (connected, disconnected, or unknown).
> + *
>    */
>   static enum drm_connector_status
>   amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)

