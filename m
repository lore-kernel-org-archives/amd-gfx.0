Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3611C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 17:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1728910FF0E;
	Fri,  3 Jun 2022 17:30:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B80710FF0E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 17:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5qUkyKVXElzNsaSM6cVKguZu2C2teMBinPpaqaJHe59nalN4n9dTlg5e9qryoPSSAol2ZKCSaYmMZhTIVbzShtgYyGgKWb1yTuvSkhyRM1cN3ohpccWS1tpFFRtNymHeIBFUzBi42yttOWJ0W+xPC1qBGONkZuL5HshtXllgr0fjmNahB8UBbTIhSWaDOhjGGUNBio5h1zmzxqPrI3Wh8/smgKMnqqy9uAer5kolEG+eKCMdUCoLZNSyQ/0jPe0u8Qcjyzlfp/9kO6rLPMUm8dqq2UW06PxYXqlYU/Q8wWkfEKYqbbhzV89VegN0ZR4EGyr2K0Khcl6UH/rgchg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byva+DNRhuP+Wh9uK2De1PXg3rD17hCH0nnOsOaOnMw=;
 b=YgPGY9mlEKTlvyWpCWIIZDcXfgWF7epGz/H+bYo+6gI1RWOAnurgz6jPoaUOV0g9A7GoPPd/K0rWrWOME0CcrejIcT8ZzrbJRRQYATZBmkM6viEMj85tOVIGNQCk4h//llxTG0NsF8QkFfP4SWZyo3ZhhdtOkGq9H2V4AAGXi/ADxRpymicEPQoaBdhSRxEiooLNj+5e1ArmDxzwT0eBagcjODhrKRYRaDJOK2hKlSDsJwE0rydk7tcKVcigEuRUdphKqGO/HVSIxQjqGSYBYNAfwltD//IHzh1YjlJNHuu2gYUyNr3fWlGZ7VNwCFWBnYxdA01LvKPTeUsEULdLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byva+DNRhuP+Wh9uK2De1PXg3rD17hCH0nnOsOaOnMw=;
 b=uyZKilMJmVcWjCCIpPQFGtT+kxryyz2Kl3mG7iEqBaieNJmQv5pQty/kKU4ZEdvF3XUOEwLhIBQIyDrg3YJPEsTlG9BP/9YrSYSO+LRdcUk/rBFHIVE65nPsS7Rp3txA8JOlpVr8bM5SjSVCB3JnENEkI0N0hCBBXHwGO7YZqNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 3 Jun
 2022 17:30:29 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.016; Fri, 3 Jun 2022
 17:30:29 +0000
Message-ID: <50e8cc35-9029-b276-9352-71f0b010997e@amd.com>
Date: Fri, 3 Jun 2022 13:29:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/4] drm/amd/display: pass panel instance in DMUB dirty
 rect command
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220602180347.754067-4-sunpeng.li@amd.com>
 <20220603163219.1134064-1-sunpeng.li@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220603163219.1134064-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::37) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99546d02-2f07-4c79-ce1c-08da4586c0c6
X-MS-TrafficTypeDiagnostic: MN0PR12MB6294:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6294200354948E3A9216E3118CA19@MN0PR12MB6294.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZQxspSfLFh76SisfeGsal5MU1QsSyDfxPqDTYptiWgoTpBCYFYGv9Ykj99I6lCWivCibe/mmAjrIzKzOhv5b0I7rdqSyz6WiAqXd+C8fP8rTCEkKRk3Z0loURrqX6U9sS/rd7tLwEsFfH69/sSH8qpqnE026XL2NXkC1CNDs/6SF29TQ1vN2XqtQKKrRcgh1WazsoCBp6WElbnMgP4Vs4hnuWaAOxeAWod25JiNUHMK7OEYf+XC9Z2ycvxbhgDKCQ4vB9K3cnp7swZcBCpiCkLdHSRxpFsLRL42A9KHNfJodpsexPMznyiUpHuTHZdcDsNMVxyburQijk2kf46G2G0hXGCFshR4nyPwyeQ8Rpqs7Kh89AVLWcJ9/MAN/DewHURaSWZkEwMwyk8z/PZlBJ7q5MpMmfIT7Yo8MKH6tw2RQsxOLzrqtaytz+A9/KTe6mLvrZs0d2owsuNDVnEBXUjITP5cArUb+mpVz/R+fimy+cv0mxNZNvYXLNSzFRjhXp4IdUW0CkEAgENTsqjuRM118WU6VlS7jAv9A9TzZSzRQ8NIz7VaGH/WcxcK3etWItkT58lbqfRxxx/LLo5Ej7IuiRV5Jj8c3LH8R8cf9JIAYVuAe/1hA5LK9zX5QqtB1ofgbvtIrlBvJWPL9HKEEh2iM5c+ri734lofXXlviHPX92nai42L4Mjrr3bwBUzTfKjOEIumxrmIJKPLYcy1OKEK+EkQ95J9JPCa+zFr+Nj2glHcN70865eE0kqEIPadGTvXyCCXlSCqMnCsylOorQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(53546011)(8676002)(83380400001)(6506007)(26005)(316002)(44832011)(5660300002)(6512007)(4326008)(66476007)(508600001)(66946007)(6486002)(186003)(36756003)(31686004)(86362001)(31696002)(6666004)(2616005)(2906002)(8936002)(66556008)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXZvZ0ZOeEdRQWkvS1hibDJUUE5CTklsNm5HdEN2NHlQUFYvMEt0T2NjeTRS?=
 =?utf-8?B?L1E3QVVFZUh0dW96MTcrL3VEakxTRE9LMmJNckI3aHdZY3lmQ0tmdzVDcGZ5?=
 =?utf-8?B?ZWs0RWFFYUJpcGZac2tCZ2lHdjM3WnF4M0VHTU1HYzU1WUFIUng4OTB3R2ZB?=
 =?utf-8?B?REkyOStVOVYzTitET05IOTJ2VEMxYy9KUTczM25JK0QzY2pzT3ZYUXdWQWxa?=
 =?utf-8?B?MzkzMVg4OTJyMUNxZHgxNGlabjVPcE52dXgwSkpEcHlkeENlSlBlY0N0Qkhh?=
 =?utf-8?B?bXRMMjJ1QUlwU0FoVG9BZkZPZWVXcGpobTJIcThMbGFrNzBHdk1rc1ZJMlVX?=
 =?utf-8?B?S1N2OGxJQ2pLcnN6aUUxR0F5SHVEb0dHUVgxNGd3UEkvWlU2SGRUM3NTeks4?=
 =?utf-8?B?Q29BSW9EcG51MnllTS9Uc3lSRXkxWkFGR2xGU245bytLVVJsWm9PR3M5eFlS?=
 =?utf-8?B?c0c4WnNyb2hMc21MMUNLWE9rVWdGWmphYjBzV21KZkdqTGJqR0dkNVhlUXd1?=
 =?utf-8?B?NXRRazcweHZmUjBDN05BSmFCbTJoUTRmVmREV0ZPKzBsbjgrVW5hZEpad2N4?=
 =?utf-8?B?cGFEUnJCODQ1SHVQT3BLRHpZak9kQkcyN0dvRUkvaHlUMlRra3p6bm9KMXlW?=
 =?utf-8?B?RDJLYlB2NWVEWDNoTWlJd0huQVo1eWladmZFRUdVKytoNnNwWUpZUFJ1SWFK?=
 =?utf-8?B?SUhFQ0lRTU5GN1gxSHhXVEYveWtoSE1hMS9KRFVna1VIUTlmUC96MFUyWUVo?=
 =?utf-8?B?Vk5QaERlVll0MVIxWmtzcm1oMGRidTNzZk4vYklxU2dTOTR6bkg5TnhEUDND?=
 =?utf-8?B?U3hWazVQWGJuNEw4MnVqWTFUNnVyblIvcEZkT3F4VmlaemlZbzJMcTlzQ3dq?=
 =?utf-8?B?WjFLYVlkdE5sbjBLZithQlVjeGJLRDNaejhjRXAxcUlYOGI5aFF6ZTFvblJK?=
 =?utf-8?B?VUpqQ1FOR1JndnlSRTJ0K1Vhd0NDOGRrVnA2WTcxS3pHc1BTK1RRUFNFd2xG?=
 =?utf-8?B?b3M1NDEvQmVneFB1MUsveHZOTlBkczF0Z1EyR1VlZS9Qd205aVkwWlJlaVJH?=
 =?utf-8?B?RURROHI3L0Iwb0dvVEpSU3QwaWo2bGpRd1Axb2tKRUR2c2tFUmxrMnJYNGFm?=
 =?utf-8?B?S1B0c09xVVB6YjVhYlZ5aGZ5WVAxU1oyZzF6QzEzS29pM3V5aTJoTVJQM0xM?=
 =?utf-8?B?ckxoREhYVmhXZWtabzZyeVdvalR3Rnp2b3FPTTdzR3luYmRRbmdub3p1VDh3?=
 =?utf-8?B?TlJOSDFFV3BJYjJ6d1AwMXVrYjZGWjBUYW9zTCtyV082enN6ZkJ6Mk1lTnIr?=
 =?utf-8?B?aHRNbzVLT2JMdHRNNjhIZFFSa0g5SXk2RVlnMFhKdDlMYjIzTzh4cTcxdkYv?=
 =?utf-8?B?Y3BPWnJyaGMvZEZMb3JwNXhETWh5UExFb2lnYS9ackVLMUhoWXl0dlZjdVJv?=
 =?utf-8?B?SXJsYjBubUt3RUl5VnJMSW11QzJlMHZHTXNlNVlxN2FsZU9nTVNXUFJWRnNY?=
 =?utf-8?B?bVpnVzNXcmVnSWFCN0pnMHdTdVAvS1JpYk44WHNheFhFYXBJZ3E2YnExRU84?=
 =?utf-8?B?ajl2cTkwSW5iQzl3Z0VFMHRRUU1hYmczWmlpSzhmL1BwRzJtVzVZbE9rV2Rv?=
 =?utf-8?B?b21wVEhVTFZCb2NBcmNkOGJKTW4ycUFzUjVKNTNEVTkzMDRVajRDZnBVZkFF?=
 =?utf-8?B?NGh1VUFMZTR3OXlNT3FlZFdROWdpeDNIY0VLajVrU0hlZWFXSHhadGFmMW1t?=
 =?utf-8?B?ZndFeWpUL2JlQmwrTFp6QStYbGt5RnF0cVQrcU9IMnVKeHk0ckkwaDNVNXZv?=
 =?utf-8?B?ZzNlZzVXVVF2NElHRVVNY2toeG85OUlpQVBacm9VYkUvSHdrWEh5QlMyQXVs?=
 =?utf-8?B?eVpCNWwyU0xia3ZSK0NmVnpPMTlacFFPaUd1NWpobFZTYkpJdG50aEhjMFpV?=
 =?utf-8?B?SzBURUg4V3YrYmVzUG0ra2tOSFduQUJaWnBPdmFURHBhOXU3MmVQcVRPZmZq?=
 =?utf-8?B?aXVnem5MdURhMmxMWG5VQU5sOFZsWU1CakRoS1RrWlNyMjhEWXFOMzYrMWVI?=
 =?utf-8?B?VndPTWR6ZHV3VHlnK2NCUFg2eVo1cDhQUHRPei9qVlRqeXZ5VjFGeWZEWUhN?=
 =?utf-8?B?Z3JVVjI3Q0tubE9DenZWUDR2TkVZWkorWUxSM3FZZ2l2d1hsZjVlcGZoekla?=
 =?utf-8?B?K0FmSzdFdjNCM2VXK01pejhibXE0OXQ1eFF2dWhXa1M0ZVUxVnc5bU9Ebmdn?=
 =?utf-8?B?cm80ZExQd2VGNHA4dUhiWHFmSG80cmVSUERvTkxXL2k4QTFncVVsL2FCTTlt?=
 =?utf-8?B?QzhYWnZhZ2kzTW00ZnRSbDNLLzJYVGIzaXZzL2c2Y3JhTmFvOCtUZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99546d02-2f07-4c79-ce1c-08da4586c0c6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 17:30:29.2128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stwBlrwQoiSgRYMY5tpbb9Hk0AbneosM0G2UPu6P0KJGkNQhhyghIePg7oKwwUnMfYBSwnwglQuzLvsOBKkMLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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



On 2022-06-03 12:32, sunpeng.li@amd.com wrote:
> From: David Zhang <dingchen.zhang@amd.com>
> 
> [Why]
> 
> In cases where there are multiple eDP instances, DMUB needs to know
> which instance the command is for. Today, the field for specifying the
> panel_inst exists in both dmub_cmd_update_dirty_rect_data and
> dmub_cmd_update_cursor_info_data.
> 
> For cursor updates, we already specify the panel_inst, but that's not
> the case for dirty_rect updates. Today, a value of '0' is used (due
> to initial memsetting of the cmd struct to 0)
> 
> [how]
> 
> In dc_dmub_update_dirty_rect(), Call dc_get_edp_link_panel_inst() to get
> the panel_inst, and fill it in the DMUB cmd struct.
> 
> v2: Update commit message for clarity.
> 
> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
> Signed-off-by: David Zhang <dingchen.zhang@amd.com>
> Acked-by: Leo Li <sunpeng.li@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index d4173be11903..31d83297bcb5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2837,10 +2837,14 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
>  	struct dc_context *dc_ctx = dc->ctx;
>  	struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
>  	unsigned int i, j;
> +	unsigned int panel_inst = 0;
>  
>  	if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_SU_1)
>  		return;
>  
> +	if (!dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
> +		return;
> +
>  	memset(&cmd, 0x0, sizeof(cmd));
>  	cmd.update_dirty_rect.header.type = DMUB_CMD__UPDATE_DIRTY_RECT;
>  	cmd.update_dirty_rect.header.sub_type = 0;
> @@ -2869,6 +2873,7 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
>  			if (pipe_ctx->plane_state != plane_state)
>  				continue;
>  
> +			update_dirty_rect->panel_inst = panel_inst;
>  			update_dirty_rect->pipe_idx = j;
>  			dc_dmub_srv_cmd_queue(dc_ctx->dmub_srv, &cmd);
>  			dc_dmub_srv_cmd_execute(dc_ctx->dmub_srv);

