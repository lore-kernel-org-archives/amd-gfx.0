Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2DEC61DF7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 15:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8AB10E08A;
	Thu, 23 Nov 2023 15:09:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D0610E08A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 15:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMEZoWgajW8Im4wnbXxPguMTo1csW+/NOvs9tKSumj/6B1Gc7vNvkh8htkjhm/y+AYytS1BmKrtldvXV7pqwPvAwx1qAvhyKPsHa7hWY07mVJzdn3o0ax+D8kSo62xuefPu7F3HztzCNj4fibIh9DgCerKXW3rQKi5QPxl0yB8W1/9fY3jNirAQYyGBILA6vwDnXxx09ALTN7XXbAO3wM/khCtn7ACH8UvY27mCbz8/jSQ6pQkwZ0KYS/nMGY88BTYLJwKW/jLT1/zXqR8DO6SCHp6HfK9GNZocSUCFfwU5horXx1NMU6Z/vYHM/YC2ByE/UweYdRVPKBcsASqMlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iux0VowswYnVMc+D3O2j3Gi4deCp0Ml4eq5DniJ8U3Q=;
 b=GFvDDQNN/iGIPK9AumOX1f4d54IP7JEr8lZV3cThTkuLM2Nj7QWCBPrDblueNvSwgacXpKKMucLgrB0DmUmkLfQNG5Nsr5Qx5bq559S8fOnppo0qQka2cg80jEXxy07s07WFfyHhbc6u/bIRCIZXGrdxVJBUjacqsrGzYx1D//YI0JKWJQzFbZwa07a66zTT+OtBM3ZvG7vE31ffxK2qpNjr2A/RGYvG9TT1liR8FLFwRFgDlDevsKBsKBY/uQkC8ou7XUbjfRhJPTzOmr7vWnX7C1e3QzKnHcFEj2G2RHUWGRAHM1qPWn09suz2oIH+cuSc+fub2WKOqerc2vcaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iux0VowswYnVMc+D3O2j3Gi4deCp0Ml4eq5DniJ8U3Q=;
 b=WfVFX5fYTPkpdw7pe+M0NYLGHg+PskXtVVaYjx+Dsw0AYdN9HXTvXuLMJrfH3cS8yAlGwAtPRbcinWYh1Hh57Vg1jlh6pIa31xsXgemodfi5mI1gUljYDoMeRgcPJ1nOBPS7zVpx4x3P6thGAfrbgF8vsIz2uB/XnA5FUd8t2pA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 15:09:22 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368%6]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 15:09:22 +0000
Message-ID: <3f87a3dc-309a-4ce2-a56b-9acf78dc551a@amd.com>
Date: Thu, 23 Nov 2023 10:09:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix ABM disablement
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231122222409.53901-1-hamza.mahfooz@amd.com>
 <CH0PR12MB5284EF0EE7874354B444BC6C8BBAA@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <CH0PR12MB5284EF0EE7874354B444BC6C8BBAA@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0035.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::37) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: c1670c24-9925-4118-4217-08dbec362c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMVTrCs3din6DRY4/nQAevLHzjrB6zDWOnvgEsm7EeFksmdk08Ht1o+3ZK9P/Y6ieX5gqRS/7EmI19UlGZ5lG0V25ZSOQGa4O1CqXztNxpLp+eCao1BH69soM780kA46Zdn02+RlMFts2/ttwTsqI9RXDVAYokkgbjUYeuI/pneaqPiDafattpFmjMfS3QoepgNrfvXR6KpybQRIQMj26JuPGL8P8+iiOaxckdsMhxy0F/U0QuZS9ZhPIGiQ4X65BSuuLmlN6UzYPdHd35vDB0K1UDCdee0WSFc+IVDUpIGun4R90DhH9kf54sB3YHc3S5F2dxYxHlSzAnhO09f2aFqNFdLXkbWD984/S6gcwx28vYOYrVAAz37ByPtJ0vqN67ZWMOC5E0rvsnULuZwOV43tOWs8q9s+sEr25W5/Fl9Y3wcirOoDiOETQh2K03YlMB91G4t1jcoJcOoyKpMv61w8KXZcRVjNhv6gZLcbJuMUsaQNAPBe3eoZtJceXTZahKW/Dps4GsjXSG/TpYCUWH+UsuGZPGvN7ci250UFns5Z8o5e/USMDh9Vvt7smsdi57pBuZ2srQwYCWLk7wkm0RCO+eE1gquXInbpZx2gH4xJzdM8VBig2KQ/X4pinmPB3tDSgJTwikVWrKDBrrvIMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(38100700002)(86362001)(36756003)(31696002)(66946007)(8936002)(8676002)(4326008)(66476007)(316002)(66556008)(54906003)(41300700001)(110136005)(5660300002)(2906002)(44832011)(31686004)(53546011)(6512007)(26005)(2616005)(6486002)(6666004)(478600001)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azNNNHlUOUVLSldXNDVodWwrSUJPSWh2MGdsd3VRcW1qWXpkZHdWUGpjM284?=
 =?utf-8?B?WFBJcmQ4ZzRod1diZXgrYktZVWxhZjcyWkloV2M4bDhaZlNPWDNoL3VnR1lB?=
 =?utf-8?B?TXNWSCt4M3lkYktqQ01yWXc2VzV3Z1ZKTWdGOGlEVlNQa2h6dDMwdWRBcmdu?=
 =?utf-8?B?dVdxaTdrTFdrRVNGQjdCWTM2L3ByUmhVemdUMXV0ajFlbFd1SFljeG5mYUVo?=
 =?utf-8?B?Sm50WGpTeVlUMFdlS1B6QTlLTzRGeXB6MEZ3OTJwZnltcHh5aFFUWHZrTzd4?=
 =?utf-8?B?NFYwNnZ1NXBGWVU0UTFJRzBma1crWXdPQXlvUFFHTllSazNnTVBmT0wxeWU1?=
 =?utf-8?B?M1dKRVlqWWlYdjd3algwSzk1V0d4SlFkeGVPNDNKblBBby9Jem5aNjkrM3NZ?=
 =?utf-8?B?bDVTNDVIY2xES0VlVDFPa21UR1MxMGw4OHRjMURmUWlNLzZhWG5CS0Y3QzFO?=
 =?utf-8?B?NFMrVkdxZGJiNlJpK0xXMG9GRGE5a25PUFdNTUpscFR1bnZKR1lMSm1vWW5W?=
 =?utf-8?B?d0YwVEJPYWt3bWlyeHYyRi9FMkNmeEJZTGNjS0pWaU8xNnZEVys3N2pRZ050?=
 =?utf-8?B?L2pjQkx2eXp3NVk2cUxaYWdBSmxEaTBRWENmMFp1M3AxYU1aek1vNHVZejMv?=
 =?utf-8?B?UTBicFQrMnpmL3U4SnVuL3ZiT1RJMmR6eDRCVndUaStUS2EyT2ZrS25rbVZh?=
 =?utf-8?B?aTV3RjFNYUlMR3R1WVg3ZVFNY1FlVC84THZtVWgzbHdVK05VYkxGUTRQSko1?=
 =?utf-8?B?ZFU2TEFEeHljdGw0ak82NGZHSzBqN1JiWjVsTzlJaURGbldMMkpqVTRrdTNW?=
 =?utf-8?B?REhXd3plMkhrZTE0VGRQbW1ETVl1MFFkY0JWQmlJSnZ6UjZKVnFqcFY3VCsy?=
 =?utf-8?B?WmYxQVRqU1RjYWtOUVkxNGw1b0VQb3lES29NWmlSbjFlODBGRDFicVNqdGlr?=
 =?utf-8?B?dmF3ZmRacHY4b0hsK3laeHBBZEIwckJUWFc4VlZkNXJqbU1SQzNTUWlLb1pI?=
 =?utf-8?B?Q0hvc0FoOWFzUGh4bkpQeXpHbkdvYkQ1TVVoWEo4VGY3R21xdVVReWl0ZytO?=
 =?utf-8?B?TzYvbTUraXFNNDlwSTgrUkNHV2tnNUExTlA5QkhXVGRnanh0S0VSRlhvSlBZ?=
 =?utf-8?B?U0k0RTJJWmhFQ1VhSUViNDZJN1dFblBjZWJZZGVVVmY3U0p6VlZmU2FRR1V3?=
 =?utf-8?B?VmwyVkljRHptU2lKR09XQUhoSnNOZzl2SlRub2FxRG5iYm9laEVBNHd1NFFB?=
 =?utf-8?B?ZXBZVHlZUlJFZk50eUtVZy8xSnpsaldETFdsdysrYXYwSVhZOFRUcHZXVkR2?=
 =?utf-8?B?ZkJVYWt3R2FyaFM0Q3VFL2NTNUhXakduaFZ3SmxwK0FuSFJYb2plak00Tlgz?=
 =?utf-8?B?cHBIQWNUS2xkSmFEZlV3Ymc2REthNEhPb3lRUlJEYWFTRzF6VGZlby84V0M0?=
 =?utf-8?B?R0o5TCsxZnBUVEdkSWNmNFhxWERFSEp0NE9sekNwcEFCZnF6eCs5RGxQbEhE?=
 =?utf-8?B?cndPTktoVE9qRWk3a3orbVJseVRCN3V6VHMyVUQ0S2JkUW5qWFFZemx6UUxx?=
 =?utf-8?B?WWVEc3NBRG9wZ0hQalpwSlNsQWplSXJ0czBEam5DVnNxbEs1djljL1EyT3dz?=
 =?utf-8?B?Z05PVDhPNEpXTDdISlQwWmJRcnN5NjdGMzZKbUFEbHNmcWJMbUl5VmozVjRY?=
 =?utf-8?B?QU9OSVRkSzdUbU5ocXhBb3VzNVpQRXhSTVBKbWE3ak1WYlp6TDltczNMV3k2?=
 =?utf-8?B?cWV3RUQvK281a0xicEZORURpaUh4QTVsNm9KQ2crSFRyNjY0OTZzQ0NkUmp2?=
 =?utf-8?B?eTNYcFpxS25RTWtMWU1DcXlJYmlMUS81bmtFM3M5eVdhNmxxUWx0OHBuUUFM?=
 =?utf-8?B?MWErRlRqRmJmbnRtRWMxSUVMK2NkeHVQend2eFY2Z21vOXJQMTZld3FGdjFI?=
 =?utf-8?B?YTdUYmhCZHZvNGg1eHdpTmVON092eTFlQUJtWmxGQitZeEo4RWJPWFJPV01Y?=
 =?utf-8?B?SWhzcHVqV3kySWQ5bUhHMmlDMHZJL3U5SjFDdFFaVVNxOGFpVUhUV0RKVTZE?=
 =?utf-8?B?RWJtRCtYNitFcGhMcXYxSUxqY1BmdzNCZVd2Y1c4Sm4wS0NnVnFSMTlxTzIw?=
 =?utf-8?Q?p/rTfLyDjsFuY3tSrcmRm2E8n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1670c24-9925-4118-4217-08dbec362c9c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:09:22.5533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI01ppXIhwwBeKESPq+cF37viN+pKW7qu7d4rmvUuGc7Awp/NcRXwVJllZOHYgqmgD0D1bKp1Q3vGxtXIkH9/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Wu,
 Hersen" <hersenxs.wu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/22/23 17:45, Pillai, Aurabindo wrote:
> [AMD Official Use Only - General]
> 
> 
> Does amdgpu_dm_connector_funcs_reset() get called on wakeup from suspend

According to my research/testing drm_connector's rest() callback only
gets called when the connector gets created.

> ?  Users would want the system to have the same brightness level before 
> suspending.
> 
> 
> --
> 
> Regards,
> Jay
> ------------------------------------------------------------------------
> *From:* Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
> *Sent:* Wednesday, November 22, 2023 5:24 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) 
> <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; 
> Koenig, Christian <Christian.Koenig@amd.com>; Hung, Alex 
> <Alex.Hung@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Wu, 
> Hersen <hersenxs.wu@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Mahfooz, 
> Hamza <Hamza.Mahfooz@amd.com>
> *Subject:* [PATCH] drm/amd/display: fix ABM disablement
> On recent versions of DMUB firmware, if we want to completely disable
> ABM we have to pass ABM_LEVEL_IMMEDIATE_DISABLE as the requested ABM
> level to DMUB. Otherwise, LCD eDP displays are unable to reach their
> maximum brightness levels. So, to fix this whenever the user requests an
> ABM level of 0 pass ABM_LEVEL_IMMEDIATE_DISABLE to DMUB instead. Also,
> to keep the user's experience consistent map ABM_LEVEL_IMMEDIATE_DISABLE
> to 0 when a user tries to read the requested ABM level.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5d9496db0ecb..8cb92d941cd9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6230,7 +6230,7 @@ int amdgpu_dm_connector_atomic_set_property(struct 
> drm_connector *connector,
>                   dm_new_state->underscan_enable = val;
>                   ret = 0;
>           } else if (property == adev->mode_info.abm_level_property) {
> -               dm_new_state->abm_level = val;
> +               dm_new_state->abm_level = val ?: 
> ABM_LEVEL_IMMEDIATE_DISABLE;
>                   ret = 0;
>           }
> 
> @@ -6275,7 +6275,8 @@ int amdgpu_dm_connector_atomic_get_property(struct 
> drm_connector *connector,
>                   *val = dm_state->underscan_enable;
>                   ret = 0;
>           } else if (property == adev->mode_info.abm_level_property) {
> -               *val = dm_state->abm_level;
> +               *val = (dm_state->abm_level != 
> ABM_LEVEL_IMMEDIATE_DISABLE) ?
> +                       dm_state->abm_level : 0;
>                   ret = 0;
>           }
> 
> @@ -6348,7 +6349,8 @@ void amdgpu_dm_connector_funcs_reset(struct 
> drm_connector *connector)
>                   state->pbn = 0;
> 
>                   if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
> -                       state->abm_level = amdgpu_dm_abm_level;
> +                       state->abm_level = amdgpu_dm_abm_level ?:
> +                               ABM_LEVEL_IMMEDIATE_DISABLE;
> 
>                   __drm_atomic_helper_connector_reset(connector, 
> &state->base);
>           }
> -- 
> 2.42.1
> 
-- 
Hamza

