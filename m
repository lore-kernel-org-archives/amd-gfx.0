Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37727FC6172
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 18:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 793F110E2A5;
	Fri, 13 Sep 2024 18:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2dVuV+Gu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF79E10E2A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 18:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pa8AtWNNfqUWXncYDCNR67eeyvxjNih6X3043+OA+xXGogehaXf49pvboI9PAzVHKGdm5S+xVbwpqawW6FQRa8J82nyZs4r5bQXob7fWfLv7IB0OXOyyZpZYFvCQB0mx+gDTxiAPnLILCJULMoCvUQ62oJONOkSpu9YwgOVq86vsAad/j/sBqlsZ+pCG64XQbLMzB6K38YTQWdeBCzUlG8VY0afQnVz5OC7nepGat+Sy7Q7LEjQ3PROT0CJg/uJ6E+4SFm2a+TfN0RtQy7JoHskQYaTrhJP5KpfK67v6hXvtVDXsskL5EU3CZH5PK8ZmWpizfTVBtrtjK85h407XeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp4uD1yaQuyWtc3w420soML7IKnBbFBoaiIY/Cg7sN8=;
 b=hFNDa3tVJ4CiwyI6SBHpjMZpVzwHHcknLnjEDsVGIiOwqp5TA5DZbeJfCQceBtb4Oed5X/e6ZTJKJ4igutLc1ROTj3btFAsk4fPEihvTLXcTaRtlN9Z4Rh30gPK5PRJLv/558OryTdvOlLklBHwSwJqqLwy2mkKon+w93yDvdQles/XxmMNyyTS8u6XLPKI+FCXTpKFKUMpfxfYc9H3FNmZlDs4pdcuIfJDfmaLCEe+zgW4xXj22AUJUpfi35Wp5H+QdFwku5122znx7hE2aXHN5PlhQgfRsOUpM4Wkw6ck1Yv1nbRfEq7FpBJFgA66hOYafC+wZnNIyB7YssWrXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp4uD1yaQuyWtc3w420soML7IKnBbFBoaiIY/Cg7sN8=;
 b=2dVuV+GucenHDfVGflw5WdcrdF3lz/UfGjUAxt7DeaAU3NAWiGyqPVN51ohsEhaYHFOF5urvyg09VOryJXQtVAHJjMsi3JKaSNCPZ7Y++dMm6kjUdGSwl/TIhwNnjtI03eVSgOAaAnAWww+n40Jr8z5abwq6Vxltmz3jl5RIHUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 18:47:53 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 18:47:52 +0000
Message-ID: <db78e83a-6b4b-4d87-a2b7-8a2a912e63b2@amd.com>
Date: Fri, 13 Sep 2024 14:47:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Validate backlight caps are sane
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240913180039.38146-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240913180039.38146-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0539844c-2571-4762-9216-08dcd42492c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qjl0dElrWldYcGpVYWdneE9LVXNCVjhaS1FWQzNuWjZiRlczaE5EL2syR0lT?=
 =?utf-8?B?Z1hPWTdxM29wZGJHcXRkT0RBQXZDcnRtK05PdDZhbU5PaUtwQlpnNU9KOStZ?=
 =?utf-8?B?RWdIZVhrbUVmYjRxZmE1bG5SV2wwL2NtWEJBSGtmZklTdmJxZGFKQlRTejhh?=
 =?utf-8?B?VmpabVJUK2RxdnA5RzZzU2xtSERMSjNtVnQ0UU1iZjVONzlYbTBTYUdpMzl0?=
 =?utf-8?B?NE9EdSsrZ3M4VnhtcmtwZnhaRjRZbkJ2VDk1SHUzcUZvcDVINUZlSUpIOHk4?=
 =?utf-8?B?RjhXcHNXZzZXNXRQTVJ6cXVacXVBMUpjQVpGVEt0MDErY09kckRVUUpJQ3Zx?=
 =?utf-8?B?NjBlVEhmeXZTUUhtN1JkMVRBeGlOd1B0K2hUZUdOblprQ0NBdUt6TVlpZk5i?=
 =?utf-8?B?aHRyTnZlTXlodVBJdTM0L3hleU4rZHRFZE5CZ00ySzJ0aGxTRmU4b085RU1u?=
 =?utf-8?B?OFYwL3hBazBpeEE4Ym9uSXpTZC8vbm82VFJodHlGblROM25WT3hMS1JmV042?=
 =?utf-8?B?eDJseDQ1RDZHYi8yODBGbHBiOVYvZVNBS254ajYyRDc3OFY2aUQ0aXEycDg4?=
 =?utf-8?B?aHBtTXVHZHJBOFlTT0lJaENrRTZqc0dXR1RUd0hUSTVlUDR5TlppTmgrSmFw?=
 =?utf-8?B?RTBNUkxUMW9LS0cxWFRaRmFEdmNhRHRhdGxOMGJ6NFpJN1B0N25EZjVaQzZh?=
 =?utf-8?B?ckk0TmxWQUNYUjJkaVNYU2NCY2wrc3RaMVpFSVBHY0ZqN2xlL29vYVc2N0dL?=
 =?utf-8?B?Y0gyVVJKYnJmRlFJcHdjVXlEVWNoYms0WHhZN3V3UFRJVXVPdmdXL2tCeVpo?=
 =?utf-8?B?UGlJU0J1VCtleG5OKzhSdzdYNXRkSyt5WkdQR3BNNDFMQ21BT0RySStkL3hw?=
 =?utf-8?B?R29RcHd0WS8rVkdOTllpUmRsaDArRWFPV0RVSnlXTUJ4K0UxdlQ4QkdOTXhT?=
 =?utf-8?B?U0lDZVFkUEdxWFlReWpXYVY2cEFEanNzLy9QSTN3VjkySCs2RHhjV3FjeTFm?=
 =?utf-8?B?T2VyeU90Q0xkenErWjh0dUZ2VDBpQ0JXUi9tZkZOQjRnRmxIT2JJcnVXaFRj?=
 =?utf-8?B?c3lLQTBHZmhZMFJSckJkZ1hYcnZhd2kwMjBjdkRqT2pIdDMzS1ZHdEJQNUdL?=
 =?utf-8?B?cmE0bFMzNDU1ekdCaCtzeC9GNGhuYTVFYmxXTWMvWllKSVliNVNvS3NkTlpZ?=
 =?utf-8?B?aUVKZFNDQ1grZjVGVTlDNzBLaG9xVlV0WStab0V6NEdaUG40dFBNL3M0d3lI?=
 =?utf-8?B?WmZlTmxaN3QzdGYvN0Q3UVZuMlFkUExuWjd5NmxIUnQwVHdIdnlSZnJVcktV?=
 =?utf-8?B?Y3VNTFM4amEvNE50NE1TbmlDYXpiN1N2QWJrREk2NkZGQnZLME1CWGV5QzNF?=
 =?utf-8?B?SCtWTGNSL3kxRWIrR2lpZTVpNjBpbkRIdjgwNk1tYklMaVVSdTdRL05iM0pH?=
 =?utf-8?B?cUJoUUJ5aVcwZXZCYjFxYkpiUXAxYW5DWExTenIwRnpBMi9RK0cyZDdDa3B2?=
 =?utf-8?B?aTJGWXN0NXNKdWR4azF0NXlSUGFjcTVWQk1kM1FBczRsRTdnWk1jU2tTSEpT?=
 =?utf-8?B?QVdZcFVvQmY5ajg3bnpnWGZvdTRWd0s3TXhOMFVMdzdmY0xQUk81NU9XQ2JP?=
 =?utf-8?B?OHdPS1VWQkY5YU80M1NzMStrbzJUOEdTUnRUbW5LaG9HU2l5Z2RybDFxbnNj?=
 =?utf-8?B?SnRVRzQ1dVVrdWdOMjNsQ1RxK1IyNm1SV2ZER2NxTUZNaWw0amlNeHRCdTdl?=
 =?utf-8?Q?90CANzN02g+T1/yfJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTduZXF6ZHdxUGRWVUpQa1R0NXp5RjlUTTh3d1h2RzlzOG8zQXdnT0NyMWVw?=
 =?utf-8?B?a2RuaXd1MnRhNml2TnBLR205OFBHYXpFYTAwNG5LTEQzUTY1UVQ3bnk3ZVdB?=
 =?utf-8?B?NjY4L1dueVEvb0ZPR1V3UHNzZ3oxNFNzbC96dDd2RFl2RFdlSS9tb1BsMHJH?=
 =?utf-8?B?YWNEVmdCZU13c0Y1SWZ3bWtuL1RpUWxuWDlxV3piQ3hud2dsNko0TmRnTWZw?=
 =?utf-8?B?QlErNW9VbGE0MEpadEVEQkpzbVZrSG9QWUdEMVVRZGN2OUhuMlRubHhUOWtB?=
 =?utf-8?B?a3hnTXNDRWNodWttZFVuTEZ1c2RTK1lpZmxTMmRyUDJMN1UybzZ4TTRXZGNw?=
 =?utf-8?B?RTRrcCs0WlBYc3Fuc1hONHc2NzBNY3M2YnZaM1dwLzBpc1doWVRQWlpmRVVX?=
 =?utf-8?B?U0lhL1Rwam5oK3QxQTEwSTJoMGtaM05yTFVBMGNGMVM0T2pxcm5hQnBsY0Zz?=
 =?utf-8?B?WG4xQWFRbVI5eU9tK0RTejMyRWpBZFN0dHVJRlhXaXJGUGNzL3RrUUVjVXJL?=
 =?utf-8?B?bE91ZWIyMFNyU1BqV3c4UFFRL2Ewb0UxNWxIdWJIZHFZWVFVbVNLQVM1Ujli?=
 =?utf-8?B?Y09KN09GQWk5c2t4K1NhRy9XaFptS2txU1BlWjk4Q1JjaCtjNE9LK0QrYng5?=
 =?utf-8?B?Y3dDNkVFcEMyK1pUd2JVcTY3UlFkeGlDSWxvMVEyejh5NUVTWHpHcFNJUmdW?=
 =?utf-8?B?T0hvNXJIM1ZmNmtSWEd4ZEVraFB2NHdIcWRqZGhOT0JFUU10bXBYczlrdHpH?=
 =?utf-8?B?dS9GUWx6aGZWRUpXejd2Q0dpMHNNZ2dMeElORXhpTThuVWlad3RJaEptemlC?=
 =?utf-8?B?T29vVW1qdVU5cS9RM0xmSDVFMHJKMkk2ZzlBUkhvSzl5N3RKUHpGZytYZ0xr?=
 =?utf-8?B?aC9xOXFjaHJiaVhCV0ExOUxBZm9GWWxkMy9JZEpSSWw1ZkpXd3ltMmNpUkVw?=
 =?utf-8?B?eUU5dWZrOTk0bHJLZ1NJMjhYbnQ3SmxUVXRHWEJxSjNZYldicjJRd1dqYW00?=
 =?utf-8?B?WXd5WnJYWUlpUzh3aytJZzBMbVphR1dqTXl2dEtrTE91MzJqdTcxc3RteUhJ?=
 =?utf-8?B?WWx3RmgvK2x4UlZWM3NjMHN6N3BSeVBQUmJjcnNFMXRQY1Z6K2pBK0JPVzVX?=
 =?utf-8?B?TE10UUhPMUs0Q3ZPZG1WRTE1NWRDaHNpeFQrbVpWbWtlVEVDVnd1TUNMaWNI?=
 =?utf-8?B?ZmlNSG9jeFBQWWhoR3lrbmsyMFJ3TllTOE1wV1grTkFwcnp4VTVpQXV4SjBS?=
 =?utf-8?B?dUpNYzMwZVl0eG9pMGZFUnRLZVZYa3Q0MkpxSkpFZHFjSmZIdU9hYi9aM05G?=
 =?utf-8?B?MjBJb1dZeU5wWFFKMDFyU0F0RXJtTDUxMVFLUFNNMnphd2NmUHpNSE1nSTYx?=
 =?utf-8?B?Vk4wd0FicmVpR1lTQW1TZTE3U3pxNVorUDhWOUk1V1I5U0tPOGlneUlSSWZR?=
 =?utf-8?B?SUluaDNKMHhGeDcxVkZmb1hZUmNoeXBZbDd0V3VqRmU4RDVPQUxsREdjWHJz?=
 =?utf-8?B?NmFUd2RRR3B2NTBWQjZDdi9jM2NhZWZvMEg4dzFORGtlVGcwWjJYRmVnMWhr?=
 =?utf-8?B?S0wyYVFsdFB1dnVMQjZaTmpIb1ErUW5qNXNsRS9tYmc0Q2tyai93MkpDbWRW?=
 =?utf-8?B?dnAzNFBmNU9VZE9ROFpmYUhuMVBCUUtrRTNnci9rYUIzbzJZckxzaXMvRnFP?=
 =?utf-8?B?OGhlTmtxemZMMDU5UFd5UjIwZWd6Umcrbis3SHRRMXdscTlIbmo3MnVTaTV3?=
 =?utf-8?B?clpiV1h5YzcwZE05V282VXdzWlZpNHd3azhXQWl2cWdCRTdmbUtseGhlb3hr?=
 =?utf-8?B?dDg3VVZhRUM2K2RlUjUwRWtFVU8wSUJ1N25FSkpoNlIwUFB0MDBkOC91NDRO?=
 =?utf-8?B?b2ExNFc3UDBlbVh3NkRuMDBPcVJSWjJtOU1VSWxLSHNKYnZINTNaNnJZZHJ6?=
 =?utf-8?B?a3krWmJ5b0dqRC9qMGhPL1RjVXQ1TklIY2JDNWVNT0xBdFJuYSs5elZScUZj?=
 =?utf-8?B?d0VqS05TWEpNN1ByaXI3MlAvT1hZa2YyVW15RVZ0dDlPZmtVQ0xYYlR2Tjdh?=
 =?utf-8?B?RXJHdnAxUmlaZUI1YzlRa1N4NzM4N1ZnaDRsak1mcE5uU3BHWEMwemdpRFkx?=
 =?utf-8?Q?RWA4jyUeiJynO5zSnemWQLy9C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0539844c-2571-4762-9216-08dcd42492c7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 18:47:52.8360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fot8KgSrxsPId5Ndb61/v0NRnwnPlroXfZ0ECL9jhQd6/nwoLT80fp5k0xiEQit+nu/sV/HmlNguzEJNk1Nf1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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



On 2024-09-13 14:00, Mario Limonciello wrote:
> Currently amdgpu takes backlight caps provided by the ACPI tables
> on systems as is.  If the firmware sets maximums that are too low
> this means that users don't get a good experience.
> 
> To avoid having to maintain a quirk list of such systems, do a sanity
> check on the values.  Check that the spread is at least half of the
> values that amdgpu would use if no ACPI table was found and if not
> use the amdgpu defaults.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3020
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5942fc4e1c86..ad66f09cd0bb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4428,6 +4428,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>  
>  #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
>  #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
> +#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
>  #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
>  
>  static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
> @@ -4442,6 +4443,21 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>  		return;
>  
>  	amdgpu_acpi_get_backlight_caps(&caps);
> +
> +	/* validate the firmware value is sane */
> +	if (caps.caps_valid) {
> +		int spread = caps.max_input_signal - caps.min_input_signal;
> +
> +		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> +		    caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||

Would we still want to allow signals below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT
(but above 0)? The min backlight value of 12 is a bit conservative and
I wouldn't be surprised if systems set it lower via ACPI.

The rest looks like great checks that we should absolutely have.

Harry

> +		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> +		    spread < AMDGPU_DM_MIN_SPREAD) {
> +			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
> +				      caps.min_input_signal, caps.max_input_signal);
> +			caps.caps_valid = false;
> +		}
> +	}
> +
>  	if (caps.caps_valid) {
>  		dm->backlight_caps[bl_idx].caps_valid = true;
>  		if (caps.aux_support)

