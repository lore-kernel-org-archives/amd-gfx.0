Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58A5C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4213210E5DB;
	Mon, 13 Jul 2026 13:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PaV7HTY";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180DE10E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT7eBqoJOYn5nbZdS3BpE6j3abyvIjTbr2BE2K9mXH2hSdcFTQcUMK8bJPGmC5xKEQfEDIABUpd7xh3mLXUanFrN1KEZQHijQgjoHMF00IL0hKqLqVY1GTWX2kqMYy0/xObETRjjRTsbbX8ces7xO/EdY1EX7asbVZeTccaJZikn0TgfDvOrho6RRWm1KkYiCME9/gl1vHJMXdgm6QUq+FUHbFzvlx/Fy4BBxugYlYERqLeHMaZmE81drMZbumxPlNnOr2agEu3IgP3ZIDmVqEBMgWRnd26CJddNupr/mKVyW0ikAwqLLnjuoPuSQAQV3KdrSRCll1N7KE/IgF6yEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMkzBLh0Vyqf0gkwwn+enC1XNOUg2SzgguA/FGzWbzI=;
 b=Mnqd7OqskgGqtcvYfeq6B9UUiPSuxa4Cnw9ZX6OjEIvvtJWF6o6CW8v21PFPd2bM6CI7R0Q1MzSX5Xch/1wJS4qu52eYX3jaiz+3kJl0bv/NkQjVpDCTWQSgVFYFAIdqxX4JgSLjC4NdQv9yJMtIqPdbDOC1pk7/Xg9rmYLJVtc9jZ/vPPhHTbEZ4J9Z4lTRwMpp2gbWjSPbYtKrxUzbOypjS8kT+YJJhb94fDZzL0HBs8e5nOifmDfe2eoXx9gL+qNq+1dxOgStVIDyoO8NPigwZaevRut4evBa7hZBs4bOsA0Ia6x2ZC98+UytlYZr5i2z/HuNLzEQZRk4c09zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMkzBLh0Vyqf0gkwwn+enC1XNOUg2SzgguA/FGzWbzI=;
 b=5PaV7HTYMoiW0XpwoQZp1PG2F5QHOKSqNpGCQbTo6KfyOGSuYMT2HDT0bTmtN8om7iWwBp5yaCxjmv4zf/R2JS8Xkwr5CDWv0d9Z5Lz9rI/A/O6MuHOnsSjmAbm/38eyJQmhEwjuEq7Fo1xS1ktC0QtczBS5I4VzQX4qPvuxWdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:33:04 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:33:04 +0000
Message-ID: <00116541-839b-41d8-90fa-1b3f228ef812@amd.com>
Date: Mon, 13 Jul 2026 08:33:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: Shorten name of FRL polling workqueue
Content-Language: en-US
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 alex.hung@amd.com, harry.wentland@amd.com
References: <20260711113009.26512-1-timur.kristof@gmail.com>
 <c1d30a27-0fa2-442c-b2be-aac23137a08e@ursulin.net>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c1d30a27-0fa2-442c-b2be-aac23137a08e@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::32) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c11cb40-4635-4993-f5af-08dee0e34484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 8UAYjGxpZp1BVXSjrko9As151XkBveXzy240iYkv1fmqSC0TEBNzhS+4sQvtcDv7N99+SbVTb/tUHLz6laUhC/tTriD6lIYQmgGK639XjrqnDqQSjaIZwlMg6cSXkkCm9XcROzqnXADA8WOnN1tveoIZsf8lX1SJxl22nHU7zSrS7wXEIbYTFopIelNO/4aEaoNbHBLlbV8tac15C5nQ+M3rDaycaLTIjpMnFtBIZ2BF88ZrnCrsFIEY9mvtbXZ4HZSCwueCKkvWNpvWouaxdlpwQAPzVQlG42ei6wuHCEu64ip0DMn/MNeIKQ93NKVAuI5zhF7w7S62A8kZJ/1XPOKMYRIpnKA0g/f60H06PjV6U19WcqQM3uOADGaOudZ5zAtJ9w3kzGp7NSjAYrzAEqKv4KnHQDAb85orjiS+m6pEpW3XmeRnEGi0EOrCX+r19pk2rrmzRne+mBjTiV8C2U3RFeAvA1gcQ4BR/0jSulgAwfc8/6t9sNDY8AJKXuiCMsaUJIun19c8kvCaF9lkcQ9hGrTlF/zvhwvctRnYypVzEVvRq4u45GKMxA3kDO/b3AWFiHR6jRvhPd/vMRYZZ0jFgmysj08sFaZhZTsgs2XZxlRwAj8pt+Y0M0p5pPAOtJ/fyWDVz+ST17aQ/SIZdtD1XSUD0elWWCzyEXoGSh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRyRERWWW9JYzYvckU1Z1BuQmNoT3U4eVo5M0RrTnA0THA1c25LRjVPcEll?=
 =?utf-8?B?T0lNNmFhUml6RWxjVXNuK2V5cjIvb0JoSk9XSHMxc0JvQnE0ZjZITzg0bWFI?=
 =?utf-8?B?QXFHU0FhdW5xMGhnV21Na0lBZXZKQUVENjJEUnYwUExmSDdSSDFuNFNvOVpk?=
 =?utf-8?B?L01NSU81VFNBb2h3Q1dBZ3EyVHI4LzVLU2ZBRHU0bmlVYXB5V0F6OWxZQzF3?=
 =?utf-8?B?MGJKYWlrNzdiV3orT1hsQXVqaXMxRWFjNThlL3RzRHM5TVVYUHFsYnRHb2RX?=
 =?utf-8?B?cko5QUlNcmFtVEpySkhZWURnQVVHSkNYTVN4bC9VaFhwTWFVTEhhSDNYblFm?=
 =?utf-8?B?dWVZa1RQLzIwbWM5aEMwTkZPNm83WW9obEhLZVJZZnlGc0xOcnFKaUQvNlE5?=
 =?utf-8?B?MWdER2ZhOE94VlpjWnprWkRzSTZyeC9RYkd3NVk0dTJiaC9YS2UzS29JUDlo?=
 =?utf-8?B?bWtmTUNyVlhaYmRmZXMrd0MzQWhFaGZvY01JLys3Sm5Ib3pKc1hKMWVOOXk2?=
 =?utf-8?B?WTVpUERjT1BPMUdlTHVLSGRpQkM2eEtYaG5EcFpnQ1dvamJ2UzM4ZmM5a0F1?=
 =?utf-8?B?WjJTa0t3WXRrR1pKdHVlTWwxYXpwaU1tcWhObzVrMlJSMG5zTVBvdVl0YVh3?=
 =?utf-8?B?WmIzbmpFL3p0L0kycVJMdkdtLzBqMWVNUkpCRktoaTh6RElvYURnb0dFM0dO?=
 =?utf-8?B?SlJXMjNyNEVwZXEvZXR3d091eElUN3J3dGhsZk04ejM1T0c2S2wxTmdRL05r?=
 =?utf-8?B?ZDgvd3BndDFSQnE3TmV5Z1RlRXVXNnJkNTBjM0tsT0RKWDVtRm9TT0Q3ZTJV?=
 =?utf-8?B?cWg2dXlBWlQyeUZjUEJrdDFMeDRUSEZqdm55ajVVRlROay9jdVI1UkhEK1JN?=
 =?utf-8?B?WlNNTVpsNHNMWE1TQklVaFQrRzVXenVyZFlPeUF5emFmWmZNMHh5NFlDRWFh?=
 =?utf-8?B?N1IzbXpkOGtBa0Z3alNyaTFTRmpLeU9sZmVlWFJwS0RyWVRFblo3c0pNWGcy?=
 =?utf-8?B?VjhKVWZkQWhUQWZZY1BrbGNsY1ZKWFdSbitidGUvZ2NpNVJMUHR3MFZ2Mytr?=
 =?utf-8?B?a2Z4T0RnSnJWQ2J3VFVTMUxQc2FwNksybUlrR1QvK2RYRzJTakM5NW52d25p?=
 =?utf-8?B?TG41UEUwaXdyM3VQUmhicjMwckttbWhsc0RrcVRndnNkVmVuR3pVZytlTFBP?=
 =?utf-8?B?NVhYZGxiZy8wK091eEx5SThUL21JRFpiZXQ2WStPNDQ1UDVQc3o5c3BOK0ZR?=
 =?utf-8?B?a1RRdmx4MGZiTngrbnRXNVM5c096cDVVejg1SW9BL1IyRlYzTzJpcE40WDRt?=
 =?utf-8?B?OURNWjlCMUpwK20zSGIzSDhQUmZFYXdGRUVjYU5ENC9TaFJ2SjlyWjFNYWZR?=
 =?utf-8?B?NVJoVEFXTEtPYmpoVmFUc0RWSWVqbnRRcW44cCtPRXQ5YWlWYlN3Si9KQTBL?=
 =?utf-8?B?eEplcHRNNkY4a0hiZkNVZ3NvWWRVR2ZXL0RTQjVYbEFUMnNTeCs3alg0ZUdH?=
 =?utf-8?B?STAyLzJhRUxGY0ZVNEhmdit4R1dSMFRBMU9PTndzTEphUmZtajB1YjNJR1JM?=
 =?utf-8?B?SmZmV1ljN3JRaW4vUGNreU1rUVJReDMvRUkxOWRTbEtaOG9PUURsK2ZaSFRM?=
 =?utf-8?B?N0JvaDh3enNkVE9WMS92V0hkRzNsOTM2NHViUHdDOUhPbmtwY09SOHhGUVdr?=
 =?utf-8?B?TnlwWUVzZ3BzTE1Ea0pNNEVSakVUUnhQblVMUUNRUG5CRUZNYnVYWjFsNEdD?=
 =?utf-8?B?aUNOSTdXTFVBbzhjMUZPUHI3NlQySjBjRmo3UWNVNWFCOGdWM05Cd09MYXF5?=
 =?utf-8?B?cmFyYXZ0Y3g2cndTUXVhVGdLTU9sbHN5TTg5MEhpY3RGUkdtcG96Ri9KcFRa?=
 =?utf-8?B?OHJCaDdaRHAxdkFpOE1BSzVEWmpTa1R5RFYwNlpCamY4ZXpOa0phQW9PRHJq?=
 =?utf-8?B?NGlDWmM4bTJnRXBLRlpuSHh5ZElDZE94U2p2d1l1RDZsZURiNUVBNkVCbm5p?=
 =?utf-8?B?eGl1OVczU0dOd25XNFNENzVoK0ZhUENUMWlkNTR2WHFUTUFrOUU2U0lWTm9M?=
 =?utf-8?B?LzdqSTBjYkZuTS9QZGVPODlxRnhOY2NCR3BaZ0JyQWpCa1lycTBobk1kbHNF?=
 =?utf-8?B?cWJmM0N1aDBDRTJoTEZvWEJmSWdpOGRvNkhqK0lyRjBRNm9IREFXUStyc01O?=
 =?utf-8?B?ZndFdS9ncDZmVVFTMCtEelY2UGpLWU5sSnhQL251elVOQmo2ZUxobWM0VVRV?=
 =?utf-8?B?K28yN2VZdnpXNEJvL3pkRGFHOGNOLzgxTExESUo0cTF1cUhqQ2RlT2dSTk1J?=
 =?utf-8?Q?qBEufLzK0CtPRa3EkH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c11cb40-4635-4993-f5af-08dee0e34484
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:33:04.6427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jruqd2l57OPEGW2TWR+g5PY42BVGishq1XNT7m0UgJcybTYY3ScgjoT270X839QvdDfqlIQDk0i8uKNZjZtjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
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



On 7/13/26 05:15, Tvrtko Ursulin wrote:
> 
> 
> On 11/07/2026 12:30, Timur Kristóf wrote:
>> The current name is too long and triggers a warning.
>>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/ 
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index b97ceabe6173..6299f0e384f1 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -829,9 +829,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>       }
>>       if (adev->dm.dc->caps.max_links > 0) {
>>           adev->dm.hdmi_frl_status_polling_wq =
>> -            
>> create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
>> +            create_singlethread_workqueue("hdmi_frl_status_polling_wq");
>>           if (!adev->dm.hdmi_frl_status_polling_wq)
>> -            drm_err(adev_to_drm(adev), "failed to initialize 
>> hdmi_frl_status_polling_workqueue\n");
>> +            drm_err(adev_to_drm(adev), "failed to initialize 
>> hdmi_frl_status_polling_wq\n");
>>       }
>>       if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
>>           init_completion(&adev->dm.dmub_aux_transfer_done);
> 
> This one does not require display knowledge so I feel okay to review it:
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Two nitpicks would be that the _wq suffix is even redundant since for 
> the task name it will have the kworker/ prefix anyway. Second one is 
> that while touching this it may make sense to replace the variable name 
> from the error message with a human readable name like "failed to 
> initialize HDMI FLR status polling". In fact, is this even an error or 
> should be a warning given I do not see an immediate exit?
> 

I'd say fix those nitpicks in v2 so we don't need to spin it again over 
them later.
