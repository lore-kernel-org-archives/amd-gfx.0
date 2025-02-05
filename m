Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EDAC02198
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572C510E7CC;
	Wed,  5 Feb 2025 15:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xIvNQXl2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D4D10E1D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJ1IpvErGG0RcLe+/lU69li0cfcfZ5mWpaxSQIUAIx9WmW0lRuzBMRMqOhkSmTzAy8sW9CzbvR4u+3bU98mDzO40CeXIBjLYaxgAHQAEPM5KTxD2zLzHIgEy5/QjG2+OZS8qJLvkEXTFXVAAvzQumY53oNIYb1Y6EgqD3c4Zq7swXeisbY40NHLOYE3ZznXY5qfO35eURHfRJS4hu2n/A8XXqvxaHDpUF+tpA/3unqTIsCOxgD43t2SQnBklPz5CO2mCEAVZMRj1GKWBoyrm7BOwmY/WHNDaUVd90lgX4QuS3+9Vr9aByGmJo/SLaKt7i03/zSn8M+mOIUWuW73LyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izCQJFmKvNeOAPNNuks1IlRyyJkLh66xgvzv1m+014Q=;
 b=KV31y6zXz9vAAZHK4uNZRWYvlbUf7cKgMRH+j9exIO34TXb1o5M7ISTaw58esUn7Au7WTiDa/RyzsweqaG4KbptZKgH73UFp5fABFPyHs2rdUjT2AxGcpZdXvJF+7zdhJC/jxQjAp4cHWM8+DDljNhR1EtSTsjWmeEqCqcg60LPVw8qPeQsx3oRxYZGTGphBzKH+OVf0oZ5mNuTycEEfW1gGC0mO80UkYtoKlTxh1rXL3Ci94zg3HZdW7HMRwRYhe79SGLp952dxQbyYqrABJN9lWZjh7lqgVeypajvGs1KnPzXbuEtTEowizeBv09JJ5UktM9ZOnmkvjhz8fFXmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izCQJFmKvNeOAPNNuks1IlRyyJkLh66xgvzv1m+014Q=;
 b=xIvNQXl20tOynsAiMD52emrnyE7NaDQWv7vrvahVMJbfSKZkvwIHAB+XXpZ/55aK0wBxgJjay+0hhM7j/KbW7hQklKpoDSPk49FbH3A8UXAGzFo+l6gGFBHq2/HAXIj+A23tGB7jpkVPYwst7Ko0X9suu4S4rcUnrDjapHh6W+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 15:04:13 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:04:12 +0000
Content-Type: multipart/alternative;
 boundary="------------fJdWYJGnT9dhx1Ul8kbOMm4y"
Message-ID: <f83920ed-79b0-4ad9-97b7-5b30133918b4@amd.com>
Date: Wed, 5 Feb 2025 10:04:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/44] drm/amdgpu/vcn4.0.5: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-19-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-19-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR0101CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::27) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e3053a-c734-4213-84e8-08dd45f659cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGhwSlljT0ZncWtvd0xOY01aOHNQbTFhQXNiZURIeHJIT2hBbWtLSXdCMWxo?=
 =?utf-8?B?NkVaSEZHOEwyQnc0YU5tdGxEaFpORGF6MmJKVFdhc0FjdXM4VEtqWUVFaFBW?=
 =?utf-8?B?MW56bVo0bFU1d3huRjZsdDZwNFk5RzRlOVNNL1ZMcllUNmVoZVp3QUxEL0tP?=
 =?utf-8?B?bWEzL3NwbFUrd3BwdUVseW1iN3RJSXQrUzV6KzdpN055eVJDblI0a29BQ2Y5?=
 =?utf-8?B?Vll5TEIzclFlQW4xbVVKSWNzU0pyUEhCT1VSNlhKZDZJWE1yUFQ4MjV5cjRt?=
 =?utf-8?B?UTR0MXRESysxamc4OHFHYXE0S3JJNjhMc0o0eHV3VVhna0VPckFMZGpmeUJD?=
 =?utf-8?B?MytJTWxITll3SitEZHhicVY4OU5QYUxOS1IwNys5Y2dxN0J4S1JoUWUxUVYw?=
 =?utf-8?B?UWdKY3FwTVJyMFB5R1pvandjMHBSVHd3Zy9rS0lqdXN3MmNDT3hQZEFwcVpj?=
 =?utf-8?B?ZEY2ZUJUQXJwbVI1aWo3Qy9RSzdCK05jYTV3UmxiMFMvYTJOeDFnNVdTQTFK?=
 =?utf-8?B?emRZK0N4T01GRmZxVGFrdVdPZElWZFBQSCtuK2JIUnF1djZncjJTWHlPSzNq?=
 =?utf-8?B?aVBSWWRvTHMxUEwxTUdrRUVxeWRCdGoxWHhwTzkxQzRGZjdNazdGckcxUlpK?=
 =?utf-8?B?Nm92dExsQ01xNzB4YkJlTkxHd2NsbmFRYzhxNktFSVc4VnI4cVcrSFhiVzBB?=
 =?utf-8?B?ZG1NTkZuRzJqMHg3d1BYN3UvczJxMmJ2SWZ6RVBMN3lSQS96MlpKYkxyNitN?=
 =?utf-8?B?OXBJSzZib0h0L3h4UlhnelBQYWlidmt3ZUdNT2dLUU1Oc3Y3S0NoN3JrUUN0?=
 =?utf-8?B?UHhlMW5IS3U0V2VtUWpSQWtobEtrdDVmV0dXSG90cFFxdEpLTzhtSGJFSlp3?=
 =?utf-8?B?Ri9EdUNlNDBoTW5hY2NLb09Idml1aXR2RkhKR3VmQ0tsSDNjd2NlRndQbk80?=
 =?utf-8?B?ajRFWjVwMG9pN3R6bUxlMkxiNy9NakNsWUVtcUxnaW5lNmRkQ2RmeCtKRW45?=
 =?utf-8?B?UXRmUGp4M3FMSXRMUUloeU1ORDVqOFQ3Q2p2VkRDWnFUQjhadjN1bW1rL2pn?=
 =?utf-8?B?YmU3eVdCVER6VTZOalpLYTJTQ3dRSHhlazdTUDNCcTgrZlozRGlQQmNsSG92?=
 =?utf-8?B?KzRaNERxQlZxRTllY2FwSUxCU2hCajFiY3dFK3FDTFowVmwxSms3U0ZUWHZx?=
 =?utf-8?B?b0FxYlRCL0t3NFhCNkZCTHU0MytxWEtVV3RLQUgwUTFIQWJFeXloLzk3bnRp?=
 =?utf-8?B?Y1VIUmxCS2VwRWEycDZ4Q2N1cXZTRnRaZzYxdDNKNDhydWczalhIL0tkNW80?=
 =?utf-8?B?amdqNE1FRkxxQ2JJVVY3S2h0ZGlNRnNTdXF3WW1pQVNPdWFEYjBCaXROdjRW?=
 =?utf-8?B?YW10cUEwTjVMRnlaaEJiT0JTMEFVeU80cGo1N3dqcHBxY0dlSC9XS29VUGps?=
 =?utf-8?B?aGk4YXdjQWoxL25FaklaMEtrSkdYNE1sbUtidkxacHJxK3hQT1RBUjliU1Bj?=
 =?utf-8?B?cnFEaDRib1VEUGVNRGZMNG95U0hkQ040NktELzd6ZDdxZ24zeGFlWU5MSkJo?=
 =?utf-8?B?ZjZSbDNWc0hUelp3RTBDdi90RDNvMUtWTDJWUDBXWlVFd2xjM0J1M2lEbXRK?=
 =?utf-8?B?UFJDc2YrbGVwbDFPTUp3VlRsSGdBU2VHcmxDYUVUY1VVRHlYcldlZ3NqMHVQ?=
 =?utf-8?B?M2RTK3ZVOG40UWpyRk8zTHRIcTI5WnpGelNYb3ZVcmU3eGVCeG15R0ErUDdw?=
 =?utf-8?B?bWcyM0dQYk9CMUUzeGNVNEFQbEpVdERZWllNcmFVSGkzcnpLVlNTRXlaYitB?=
 =?utf-8?B?WlZvSlV5bExPRzZITElQUi9rQkNXUkVjREYvOXZxeUFQUExtTVBwRjJscUVQ?=
 =?utf-8?Q?zTcbLSaPcsgyf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0Vyd0dFak14ekI4Z2ZQdHJNNThVSzIyR3Q2QmJOaS9UOVU5VUtoaVlrTnVn?=
 =?utf-8?B?WkIxbEc1alluK0ZHYlo4VUVCTXFGcjRDaFNqYjJMaWY0NnZ1RmVySVRaL3lz?=
 =?utf-8?B?S0IzVVpqbmlWSmhEWXMvWE5PZkVCSXFEM3lBdWUxNXJrRVJMOElsd29zRVA5?=
 =?utf-8?B?cEd6eTRiY0VqV2JYcytJSjd3U0t5TjV6aTBEclhQZDB2a2xUVmpmdGE0UFVG?=
 =?utf-8?B?ZzVnc2o5cDdJNCt2ZkFOVVZReklTTnRhbEoweDR6K05HZklyNkVyQkc2bTE1?=
 =?utf-8?B?SU1sQVhlNGxOd2ExVENGcm9ldm5PK1lTMGpxRnFaTXp3V2ZtbE13VDRtRmoz?=
 =?utf-8?B?MVZUdW5kTytBRHNiMlc4ak84OTlSMnkxeGFCYjRtRHNtQXRjM3ppRFZTTXlP?=
 =?utf-8?B?QjZnNzZMYzExSCtBSUJlMjhzd3I0UzVxK2g3YnA2L2kxMDBXN1dtWXR6WEdm?=
 =?utf-8?B?QzBKZld6Q2h4Wi9OVXVYb2J6T1NMdWtaeFRvV2xJMnJ0UWVSb09UZmhReXA4?=
 =?utf-8?B?cFZLRzdnT3VsbEJvRTVsZERpWTFYbTBma3VLNVArVkpPYlBDNFowczdQcE5O?=
 =?utf-8?B?UXdQa0tsNjAwS01HaUdlMFBMenFRcUdDbnhwWjNMMFpsWTlaSm5KWkRRcDM0?=
 =?utf-8?B?Zy9SamlPdTZpNElEc1RoeTlsd3VHQTV3eTNsRGZaYVFNcHFiTDJJazBIOFNt?=
 =?utf-8?B?bnZPZk5SSzN4Nm9SVW5JdkNNalYzV0krR01Rd0lad2VBaXlVV1h5ZE1WS1Vy?=
 =?utf-8?B?dktxRUljY2ZheXJWeUJoT2JLMWd1OGkxUmRmNXJGaEFVRFJHdkRhbDdzczda?=
 =?utf-8?B?R1dMVzJ6N3ZmNWR4bXlVMGRJb3ozbWpHSzlpZmkrYlY4RERUNURNdE11WEVz?=
 =?utf-8?B?RDVlT3ZQTXFuSW9LNjFnb2FFdFlFY25wVDR4ZWlERE52WDhPOEhVZ1Bhek9H?=
 =?utf-8?B?R2d4VlEza1orcllJekk3UGhldHo2WWlJbVdLWC9tdDNQSHRBMU5Vc1NsbVhl?=
 =?utf-8?B?ZElQaE9MUWFLTTBTZ3lIeDVub0ZEVzhsMmRXMlEwcEIzQUJjM3FFN21pd2Zx?=
 =?utf-8?B?cDEyQ0hzdTV3SG0vOVg1VnE5UExFaFJFdzJZelpMM3YwN3EzRkVkWlNCU201?=
 =?utf-8?B?VVVLRUNZOWVLN0wrSGVDR1pLaU5jcFlaMFc1dzh0UitFV0pyaHB1WitEWGFO?=
 =?utf-8?B?NjZRckpPUVE4WGg4d0hhZjhuRXFBQWVFWmlLNTJqS0RzQ0VMQWR5SjZNL1li?=
 =?utf-8?B?Vkd4dXQzQlVvQlQ1REhPZ1dib3l2bWJ5N1QvcW9XMDZvNEpvcEIxVjBsdUdj?=
 =?utf-8?B?RFhCVWZVVDMwVDlQNWJiR21MU1pLK0c3QmoxUXpDOEs5b2JrSzdhRFJLWitQ?=
 =?utf-8?B?SURoOFMyL0FFS3RtQ2lxSXcyRFZJRVJHR3p4dm1keS9PclJoa0hLaUp6ZGlx?=
 =?utf-8?B?a2FrTFpiK2I5bjY3MXd1NTNxV3F6Qm5RdEc3WXZTaGhWU0NTSmU4Ry9xMWtH?=
 =?utf-8?B?RVQ2SVNpM0E0UGkrdlhJQ3IxdlhUK1JuSmloK01iU2pvTGJaeVl2R0JXTHJL?=
 =?utf-8?B?dHYyOTNWeHJBRExFakM2cXVyMzJHZTZtdVVtTW1hcDBVZTdGMXZ5YjR2UVBQ?=
 =?utf-8?B?WDRPS0tXT2RyYVE2L2ZyQkdYK3pja0R4TG5nTEJneEQ2ZW9Qb3FybGpHNVJm?=
 =?utf-8?B?dGFBOFYzYThoNk9GTXp2TzZzV0xxSjFBcktnZWs0MEkvUXUySHN1YlhBT2xG?=
 =?utf-8?B?UlR2eGFZQjBnYkx3R05HZDdINjJNa2JnNVdHVHZxcDlGUTRubzJtemQwaWl2?=
 =?utf-8?B?Q3BBMUx1eldDdGl3TlVSdk4wRW5oZjZ5SmRvc3RFRkQveElVOFVLVnU3djhN?=
 =?utf-8?B?dDV3Ny9SeTVmZ3JOcDJUTUhlN0N0UFkrb3hrc05uUGpTaThFVlRadHR0bllz?=
 =?utf-8?B?YnNIQVJHa2cvMytjUEN1eER3WTFxWEN2ME9hK1pDcFRZRlpDVDJEdC9YbURY?=
 =?utf-8?B?Y0ZJTmtyODVSVy9tRGVXK3NXRDZBVWhEdXhTMDRSTmo2dDlJbnFiRDA2Wi80?=
 =?utf-8?B?YS9nMkJMRm80cU1EbDlMUkdWN01LWFJWdmIrbGtZTzNGc0dJZWZ1V1haUVlj?=
 =?utf-8?Q?cFje1zWwrsRaCGw3sHNNpLMZ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e3053a-c734-4213-84e8-08dd45f659cf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:04:12.9399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4ao0eCm7ORuyYwNscUILJhG1ZU+vhVwAsBO1hFJm3CuTbBn9huSqvxuT/KVFrfJIx4+sNsRK5qLdOzB9DX3gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

--------------fJdWYJGnT9dhx1Ul8kbOMm4y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Pass the vcn instance structure to these functions rather
> than adev and the instance number.
>
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 111 ++++++++++++++----------
>   1 file changed, 64 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index c3a2826a59631..295f39b2222d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -385,13 +385,14 @@ static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_5_mc_resume - memory controller programming
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v4_0_5_mc_resume(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_5_mc_resume(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t offset, size;
>   	const struct common_firmware_header *hdr;
>   
> @@ -445,14 +446,16 @@ static void vcn_v4_0_5_mc_resume(struct amdgpu_device *adev, int inst)
>   /**
>    * vcn_v4_0_5_mc_resume_dpg_mode - memory controller programming for dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Let the VCN memory controller know it's offsets with dpg mode
>    */
> -static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					  bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t offset, size;
>   	const struct common_firmware_header *hdr;
>   
> @@ -559,13 +562,14 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
>   /**
>    * vcn_v4_0_5_disable_static_power_gating - disable VCN static power gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Disable static power gating for VCN block
>    */
> -static void vcn_v4_0_5_disable_static_power_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_5_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data = 0;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -618,13 +622,14 @@ static void vcn_v4_0_5_disable_static_power_gating(struct amdgpu_device *adev, i
>   /**
>    * vcn_v4_0_5_enable_static_power_gating - enable VCN static power gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Enable static power gating for VCN block
>    */
> -static void vcn_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_5_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -660,13 +665,14 @@ static void vcn_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev, in
>   /**
>    * vcn_v4_0_5_disable_clock_gating - disable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v4_0_5_disable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_5_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> @@ -771,16 +777,18 @@ static void vcn_v4_0_5_disable_clock_gating(struct amdgpu_device *adev, int inst
>   /**
>    * vcn_v4_0_5_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    * @sram_sel: sram select
> - * @inst_idx: instance number index
>    * @indirect: indirectly write sram
>    *
>    * Disable clock gating for VCN block with dpg mode
>    */
> -static void vcn_v4_0_5_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
> -		int inst_idx, uint8_t indirect)
> +static void vcn_v4_0_5_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +						     uint8_t sram_sel,
> +						     uint8_t indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t reg_data = 0;
>   
>   	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> @@ -828,13 +836,14 @@ static void vcn_v4_0_5_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   /**
>    * vcn_v4_0_5_enable_clock_gating - enable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v4_0_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v4_0_5_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> @@ -887,14 +896,16 @@ static void vcn_v4_0_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
>   /**
>    * vcn_v4_0_5_start_dpg_mode - VCN start with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Start VCN block with dpg mode
>    */
> -static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> @@ -913,7 +924,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   					(uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
>   
>   	/* enable clock gating */
> -	vcn_v4_0_5_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
> +	vcn_v4_0_5_disable_clock_gating_dpg_mode(vinst, 0, indirect);
>   
>   	/* enable VCPU clock */
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
> @@ -961,7 +972,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
>   
> -	vcn_v4_0_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
> +	vcn_v4_0_5_mc_resume_dpg_mode(vinst, indirect);
>   
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
> @@ -1014,13 +1025,14 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   /**
>    * vcn_v4_0_5_start - VCN start
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to start
> + * @vinst: VCN instance
>    *
>    * Start VCN block
>    */
> -static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
> +static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> @@ -1035,17 +1047,17 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
>   	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
> +		return vcn_v4_0_5_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
>   
>   	/* disable VCN power gating */
> -	vcn_v4_0_5_disable_static_power_gating(adev, i);
> +	vcn_v4_0_5_disable_static_power_gating(vinst);
>   
>   	/* set VCN status busy */
>   	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>   	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
>   
>   	/* SW clock gating */
> -	vcn_v4_0_5_disable_clock_gating(adev, i);
> +	vcn_v4_0_5_disable_clock_gating(vinst);
>   
>   	/* enable VCPU clock */
>   	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> @@ -1098,7 +1110,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
>   		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>   
> -	vcn_v4_0_5_mc_resume(adev, i);
> +	vcn_v4_0_5_mc_resume(vinst);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> @@ -1194,13 +1206,14 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
>   /**
>    * vcn_v4_0_5_stop_dpg_mode - VCN stop with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    *
>    * Stop VCN block with dpg mode
>    */
> -static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
> +static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t tmp;
>   
>   	/* Wait for power status to be 1 */
> @@ -1222,13 +1235,14 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   /**
>    * vcn_v4_0_5_stop - VCN stop
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to stop
> + * @vinst: VCN instance
>    *
>    * Stop VCN block
>    */
> -static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
> +static int vcn_v4_0_5_stop(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	uint32_t tmp;
>   	int r = 0;
> @@ -1240,7 +1254,7 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
>   	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		vcn_v4_0_5_stop_dpg_mode(adev, i);
> +		vcn_v4_0_5_stop_dpg_mode(vinst);
>   		return 0;
>   	}
>   
> @@ -1293,10 +1307,10 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
>   	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
>   
>   	/* apply HW clock gating */
> -	vcn_v4_0_5_enable_clock_gating(adev, i);
> +	vcn_v4_0_5_enable_clock_gating(vinst);
>   
>   	/* enable VCN power gating */
> -	vcn_v4_0_5_enable_static_power_gating(adev, i);
> +	vcn_v4_0_5_enable_static_power_gating(vinst);
>   
>   	if (adev->pm.dpm_enabled)
>   		amdgpu_dpm_enable_vcn(adev, false, i);
> @@ -1526,15 +1540,17 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	int i;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
> +
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
>   		if (enable) {
>   			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
>   				return -EBUSY;
> -			vcn_v4_0_5_enable_clock_gating(adev, i);
> +			vcn_v4_0_5_enable_clock_gating(vinst);
>   		} else {
> -			vcn_v4_0_5_disable_clock_gating(adev, i);
> +			vcn_v4_0_5_disable_clock_gating(vinst);
>   		}
>   	}
>   
> @@ -1546,15 +1562,16 @@ static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
>   						 int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   	int ret = 0;
>   
>   	if (state == adev->vcn.inst[i].cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_5_stop(adev, i);
> +		ret = vcn_v4_0_5_stop(vinst);
>   	else
> -		ret = vcn_v4_0_5_start(adev, i);
> +		ret = vcn_v4_0_5_start(vinst);
>   
>   	if (!ret)
>   		adev->vcn.inst[i].cur_state = state;
--------------fJdWYJGnT9dhx1Ul8kbOMm4y
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-19-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev-&gt;vcn.inst[].

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="markpsh7afcgm" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-19-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 111 ++++++++++++++----------
 1 file changed, 64 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index c3a2826a59631..295f39b2222d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -385,13 +385,14 @@ static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_5_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v4_0_5_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -445,14 +446,16 @@ static void vcn_v4_0_5_mc_resume(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v4_0_5_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -559,13 +562,14 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 /**
  * vcn_v4_0_5_disable_static_power_gating - disable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable static power gating for VCN block
  */
-static void vcn_v4_0_5_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data = 0;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -618,13 +622,14 @@ static void vcn_v4_0_5_disable_static_power_gating(struct amdgpu_device *adev, i
 /**
  * vcn_v4_0_5_enable_static_power_gating - enable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable static power gating for VCN block
  */
-static void vcn_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -660,13 +665,14 @@ static void vcn_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev, in
 /**
  * vcn_v4_0_5_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v4_0_5_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
@@ -771,16 +777,18 @@ static void vcn_v4_0_5_disable_clock_gating(struct amdgpu_device *adev, int inst
 /**
  * vcn_v4_0_5_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  * @sram_sel: sram select
- * @inst_idx: instance number index
  * @indirect: indirectly write sram
  *
  * Disable clock gating for VCN block with dpg mode
  */
-static void vcn_v4_0_5_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
-		int inst_idx, uint8_t indirect)
+static void vcn_v4_0_5_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+						     uint8_t sram_sel,
+						     uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t reg_data = 0;
 
 	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
@@ -828,13 +836,14 @@ static void vcn_v4_0_5_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v4_0_5_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v4_0_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_5_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
@@ -887,14 +896,16 @@ static void vcn_v4_0_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v4_0_5_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev-&gt;vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -913,7 +924,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 					(uint32_t *)adev-&gt;vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v4_0_5_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v4_0_5_disable_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -961,7 +972,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		 (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v4_0_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v4_0_5_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -1014,13 +1025,14 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 /**
  * vcn_v4_0_5_start - VCN start
  *
- * @adev: amdgpu_device pointer
- * @i: instance to start
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -1035,17 +1047,17 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_5_start_dpg_mode(adev, i, adev-&gt;vcn.inst[i].indirect_sram);
+		return vcn_v4_0_5_start_dpg_mode(vinst, adev-&gt;vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v4_0_5_disable_static_power_gating(adev, i);
+	vcn_v4_0_5_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
 
 	/* SW clock gating */
-	vcn_v4_0_5_disable_clock_gating(adev, i);
+	vcn_v4_0_5_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
@@ -1098,7 +1110,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
 		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v4_0_5_mc_resume(adev, i);
+	vcn_v4_0_5_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
@@ -1194,13 +1206,14 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
 /**
  * vcn_v4_0_5_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t tmp;
 
 	/* Wait for power status to be 1 */
@@ -1222,13 +1235,14 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v4_0_5_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
- * @i: instance to stop
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_5_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
@@ -1240,7 +1254,7 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
 	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v4_0_5_stop_dpg_mode(adev, i);
+		vcn_v4_0_5_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1293,10 +1307,10 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v4_0_5_enable_clock_gating(adev, i);
+	vcn_v4_0_5_enable_clock_gating(vinst);
 
 	/* enable VCN power gating */
-	vcn_v4_0_5_enable_static_power_gating(adev, i);
+	vcn_v4_0_5_enable_static_power_gating(vinst);
 
 	if (adev-&gt;pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -1526,15 +1540,17 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
+
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v4_0_5_enable_clock_gating(adev, i);
+			vcn_v4_0_5_enable_clock_gating(vinst);
 		} else {
-			vcn_v4_0_5_disable_clock_gating(adev, i);
+			vcn_v4_0_5_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1546,15 +1562,16 @@ static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
 	int ret = 0;
 
 	if (state == adev-&gt;vcn.inst[i].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_5_stop(adev, i);
+		ret = vcn_v4_0_5_stop(vinst);
 	else
-		ret = vcn_v4_0_5_start(adev, i);
+		ret = vcn_v4_0_5_start(vinst);
 
 	if (!ret)
 		adev-&gt;vcn.inst[i].cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------fJdWYJGnT9dhx1Ul8kbOMm4y--
