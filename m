Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A171C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 15:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84872113288;
	Fri,  3 Jun 2022 15:09:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE9E113288
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 15:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgFoDxm5RuQxJFsvIPZ6RYtfKiAOa4WyKts4wHRZYh1V3fAWj1t2UnoZqxtlh4+LKxmHkn0+TUqgYhKhVKv7EfyGcB0SpK+JbwynVqv3M+xrxUHqwTPYf5hr3hnH1QpehhifAGsgM/PJEW8ClmzCYCC2hDkgrtXCAc+5wikZmhFkmaNUA09d3rrqNy4EuAlb0q4wrGh7I0rAbqmWDG+hFUQKVp2DpHbCpjf5iAMdg7eh5ak+IdEPJ8JUtAPtmTWXURm7uiGZ22hscWUc5Rp020NQdj38QaC5N5SfiAyAAN/sNsSliRnFJZkiMnPCXngOZWe5JEdhIguxKvBqZg8EVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbKF3ySOVS7Vdk1x8saiBh8c8MXIYXOw4QBtzt+6CPc=;
 b=gG+aaTzU7XoIGkR3pJp4MY6vZ+RJNNpRhSfacGGTbKA/MwR0R7ZxvbzQHKfLDPGUCIde0SSb9vzuImWLaNrLNBIBmkTr3d8TIn81UggC9AZQ2bdA+4PmGVJmEmfLxD1FGx50th5hfP14hkdX/4zHvS3JDO37ZriQ4uku02LlnF1X4D9xS9bhfS3kaGbtqky1aW1+nRm04apanSQvGVxhCPc/jD7ePjWOS7wigpGUsVodTpXXcmjT7bi60HzR4cPguXCW/eXkXuIGzwRBibsAeNAZ9wF9cIw9+zZS91k5mzYpVxXrF66xsc8PG71JYRIacEfQ+dlGQc9iiJlkAf1kIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbKF3ySOVS7Vdk1x8saiBh8c8MXIYXOw4QBtzt+6CPc=;
 b=0Qgi5uRmURi+edDCLUw5q1oCIp8GaUW9bhU4hXtXvEm3fdYm4dXnZ0SBz/v2MeN5vx+TUS+SH5KfMW6yrfTWFzIez0sHFm5qyiQe1QxlmUku96myEreyEB7Ke9bmnm81JJhZ0htjebLSu7QRQEUw4+0j73yKkqk4rM3mx88ZaTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 BYAPR12MB5701.namprd12.prod.outlook.com (2603:10b6:a03:a6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Fri, 3 Jun 2022 15:08:57 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd%7]) with mapi id 15.20.5314.015; Fri, 3 Jun 2022
 15:08:57 +0000
Message-ID: <01cbc0ea-7a5e-53a6-1560-dd4b95c249f7@amd.com>
Date: Fri, 3 Jun 2022 11:08:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] drm/amd/display: pass panel instance in dirty rect
 message
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220602180347.754067-1-sunpeng.li@amd.com>
 <20220602180347.754067-4-sunpeng.li@amd.com>
 <6ed8ce38-1653-225c-10d9-f7e4fff5adbb@amd.com>
From: Leo <sunpeng.li@amd.com>
In-Reply-To: <6ed8ce38-1653-225c-10d9-f7e4fff5adbb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08276c9b-1762-43b7-7b88-08da4572fba4
X-MS-TrafficTypeDiagnostic: BYAPR12MB5701:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB570141D19DF25B0A872C1D0B82A19@BYAPR12MB5701.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VYqHIYsQswNr+b22tSpRNLboFQBp2UxDWjXD4tZpLTJHbqIwBCwIoYTJekJKnRb+YDovCYc1+rfsoI6uNYVdDe+suzRnHNQGyQ+WAgDJ3Fzi1AL9pP/o3zWGeeakiNJPw+4MAzTigDncQ0BD9k8K9xyi1Ym/v74WvISFep72C5BXoKwpsejj8NiJ0wCkk2N4U9m+WYSiJvDxAj88Agr/XlEQx6pT4cFjesY+NJv0KdB94LPZrTR47x1FiM8/+tWQ0bfNe23mTHWBuEsAE6fLYk/hMVOCN7m9wZegW9qwlShBrr3Ldeakp7vqCNv42woRQ5n9nAR55Qzwp0F354mFduwjNc4ztygHNHNvwmoh5joE15iE1Gh5tJhPeT/NJMXH8QElzMXzgWRkvnbLUhvK/ML0cMWSZYOt+hi9xWXs9l/jiOKfnKe1a6cKNtMhG4q+gdS1kClkSAW5YsS1olKYSsOrgBxCgPsJIMc0U3fBvQJ3IApu613GRR6JQrZrepZU/cU6D1KoJSUnWCyNVIYRoxOkudKDQd++assZPgE4CM7HZmF+OjUISkTaOCyavjPL0ut8/Zg5JZe72HPYVZ3poxxnzB3efJZjfbJN68T0PKy2noU+9V4XZXjRIVmd9/cMt7ZZWZ4U2ZHd1Vo+XdEvRuEzATg3BzxSrHJRW/e6TT8wGE/ZoBLallkFyP3AuVwqlGmQO3WsgzDOPiK+rL03F6K2EBLJ93j0o7ghCAtuCF4e21BI7N1IdyHH9HQ5Rp9OesYDLsHBDkUhRsqgq6YYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(66946007)(2616005)(5660300002)(66476007)(508600001)(31696002)(66556008)(86362001)(6512007)(26005)(6506007)(53546011)(15650500001)(6486002)(8936002)(186003)(83380400001)(31686004)(36756003)(4326008)(316002)(8676002)(2906002)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2VubEMwNXZyeHFEK2JGN2d5UFkrcEFsRTk1cU1YMG5nOVd5R1lMbHN1RlZY?=
 =?utf-8?B?a29JanNjZDlGZDBtZ0oxUlNBTXlpTDg1Wk9KNERlMllTOU5wVWV1QTFLTEVI?=
 =?utf-8?B?VEJ0clR5OWlxbk0zMzdCMFhNZ2FCcnE2RzdqTFBkMlgzcm5pU2xPMkFrakh3?=
 =?utf-8?B?bm0rekFPYm9XTElKZTV1UVkxdERvbG81VW4zNEptL0oxN0tVUENxZ2VZTDFH?=
 =?utf-8?B?anY2R3JQbDAwNWV1ZmtscHdxUHpOTG1kNTBtQWxSVlVkRDZmY0xFcW1wVWpQ?=
 =?utf-8?B?U1hRb0xlK1M5VDVEeklRdFdVSjdEbmh4RFRKMzA2MTBYZngxLy8yQ3dpdjJT?=
 =?utf-8?B?ZXRJdG8rVjFBUWNlQU45Z0xwQWJTckgxcHFyb0JCenlsNFR1c2FpODRxc0Y2?=
 =?utf-8?B?bk1mamtZbnRlam8vdDhHVitFSFJjWnN6bWZGa3ZzbE1Fc09Zai9DQTV3eS9C?=
 =?utf-8?B?cGV4eGhSYVhFbnh2ZnE4S3UyL3lBZUZrVU56elN1WTVOZDRmWDl5R01Rb2or?=
 =?utf-8?B?WE4rem14M0o5RDM4K284TXVIQUJtK0tnS2Y5dDd1V0gwVkcwUHJFSEVlZFBY?=
 =?utf-8?B?YzgrQW5udUk4RjJsRmZ4K1U3MWoyMHRUWU1NMDlsemM3Qy92ZHVFQUpoNlBH?=
 =?utf-8?B?TGhIOXNrMDUyR0FkWXlFdU90M1FjVFpDTGNGUWR0ZHZucm1QV0lTcXNhVU0w?=
 =?utf-8?B?bjJXMlZuVVZvT0JuZG5CRFBEREJ1Z215ZlhSTmJacExhQkhSY01UR3ZiUHU0?=
 =?utf-8?B?ZWxvakF5YzdPMEFDWTlkQTJFUzRFSHhrT0l2QWdyNy9sWTR5MXg0TUwzSTIz?=
 =?utf-8?B?QTJYSWxjbU0rZEd5M0tlak5LYmVIVC9hWCszVUNIMFdXNE12V1N3aW15WVRk?=
 =?utf-8?B?MTVZU3FaUVVJZVloU0lyVjdXWVFlYnZ5TnZVTG4xYzM3dHgvbWM3NVpXM3Ji?=
 =?utf-8?B?MnRSczNka2VsRTFzeG1xeGFIdU02L3ZZZy9QNFBVQmxZRjRJMlVNNXNqTVBE?=
 =?utf-8?B?aTdQalQweXZNWURpcmhMZDdiNVg2Z2FlaWkzcmRzdk1WOGhQbDI0VnpJUFZ6?=
 =?utf-8?B?eUZjTkdiVFR2ZkRIMk5wekxNVGVNM2RlS2FBbmMyL3MvLzBhSUhrZEd6K05Y?=
 =?utf-8?B?ZDZYS0hPemxKc2p1R0ZIV2pUUkVEUWRjdG45aDkrd2lWL2RZUXFLT2NEUVB3?=
 =?utf-8?B?VURRRVRFeExLYzRXS1ArbHpWNk9aejkyaUd6R3RYK2dtc3hJbHAvdmJqbElh?=
 =?utf-8?B?L3B1SEhudkI2ZFRzTnBNR2lTdUNNejUvNTRkcnhvcGx0WjhoeGhOMDFRYjVK?=
 =?utf-8?B?OS9lckVISUt3OUtORkJkVThjUGs2Z3dwSnZ3dXJUUTBrald4dW9qYzJFNGVD?=
 =?utf-8?B?NDV6STNNczNuYi9FbytVeW0yOWNnNDM3OXpYa0ZhRXZycFYxZXNjdW0wbFZN?=
 =?utf-8?B?YVZpdDB6WHlpZ1RxT25MYzQ3ekl0b0lRM2RvRWJIU0tBdWFjV2daL3V1TEZh?=
 =?utf-8?B?VWpObkpOdDl3WE9mRmdWWFoyREZyY2RGL0V4Q0ZYYUFSVWhpQitHT3ZCV2Qx?=
 =?utf-8?B?cno2TW8raGFFZmFEdFIwbTNjZDZUV0ZONUNTRUMvYjhJMzU0VE1SNnlmZWlD?=
 =?utf-8?B?dkFSeUdBRTF3ZHIxQ3o1dnB3c0FXVFh0MnNjWDYvai9HVDArNStjQmkra0Zl?=
 =?utf-8?B?TnlyUzNsNVZlbEUxemY5MlBuM1lhSmEvTE9VQzdVTFl1QmNoeENlRFo0eUxE?=
 =?utf-8?B?c1F5c2xzQnJTcjR3TVQvZTEvNnF2eEZvYy9nakFjcFNQRnYxRWtxelR4enhT?=
 =?utf-8?B?RUx3bjdwRWZWdWUwOWtINjl3SzZoSkRLdzdyS210cmp1RG96RENYalU5N0d6?=
 =?utf-8?B?czBtRGloZkppeGEyemdWMFJtNWIwNTdxNW00RnFYZVFxL3Y1WThCQW8zWmtJ?=
 =?utf-8?B?bXBNKzh6QitFVkt2RHRISWRwS2dzeUp6ak1wKzJBN0VlTkxmRFV5YmE0eDRh?=
 =?utf-8?B?RVVpNmpDc092cUkzTExvdHJRTkdrQm9GWUFmeTNOS1g5T21oZ2dXcVhJY3U5?=
 =?utf-8?B?THF6dU04T09ZYU1OTFU0ZDkxTEZIUXpzZUNjb2hDVWtMRXNCdUkwY3lMa3c0?=
 =?utf-8?B?N24xR2hZa2hwMHVra2tmM2VIZGtLNkFkUzlOazl5dUtNM2wwajZDZ2xkTEF1?=
 =?utf-8?B?YVdCTjdSSkhrN2R4VElZcFBXS25kbnZhLzZkVE9tZVhOSjBydHdUNmd0bTVU?=
 =?utf-8?B?d2tuaXh4WFJRVFBaVXB4VHovbTRPblRua3VIZFRIMVp0TWp4L01BbGI2WkhT?=
 =?utf-8?B?TmxibXUrSGdGdktNZHVXUmFGZFp2dzBjMytiakVMc0hIdGJNNWFRQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08276c9b-1762-43b7-7b88-08da4572fba4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 15:08:57.8357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh27C7fdfygEvugofzApD0fnhmfOsStZUUlHF3VhUlOS0NIn+fuXIr662bUKnQuh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB5701
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
Cc: alexander.deucher@amd.com, Mikita Lipski <mikita.lipski@amd.com>,
 dingchen.zhang@amd.com, roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>




On 2022-06-02 16:48, Harry Wentland wrote:
> 
> 
> On 2022-06-02 14:03, sunpeng.li@amd.com wrote:
>> From: David Zhang <dingchen.zhang@amd.com>
>>
>> [why]
>> DMUB FW uses OTG instance to get eDP panel instance. But in case
>> of MPO multiple pipe indexes are passed to updated the same panel.
>> The other OTG instance passed would be ignored causing in DMUB not
>> acknowledging the messages.
>>
>> [how]
>> Add panel instance to dirty rectangle data and cursor update data
>> structures and pass to DMUB.
>>
> 
> I'm not entirely following why passing the panel_inst solves the problem
> that is described.

Oops, it looks like the commit message is misleading.

"panel_inst" already exists in the dmub_cmd structures. It defaults to 0 today due to the memset, which works with single eDP scenarios.
What this change is really doing is identifying the panel instance to run PSR commands on, instead of assuming that the eDP we want is always instance 0.

Will reword the message.

Thanks,
Leo

> 
>> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
> 
> This says the author is David but it has only Mikita's sign-off.
> We need David's sign-off as well.
> 
> Harry
> 
>> Acked-by: Leo Li <sunpeng.li@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index d4173be11903..31d83297bcb5 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -2837,10 +2837,14 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
>>  	struct dc_context *dc_ctx = dc->ctx;
>>  	struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
>>  	unsigned int i, j;
>> +	unsigned int panel_inst = 0;
>>  
>>  	if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_SU_1)
>>  		return;
>>  
>> +	if (!dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
>> +		return;
>> +
>>  	memset(&cmd, 0x0, sizeof(cmd));
>>  	cmd.update_dirty_rect.header.type = DMUB_CMD__UPDATE_DIRTY_RECT;
>>  	cmd.update_dirty_rect.header.sub_type = 0;
>> @@ -2869,6 +2873,7 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
>>  			if (pipe_ctx->plane_state != plane_state)
>>  				continue;
>>  
>> +			update_dirty_rect->panel_inst = panel_inst;
>>  			update_dirty_rect->pipe_idx = j;
>>  			dc_dmub_srv_cmd_queue(dc_ctx->dmub_srv, &cmd);
>>  			dc_dmub_srv_cmd_execute(dc_ctx->dmub_srv);
> 

