Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAF606A320
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Pxmms3A7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CED710F514;
	Tue, 27 Oct 2026 13:26:37 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA68410F514
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 13:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cj9w7dT2yDnPwusajTDp75Tj2mLI9OtXfkEQNpuAX0cal4N60hvMHXqU+0gseCqE4nODO8gMGf8s3PiWwImKWbx2Sz+2ltarODzR+FBbePf7lTDpocdYTRzOfgysOQDJpv7ObHL/5Q9DVxpvBnMt9QWSQXZBF4WxRdbvbX0dBtvxecMfcsw1UtzBv3KVLVkW67LelVdt9gq4VYkQ2zyZmeZqAo7KhGSg1r3n4GndER3+o1FS3wd4qstH5qDyrJhDrMHpmJOG/H1raRnoBe9sgShWDa5vRo7u403GnlG3yoe97TTyXV6+zgbl75iljiqrbG8V085uHxoVGbvuN8nm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zy44K5cAxGot4oYeOtN9jEpRyjkYz+/ItjFwhvjh1w=;
 b=hIej3dE52nszHL0MSpiqDMHC6Mfe/zuMrAOMUIqZry7y5xVfSmCZP+e5kokycQhLhdprBA6VGdd4+6VPeAyFQpal9TtM3/uFGK6RwOrqragAdHFFsxkwJgedMzoDtVTcHlSwS1FTV7CAHZJ8MP3ztJcMV/Tvu4gD+pPg1QsmfrVHtZD9YIDqMnv2/iC1NOzaaUFQ8tmxvfhq6BUj8Aqjz3u0qL4BME3SRliYwsN65PMI1Fm8Z3z1Rm6IUbYqZhPLAWzE7QqJWcAHABEJTsUM20CKR/UVD2aVpnaQQFVDCgfVpt0iVRkNJnZwLakjZijXo5K2BuErpR+jhYNYrOfxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zy44K5cAxGot4oYeOtN9jEpRyjkYz+/ItjFwhvjh1w=;
 b=Pxmms3A73ENe1TrvOJpe7bequ0m1WPtd+xOr4dKldnLOabkWbykxY+pijeSW7gXWI4rqCWdXqll9hwFlZl1tkHA8tDGz+oIJy8LKEa8djOclnCMBRMvQP6gtJj0lja84osaVDf5SGMcoI/mOnAz8NERPuRsDQyvo1kJ1a8UK4xY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:26:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:26:27 +0000
Message-ID: <0af60863-c383-4b20-b444-378440e34e83@amd.com>
Date: Tue, 27 Oct 2026 14:26:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu: Add UAPI for disabling implicit sync per
 submission.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
Cc: samuel.pitoiset@gmail.com, natalie.vock@gmx.de
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
 <20261022003058.1723817-4-bas@basnieuwenhuizen.nl>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261022003058.1723817-4-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:408:ff::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ef17ef-512b-42b9-29e2-08df342de786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261026140227099003|4143699003|11063799006|56012099006|261021123027099003|261022105027099003|261021121427099003|261009223027099003|10067099003|22082099003|18002099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: tSR8PJOjNP1rUZdI4ILQofvBMwQhFQxtVPx2Mg5RmBJPf8mvcKZfgb9BSe85OJTt47YBbmzuLkdz1lzY7V/AEaYsSHVhGBvpe78PUR5m/MZYOU4s86Hl9CM4tlcIf0v2TMs4wyvZ3w/JYBdRyTeMNkkBj/4zrWdrMDrUeTEPZAdDpfGGzxF1Z6mdLb/DjP2Ml/1Qh6BBj+BmBKYkfVQic/6c/1a95biUr+veQnB9G+o+Ch69w5tJEbTnpsuwePjbAZkBj9QEX0qouLb6XW5Dnzj5DnbhcBIPSOM5b0YDfcDd0vli48VR5nD1eB06l1j4oVWOu4XJupyIazcZFSkIC1VpsK+a2m94xDKFvcEAh5mpJ3KW3yDcDbYZzY8/u5I5O7KFRj9hFUfna/mt0itKrTYZWdnKCQeKCol02koW9MTCIK30HyZWFALz/oymCFOb/wR4AR+laYyJvKnTjBbgPCuVwqk3fW61QsQlQ+56QeTn/oehYY+gA1cMdwKjx/j0vUegBNvgL8FA8HYi4pE7MVHhbSHl/Xn/kW79msqUnHWlM/wi30/TLAz92hTpTth/O+GzgAljhjhrVq3Sh23xzM52pmma9zGwQIZARnTIU+8YwN/Ouf7PSGCWP8ymljOt3VU66ytmE+8EZX4ijghEeiMMybsJxZYQo/Xj1LE6WpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261026140227099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3k0QTBuQzVxN1M1OGl0UjVMbWlUZk9DdGh2Ym5VWklsWnJNZ3pjWEV0bjZF?=
 =?utf-8?B?RkR6T29nOXdmL0NuNGtLUVQxNXYrOXJOeDU2aUhMcTE5Rjg2L0dmYncraVUy?=
 =?utf-8?B?bXE0em85MU9Ianc2NjE4OW9HWWhmakFSNDZTU3kxaHVqNFhNS2VHZDZSVGU5?=
 =?utf-8?B?bjlKWUdiN0tOWjhiRGh3QlNlWkJhbnRiNDBsU3lRdTRRUjEva2lOZDdQT2Jm?=
 =?utf-8?B?Z0ZycTZKdmdWN1FORmljcUZUUUs0QXJBSUZaeDlXTUMwVzJCUGp3MDlnT1g0?=
 =?utf-8?B?UmRJTm1XbFdGV3UvTTU2SG9WNlN1Szh0MENWVUdaSXV5OVoxSUZ2L0F0WDB1?=
 =?utf-8?B?b3Vrd0MxMC8xSDBhR2F0alZ5bkhQa1RELzBGQ21FMVdrdGJUS1Z5SzJWZVVT?=
 =?utf-8?B?bm1BMGRTR21UcmdmaFM4UjY5d1RJZFVtbS9SVlpiaWFLajF2VjE0VkRXUFVS?=
 =?utf-8?B?MXBJcys0ajlPWC9rblhQOVlwcnNmWHphaWlaWUloTENHVzVFSU9uRTVBb0Jn?=
 =?utf-8?B?UjVrTWpSU2dsdjJLenVVNXpUS0hxeEhkVy9lbGNuemZIaGduUXd5RDdKWmw4?=
 =?utf-8?B?WVNzMDZRdWVBekdET205eVZGTGNrVjMza3V0ODU3NlBXUUNXN2tSSVByZmwr?=
 =?utf-8?B?Uk9QTWJEQmVmMHZHYlNaTlV1WUhpd1RONnp6V0NQbytuNFVacytKcXkrbFNW?=
 =?utf-8?B?cnJ5WTM3T2w5WG8zNmxwQjhDbW4wNjBlbnE3TSt1S2wwUVV2SUxQTDQ4S21J?=
 =?utf-8?B?UnlMKytKY1F3elg3VVNFNkx3Nkd5d0VJSG1ZdlZpUFlEeEtxdG1uWTJzQUhN?=
 =?utf-8?B?TitoTHQvYk40a2FhZHRMQWVxN25rK2RqNE9peXlFaUhycEFLVzJJRDdFelZY?=
 =?utf-8?B?VVo4UnZOUzQzYnJQL2JNRUlNS1RSWk9NWWJEU0VpVGFlOHZJSlV2VkduZXRM?=
 =?utf-8?B?cUEycnRUSGg0U1A0cWhPcHE3MnZDZWkyZ21xc2ZPQ1lhMUxLNERKcHNlc3Bu?=
 =?utf-8?B?RDV2eGRycncwRlg3S2JPYWVIRjlORUsxZ21NTkVBWFVpMGVGNTUwTHVkdHk2?=
 =?utf-8?B?NnJyc2xhQW9VS1B1aVYxVEVHa0VGVFFnQXcyOVBUMWc2M3VZRUVWQWhRTHJN?=
 =?utf-8?B?NmVmbzJyK3FQWExFUW9pNlZVRnRUR1pPSW1aNWxTK2xDczhSNTUyQXIvdGhT?=
 =?utf-8?B?M3Bnc1UyZnJMdWpOcFl5QnlQSG4xN2o2M1NlbmZVdFBrKzRPQ2RTT3VvT0ll?=
 =?utf-8?B?ZmRPTVN5N1dqWjc0T3FBQ3plcnNVZm4xaXNLWVFyU1gvUjZBKzAyWjg0RVA4?=
 =?utf-8?B?ekxsS2IyQVppQllJZVZPMzc5Um1KOHhub0FqL2ZTM1QvellQWjFodXBtVmVl?=
 =?utf-8?B?a0RnSU5RajVTYm96ZmlsRldsaWpYNGErTzlXYXJCTWovbkFwSWFTN3BvQk5I?=
 =?utf-8?B?RnRDVnZ5UWpqQTk3V0RuR3F1QnkxZDZzMkxyQnhKdklsQmJYS202NTI5YzJY?=
 =?utf-8?B?U2pBL2lOQWdEY3Frd3lhcFIxTzJtelpldGYxbTg0YmZBUE5qN2h4dkpHZHZL?=
 =?utf-8?B?TmJOa0o4YWlHMGsyQXR3NDJwVDBab3Q2c0NPZWtiVXJqc3N1M0FoZWV0QU5p?=
 =?utf-8?B?ekdIWHdEeFY3MXBCcWdId1RZRVc1OW05endWb0YrdmtWYmkrVDdyNXNndEtz?=
 =?utf-8?B?VWQ0Q2ZpcHFERmdQR1pyT3A5QW5hQWdmOUdzcy9VNGN5b0FLNm1vS2ZBZkRv?=
 =?utf-8?B?WDVtcFNuMzV6ZzMxeWRsSE9mR1FLbTVsTEdYdnVIdlNwRGp3aC9GQjNXTjlU?=
 =?utf-8?B?K2tidGYzWnVKMVVWU01oT1BDS3YxbnNLM2h6NTVzOWtVRXFyaHFiQmFreGtO?=
 =?utf-8?B?TS8xb1NvdlN0dndjSDdyakcrQWhNSnhya2ZMUytUcmJ4WFNoTDNtV2RuRDZS?=
 =?utf-8?B?Z3ljKzUwYXY3ZS8xcFdSVkEwVVBzYmJlci9Gd1lZbFhTRk9RVGg0Z1pZWjR0?=
 =?utf-8?B?TVZmeXJsdmVkYjhVV1IvdFlvOXU1YXE4R283eHhSdzdaSzdySlB6VHFMVXh3?=
 =?utf-8?B?Y2IzakxBWC9LeldkY00vVWtrUXR4V0RpTkxyTmx2cFpjMHlDREtPSkpWVUcw?=
 =?utf-8?B?OXBITVM5VXJpZkRRU0UzRUErdmxqcVZCaUsrU0FPM0FBL0hTNUVDMTEvekdF?=
 =?utf-8?B?Umd1dzMxbHBUZXhDVUkzeHZaMTFXc05GRFZIcGQvVCtTL2FzOTVGQko2Q3V5?=
 =?utf-8?B?UXZDK1ZVL0FTcGZTY1dFdjJ5WDUzZFJ6YUM4NUdSNkJjZjg5NWpGMWQyZ0xz?=
 =?utf-8?Q?jlsq5oQUAU3vsKIxQr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ef17ef-512b-42b9-29e2-08df342de786
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:26:27.4100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlpkSBAswZzBbTWvhjjCh7iBkh2cKyPQrcWBqRp0F4ga1pQaUVMxewnb4K5mJbZz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 02:30, Bas Nieuwenhuizen wrote:
> Per submission flag because:
> 
> 1) Slightly simpler & more flexible than per context flag.
> 2) We'd need to extend the per-BO struct if we want to put
>    it there.
> 3) Doing it per BO is annoying implementation wise as we
>    disassociate it from the BO list before doing the fences.
> 4) I don't really anticipate an usecase for doing it per BO.
>    (e.g. I don't think we need to selectively do implicit in
>     radv and I don't see radeonsi tracking READ vs. WRITE at
>     this point.)
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  include/uapi/drm/amdgpu_drm.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index cd1b8034a2fb..0f75221064b0 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -143,7 +143,14 @@ extern "C" {
>  #define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS	(1 << 5)
>  /* Flag that BO is always valid in this VM */
>  #define AMDGPU_GEM_CREATE_VM_ALWAYS_VALID	(1 << 6)
> -/* Flag that BO sharing will be explicitly synchronized */
> +/* Flag that BO sharing will be explicitly synchronized
> + *
> + * This flag should not be used unless the client can guarantee that no
> + * other driver which ever touches this BO will ever want to use implicit
> + * synchronization as it disables implicit sync on this BO system-wide.
> + * Instead, drivers which use an explicit synchronization model should
> + * prefer AMDGPU_CS_NO_IMPLICIT_SYNC.
> + */
>  #define AMDGPU_GEM_CREATE_EXPLICIT_SYNC		(1 << 7)
>  /* Flag that indicates allocating MQD gart on GFX9, where the mtype
>   * for the second page onward should be set to NC. It should never
> @@ -974,6 +981,9 @@ struct drm_amdgpu_gem_va {
>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>  #define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>  
> +/* Disable implicit sync on BOs wrt other submissions. */
> +#define AMDGPU_CS_NO_IMPLICIT_SYNC 1
> +
>  struct drm_amdgpu_cs_chunk {
>  	__u32		chunk_id;
>  	__u32		length_dw;

