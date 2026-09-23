Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9084AC98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A8D10F1EE;
	Wed, 23 Sep 2026 21:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n2+PDvHW";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C080010F1E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIvhDH7mYEQeqSYBOIi6uLwySCQm59XDzr3zIhmTHQ5pq6GnO2yGxBpYLcWIGH1gIO9JV2JFEFg8ljfBNuD/vjHA215S2S0SuajPryUNg5Ky0H8Wn2HT9P7xWKQzdhnusaVptAaa733CxOatVUbDsHQg1H/jvDnHQc8F01Hq08htMtSsY8KjuQ0CSMhtsGKHcjuwzkad85r+Gf+MpkxRtHcYaZpwsRveUYM2mt+m9OKeBqbm/ObfzrbPHn8TfBcI57i0/hsdZPbwjPFeHBhmf5DbMz/9gy4SnyOVqFWqPI7YzptqrgcU2LxMWv3DmWY7a67zn+WEPIG0Wte+/MiYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF9AQHlhPFOd3g+vjptqZ3DHJgj7jGVWPcfj/jJ1pTA=;
 b=t6xi5bPaQz+MAvYDzPHBQTu60StNmAnYbaLiMv2SRwtazy9FfffP/b7wcswUC9IYtqMKd5CddphKXby9e4TejF7fZRMuitiHSxgws3Xi8WaDEnJIbsZLvELnJdj0EujIAsJle/RPXjwO5fwAFdlyQeLiDi34s5wfNMUnniomzpUGxUJT5/BEvG+fjxNOPxitG4pBwaB9tk8yeO040DSx1sChILGTyVnJKFD+YnQJHE9SE0IwVo6uxpNaQLf/6w+z0K9My8bp4Xfewc1TgXQV16TKgg8an9dm4WtMsKCyHK8O5+eFp5kWB+rA2R+XMrbAqO6HtY7vZoYUbs51bEEDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF9AQHlhPFOd3g+vjptqZ3DHJgj7jGVWPcfj/jJ1pTA=;
 b=n2+PDvHW6ml8vMOar52z4T2sevN0Oj7jjMsp1lGhPiVQX5wAjt/HCZ7eghqdA8cGt85tdwn6vajhFFe1FYDop5CtCZ5aEOo8ca8FBjNd6XT8Nra2VrJuDhUni70ChFEfd5EXDiy0v7IeLXyH07RhsM+qnQph/WHwbQermgT6EOE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS0PR12MB7972.namprd12.prod.outlook.com
 (2603:10b6:8:14f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 21:44:27 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 21:44:27 +0000
Message-ID: <757e97f5-0836-4cf0-925e-0b0387572f74@amd.com>
Date: Wed, 23 Sep 2026 17:44:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/5] drm/amdgpu: re-check connection state before
 sending NPA-REVOKE
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20260923212515.1420047-1-mukul.joshi@amd.com>
 <20260923212515.1420047-4-mukul.joshi@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260923212515.1420047-4-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::13) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b638885-176d-472b-a0aa-08df19bbd79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3bDjqMamA/gQQPH+TYQgFQzztKpi8iQzz0wy3NTLEkcR6oxR0Pd+ptZ+J+63pf0vyPcW7bnC4aAsuAQB9F5awJl1V53/uXliWjQOe8rat7Zyyx708Bl9UEskMXl7pWfCOex43HivjHsm9H+HJywytYY5Gr6ctNMIDbSGnmSWxC6Q3c5vN1t2kEhwKscGImhdw1z8pcscJLbJgH2G/mj82NMnJPGZ8MUz2r4NS7mZDvNK1D/VNDIZ6oMkUL1yLJXJLdY5+TpoDjLFGphplQJYFuGaMElodzbEZ1AsuLwLQMdHMkEose+iho2TgrfgnriKlZuZw2nr2L6mX494weEzl0Yqcf3zwEU7cH+TlLdDMb2VnJALTV5buWiQ5z62uopaxthb8WCLz8szOW+zZKlR8koQ21SLjyuMWc/UbLNXXFohEADj2y1maiKMwG3v6LSmpdnNRXctLx5YrJ7DVkAWzSZBhQ4QLwzzlSESVyge+k0waO82aEcYFjKlAm/8agRizw9HLVEn/InvsUpLx/H0S9FTKBcJdYIEMjptvcJbWigCc0CYJrpMvrE6yiQU0UtUOsr8D1EdR2tcwazeBTmEOGMJKOI5n8qGLMZ42ZmlTNvcdbdIC4qpbWNBwXjKAZxmMZprpsUbeXyTjruz262gRQkn4L2XmGnw5AlpHKIJn8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDZFMEd5am5Nd2x6UHdRMk9FVWsvS0x2TmZUUjcvbUVLQTdOZDBqN1ZaSnVF?=
 =?utf-8?B?ZWN3SUNmQmdVbDlHYlhOdVltV3VHWTN6akZLNVJTcURmL1pPT0U5RXhxNVNW?=
 =?utf-8?B?UjEwcFdjd3RzTmVqaHl2TENydUtxODJGdlV2TG5BNUNTUHJzOUV3bTFQZDZv?=
 =?utf-8?B?YmhKUUhkaWNCVmJZTjFCdmdWQ1hZcWFabzJJdUh2QW9IaW5PdXhlMEY5dDFa?=
 =?utf-8?B?T0l5Q1l4eTBuTk9UbkZHR21ob3J0dDB2NEdqa3pIZ3c4TzVudXZYaWxNenE3?=
 =?utf-8?B?OHRwd0dFclI2SnpFeGJqdXNESGxrQ0dOUzhLUmxxYmNZaS9hQTUxSEdvYndW?=
 =?utf-8?B?Y2dHMUY4V2toYjdoeHlzeFFSQWpvU3NVVkpmVW9LVG5pT1NpTDJpQ29vRDJT?=
 =?utf-8?B?UDNTYmJVYnJDeGN6THJzU2dLM2J1WVpPM25NeTBJK2lTaEU0MjM3cUVRYVln?=
 =?utf-8?B?OTFuaFFvSlFnVDRZY1pOd1NCUlg1MFFwQUdEaWtGZlN1eWxzY082NWc1UFFN?=
 =?utf-8?B?VElPNjU4UU1weXF6UDNvU1RpRTBoTjJmMEhNd0JCaEJOcXkybGRzQmtNQ2pD?=
 =?utf-8?B?aDdpWmtJc3MvdWpyMDBQN2FBaEpOOGtyakxaNnZmbVluY1owTDJaRHAyV2tC?=
 =?utf-8?B?VmtkRnZ1TUZ3Uk16Z3c4TTRadGs2SVZXcnRrdW1NTVNoMEhtVllpKys5cXhj?=
 =?utf-8?B?WjNsUVZ3cUlGUlY4OW5GOENEd2ZvSXdrZW5rVTFFc1pxcVJCVjFXOW15cHBW?=
 =?utf-8?B?Uk9uRm1vZFNOOG1uVFVtVWhEbmRMV2FHWnAvODlUR3FwelkyL1pKZ1NPdk5u?=
 =?utf-8?B?czRlRExuUXR2V2ZwSDFXSVljNW1wQjdRYTZ1dWpxNGFhVVRxNjE3TzU4SmRP?=
 =?utf-8?B?U2JDUzFHQnNFZlpnY0VwWHJPVTk5TzVhNVZLblliTHVsVi9WWUY5Y0RnaXFj?=
 =?utf-8?B?MzhlTmhUY3UydXNQUXhkQ0FrM0NYRUpmV3pobHFTVjlOWEVWS2NnTjVJRDFB?=
 =?utf-8?B?Q0U2QWN2NXFvNkdZdjBnNHl6OHFxdDdRYWJSMzJjY0F0N2x6ajNXckg3aTNk?=
 =?utf-8?B?bWdBMnJMWm1SbTQ1OXhtTHVzV2ZSTURBdDJHOUgySUNkZ3dGc0JJRmNCS3g5?=
 =?utf-8?B?ajJCZGJOWHRCL3Z2ZVF2dm5ZSzBDbmFDK1hTckxoVGZPRDcraHllUWVEdmEz?=
 =?utf-8?B?MWpiZWZDOTVJZmR2UXRzMlMrbDBRcFlHbmlPM3hDUWV1TCtYTjNURysyRlo0?=
 =?utf-8?B?M2NlUEFDZE92Wk0yQWh2UHlOVlIyMEtWNEdZeGpXNVVqMkxlV082TUF0RkN0?=
 =?utf-8?B?UWRzQ0E1S1hWQ3U5bnphbFFOdktnMlo4QW02Snd6eU1qQ1N4NG5XZ3RtbVpx?=
 =?utf-8?B?TDBxRXNzKzJnRUtlYXQ3TXI4VzJaMndEaWdLKzhhMldKdGFOa2tvM3BVNnRN?=
 =?utf-8?B?ekRROHJuNzJZM01OWXMvWFVmZGJRU0pxTEljVWErRVZ0MlUrbCtpV0oxb1Yz?=
 =?utf-8?B?dHd0OHJTQzBERTJFK1pKS1RGZi9jd2N4cUxxZzB4cEgvVVRYeVI4VzcwWFNm?=
 =?utf-8?B?QUZyYmFEVkpueUpxN3hjamVvdFIvVk5EOVRPZ3I3dXB1djlGbXlrZUxncEdB?=
 =?utf-8?B?MDJ6SjZ1M0FhbjVtK0xWTVBON1ZHOW5RTDYzQ2hsVDJZOVRqYkE4T1JTS0l1?=
 =?utf-8?B?bXQzWitZV29naDVkZUlRT0M3cVhaSjFJOWlUYjRTUG45SVBlWEhUNkVkTElC?=
 =?utf-8?B?NHBUYUVCZ0ovRjBUTHFRNmVQMGtUdTlFMWNnRWZsaDRxdXg5eXRSbjhQNHd5?=
 =?utf-8?B?cTNVajZJTU53SlFTTnFOTGdzQnpvdWxhMGdrQ1ZTQi9Ba0ZVaFlIeWRoOG9B?=
 =?utf-8?B?SmVwcEZUY2NuTi96QjRoWmJMZm1ZT2J3eHNWc2pxRnp4K0MyNExBSE5ScjZB?=
 =?utf-8?B?dzRvaFA4WkI5Z29lTUttVFp1UzNoOTJnMGUyRlEvdXVMbGx6R1ZWUU8xRERX?=
 =?utf-8?B?cjNWNkpUcXRUNXlGQ3hQMFNtTHlTK3RxYjJmZjA4VG04R1dpRDVNWW9YbkJR?=
 =?utf-8?B?cG5wME45blppbnZ4UjdTUThqbkllT1doYjN6Zm85RU81Q1psb0F2UXVkS1Bl?=
 =?utf-8?B?M0FENjhMNFJvSW5VWWoxK1pLVWJ4algxU1NsVkpMM25qZTF5UjljRXl4YzZV?=
 =?utf-8?B?V01US3Fqd24va1FLQ1h5aEFGRVZjZnZEQWtZS3JsU2VjbmR6Qk16MGdYME05?=
 =?utf-8?B?eWxsMVR1R0JuUE11QkhQeDhBbmZwVEFKTHpvcURNV2VpUTNoVm9EMjFsekNY?=
 =?utf-8?Q?uK4ZwG3xBdlnuzSr56?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b638885-176d-472b-a0aa-08df19bbd79f
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:44:27.8199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIHH9EMP+aFMt0+czFkIH05UwErDOWdUsLBXWcNVrETgbihwjz8fcy/MBN6yIZHQJ6N+FOzwLjoe5T0HIrbX9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
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

On 2026-09-23 17:20, Mukul Joshi wrote:
> The export cleanup worker checks amdgpu_ualink_check_conn_ready() once
> when building npa_release_bitmap, but not again in the send loop. Cleanup
> workers run concurrently on the unbounded NPA WQ (one per exported
> handle), so when a peer's egress dies many workers have already seeded
> npa_release_bitmap from a connection that was still ESTABLISHED and all
> issue an LSDMA copy to the dead peer, flooding the log with repeated
> NPA-REVOKE send failures.
>
> Re-check the connection immediately before each send, as the tlb
> shootdown, force_retry_rpcs and unmap_all_npa_addr loops already do, so
> once the first worker marks a peer NOT_READY the rest skip it. With the
> re-check in place, seed npa_release_bitmap with a single bitmap_copy() of
> importers_bitmap instead of a separate build loop; peers that fail the
> re-check or the send are dropped from the bitmap in the send loop.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - We were using 2 for loops, once for building the npa_release_bitmap,
>    and another for sending the NPA-REVOKEs.
> - Replace it by using a single loop instead.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 31 +++++++++++++---------
>   1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 39b7cc8bc1c5..f6ad64be4349 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -2936,26 +2936,34 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
>   	amdgpu_bo_unref(&bo);
>   	exp_xa_node->bo = NULL;
>   
> -	/* Build the full npa_release_bitmap before sending any NPA-REVOKE. */
> +	/* Seed npa_release_bitmap with all importers before any NPA-REVOKE, so
> +	 * the release IRQ only sees it empty once every responder has replied.
> +	 * Dead peers are dropped from it in the send loop below.
> +	 */
> +	bitmap_copy(exp_xa_node->npa_release_bitmap,
> +		    exp_xa_node->importers_bitmap, AMDGPU_UALINK_ACCEL_MAX);
> +
> +	/* Send NPA-REVOKE to all importers which have imported this memory.
> +	 * On send failure clear the bit (no response will arrive) and mark the
> +	 * connection NOT_READY so other cleanups skip this unreachable peer.
> +	 */
>   	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
>   				 AMDGPU_UALINK_ACCEL_MAX) {
>   		imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
> +
> +		/* Re-check the connection right before the send: concurrent
> +		 * cleanup workers all seed the bitmap while the peer is still
> +		 * ESTABLISHED, so once its egress dies and the first worker
> +		 * marks it NOT_READY, this skips the rest instead of flooding
> +		 * the log with failed LSDMA sends to the same dead peer.
> +		 */
>   		if (!amdgpu_ualink_check_conn_ready(adev, remote_acc_id,
>   					imp_entry->generation_count)) {
>   			clear_bit(remote_acc_id,
> -				  exp_xa_node->importers_bitmap);
> +				  exp_xa_node->npa_release_bitmap);

It look like you never clear bits in importers_bitmap now. So maybe you 
could get rid of orig_importers_bitmap now as well. But that could be a 
separate cleanup patch if this one is urgent.

Either way, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   			continue;
>   		}
>   
> -		set_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
> -	}
> -
> -	/* Send NPA-REVOKE to all importers which have imported this memory.
> -	 * On send failure clear the bit (no response will arrive) and mark the
> -	 * connection NOT_READY so other cleanups skip this unreachable peer.
> -	 */
> -	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
> -				 AMDGPU_UALINK_ACCEL_MAX) {
>   		dev_dbg(adev->dev,
>   			"EXP-CLEANUP: Sending NPA-REVOKE to remote:%u\n",
>   			remote_acc_id);
> @@ -2966,7 +2974,6 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
>   				remote_acc_id);
>   			clear_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
>   
> -			imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
>   			amdgpu_ualink_handle_connection_reset(adev, remote_acc_id,
>   						AMDGPU_UALINK_CONN_NOT_READY,
>   						imp_entry->generation_count);
