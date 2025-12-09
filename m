Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE9BD3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 09:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5845F10E4EA;
	Tue,  9 Dec 2025 09:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2nNDbifM";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010065.outbound.protection.outlook.com
 [52.101.193.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1920310E4EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 09:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxqVhEow2AHopPqknP8nVxrZ1R6JrjbT48N4k6cStNfs1l5NTS1Q06TVscH/AjVdUONrzWoWuiJ6vJWCKH5Z0qSHR2AvTuFuMHxTykQISvNdDQlV9zlZp2umFsPIXOu24mc/ELLboRYv8LNONSZncGaeNYKBhmMOMJrVc3j0xFdYeM9FDAV3IC7zXzpPzxPb/svySq8Lwb9zQwhLsizMfi2zh36itNrQ2Q4k3uARZD9bbyFR83V+Oa2HVb3uYKbwUIkRP+NU72X9HXVpHFrOzCQC9tvvpH6cPX7uykNJbadWOln8QTXH+Uo+1EPKbA5wSHilnuEVso7mmv0x0JiLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ8WF872QPX+QIJEuL2JsiBkt0tVPCCo1ZPv8Ud7bb0=;
 b=hBCSTRz4PpeljZ/pWHRBlJd2dzp8+QQHjqXnHSySEYRlfzbtSvSqUTXV9Aom9wk9h53IFhkj4a7iwcbynsSp4RiSgodw+6rqHjGecHSTtRL9QvtAbh6UlG15RdjevMGQZI2ox8Ej8k70ZUSqSNzu323aEyIidt0bnwcHraTTK38nOkMvlaKqheB9PSq/u8wKjPt2yXVpIfEaeLyw539Z2SR0XPqRAXwvk9PGxYrBm7b847U23kTzWB5lBKlWC48T7rGjITvOgaIgyZh0Chte9UnOUJ0rb9sPbl76D7C0w0JHTGklUJmEZ3GDG64mXgsqKVM+cq14/WCLow3xmYDdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ8WF872QPX+QIJEuL2JsiBkt0tVPCCo1ZPv8Ud7bb0=;
 b=2nNDbifMlQXiMRCsCgqnvD6el53+9G8FITqqaXEkzX60amP+nUUGFy/9hYE7ingiyvWkXJBOeY8fHDvZhOcHWNmerZNvyPbOIV4p+K8kjndJAkO/AgLTRYXIGbJoLKA7dOqmZbqB5JKxgvrX0dNj9F8oMBNidcgKN5QAJdLcBLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 09:42:08 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 09:42:08 +0000
Message-ID: <c1aa6e1e-88a8-4b09-aa8a-f239f1306b9d@amd.com>
Date: Tue, 9 Dec 2025 10:42:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Wait for eviction fence before scheduling
 resume work
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251209092409.1257671-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251209092409.1257671-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5bfb5b-7f52-4dee-40f2-08de37073864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkFaR3J1b2NUbVRXNGcyaUpoMmc4NWI1Z2FKVEd1K3EzQnlkNUxjYTRsN0dt?=
 =?utf-8?B?ekwwbmNNdHU5cUVnL1o1OGlKTm9sNHVYNm9zOFdML0U5M2dFaG81MTdXVE1o?=
 =?utf-8?B?RHJoN1pUU3RnQ3hVVCt0MXRpWmo3cWVUK0tpMFpyYzZFQjA3bWdoc21LcVVP?=
 =?utf-8?B?TVZOTXFuNkhFOUxTRGV3OElISGZNWDZtVnhhb2hTbmZFc0pGZW9ZNUdSZUFl?=
 =?utf-8?B?MzRKdTBwekt1ZEpxYXAvZE9HNWlNZUdCK3ZYVW9jNmFOTDk1TW1OUHhGZzMz?=
 =?utf-8?B?Zkh1cGZaWHNlT1IwU1JrSCsyRTN6T2wza0NGWlFFbXZxTTMrVHdjSmdYUm5v?=
 =?utf-8?B?RlpUOGRUUllsRTRQanN1L0RsM2Q5TmNnZm9HL0hNQ2UxdEpJNFJZOFhoTGVP?=
 =?utf-8?B?ZFJuMWxXUEVqeW5RaTVhbmxnRm9rTjRQY00rd2dGSTNPb1I4b2QyOCtDVzFv?=
 =?utf-8?B?RnJJMS91NStEZ3IrRC9jVndEQUdNK25zOHFhemxxRDBrb3RhNkZ4MjU0N1Jx?=
 =?utf-8?B?VzdYYXlYM3BqNzVnR3NPbnpJNEt1ZjBsdkphMENCK2F2Z0R3TWlDZTlXZ0da?=
 =?utf-8?B?SWVQRTNhNktjRGJIRDRUaWpyN0Fiaks0ZnBWL0YvazRWTjQ0ZGJObldSU25h?=
 =?utf-8?B?bmRjaTMrZHQrb3hzSGh0SDZiZkovdTFxT2FLWTN2UUdPUWdYakFOQkIzeG9z?=
 =?utf-8?B?dithRG5uN1dzbTR6K2VQMDRqQjhGbit4cEZBb1NOVXZvV2lLaDJtRnhUYW1L?=
 =?utf-8?B?TjRaM0FhNVd5ei9HRndWSTJrajZ3eWdQREJrU3R5VjFyeWg5NTM2TCtnNmxY?=
 =?utf-8?B?cncvM0cra1A3eDBzd3RmcE1TcThwRDRLRkt2ZlF2Y0VZUGlyTjNqSlB3RWlv?=
 =?utf-8?B?eHRJSno3SlcxNlZrS04zQWs1a0kydmxGeE1wQlZoK0NtcHRTOHQvNmpFVFVQ?=
 =?utf-8?B?QjRuTFgzVW5iNDhmT0RzckhKVUZPNWhNdWwwRGxYS1R6TlM5M0FSVDZ0Wlpp?=
 =?utf-8?B?d2REdkkyQjk0ZERxYkJTYUV5VDMzYVVMTm44Wm5aZ2NlZm1Qbk5PTzRkOVZ3?=
 =?utf-8?B?d05lVkNaRlg0SmYvTHJaWkhsRWs4VytGMHdpMTNld3VQNHdja2JhUGd2VERl?=
 =?utf-8?B?eFcvSGE0VnQ5ODMrMGtZdHdBNCtmeFEyOWtuTC9KTTdlMmNRaGJLaHJZUGxR?=
 =?utf-8?B?WEZvK1BvVzBQb3MwK3BsNUs1VFVPQkJhQzdyTjJCMXdJZjloMjNlcEtiM2w4?=
 =?utf-8?B?alJDVEg0a3lkSnBuYUNkWTM0Z3RzV25uMkp4enh5RWx6VDJhYUNuajZxc2Vz?=
 =?utf-8?B?a0dNclA1cUdlMGhSbmFCVVQyNDVHNytrOXVRWTVvakpYakxaWE9GbG9tN3p6?=
 =?utf-8?B?amdZbUt5cW1DYWlUNXVqMnhhcUJmMTdQMURXdXRyQ3N6YWdZT1VqdkVPRm1J?=
 =?utf-8?B?MEZTVERFQ1pwOHVFVnlQeG1PNWpUSWZoTFZ4SzJnMDhES1FYWUVZYnNONDJ5?=
 =?utf-8?B?bFQ0R1VrdE1wNVJXbHQ0bjBoaXYvQWIzbXNORzRLc1NldEVuTTJYdWhvQjAz?=
 =?utf-8?B?ZUprM2UrYTJlbXo0WkI2WWFsUm13Q3d5U2R2cE9UamU2dnpPM0VTNWdHU3o0?=
 =?utf-8?B?V1NRaFZUN0xKMStFRnltNUo1ZmgyNURYank0WWhvdFNveG5SUzFDcERTMjA3?=
 =?utf-8?B?bjNXYXE0QkErYVVLQW8wc2RKcGtPMXJmYUplS0hYbEdtNUV1bTg3anp1bXZz?=
 =?utf-8?B?alBJRlJMT2FJZHVVQXNPNE9mS0FBSm1HTjMyZmRnQ3NsTkkyb2hjcERzdmg4?=
 =?utf-8?B?bkNyUnJySUFiWHFpLzlkTVh0SkpaSzMrQjRPN3hWc1JYVjVOZmlLK0Zic3Jl?=
 =?utf-8?B?RFhmOU10N1FQSi9mVHk3TE9hemQ1cUpSejFZMmF3QUdQaTlMcmhHak0zd1hE?=
 =?utf-8?Q?/meZKiAMwIH9Tskq6dGJXdBsBlGTsgIS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRqdmdUcXpKQVNhN1drQXd2TWFuNTlDa04vU0g2SHFDZHBLTlc1ZW15KzRW?=
 =?utf-8?B?RXJReXMxdk9vZ1Q0SmpXM0dlWU84Nm1MQ3VuZ0NWUWd0OUNMYUxwQ21CMzZs?=
 =?utf-8?B?UVJEN1hlTERKbWFCRVBtaFNRNU5SanhRV3RvSDJsYnhZR1Q3QjU3YjdvWnVi?=
 =?utf-8?B?Vk0zamhTdktJaW1FUjNIeUNRajhTa2c4d0tiSkNyZjg1OC9URU93SkZLeTVs?=
 =?utf-8?B?L3V3SUU1RkhxRjVXSmliQkdMTHp0Q1BOaEpvcmtOME9jU0tRSW1BTUV5ZWps?=
 =?utf-8?B?ZlVsSk8rSFMxUXdXcVRPdE1nZVpkTzU5RXJZNjE5Q0VuaG5iSXZ2WDZSMlhJ?=
 =?utf-8?B?WnlZUzg5Q3hYVTNQWnhKSENFait1S0VpNHU2MmlRb3ZJekdSUFh4cmh6RkhO?=
 =?utf-8?B?SWV0T3F4ME43R0c0dUppUVZyWUdUNWtPOHoxdU5HVzBVMWdRVDFJTzFqYWk3?=
 =?utf-8?B?TlE2aDVmTEt1TWxlcmJUd2EwUU9vRzZaZkIrUFYvUDFLQkZIbVRMbThzWjFn?=
 =?utf-8?B?dnhaNFJPTlJhMDdZWS9SMkNUbWc1cFNkT1Q1ODRERjZFZWZ2Z2kxdkdydFdR?=
 =?utf-8?B?QVE1elZLaUFRZ0t3Ym5EdWQvejBlUXFsVWJHejNycVdkbTE1SkxOcUhWblla?=
 =?utf-8?B?ZFFyaHErdEpDc0g5UElQZm41WGhuNndUMllrM016VGlvckplZGV3Wjlka1hy?=
 =?utf-8?B?VDA2a2ptVFhubDhOd3VRR0ZUKzQ4bkU3ODBsZ2krNlM1amlpRXA0eW1CQTFn?=
 =?utf-8?B?VE5DeVQ5WTBMQ0tYRWJZS2JzL2JmTXFOd3RGOUptU2MxRWthUXgza1NzVkRJ?=
 =?utf-8?B?R2VsTWlMK0I0UUpUbzFiOHhwNEVLZjBiVVdGbHVIaWh5clFUYjVKbVRjSllX?=
 =?utf-8?B?L3pUTDcyY2Z6ck15VnVHWVoxTXF3QnBnKzQ3M3pSc1Y1Z3E0ZFMrTjBGaVdv?=
 =?utf-8?B?czhPWXFzRm05bGVMUFY1cWY4Z25oTFBNV0hkMEpmVThnNENlMFp6VVNzUm1D?=
 =?utf-8?B?Sm1LSWlDYVVkVURUNDFUd3NvcTNGVGI0TG8za1VPdHE1WFQxZlQzWTRPNnVs?=
 =?utf-8?B?L1hjNjNaNTg1bVBjRHdQUHBvdTUyK040SjFEdWozaGY0OEROSnp6NjNic0pi?=
 =?utf-8?B?elo4RTBKZ3BzSlYxSFZjQ2Qzdms5Q2dvbUJVcXBMaWNJYlYvYU10QXh4c3ll?=
 =?utf-8?B?K2d6cndRNFkzak1kclJZdGJCSjZNSC9BM3ZoY3NqcnU4djdSSTBXRDhJN1ZH?=
 =?utf-8?B?dGVLb3BBMkRqN1oyQW9Rd3BCVzBnNkZvL21hV0ZDMGh6NWFuaW9FUjdyUlRE?=
 =?utf-8?B?SFVxVWw5bzdMalE0d01CaXdJSmlLS3d3d2VQL2QrMWFlMm5uVWhBVDZoZGZp?=
 =?utf-8?B?eHJJcStxSDdqZVpQUEFzS0wvSUZYTkF1eWprTjhSWTdyRFljK20zQU5sVGVu?=
 =?utf-8?B?VUk4Tlo3WllxU1A1b0RzUStoeXY3cDhtVytwaXJXN3NkTFBMUnpUSE5NYnY4?=
 =?utf-8?B?bVhEVm1ZOVdNU1JlYWszeUUxV0pHODMyZFRUano5alA2c2xpREFwTDNtdUhB?=
 =?utf-8?B?cHhVdlpJUHNJYWFtNmlNMWJJaHlYZ25HRVFEdytBMTBUOHI3Ky94YjFtUXRm?=
 =?utf-8?B?OTlqem8rbHhHZS9TK1BZTWR4aktJQUF2cVZrek9OczRuRytCRnlMTmlnZHNC?=
 =?utf-8?B?T3NBb1RKTUUweURzMGg4RHZXREJXd2ErNC93dEJuTitJMnpKM09lTythY2V6?=
 =?utf-8?B?YTk1TS9TU0U2bXpqbmczbk5iYmZBRWpuZCtKTDE0S2RNdURqQ0hlekJPYkpO?=
 =?utf-8?B?TzQraXNuY0orSFFwOXUrK043MjBXUEcvcDZrZlZKUTZITFBRNHRZc2s4S0VP?=
 =?utf-8?B?REhWN05TTmtzRU5JcWpXSW1aNVJ2T0IvbWRTb3p3SUNxMWw5eDllR2tWdE10?=
 =?utf-8?B?d1VrYXZjbklaWEkvS1p2bWU5NTFENHdOMTVVdjcwbk55K3dNU3Y3a211SHFN?=
 =?utf-8?B?cWVBbXBjREdaZnQrUE80cHVwNG54aUJjMEF5aFBKaXdZVnNUbDBzOTNhYWxE?=
 =?utf-8?B?NmlCbnVabkN4ZjR3eUxjOVE4QWtrRjd3T3lWMVhPYm1IaUUrSHZ6YmpBbktO?=
 =?utf-8?Q?svWWNGcw05VkXcvA/L/Z2aCuX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5bfb5b-7f52-4dee-40f2-08de37073864
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:42:08.7701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUg/3fU7+bzVww7nOUba595VwpEaTmzwkWPrsuF7hzsCW2c/ZbDWWeGCbicXtbze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
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

On 12/9/25 10:23, Jesse.Zhang wrote:
> In the amdgpu_userq_evict function, after signaling the eviction fence, we
> need to ensure it's processed before scheduling the resume work. This
> prevents potential race conditions where the resume work might start
> before the eviction fence has been fully handled, leading to inconsistent
> state in user queues.

Well signaling the fence means it is fully processed. So this change here is just bluntly nonsense.

What exactly is happening?

Regards,
Christian.

> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2f97f35e0af5..ed744b2edc61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1238,6 +1238,10 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>  		return;
>  	}
>  
> +       /* Wait for eviction fence to be processed before schedule a resume work */
> +	if (dma_fence_wait_timeout(&ev_fence->base, false, msecs_to_jiffies(100)) <= 0) {
> +		dev_warn(adev->dev, "Eviction fence wait timed out\n");
> +	}
>  	/* Schedule a resume work */
>  	schedule_delayed_work(&uq_mgr->resume_work, 0);
>  }

