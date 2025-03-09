Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7286FC28B28
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Mar 2025 21:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD8210E36A;
	Sun,  9 Mar 2025 21:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YM0o8r46";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBD910E36A
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Mar 2025 21:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usgq7PUQdnrAx5OPG0gm3/39cdsa8ZQGLiV7hbyuUQIfq/13GrUDkDr7vQxiWeDANjuixBe5GRLEnJd6u+5Mbm+GwHIHxbwoz0/193UU2+9D2Wdqpjn+HA6tQqAxMiJ+ev2Cm4wgsLIIkJ1S8Pw6rHW8WyI/uLvnlTxmCBhB0mq40icgaIFZBbUQLRwi/0XW9EZQijOLbLhgDKVSunG3Vxh935UC/npWmlp45JmlMvMp0ZGkI0od3vbPlMBpgZi/S7Pk8SkjutX8eyishpZMmBAuVBc1+c9xtkOvBvGdP91SN8qikfsutmhndSexPzirwQVVnafvbbmXCDtomI/qOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCa9xi5xb/SPX9oJu+d6a6kInfkqaWDa2g6rBt7J1SM=;
 b=gc1q3/M1doOINCaqvyS7wvkFc7AbZQ+RHO4BExLXFxLHerSqriwGVe5YsiYZOyIoiKfQjkUlyDCybN47GDLu4E5Fp9THTqrf122XQj/LrWj6dqs/R/X+ZvHKjED2HZfqm1OvGFQLHqesRpxat96zwT9hbFMSTfJHu1UqlbP5vF06aCipuEU7yJ7xetFySY/U6jC4YHXzRZafDalLAOT8vib5tBexllMg2Ed2d9Z4xZt1TXOztt0N7iRUZ6Idh43k7QvLwmnVjU2k1aMefYdgS7h+CDP5tLrj+v0xFNUPG8UxNsmvh85vDc+v43i5rQDGYYIbVWIf9kmM0qNoQwFFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCa9xi5xb/SPX9oJu+d6a6kInfkqaWDa2g6rBt7J1SM=;
 b=YM0o8r46RXR//TluLtziIi4u2Hg4JFGA9Gcz+6lmn8f6B2gZFesUDEsNsODumJ9C7Hfgoc+H4qWs9wjtLFvXtkHiI5JwxH0GKnm42qqteX62Wo0IG6sWHWCBXGX0ptcr2aVNsJsyKDN7Gc8EvzUnkMllQPzNcUQBwESkDdYitkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 21:20:53 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 21:20:53 +0000
Content-Type: multipart/alternative;
 boundary="------------bnPu7AJs2o0AYKP4UWl8xh6p"
Message-ID: <c5e6bdb7-f383-4121-a21c-9004b2f9a2fd@amd.com>
Date: Sun, 9 Mar 2025 17:20:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vce2: fix ip block reference
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20250309163147.2271337-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250309163147.2271337-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR0101CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::34) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5eeb62-0f9d-475b-0db0-08dd5f5045de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXAyUkpiaG5YcHRpcmlsWE5udUZ5RlUxb3B2cmdXQWp1MnA5S1JEQ1RFYnNS?=
 =?utf-8?B?TEZoUWVVaHZvM3YrVkxnSkcxbFBMd3lFdE1lU3pzbGhYeXFSREh4YXZzRkw5?=
 =?utf-8?B?Zjd2Ym44OGovRjNJcjN1M0ZwWk9jZE1CQU9DY0RuRXh3enZkNzdrK0pqU2NP?=
 =?utf-8?B?eHcxbWljY2hZS2l2NXMwd3pUYUttT2lqTGFrWHptYXQ5d3d5N1RUVXdlMlpS?=
 =?utf-8?B?TEcxdGN3WWQxeEdEcEVHRUJVR1VBMzlFN3BGQ2JneDhLeE0wc3pGeWhlUnFV?=
 =?utf-8?B?OWVacWFYZk10SXNlczdvcU9yc1ZPbUdwelRZbU9ncHhLWUtIQm1MNXh3STRj?=
 =?utf-8?B?ditGZHVzSDhwVlJpWS90MU5nOS85a2gxd045Y1VrTHZ4MjZFcTduVVRldlE0?=
 =?utf-8?B?U05ab05Ra2NCMFNwNmlTbE9oRWZzQlp4ZnlNSGM1NGlBMW5GRjdoRlZnVXZn?=
 =?utf-8?B?eW9SZWJTOHRqNGNsVWlMT2hBK214N2VCL2hhU3lVWVBxQmc2RVAxK1V5NHN0?=
 =?utf-8?B?cWl1bXJsK0djcDM5WlBKcmJLajFuZzBVRUJpNUh0UW5RK1kva2Jza3ZuQlBi?=
 =?utf-8?B?SVR4b0xzRVBnR1hBTXlDeGRIamFFL1dsNjg0Y1pKc0sxSEgxbTcrUHdYNmd3?=
 =?utf-8?B?L2Z6YThUVlZWVkJvd1VEMlhyWUo5cHFFajNJVGNSa3gxSzlBNmFBUERFdjFo?=
 =?utf-8?B?QU1NeTdMaytwbE5zNGhRckg4QWhQK3hMYjhrb2JUTnhpaVY2UW0wLzRQOXp0?=
 =?utf-8?B?R090QzBibUFBM3c5NzM3ejJLNW9taDFUZUJDVWpBa0VLOEtrSDZHNlpzMVNE?=
 =?utf-8?B?d25GSmJMc0ROa2lBMm9Xcm9YVmxrZ0U3L0tiS2ZHQ2k1MjlVSHU5OEhHT1lL?=
 =?utf-8?B?UUhjemVwTGV4NWZiVHZIaTdJVUwremxDcjI0ZWJnZW5JTnlsWFBmNkZBQ0VB?=
 =?utf-8?B?aEM3OFE2bWRGb0pMNFkzNWhDK2ZqUUJLYnVVRWRxOFRpZ3V1ZVJsWUc3WUls?=
 =?utf-8?B?ZmdsVDBvRFRzNnZFVENXN0RybldpblRrTVR6NWgwbm9uSURrbWxEbnpHVGNI?=
 =?utf-8?B?WFc5YWE5SWwxcWhTT3lzQnRCd0lZbTUwZ3A0cjFPTTRWWDgvQkM1dUNmYmxq?=
 =?utf-8?B?bzdRN1phT1NzVGV5UEhpM25ldFNTZHVNTXI4M09aY2VacmJQeitqNTBYbXhk?=
 =?utf-8?B?ZUw3TDdMY1B0eFdpY1pmZGdORVRJNUlyVVRIMGsybEJtQ0sycEhQMXV1N2tE?=
 =?utf-8?B?T2F3djJGcXlYUlJqR04yQzhXSlVZSWEzSUlLTmVFMDhEUzl1dXFMeHQ5cXJ5?=
 =?utf-8?B?UndVS1ZCVFVrNnY0OE5VSnV4cGp2UzNNSjBlajlPMmN3aHBQNVc5Z21JSXpt?=
 =?utf-8?B?SWFOaWNsc0EreFVCNXN2eXlMMVpqaDZPL3BHTDVNMGliRjlVQXhLNUg2NWsv?=
 =?utf-8?B?N0kxb0ZJL2lBS05lMit2SGtSTHd2VkxSZDE2Y0doQ0lhWXBxNi9BRUp6VkI3?=
 =?utf-8?B?dDhPTFdmZDQyZk1wVThlcmZDL2VrekU1ZHJWTnc2NVRMVXNSZGJJK3ZOZkxn?=
 =?utf-8?B?WTFESnBrdzRUQ3VRdGV2Y0hiQ3F0MGVpU2ZiazVWeFlGcmtESzB1RGtKOXVo?=
 =?utf-8?B?aTcvZU5lUG4xUFA4cFpJOHQrT0J0NEtmalRuWTlKSFRrem0zZHdqR1FydHQy?=
 =?utf-8?B?eHRvWmd0UzYwU010WVhXUU54QlMrNTROdWt5K1k2cGRpalk5bmp0NWhrN3Ey?=
 =?utf-8?Q?tdJBJuv/Aofl5APy8c52BPMXVvKVEw6Kg/qUCj4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dXaVJINTVGQUgvWFBmd2RsazhBSjh0bG5Wb3BtY0JUSURDK1NyRG5sNE05?=
 =?utf-8?B?SXU5anc0VU9RbzhnOHdSaEF2TGw3SXdmSnk1Uk1QSUc1bml5bjdWUEpsVzlC?=
 =?utf-8?B?amVjVS9NeEFzUEtjYUpDMWp2anFmNXpYUGc1Q2FOUGxlK0s2ZTJBMWdlK0Rm?=
 =?utf-8?B?QlpnbHoyaFloQTJOZklaV0YyQlRFTzM0MWtaQ2NtQ1FWMFlLYkVNcUVjQzUw?=
 =?utf-8?B?bk9jaHd2bE1NR3FLR1RRbG1ndFlReENQSG9QUnhQd0FRNEJSaDRzQnR5dXJv?=
 =?utf-8?B?Zy9CM3ZiMDk4Q0sycnVtWDdVZGZMRXkvM3RVa1BmUThDcFVrWS9LZWJ1MDVI?=
 =?utf-8?B?NGFnL3dTcnhyMXk1REtVOVVxWE1tVklUZC9aZGd1aFE0b1NnYnNWT3RiU3ZL?=
 =?utf-8?B?cXF0YStRbnNTNk85d2pvdFh0WEdYYW8vVC9qakNOYVFwWHJMMUFIK0lnVlRt?=
 =?utf-8?B?R3pkUGdwMmRYRkpxR2RPY01XSnpkb082b2M0amxqVWVLS0ZKK0l2VVJCeUVi?=
 =?utf-8?B?NUExRkQ5TkM3UHdBQVNpNk10V2QyQUJWNUZNSGNLb0pXVE0wMXhoamVLSm9z?=
 =?utf-8?B?Vkh1dWVNMGdHdTZWSERxbDgzNldiaDdOeHE2SlYxWHpxVll0bEZFS0plazRE?=
 =?utf-8?B?ZHN4SmUxTmd2NUk0U2lNcWUxYmNRbE1TMm9xOG9NVEMzQVFTb3hMclpvekNs?=
 =?utf-8?B?amlNaVNwRUNLeExEQmg3QWE3bFhrSHRqVjVSYXJSZHkyMEE3RGhDZksxUmdj?=
 =?utf-8?B?Nzd5NE02cEpsOE1iMXZOM1p4QWRrcU9COXFkbGpMWDBsMFlqNmFYMWhlankr?=
 =?utf-8?B?MWFxcEl4KzlGZXd5UTFsQTdYZXg3d1ZHYTNJSXg3dEMrKzAyRmFtWWRKcUpD?=
 =?utf-8?B?RCt2bkZCaHNyNlJ0cFNQK1NqNldRY0NnWUk3czJOb1g3VUY2UXpMWEtBQnFS?=
 =?utf-8?B?bnZtU3JhVWFleE4xRnNqUjZBYzRNSDFKNTFaNUpHSmRDcXM3TG1EWTBzSHl3?=
 =?utf-8?B?R0FXenc4bGllWGVtWmtmUVFTclBqVEk3Sk15WjJsMXBzWVpsWG1UcXlMQnUy?=
 =?utf-8?B?d1l5dnk3Y0ExcFRSek5xU1pNcUxxL0JYdjlFR0NxcmxzOGxHYmVLeTJQNGcy?=
 =?utf-8?B?YnhuaHp5UVo4RmJVK2hYUUJmNXUvQWUyWUNTS3YxSkVCU0dSV3p0dmFEK1hz?=
 =?utf-8?B?MWJpblllYU9TVUdxWDNhWWhFWThjUkxvZk9lcmFMbkMwMXlIWE5SZnV2K28x?=
 =?utf-8?B?NWhqMExWVXNoVFZUTVY2NmorTGU5cTdicjRtd3ZrNXQwQ2IzY0RXR2ZJUnJ4?=
 =?utf-8?B?NXlqcERhSTV4YVVjVUR0dWtHRTFCWCtvaElSU3UxbFdpa2hsL1c2aVlzbkpt?=
 =?utf-8?B?Um1RaUJvSUNBWW1UR2xrSzFKemppUk5XY3ZiL2JrbG1WRlpkRGl6MnJORCtx?=
 =?utf-8?B?ZEttcFJXVDRXQytTUnRlRnpBVUdkMDhrMGQzTWw4NlZCaEdrK2UzWEE1aSsz?=
 =?utf-8?B?emFaU1hlT1pRamV0VHdIbko0WjlLcUVSTHFXRmRjMXpIS3l0aVd3YU1zdEpI?=
 =?utf-8?B?eTcvREFWT01SeWNVcmxiSTJNWnlJcUZkS0JQZkNid2VIc0ZlOGtJSy9VTWZR?=
 =?utf-8?B?OEk4bThhTGxrQ2dkNjBoOW04QmJHM244NlExTEZDbkFhUnBPYitJM1d4OWNN?=
 =?utf-8?B?QlJkbDY2bzVUR2ZDbVdneVI0d0RYMnIwYWx0Q0psZEVCZFhhWnB0em5MS3NE?=
 =?utf-8?B?SGh0aXdsMmFPT1NhUUVkUkt6OVBlRW1pRm4wQ1dnVUhhMWl3U1VXMVVxM0ZW?=
 =?utf-8?B?YTNMY2hNSW9WWGh5eGlLS1R6Y2tuM2RjQUVzYVg0eHNZMmxjbnFqN09SeFNQ?=
 =?utf-8?B?dTlUOGl0WDlOd2dUZytGU1NodzNIbXFxU0lEWkdtSW1NUEJvSVNLc2pvUDZY?=
 =?utf-8?B?QW9VTlp0MjVBNGlmWWZuY1BxUkd5VEx1L3lod1ZnakxJeVBIYVlwc2RES0Zs?=
 =?utf-8?B?VUt6QlJFbVExblFpMUpFVXdpUkZWbTIvZ2FLaUYzeWNFVTh3WVllTkNFTkNE?=
 =?utf-8?B?bTc4U3Q3R3lsNUVXYXE4dlVTYlVrclp1dHJON2lwVTZFVU41SDkrQTUxbERI?=
 =?utf-8?Q?maM6+By5MqS3Yzv1/6evFMqni?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5eeb62-0f9d-475b-0db0-08dd5f5045de
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 21:20:53.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/U6dpGblBm3xs6dYoLa+oxVB0ay1oWV3ThB0XMcU7m/aRPN9+LmNegYlOh61dfaI/XnOk3+dkzS4CGD3qZVVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
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

--------------bnPu7AJs2o0AYKP4UWl8xh6p
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-03-09 12:31, Alex Deucher wrote:
> Need to use the correct IP block type.  VCE vs VCN.
> Fixes mclk issues on Hawaii.
>
> Suggested by selendym.
>
> Fixes: 82ae6619a450a ("drm/amdgpu: update the handle ptr in wait_for_idle")
> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3997
> Cc: Sunil Khatri<sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 8c8c02606d25a..bee3e904a6bc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -284,7 +284,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
>   		return 0;
>   	}
>   
> -	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCN);
> +	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE);
>   	if (!ip_block)
>   		return -EINVAL;
>   
--------------bnPu7AJs2o0AYKP4UWl8xh6p
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-03-09 12:31, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250309163147.2271337-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Need to use the correct IP block type.  VCE vs VCN.
Fixes mclk issues on Hawaii.

Suggested by selendym.

Fixes: 82ae6619a450a (&quot;drm/amdgpu: update the handle ptr in wait_for_idle&quot;)
Closes: <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/3997">https://gitlab.freedesktop.org/drm/amd/-/issues/3997</a>
Cc: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><span style="color:black;font-size:11pt;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;"><span data-markjs="true" class="mark2l17gh44q" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span>: Boyuan
        Zhang <a style="margin-top:0;margin-bottom:0;" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="0" id="LPlnkOWAe9ae1d9d-ee89-4485-f7c4-71ccfa2343b8" href="mailto:Boyuan.Zhang@amd.com">&lt;Boyuan.Zhang@amd.com&gt;</a></span></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250309163147.2271337-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 8c8c02606d25a..bee3e904a6bc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -284,7 +284,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCN);
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE);
 	if (!ip_block)
 		return -EINVAL;
 
</pre>
    </blockquote>
  </body>
</html>

--------------bnPu7AJs2o0AYKP4UWl8xh6p--
