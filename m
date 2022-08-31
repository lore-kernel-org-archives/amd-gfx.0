Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F241ECAAD5
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 21:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC58C10E464;
	Wed, 31 Aug 2022 21:42:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7441E10E464
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 21:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uo22wOzo7Lcf6cpcSQrHiZ1HjC9vwOcS193H+aKhJGvaH2UpEVCrehfVW8LmmiIUUlkTbKPPyDEd8rHTQvp6xLmuvd+XClH8dv3TcNKfBL+tG4HpWbv3JtDnAIcXFDxEGPVsXWusY8rvCYyPYluoFfFppNavbsMedVPHG3RDa9NWupM5ydFdq37OFfRAGY3YWUDEcBcy8YVhgCdxIGyomw1awEPtJMiS/1BqkM5E4wkJ+eKvEOtrFZnGjj0T8AUL04zU/qP8Uat98LRWHob7XFRSXJWC6eB/XfxF49zZsPg1mf12e2fHikjU0g206gW1NU9nqMt3si9H8Gap3XxgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZo8M6zM9o6SJGVpL62Hy1xnEoJn1mErvaHfVuf0s3E=;
 b=lri7tvaK0rIEZlELEd8chbsiwisnLL2DfCCEGQWr0Sywe5yu2fN7ZJyjdJMVhWbmW9sUPRdJDhwnXee9rBmg8Fn54RvNV4lNg6YwEYSgErEkX64BlTHDJGgXKq5CUgk4O60nCV0Uk4pKpd7j16w4izuypas3lMXGApG5zwh3I3XG/j3pcIR0aAUZcMZrpmpEYuTyCJewE3am1TdpJwotDmnCwnYsNe7So8KJ2UIi841PhNVjexSSbaRGrtINGhQGXpCeRlOqYdyTa9wbMxHrzB092alv4JtUaak5Ua3QMcNWOFIHVsQbqzpzFvaN65ER5JpN2jG2vETwdfvchhzzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZo8M6zM9o6SJGVpL62Hy1xnEoJn1mErvaHfVuf0s3E=;
 b=2FXTKEVdNT9QNiCRE1wwAz1PIG//cHZ9qlkUSnCq6ZN/QQoS8EPY9jn0Qo4vfATR4NOvXm9bBzlcO0d6qH+AkViKXvLcEPYu0jSK/boIVkO8cuyt3qj3gOU+7BThG1ZRfaU61KTw7WVjhR2sHmqJd++9lmTa+1H4arR9wKIRBiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 21:42:23 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588c:ac12:d318:bfee]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588c:ac12:d318:bfee%7]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 21:42:23 +0000
Message-ID: <99d71ce6-5ad2-9dbd-e1b7-e67d65dbceac@amd.com>
Date: Wed, 31 Aug 2022 17:42:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] drm/amd/display: fix documentation for
 amdgpu_dm_update_freesync_caps()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220830215752.26536-1-alexander.deucher@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220830215752.26536-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:610:57::29) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39c1be6a-59f0-4f0b-bb89-08da8b99b083
X-MS-TrafficTypeDiagnostic: CH2PR12MB4133:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNLjOV87jg16UkbQ96vhrpWOYxsRe7QDMvIor8M4kIeFKTABfisRIpjFBc2CFM+vxkYdpqJLmvuTvkyc/MB4TsO0/O4llwU/msmi4oCO07mOvaNTGXMrteMgc6fV++zehLn9z1Rk71dUTvuDH0aYwWd3WZRKHUJdC3A418Qwv0ExkHbQnV6XtrI37cWD60dACTExuahrj5kIlstQTl0yuVTTwdoD2G/ggFr6lqriEtd+3428QZDaQIwg7UAn69ssHcmXFy1iJxMNP0HJwf3Zgc5DG+Eil4uKgrCKVuZcOib3b9So1FCXvqPUtn+s44yWmlV9WC5iDGUNofhYd2bBR1Y2qbi29wRqfF69hcKACxgG9blT5Knuo7m5085aEX1zODSYtyV91g5qlERhU213en6zPZhJ1kszYkQIeUCzJY8Psciduqe29mCTVTfjl2qb5nNbQCyJP/hRUpwvXvpAP2zp0G+BJTQxwwcyd3r2imIodexkY+czgzwLSG5ptXMgL29uzUA01/7nu5XMVSgPx3Vv07SeT7A0/xmbCVvkO5aLwUIS0P5PmI+YTCbMelFOYzMcukz5m5pdw10rIo8oYKMii0L+AFK452h15OhYvWE2V+Ch/2INX4VmfTzM4VEtBqnABqVOtsbCJ50ynrpWiozkYh/gb3s4A5Qn1zGCKGhx3Hqf9hSS74ueTegMr6m0brRVOeHxnqh/0ABAxZikaL6D/X7MtP1gSQqb58XWmfGnlhrzoJDPXKqJ9G6ahbKcDErjEkck0bwFiLmHv8aaWXgpqbEzw6p8SzsIIrH6QUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(31686004)(316002)(38100700002)(186003)(86362001)(31696002)(54906003)(36756003)(2616005)(2906002)(83380400001)(53546011)(41300700001)(6486002)(8676002)(66556008)(66476007)(66946007)(478600001)(4326008)(8936002)(5660300002)(6506007)(6512007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVVsS0V3L3EvREdEYlpoaHdxMXJYMkt0alNybWVRYVVleWx3SlFucHR4N0Zo?=
 =?utf-8?B?V210MjFwSTZ6TXZKUFRzQmQ4bnd0Mnlwa1NoUUJVUHFINFJsbVpTTmUrdGNF?=
 =?utf-8?B?ZzBVNXV4Q3hxTWxnTEVsK0xVRHBkMmRuV3lsSWNhNWV5cDF0d203REZRMmJF?=
 =?utf-8?B?SFliUWdaRGR5Qys0d1h4T0dDV1FXa3dUbVJ0b3Fka1R5VmxoNWVpcTVHVFpI?=
 =?utf-8?B?b3h6OStGZ25Gc3Q1TlI2a20xR1Fra2NDV3JTVTdDN2FENzBVcEtpdHZxNjFy?=
 =?utf-8?B?WEpZdHlvTWY1NWFnRnRrQlZTY3Z0Mk5sZEhia1l4TmJtYlc0YmRQM0Q1bjdk?=
 =?utf-8?B?REcxTXNaNVZ6NGFxSnErMW5xLzJVcWxMV3RIckVNMFBWMzVzem5YSjhJMnBv?=
 =?utf-8?B?eWt5OVdMTnhMTEJWYllYSzZMeUcxZXBnT3dGYTI2ZDNOMUs2Y2NnYW5FcVVt?=
 =?utf-8?B?bWxFR05tK1Zib2dRNVVIdCs4c3djRyttdjRTTkM4TVgrNWliSTBCd1p0WVIz?=
 =?utf-8?B?NHJNVUFKZ2VDR0RlS1pYanRiL3hpNHUxc0sxaERGM3d6ZThoL2RoamlraEkv?=
 =?utf-8?B?K003UXlMRDJJeFZVWmNWbUVtVVNjYmgxYlVleFNBbE9vOXNaSzY0VFV4L0pR?=
 =?utf-8?B?b1pndzlCYkUwendrT0NpWFdtNFpKU0tnaXR6bWRCK3dPZTJBekhYTzlscUlT?=
 =?utf-8?B?SHpsSHJNRlVkV21sZzlyaFNXUWRDQk4yN3JiVDNqWWU4RGxhdE9xVmVpbUJ3?=
 =?utf-8?B?NThiUFMwazVkVTZ1ajFwK1hoQW1ERXFZNm5ZbVRUMU1oOXNNVnRDNGE2SDlk?=
 =?utf-8?B?VW9JZEFVcE15ODVKN0E5WkdtNld2d0UrbDFpcy91Q250emF6czcvT2Y1YjlR?=
 =?utf-8?B?Mlc5Yy8vbWdSUEo4T1c2Tml4Q3AwOUloVzMzcXVWUDZoNjN2SmN6UVY0QjhF?=
 =?utf-8?B?ODdiM2ZiQjA2QWZlMWlmMVZtWUJtek5QUEpHNXgwV0V2VE5UM1lsSnhlQjM3?=
 =?utf-8?B?UzBkSkMwY25oNGxKOHJWWjRHaEZaRmp1bXhuN2I1bk12bHFVNXZXeHBTeW52?=
 =?utf-8?B?ekZ4REZ3c1N3OXhjK3lkekM4MC9Fa3EzWGtvVWcxUGpCVHlaT0dzTElVVFg4?=
 =?utf-8?B?aTJ6VmExUkRTTXMxeWRqTmxwYWc2Z3hrLzV4RnhDOFUzSWdIeFpxUGdiQy9W?=
 =?utf-8?B?bXAyWDAxaDhoN2hiQkh3WGNKNFVxd3JPbWlhZ3FVL3l3Vkd5T1R4QkVsOThu?=
 =?utf-8?B?MTJKWU5GdkUvWEMxRkNwS1BHM2VENXhtcVJUU0ZXakhzcS9md1JmRTk0ckUx?=
 =?utf-8?B?Y2dLYzRuMFJiU3p2azBFK3hIczE2a3hBNEZtb2ljNlBieWUvNE5ZbytFVVRs?=
 =?utf-8?B?bmozZTlLWVArelNTM1hIQkt6cklFcUpWTjMxY1NmV2lSVDBWcGkxZHpIM1FK?=
 =?utf-8?B?WUtPam1zdHRkZ3V2V01zMzlZejI0OXU5ZlU3TkQ5Z3AyU0VSSHBWcmY3Zjkz?=
 =?utf-8?B?L0tMQ041VUg2c2RVWElYUy9haXhiMWdrMUpDbmZTMG9mcHRXZmRxSTNsVVZX?=
 =?utf-8?B?UEtjZ2pjN1ZRSzNnVWp3Y2xodTV1ZVg0R3lXMkE0ZmFpMkN2ZFFGSHRqV3Ay?=
 =?utf-8?B?NnI3ZTQyek5LczM4NithdG9CeVpsR3dxWlIycGtWYVp0WDlQVVo5Q1BKTy9s?=
 =?utf-8?B?bkx4emU0RlNXZHB5eEFoM1dxU0ZLQmJudFZLK0hBYnVEdHVUVzZZZ2JZazBw?=
 =?utf-8?B?Vm1nRlBNNEhCaE95QnVURnQ0YmJ2R212S1F3S3VoWUxXZSsxandsa1Z1QkRI?=
 =?utf-8?B?UllhVFFLV3NLZEw0enIvVmpVUTEwb1c2bmVqNmFCa29kQWtHYlIxblFlZEo2?=
 =?utf-8?B?d1U4R2FST0pScXdiU0pHRUFEbjljTTRpdTdCRzB2Uk8rYjhuT29uTzI1WWlL?=
 =?utf-8?B?enlqMXJydTNaUHRlYitZTHRXWUhKcGRMOXhYTW9DaWg3UWUwMjNNejlWdEty?=
 =?utf-8?B?bVVPSENNZXFLemFKVVlwQUtYNngxRmEyd01FaklpT0NTK2pOaDMvZ0VER3h3?=
 =?utf-8?B?Nm1DYWdET0I4WHJqOVhKZkVaNDdEeElYZlByUHVOYkZqeDZHZnpkMStvanJU?=
 =?utf-8?Q?vRScLKUTCOevvje0pG+NR/QWk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c1be6a-59f0-4f0b-bb89-08da8b99b083
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 21:42:23.6214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYj1X47oV2VYYMUfhea28AFr6ij40PwiUSlVYie54zEd3I1PBKHMBOoaZPnW6ihKO1otvI49PW+anwphRLtADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-08-30 17:57, Alex Deucher wrote:
> Document missing parameter.
> 
> Fixes: 8889a13f99e5 ("drm/amd/display: Add some extra kernel doc to amdgpu_dm")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> ---
> 
> v2: fix aconnector too.
> 
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9d5ec1ea23a6..b053c13a81a5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9936,7 +9936,8 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>   /**
>    * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
>    *
> - * @aconnector: Connector to query.
> + * @connector: Connector to query.
> + * @edid: EDID from monitor
>    *
>    * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
>    * track of some of the display information in the internal data struct used by

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

And applied to amd-staging-drm-next.

Thanks
Siqueira
