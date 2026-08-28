Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD7BC61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 14:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043FD10F3F1;
	Fri, 28 Aug 2026 14:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vCFz0W51";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDE510F3F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 14:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmc/eqfaIwLuCt047h3vfsVHEDFhl0jDdAgoOK6PmwUEKBCT4A5yil37iBZnTxoaLRp1lCNHR4PNe7BzdvLeGyEeBF7fjb0+V3I1e4IHYpBDcySoRHIapAvEWhvD+ZRbhxLhPyUN1BT3vcvk/oH6/KCt+efgX7F/7g98zz/e+GP3x0nlmGEqNr6kIs9RpCRKJSYRbaKFDhfGe1yUf0iUAh4mTuCIPbiqj9pIkyIF37oNqMMLHtU20Ebe2zOxRvZ5Mmc2Pw5AKVI1s3kTb/9RJhYuvXktZNCqUWw1WrV2O1Uzh/Eg42nHenBWK2R2TeJ4InYuNT8GK282tS3zGkf65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eowHimsPAyMsx8mtNNrAushFL5CS+GfH7B2aL/joYdI=;
 b=hALe+xXH8/H/VgOr0IanDtqOoVdIMb2hlKCsH+jXo1AQzhzt5CIOO9EcbCiKt0LWVDfqasy6u+3yoWDi445PtNoa2Mu+Lo5p3vkB8pha1jo4TBpCIDZCtDr8u/lA0XbjU2dvb69s+iBtWR1Pa9KQD14MwYUOXvPj0PJoqNKqtlrGpoFdD6v++KY7E4SeBWCN8VW3lSN+9O2y8pJQfnZTlvoLtT//LKg3ha7MYZTDEDWtZj55p7ELOz1xEGlPVAmj0cksFx+AqF0XGpW91tCvsn5k3xZ2bqoh8KBlhhp383OczEkjKicTBU8bDsITgyZn4ivbZSsujpNYKSUzraIhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eowHimsPAyMsx8mtNNrAushFL5CS+GfH7B2aL/joYdI=;
 b=vCFz0W51gRGxqRHYJDCrMN73cT1PMhJ9HoQT6urYJ8+b5zUfW+/6YKBgPcZOX+1RWbMmTJaJ4CJ3uMTmuziE7uN5hvN5YD/RplEI1EwP7cCXTfZCS5nXDdLbXORamrWcw06cSM3OH+Vzd3DpXbqgv8M42WrlG0qcMYHS+nQvH2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 28 Aug
 2026 14:35:21 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:35:21 +0000
Message-ID: <b65b0088-3333-421b-9440-3b14247f56a7@amd.com>
Date: Fri, 28 Aug 2026 10:35:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Emit VTEM for HF-VSDB VRR on TMDS links
To: Fangzhi Zuo <jerry.zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Pei-Hsin Yang <peihsiny@valvesoftware.com>
References: <20260828143227.2280936-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260828143227.2280936-1-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::10) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b05250a-6f5e-48d7-62a2-08df05119694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SiRf0D+DvBn7hiSROW25pKkx7HRJLcYRytd/AAG1uk3PyvlUzmtaP99JDXXtd+dPbbPD+IZJDmjpr1SRn2of9cUJ0T44O755t3ohXwLQ+E5of2b5d4ryy3xMYRF8oz++iV8AKyf/7eb0cNoPHtZJw+0U8EpQTnS/yXAFMvfHYDjoB8ZxIZq5yAymSu1gBacRBQz/L0FMu3EJFLVNPXJaAS8b1PtdWLPZOofYo2DrgX+vS1rjsS0nqeTCsNA3K8OU23Vw299EmyQXvRQsmu5RA3T9AWxmLSumh6gBGMkXE4Qp1SA18oN7frvLnS0Vu4DcZyJ/2PMBCrWa3gN8Uk/QBWKij06i5T3F9UaZFonWrYG4zrdMKOdIZgYczghNH59gDnpblsLSkj9O9epDku3pkQsKo4yuHwyNXjeTtoeyBvgmSADa7OrGwDpNYGApWCZX9A8GKayGgcP6agkji3r2NulrdeXDte7Qr1v5ClUVRuDfx8vuOwBvSASBYDpYNAyxeqSQA3gT6ZmZ1mXNbNwyG59HQyzI6UyaV2oTRXDT5KgTgt4pkbxnFyNi8+HgNbZXm66DATgrDFS+sBHs5RKfinoNxv+Kf7BSObraq1oKP1zqtqp+T2PLgCEDMlADpvO9+BbxQbNe631wuWo4btnT+Oxe7LItEbxWeTIdHhQ22Z0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0IvRFk4U0k3NjA3WWpWdmtZOXBWYUNScnZqRVh4UCtEdmZtSnJrYVdXN2Jn?=
 =?utf-8?B?clV1V0ZNdFNZUTlTeEJxQ2NZSVhIYzdxTWpQd0dCZ3pIRDV6SGcyN0doa2dt?=
 =?utf-8?B?eVdiOW9NdVFqNzZ5b3h3eEd0d1p0NnZNbUJZaEhXRkREUWM3TmIzaFlNQXFP?=
 =?utf-8?B?L21TcjZZMVU2Z2g5VkdLMmpiOUJCd3FmYTh6WVhVVlJoMnkxRVFONGkwRkNW?=
 =?utf-8?B?ZDVWekJNTDE0UmVweVRlMkFqa1ZMQ0RIYU5UWVpOWG54d2pCd1oxVW53Ykhw?=
 =?utf-8?B?d21BTWNFT0IyWkF1U2I2UmwrTzhKclQ4OFp1bTBzcGprZFJpcjRieFd4akJx?=
 =?utf-8?B?c2xxSlNjc3FjUlNoQ0d2bkNvK3hFbUJHRDVEdXp1eFBobUhGNFUyc0VsUm1H?=
 =?utf-8?B?bGRHOGpVazhCQUczWlRnM0REbTZFRUZGUjRnQTF2Ky95cnNIK3MrYXFmRnJK?=
 =?utf-8?B?MklMVXdZUFNJcjhsemJYdzVZcTRGL0dIcGduTk9uSnk3MmZYUWR4aStjMFQv?=
 =?utf-8?B?OHFwdlhDaFJDWU1Fc3lFcStZYmtnS0NEcnByYkdYQWtrYnpyTzZjMEROUUx1?=
 =?utf-8?B?dDdDZjU2RWtoOFNVY1Fvc1REeHh6cnF4MDV3OVJsUnNyRWhNekVva0tDeDRV?=
 =?utf-8?B?d2E0ckRPWUlWbndndFRSdnUvMXpRTWozRzVIb2pwTU04cU1ETTlTZm8yaFFr?=
 =?utf-8?B?WnNKcTFJNHJDUXdGN3ZQeDVpdHc0ZTNDQjF2TDUwQlh1b1VOTGRzOUpJU29O?=
 =?utf-8?B?SEhqdEtJUTRuMjdZZE1tMkdjbjZsbnl2NUhyZXlPRWU4VDVXdENPeURSQmkw?=
 =?utf-8?B?MDUvd1ZnMVlVblg1NGpTQkU2YVgyRHFPY3ZXdUZLWDA0aHNQMlg5RzA2Q1B5?=
 =?utf-8?B?MWN6YWY5RUFIaFRsc3dhUGlkUzdOZmRrYU1MY3JFbUs0TXYyRU1UNWpFeEpX?=
 =?utf-8?B?NktsVGE3bC9vWERqU2xaVFhnSFk4QXVpWHdnVU8zUGpSVDJCYXZYRmlOTkdK?=
 =?utf-8?B?T2s5ZUZlRjh6RjdPY2w3MHhRZk52TTFablNxOTREUHdiUzlvdUZDd2NUMDFl?=
 =?utf-8?B?WDhMOTVENmpzcmo5OUxzM1JPcWxNbDM4YnZ2SGZDcDBBZHZNU05jUDBocUo4?=
 =?utf-8?B?Y2l5RTdoSkMxMkRZLzRaQkpkUnVZaHBYQ0xaZ2hrVGIrc0J0NWF2NktzTmhX?=
 =?utf-8?B?UGxoM0ZSelBDbE1idmFWS25kUXI0L3BLKytFQ1JtZEhDMGF6c0lUbVFrM3BE?=
 =?utf-8?B?TkpZWGoyanRWODFLc0lLdWhFUEl1b1JQa1BXaG9nWnZWSnZhOHNLT1NWTC9D?=
 =?utf-8?B?OXVWMDgxc1EvMlo5OXFtTU5Vd2UweHlFclNrL0IrNTNMeXBpSlQ1Q1hlMEdO?=
 =?utf-8?B?Tncyb0tUQk44WFdsMmFlc2hzVHVmOEFBZEh6R1VGVWo3MFcvaUd0QW9ZZHlh?=
 =?utf-8?B?cXhlejlCblV2OWJYd3Rrc0JESVlYV05qTWpNenBzQUxMOG5WSG03cllDR0ZT?=
 =?utf-8?B?S2grdVZXSVVERXFBZE5ZWm9sYnVhaEZMcUJPOEFRMEs1dDRpTnN5VGlxY1lS?=
 =?utf-8?B?V1ptZnBBVjdHVE9BR0FXbFpNVGFLR1BYTWNiUHdDV2YvbUg4dEpwMTdmTHd2?=
 =?utf-8?B?b0dCRTF6YzI4a2Z3UGtXa1RxVTdNQUY5ckFkWXBIcUV3aGpSSTExcEgvQVov?=
 =?utf-8?B?UFZyVkdtUlcreURtSElRUzFzZDRVMElnNmhXOGxCNUx1QXdsYnZkcVhlWFJz?=
 =?utf-8?B?ZjMxYlVZTEc4RzBCdk9Ob2J4WFVib3RhMlRXT2g4dTZUdXM4QitKSmFyd0xR?=
 =?utf-8?B?dld5SklFbHk3Mk5sZWxWMUJDSml5ck5MbGUrQnd5TXduazFPWHhPYXpkdTVo?=
 =?utf-8?B?MlhBd2xoTVl5aUhmdnEwSTJKNjVHL0dYQUhlN0hYN0w1NHJkVDlJdTNvNGhz?=
 =?utf-8?B?djRmalpFazJXSDZ4SGpTVzZRSVBLMXpFcUhBbkYwMzBHVWJqM1kzOXZROFZ2?=
 =?utf-8?B?b2xJWDFZVjhtdS9Ta2FEa1gxb0tvWDhqRFF3TDZqMXoyMU5jbWgvN1ZVcnVw?=
 =?utf-8?B?WkthYjMrNGdsZHU2d1A4aktJWS9rVDdBNVVQS2I3ZkpnbzdBRkw1TWo3NmYz?=
 =?utf-8?B?Z2RqcSs2MFUrbzZCZXdPUGppVWYvQm9qd29xbkRZNXJMT2laa1kveW15UkM4?=
 =?utf-8?B?OU1LVDdsbWtwR0NaTkQ3RmNFb01CN3k0bG5GU3NYcnd1K25MWXg2MlZoV0NH?=
 =?utf-8?B?SkJCNVlZdUJ4LzY3NEZycHlvTDZvSVBjQ2dVSWtzOTI1eGtpazNVVEpSK05J?=
 =?utf-8?B?c1hQWWc3V25iaTAwVHdYMEtMQU1MQUdvVlkvRXVQMzRNRzZJR1ZqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b05250a-6f5e-48d7-62a2-08df05119694
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:35:21.0523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6Yaq5ypk0eBtodlsrh/VWU5Tl24FjFfEICo4EVTX/rTx/2jWLpHWn6oTyzqXwjPQVmIBUW9UsQZRUuaE1+rIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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



On 2026-08-28 10:32, Fangzhi Zuo wrote:
> From: Fangzhi Zuo <Jerry.Zuo@amd.com>
> 
> HDMI-Forum VRR metadata is carried in the Video Timing Extended Metadata
> Packet (VTEM). amdgpu_dm_update_freesync_state_on_stream() only built the
> VTEM for SIGNAL_TYPE_HDMI_FRL, so on a TMDS link a sink that advertises
> HDMI-Forum VRR via the HF-VSDB (but not AMD FreeSync via the AMD-VSDB)
> never received a VTEM and VRR could not engage.
> 
> Per HDMI 2.1 a VTEM is a video-blanking data-island packet valid in both
> TMDS and FRL modes; only the compressed-video CVTEM is tied to FRL. Build
> the VTEM on a TMDS link as well when the sink reports HF-VSDB VRR. Sinks
> without HF-VSDB VRR keep the existing AMD FreeSync SPD infopacket path, so
> AMD FreeSync behavior is unchanged.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Tested-by: Pei-Hsin Yang <peihsiny@valvesoftware.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index 63d10cb7f5ed..281c6cec9f4b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -238,7 +238,10 @@ void amdgpu_dm_update_freesync_state_on_stream(
>  		&vrr_infopacket,
>  		pack_sdp_v1_3);
>  
> -	if (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
> +	/* Per HDMI 2.1, VTEM is valid on TMDS as well as FRL */
> +	if (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_FRL ||
> +	    (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
> +	     aconn && aconn->base.display_info.hdmi.vrr_cap.supported))
>  		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopacket);
>  
>  	new_crtc_state->freesync_vrr_info_changed |=
> 
> base-commit: eb3ff61912825e72633f70b6f7197973be83c8db

