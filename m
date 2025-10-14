Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8443CCCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 21:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A3810E0B8;
	Tue, 14 Oct 2025 21:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FNXHiWKB";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CF910E0B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 21:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj23puD1R8gac9D0qeOgyNzi6SqidlbByV6LFeujBFZiu3Bs5Kk6TjY4lLtaQ6GrROLuyvB8qHLrC4d9oTZ3KboJ1oIlw4DAuqIX18FArOgegT6irq587S0XRO0Zhnzk8sF4JdQKmNtyYVuqAitqDEvzWVWMOcmZq/a6NroSC64dDDg4ZMRSAWaDhn20Af/Fd9OgGk99p3G773J99LXL7MJempXjaVilMdLD+MWbqjBy0znFH5UP0Ebvhxfwho/4JJwML/U8S73b6xDQK8JfSiJRQdbPVIM3QuEJxeYWNUfGX+WHQlOCk0HcemSiyKedLiYrXZn2TMsYkDycKvwhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l0A43plNFnUjkitGUlANPFj0c03ua1GwOhNJ2f8dXg=;
 b=brTeckVdcOwTb4EzeSbfqLWwEEd20pasjXdFFUQIt/EgHjZ5GLwmPDtykoDSl+SCR0lldbpKu0Z2kzRbhUYaaE+Ce560BKzEjAM+7vZJXK3NKEUOHu7CPGejAnaGRueMhMGQXyueR9ktDU+HOUwuWskFm4crpltX6DCA+/fEJ2TdgzqeKPy7HXmdeN5q8TPG4KVn2pGJgnZgi+M9Aa4J62U+6QlGPI6dXlTt8a/xtLkslDZrWvT6ZIavvbMvpjfAg+5ezJrgg7pjqFxJTJ9gDEZFSZ5qXULHnrbykvqDESc0ghNRjS4V4SgbdrGN7bobcCmHnaf3b0TpE5S4L2SrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l0A43plNFnUjkitGUlANPFj0c03ua1GwOhNJ2f8dXg=;
 b=FNXHiWKBY79SWnPNNNQ2iCzr9wu6tmwXNH1AB2GZpRRr1ma0T4oAX9GQ06LnEzffLea3weXgokC6rsB6DsZQ/VU/STg/9Q10uEMSZhfzhV25tAHXya7+8hso4TIn5FfuRVnqFr7m4fadkrv58i/urrxfo22aNflvnF93FAm6JhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 21:14:07 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 21:14:07 +0000
Message-ID: <2000e575-3ef5-46a7-81bc-71ea4fc0c327@amd.com>
Date: Tue, 14 Oct 2025 17:14:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251014193036.595453-1-mario.limonciello@amd.com>
 <20251014193036.595453-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20251014193036.595453-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0589.namprd03.prod.outlook.com
 (2603:10b6:408:10d::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: efde1503-c011-49d3-0f01-08de0b669c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OStxNXRoRW94cUdvQ21aRXVEMFhTaGhCSnl4dG5lRDkyNVVPQUowNmFpbXBE?=
 =?utf-8?B?RHE3WHJ3blBGNFVoTVpnbGtRbm1wZ01FS24yb1FyTVpwNXBET3NmWE5IOW9B?=
 =?utf-8?B?VENlcTNQZGZPN2ovVFBHNDNWeEw1SjhxUmo1cFZnZWFzM0diTGNyTm9FWGE2?=
 =?utf-8?B?cXBxS0Y1RWErUHBXamdLam9xWDRnaEk0YTJoWEJlb0tqV0Yzc3p5ams1Q25j?=
 =?utf-8?B?R3p5elNka0oydG5ZbWlWVVV6ejBGVERVcHZ3d1VnYjhmcktTQUtUckV1WUw5?=
 =?utf-8?B?QkcxNHBXN0M0ZlM5WlJvaEgydjR0aEVGektTdTNxTVdxZlFRTWRqQWF0U25R?=
 =?utf-8?B?a1BGT1dzV1lab0xVWXpTUGtjaW1LbjR2M2l1T0NJMDdMWHFQSWNFeWxpcVhm?=
 =?utf-8?B?NXR0NzVXSzBRQTQrSmw1YXZ3TGxQSXhKWU1XL2tpYXJYUC84VGRRNXdTSEtY?=
 =?utf-8?B?R1hOSFZ5MEN5dC9RSVNSbGQzeHBCMk9wRWNlUkcrNW5zN3pWRnFqM1ZpTHE1?=
 =?utf-8?B?VlFZdzdIOTQvSC9UVnBzNlFrVFZvWGprSjdpMUV0UHZ6cEVkdXlFMmlYckhv?=
 =?utf-8?B?NWtXejJhbkdUUDNwOCt6MFBzdlZ4TzZ3K2N5N0kwZUtwNC9IQlZjUkFIaCs3?=
 =?utf-8?B?Z3J3dm1tVGlmM094bUtFbDQrNTJhVDlGdXRnVkk2TEk0TjNKK1pnZVRwOGUz?=
 =?utf-8?B?dzlYTUY4Ti96a09RZk5DVnd1NExFWXdUajhNTkVsTnlLRDJsMUo2QTJIZC9w?=
 =?utf-8?B?Mi9ldHNBOGIvWUZ0NzcwS1d1bDhtVjJGandxQnFtV3I3RnBXZVlBT2c3M3J5?=
 =?utf-8?B?VThFMVFsVVZrdXdrNTNkSTZEZ0drVjJvWlBUbHdKbno0QkNtYngwczBBRlpM?=
 =?utf-8?B?MStvYXNFb3JvTkdPRkhJeStjNEt6aEtBZ0h6T0hUV2JzT2YxVFN1Z3FKci9E?=
 =?utf-8?B?dzJXOTNPRE9uQTFIajRkYlRaaUQ3TEFMVTFNSmYxbFRydit6Umh3WDlKMUhZ?=
 =?utf-8?B?T3dhMzBDdERlY1dwQVJuUGhQc205YlZMMkU1RyttWXlVdENXdERRa2RvdXds?=
 =?utf-8?B?SVZsS21WelhiRzhpR0w0WXhtNmNwV3hsWVREdlJUT211SGo4bTJmTDRtMXN4?=
 =?utf-8?B?Ui9qQlYxMkYra05DZW51TFdOL0RzUG9FS0xaQjk4bHpzNmxjZzNid2NrSFVR?=
 =?utf-8?B?My9GbVl6blRLeE52NjFleUY5VHJ2VDhZS1ZNcXp1YWRyWEczSk8xeW5IMHZ2?=
 =?utf-8?B?amI2c0VqVWJVS083MlRkREFPYm1YdHFLeUlUYTQ5eDFHckYwWklpOHlCZUxS?=
 =?utf-8?B?bGQ3V3hZYTdwWFdYbUVtZnNMU3ZXNzBQOEFJalIxQmJOejFCelc5TEg3Q0R2?=
 =?utf-8?B?dzJwNUF6NW1oMnpHMVE3SEJjNWdGbGMvVUJVWjhEbUlndGpsQXZXTDhqOFFp?=
 =?utf-8?B?UkNDdDIvWGE3czdBcU9NUTVNa0s1ZlJiUGZwWUovcWRDNldoNDJ4c3hiYVFI?=
 =?utf-8?B?VSsvcW5zSi9QanNjYXA0Qmxwa3FBSEFNSXNjYkx2a0QyNHUzMUlhM0daTTkx?=
 =?utf-8?B?Qm9zcFY4WXhQWlZRSlUxUWpwejVjVmgzSXZFaXBHcDgxcHFyZk9KODc0Z3pL?=
 =?utf-8?B?amZ4OGtFemhWOXRCS0Y3NC9keUtSVm9FaUlmamM5aVVyQzduckJkclhGMDZz?=
 =?utf-8?B?a0FRNCtVOUVjWHp6eDZxeXFkSzZsSDdxOU1OSnV3WmxDS3hmTThGcDNJeDBv?=
 =?utf-8?B?VzFHVFBUZEtid3pNSjBxSXVzekVZYXd5aUQvN3FyVkxHQWJqd3ZFbjFIdXor?=
 =?utf-8?B?Z2YxcUFmUmJsa2wwQ2ZkZjZuNUh3RVoyNUU4R29rZHhveDV0RWxBUkFwTTJh?=
 =?utf-8?B?SGxiRVB6Z1FBeXpDMXg2UVo1dXRMNnZ3elluYU1ieVZvUHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFsb1NwZ0RTZEJVVDdTbXc5OThkVGNyVG82V29FdFJSNUZSQ3RLMkNtZWhp?=
 =?utf-8?B?eG9YMDhlaDBsQ2Zzai9ob2FhT2k3enFrNXcxZ01sOG1QamhNUms5SmZqYjdy?=
 =?utf-8?B?V2htZ1pncm9BVll0NkVmT1NtVWhXMlY0S0gzYjVDV3pQaTgrZUovQncwQ1pM?=
 =?utf-8?B?eG9oSlVTY0xGbDlOamYrOTJEMmJXdUNKZkRCNjZISnFTdFNYbUJOR1U1bVJj?=
 =?utf-8?B?Rkovc0xGNlhhKzd6ZlFjQUlzV0JPVitVMDJtc3RiTHpuajlONHBZemhqSHdU?=
 =?utf-8?B?VkZaZE5HNy9nSHc5VnRnSVRDa1BiNjRnbmg2cE5rV29KaW94TmJlcXZiZ0pP?=
 =?utf-8?B?V0sxOHVZUHlkRGdKTnVNVFU3U2JTWkdEdzVSVUY2aUZTcmk0bElIVFBjN0Jn?=
 =?utf-8?B?RE9Pa3Y1M3RjNzN1enlmWnlyUGlWd3BSdmsxaTNoSnNiRnNxMmNBZHdsenNT?=
 =?utf-8?B?RVNKekFCQWI0L1NHRi9YZVozZDRMbTUvWDZMeTdRbjl0TmNPTDRjWWVzUGM5?=
 =?utf-8?B?Nnd6ODRNWElQdC90eDQrNzBEOXZwS1ZoUEIzdTBqNUViQ291dkRaTXlQYzJJ?=
 =?utf-8?B?eVRxVVlFWW1oNml6OGZaOEYxNm1XT1ZYMllaR2s1TldVSm5lejZTbCtHNkNB?=
 =?utf-8?B?UkZxdFRxTXBxYXhVa0tGbG1JdHNyTHloTng2bUFCSUtIV2NVK1I5K2NTUG9v?=
 =?utf-8?B?d1RsVGw1eCtLMzgzQ1pTaTJnSUZ3d3lpZ1BUd0hyc1doQzFobUk5cy9zQ0hD?=
 =?utf-8?B?VDRYUy9OZy9PQzEvaEoxUnN1UEtvTDNFRjRKdTlOaTlPNG1XVUFWSFVLNy91?=
 =?utf-8?B?Rzd1Q2FtM2Jkb0tNTDlOaFlJZ0R4OUVyTFUrclZBRm5mTVl5d0xZTWxOdGM3?=
 =?utf-8?B?UmJMYkx0WjN6amMxdUo5ZlBOY0tKZC9oS1JCc3ZtNUpLQk1jUUxlNFcvaWMy?=
 =?utf-8?B?UFl5SDRHc3ltOG5sU3N1V3I4cWxpKzVOWkhVNDZOWjNhTHIyeFVGKzlYcEZV?=
 =?utf-8?B?b1NlK3JHOWhuOVZHcy9oRDBYTUYya0lDSVVnOGQ4V05WK3I5cFFsVGFDc0kv?=
 =?utf-8?B?cTV0dWpiVFM3TkcrWHpYMUlJd0hraURFNmRoMXhCVXViVlgzT2g1WkZxeEJx?=
 =?utf-8?B?NzRLazdCK2xqVFY2TFVEQTBDOGdENGFDUndnTEJGblJtSFJKSTZxWE8xeXYw?=
 =?utf-8?B?SXNRZHJLZ0pwalZ0OHJIa2NiZWZPRzdDdHNBMnJ2VTVycTFRWVRsRGVCa3do?=
 =?utf-8?B?ank3bWV4OEtBb2Z0TUJpejBEUkFRUjhiak9UdkhBRWJLczdlNFJ3OExRU1J6?=
 =?utf-8?B?N1pGcjBmV2phdUJXZUtvUGJHWGVzaC9IM0Q2MTlkVTJTcmV5a21sczdvL0Uv?=
 =?utf-8?B?bng2UitZSjNYSk5jekoxWVJPWlR1bFZKYUxCVVYzQ291TVZaK3U5UkJmSmx2?=
 =?utf-8?B?TjJ1Y1VTT0xVN0VGOEpWR0hxdmVFQVRjSG03RXUwR2dXTkEvTnRQd1gzdzBR?=
 =?utf-8?B?K1d6b0dqZEtaU1Y1UFJJaEtlcFowY1hVSHRKNlRWUStpM2hyUnlSZW0ya2FR?=
 =?utf-8?B?bkpoRGxLeGlUdFpoQVkybDYzbnVQTFVnYklsQWVxN1NMbDhNZ0U1S3JKN0g0?=
 =?utf-8?B?RjJPTnUxWEpzZlJSUW1iWWtDa2dPalptRnN3UTAyVlNWcUlkSG9UbExXTjU1?=
 =?utf-8?B?NFh1TFdwc1ZRZ3phTWVQMjlnNHpoamNac0VwbWpwdTBzdnkwN29jK0FLcDd6?=
 =?utf-8?B?RzFlRVdDUmVSQm01dE9penpESy80MkRZbkdLeGlIVE5lbVZmT1orOWxHdTdm?=
 =?utf-8?B?QmU1LzNVU2dPQjVzNVM4UlhNNjVmNmJlN1EycmFXaFZyd05OYlJLZmxyOElU?=
 =?utf-8?B?b0hzNCttcGlrNTM0RERLMnlnVFlGUkFxaERuZmwxdlZld01OK094aEYydlFJ?=
 =?utf-8?B?ZTAvUFltSHVORTF4b2xkSHpPYkt1OXZPc0NDYzlzUlhwdnJkQzMydjIvblZn?=
 =?utf-8?B?cWNSdFJBVEZGNVZZQmVncXFPNTEzLzVueTlBbzMrRkFPa1BtM0pHR1VXWW5n?=
 =?utf-8?B?QjBoL2tmS1JoR0tybm1RaC9ZOE15bnZNTFJqNlh0UVFqUUttMkE0SmxlZHJx?=
 =?utf-8?Q?M1o0pisnJfqCDiN5n8GI0pXJ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efde1503-c011-49d3-0f01-08de0b669c21
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:14:06.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKuUjLMUTpKty1klRog/WJLl+XfFsv/m5F3FxQR7ueLNWkJ7La8asZ9cJLtj0X888DfzE4Qpaew7BF3aOUNdLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
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



On 2025-10-14 15:30, Mario Limonciello wrote:
> [Why]
> If userspace hasn't frozen user processes (like systemd does with
> user.slice) then an aborted hibernate could give control back to
> userspace before display hardware is resumed.  IoW an atomic commit could
> be done while the hardware is in D3, which could hang a system.
> 
> [How]
> Add a check whether the IP block hardware is ready to the atomic check
> handler and return a failure. Userspace shouldn't do an atomic commit if
> the atomic check fails.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Harry Wentland <harry.wentland@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> v2:
>  * Return -EBUSY instead (Harry)
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6446ec6c21d4..f5cd9982af99 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12010,6 +12010,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  
>  	trace_amdgpu_dm_atomic_check_begin(state);
>  
> +	if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_TYPE_DCE)))) {
> +		ret = -EBUSY;
> +		goto fail;
> +	}
> +
>  	ret = drm_atomic_helper_check_modeset(dev, state);
>  	if (ret) {
>  		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");

